local INDICATOR_SIZE = 0.2						-- Size for the corona markers
local INDICATOR_COLOR = { 255, 100, 10, 255 }	-- Color in R G B A format
local INDICATOR_FADE_MS = 160					-- Miliseconds to fade out the indicators
local INDICATOR_SWITCH_TIMES = { 300, 400 }		-- In miliseconds. First is time to switch them off, second to switch them on.
local INDICATOR_AUTOSWITCH_OFF_THRESHOLD = 62	-- A value in degrees ranging (0, 90) preferibly far from the limits.

local root = getRootElement()
local localPlayer = getLocalPlayer()
local vehiclesWithIndicator = {}

INDICATOR_AUTOSWITCH_OFF_THRESHOLD = INDICATOR_AUTOSWITCH_OFF_THRESHOLD / 90

local function vectorLength ( vector )
	return math.sqrt ( vector[1]*vector[1] + vector[2]*vector[2] + vector[3]*vector[3] )
end

local function normalizeVector ( vector )
	local length = vectorLength ( vector )
	if length > 0 then
		local normalizedVector = {}
		normalizedVector[1] = vector[1] / length
		normalizedVector[2] = vector[2] / length
		normalizedVector[3] = vector[3] / length
		return normalizedVector, length
	else
		return nil, length
	end
end

local function crossProduct ( v, w )
	local result = {}
	result[1] = v[2]*w[3] - v[3]*w[2]
	result[2] = w[1]*v[3] - w[3]*v[1]
	result[3] = v[1]*w[2] - v[2]*w[1]
	return result
end

local function getFakeVelocity ( vehicle )
	-- Get the angle around the Z axis
	local _, _, angle = getElementRotation ( vehicle )
	local velocity = { 0, 0, 0 }
	velocity[1] = -math.sin ( angle )
	velocity[2] = math.cos ( angle )
	return velocity
end

local function createIndicator ()
	local x, y, z = getElementPosition(localPlayer)
	local indicator = createMarker ( 	x, y, z+4, 'cylinder',INDICATOR_SIZE,INDICATOR_COLOR[1],INDICATOR_COLOR[2],INDICATOR_COLOR[3],0, getRootElement())
	setElementStreamable ( indicator, false )
	return indicator
end

local function createIndicatorState ( vehicle, indicatorLeft, indicatorRight )
	local t = { vehicle		  = vehicle,		-- The vehicle that this state refers to
				left 		  = indicatorLeft,	-- The state of the left indicator
				right 		  = indicatorRight,	-- The state of the right indicator
				coronaLeft	  = nil,			-- The corona elements for the left indicator
				coronaRight	  = nil,			-- The corona elements for the right indicator
				nextChange	  = 0,				-- The time for the next change of the indicators
				timeElapsed   = 0,				-- Elapsed time since the last change
				currentState  = false,			-- If set to true, the coronas are activated.
				activationDir = nil,			-- Direction that the vehicle was following when the indicator got activated, for auto shut down.
			  }
	return t
end

local width, height = guiGetScreenSize()
local x = width
local y = height

local function updateIndicatorState ( state )
	if not state then return end

	local numberOfIndicators = 0

	local xmin, ymin, zmin, xmax, ymax, zmax = getElementBoundingBox ( state.vehicle )

	xmin = xmin + 0.2
	xmax = xmax - 0.2
	ymin = ymin + 0.2
	ymax = ymax - 0.2
	zmin = zmin + 0.3

	-- Check the left indicator
	if state.left then
		if not state.coronaLeft then
			state.coronaLeft = { createIndicator (), createIndicator () }
			attachElements ( state.coronaLeft[1], state.vehicle, xmin,  ymax, zmin )
			attachElements ( state.coronaLeft[2], state.vehicle, xmin, -ymax, zmin )
		end
		numberOfIndicators = numberOfIndicators + 1
	elseif state.coronaLeft then
		destroyElement ( state.coronaLeft[1] )
		destroyElement ( state.coronaLeft[2] )
		state.coronaLeft = nil
	end
	
	-- Check the right indicator
	if state.right then
		if not state.coronaRight then
			state.coronaRight = { createIndicator (), createIndicator () }
			attachElements ( state.coronaRight[1], state.vehicle, -xmin,  ymax, zmin )
			attachElements ( state.coronaRight[2], state.vehicle, -xmin, -ymax, zmin )
		end
		numberOfIndicators = numberOfIndicators + 1
	elseif state.coronaRight then
		destroyElement ( state.coronaRight[1] )
		destroyElement ( state.coronaRight[2] )
		state.coronaRight = nil
	end
	
	-- Check if this is the car that you are driving and that there is one and only one indicator
	-- to enable auto switching off
	if numberOfIndicators == 1 and getVehicleOccupant ( state.vehicle, 0 ) == localPlayer then
		-- Store the current velocity, normalized, to check when will we have to switch it off.
		state.activationDir = normalizeVector ( { getElementVelocity ( state.vehicle ) } )
		if not state.activationDir then
			-- The vehicle is stopped, get a fake velocity from the angle.
			state.activationDir = getFakeVelocity ( state.vehicle )
		end
	else
		state.activationDir = nil
	end
end

local function destroyIndicatorState ( state )
	if not state then return end
	
	-- Destroy the left coronas
	if state.coronaLeft then
		destroyElement ( state.coronaLeft[1] )
		destroyElement ( state.coronaLeft[2] )
		state.coronaLeft = nil
	end
	
	-- Destroy the right coronas
	if state.coronaRight then
		destroyElement ( state.coronaRight[1] )
		destroyElement ( state.coronaRight[2] )
		state.coronaRight = nil
	end
	
	-- If I am the driver, reset the element data.
	if getVehicleOccupant ( state.vehicle ) == localPlayer then
		setElementData ( state.vehicle, 'i:left', false, true )
		setElementData ( state.vehicle, 'i:right', false, true )
	end
end

local function performIndicatorChecks ( vehicle )
	-- Get the current indicator states
	local indicatorLeft = getElementData(vehicle, 'i:left')
	local indicatorRight = getElementData(vehicle, 'i:right')

	-- Check if we at least have one indicator running
	local anyIndicator = indicatorLeft or indicatorRight
	
	-- Grab the current indicators state in the flashing period.
	local currentState = vehiclesWithIndicator [ vehicle ]

	-- If there's any indicator running, push it to the list of vehicles to draw the indicator.
	-- Else, remove it from the list.
	if anyIndicator then
		-- Check if there is already a state for this vehicle
		if currentState then
			-- Update the state
			currentState.left = indicatorLeft
			currentState.right = indicatorRight
		else
			-- Create a new state
			currentState = createIndicatorState ( vehicle, indicatorLeft, indicatorRight )
			vehiclesWithIndicator [ vehicle ] = currentState
		end
		updateIndicatorState ( currentState )
	elseif currentState then
		-- Destroy the current state
		destroyIndicatorState ( currentState )
		vehiclesWithIndicator [ vehicle ] = nil
	end
end

local function setIndicatorsAlpha ( state, alpha )
	if state.coronaLeft then
		setMarkerColor ( state.coronaLeft[1],	INDICATOR_COLOR[1],
												INDICATOR_COLOR[2],
												INDICATOR_COLOR[3],
												alpha )
		setMarkerColor ( state.coronaLeft[2],	INDICATOR_COLOR[1],
												INDICATOR_COLOR[2],
												INDICATOR_COLOR[3],
												alpha )
	end
	if state.coronaRight then
		setMarkerColor ( state.coronaRight[1],	INDICATOR_COLOR[1],
												INDICATOR_COLOR[2],
												INDICATOR_COLOR[3],
												alpha )
		setMarkerColor ( state.coronaRight[2],	INDICATOR_COLOR[1],
												INDICATOR_COLOR[2],
												INDICATOR_COLOR[3],
												alpha )
	end
end

local function processIndicators ( state )
	-- Check first if the vehicle is blown up.
	if getElementHealth ( state.vehicle ) == 0 then
		-- Destroy the state.
		destroyIndicatorState ( state )
		vehiclesWithIndicator [ state.vehicle ] = nil
		return
	end
	
	-- Check if we must automatically deactivate the indicators.
	if state.activationDir then
		-- Get the current velocity and normalize it
		local currentVelocity = normalizeVector ( { getElementVelocity ( state.vehicle ) } )
		
		-- If the vehicle is stopped, calculate a fake velocity from the angle.
		if not currentVelocity then
			currentVelocity = getFakeVelocity ( state.vehicle )
		end
		
		-- Calculate the cross product between the velocities to get the angle and direction of any turn.
		local cross = crossProduct ( state.activationDir, currentVelocity )
			
		-- Get the length of the resulting vector to calculate the "amount" of direction change [0..1].
		local length = vectorLength ( cross )
			
		-- If the turn is over the threshold, deactivate the indicators
		-- if length > INDICATOR_AUTOSWITCH_OFF_THRESHOLD then
			-- Destroy the state
			-- destroyIndicatorState ( state )
			-- vehiclesWithIndicator [ state.vehicle ] = nil
			-- return
		-- end
	end

	-- Check if we must switch the state
	if state.nextChange <= state.timeElapsed then
		-- Turn to switched on indicators, in both cases. When turning on,
		-- it goes straight to the full alpha mode. When turning off, it
		-- fades out from full alpha to full transparent.
		setIndicatorsAlpha ( state, INDICATOR_COLOR[4] )
		
		-- Switch the state
		state.currentState = not state.currentState
	
		-- Get the vehicle that we are in
		local playerVehicle = getPedOccupiedVehicle ( localPlayer )
		
		-- Restart the timers and play a sound if we are in that vehicle
		state.timeElapsed = 0
		if state.currentState then
			state.nextChange = INDICATOR_SWITCH_TIMES[1]
			if playerVehicle == state.vehicle then playSoundFrontEnd ( 37 ) 
				playSound("files/turnsignal.mp3",false)
			end
		else
			state.nextChange = INDICATOR_SWITCH_TIMES[2]
			if playerVehicle == state.vehicle then playSoundFrontEnd ( 38 ) end
		end
		

	-- Check if we are turning them off
	elseif state.currentState == false then
		-- If the time elapsed is bigger than the time to fade out, then
		-- just set the alpha to zero. Else, set it to the current alpha
		-- value.
		if state.timeElapsed >= INDICATOR_FADE_MS then
			setIndicatorsAlpha ( state, 0 )
		else
			setIndicatorsAlpha ( state, (1 - (state.timeElapsed / INDICATOR_FADE_MS)) * INDICATOR_COLOR[4] )
		end
	end
end

--[[
* onClientElementDataChange
Detects when the indicator state of a vehicle changes.
--]]
addEventHandler('onClientElementDataChange', root, function ( dataName, oldValue )
	-- Check that the source is a vehicle and that the data name is what we are looking for.
	if getElementType(source) == 'vehicle' and ( dataName == 'i:left' or dataName == 'i:right' ) then
		-- If the vehicle is not streamed in, don't do anything.
		if isElementStreamedIn(source) then
			-- Perform the indicator checks for the new indicator states.
			performIndicatorChecks ( source )
		end
	end
end)

addEventHandler('onClientElementStreamIn', root, function ()
	if getElementType(source) == 'vehicle' then
		performIndicatorChecks ( source )
	end
end)

addEventHandler('onClientElementStreamOut', root, function ()
	if getElementType(source) == 'vehicle' then
		local currentState = vehiclesWithIndicator [ source ]

		if currentState then
			destroyIndicatorState ( currentState )
			vehiclesWithIndicator [ source ] = nil
		end
	end
end)

local function switchIndicatorState ( indicator )
	local v = getPedOccupiedVehicle(localPlayer)
	if v then
		if getVehicleType(v) == "Automobile" or getVehicleType(v) == "Bike" or getVehicleType(v) == "Quad" then
			if getVehicleOccupant(v, 0) == localPlayer then
				local dataName = 'i:' .. indicator
				local currentValue = getElementData(v, dataName) or false

				setElementData(v, dataName, not currentValue, true)
			end
		end
	end
end
addCommandHandler('indicator_left', function () switchIndicatorState('left') end, false)
addCommandHandler('indicator_right', function () switchIndicatorState('right') end, false)

addEventHandler('onClientPreRender', root, function ( timeSlice )
	for vehicle, state in pairs(vehiclesWithIndicator) do
		state.timeElapsed = state.timeElapsed + timeSlice
		processIndicators ( state, state.lastChange )
	end
end)

function handleKeyBind( keyPressed, keyState )
	if (keyPressed == "mouse1") then
		switchIndicatorState('left')
	elseif (keyPressed == "mouse2") then
		switchIndicatorState('right')
	end
end

addEventHandler('onClientResourceStart', getResourceRootElement(getThisResource()), function ()
	-- Check all streamed in vehicles that have any indicator activated and create a state for them.
	local vehicles = getElementsByType ( 'vehicle' )
	for k, vehicle in ipairs(vehicles) do
		if isElementStreamedIn ( vehicle ) then
			local indicatorLeft = getElementData ( vehicle, 'i:left' )
			local indicatorRight = getElementData ( vehicle, 'i:right' )
			if indicatorLeft or indicatorRight then
				performIndicatorChecks ( vehicle )
			end
		end
	end
	 
	bindKey ( "mouse1", "down", handleKeyBind )
	bindKey ( "mouse2", "down", handleKeyBind )
end, false)

addEventHandler('onClientVehicleRespawn', root, function ()
	if isElementStreamedIn ( source ) then
		performIndicatorChecks ( source )
	end
end)

addEventHandler('onClientElementDestroy', root, function ()
	if getElementType ( source ) == 'vehicle' then
		local currentState = vehiclesWithIndicator [ source ]
		if currentState then
			-- Destroy the state
			destroyIndicatorState ( currentState )
			vehiclesWithIndicator [ source ] = nil
		end
	end
end)
