function motorAoSair ( theVehicle, leftSeat, jackerPlayer )
    if leftSeat == 0 and not jackerPlayer then
        setVehicleEngineState ( theVehicle, false )
    end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement ( ), motorAoSair )


addEvent( "engineswitch", true )
addEventHandler( "engineswitch", getRootElement( ), function(player, state)
    local theVehicle = getPedOccupiedVehicle ( player )
    if theVehicle and getVehicleController ( theVehicle ) == player and getElementHealth(theVehicle) >= 310 then
		setVehicleEngineState ( theVehicle, state )
		triggerClientEvent("sendengine", player, false)
		if state == false then
			outputChatBox("#d9534f[VDBG.ORG] #FFFFFFUse: #428bca(ESPAÇO #FFFFFF+ #428bcaJ) #FFFFFFpara #acd373ligar#FFFFFF o veículo.", player, 255, 255, 255, true) 
		else
			outputChatBox("#d9534f[VDBG.ORG] #FFFFFFUse:  #428bca(J) #FFFFFFpara #d9534fdesligar#FFFFFF o veículo.", player, 255, 255, 255, true)
		end
    end
end)

addEvent( "lightswitch", true )
addEventHandler( "lightswitch", getRootElement( ), function( player )
    playerVehicle = getPedOccupiedVehicle ( player )                 -- get the player's vehicle
    if ( playerVehicle ) then                                        -- if he was in one
        if ( getVehicleOverrideLights ( playerVehicle ) ~= 2 ) then  -- if the current state isn't 'force on'
            setVehicleOverrideLights ( playerVehicle, 2 )            -- force the lights on
        else
            setVehicleOverrideLights ( playerVehicle, 1 )            -- otherwise, force the lights off
        end
    end
end)


function initCarLocks ()
	local players = getElementsByType ( "player" )
	for k,p in ipairs(players) do
		removeElementData ( p, "cl_ownedvehicle" )
		bindKey ( p, "l", "down", doToggleLocked )
	end

	local vehicles = getElementsByType ( "vehicle" )
	for k,v in ipairs(vehicles) do
		removeElementData ( v, "cl_vehicleowner" )
		removeElementData ( v, "cl_vehiclelocked" )
		removeElementData ( v, "cl_enginestate" )
		setVehicleLocked ( v, false )
		setVehicleOverrideLights ( v, 0 )
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), initCarLocks )
addEventHandler ( "onResourceStop", getResourceRootElement ( getThisResource () ), initCarLocks )

function cl_PlayerJoin ( )
	bindKey ( source, "l", "down", doToggleLocked )
end
addEventHandler ( "onPlayerJoin", getRootElement(), cl_PlayerJoin )

function cl_PlayerQuit ( )
	local ownedVehicle = getElementData ( source, "cl_ownedvehicle" )
	if (ownedVehicle ~= false) then
		cl_RemoveVehicleOwner ( ownedVehicle )
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), cl_PlayerQuit )


function cl_PlayerWasted ( )
	local ownedVehicle = getElementData ( source, "cl_ownedvehicle" )
	if (ownedVehicle ~= false) then
		cl_RemoveVehicleOwner ( ownedVehicle )
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), cl_PlayerWasted )


function cl_VehicleStartEnter ( enteringPlayer, seat, jacked )
	local theVehicle = source
	local theOwner
	if ( getElementData ( theVehicle, "cl_vehiclelocked" ) == true ) then
		theOwner = getElementData ( theVehicle, "cl_vehicleowner" )
		if theOwner ~= false and theOwner ~= enteringPlayer then
			-- make sure they dont enter
			--cancelEvent();
		end
	 end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), cl_VehicleStartEnter )


function cl_PlayerDriveVehicle ( player, seat, jacked )
	if ( seat == 0 ) then
		oldVehicle = getElementData ( player, "cl_ownedvehicle" )
		if ( (cl_VehicleLocked(source) == true) and (cl_VehicleOwner(source) ~= player) ) then
			removePlayerFromVehicle( player )
			--Err_Msg("Esse carro tá trancado.", player)
			return false
		end
		cl_SetVehicleOwner ( source, player )
	end
	return true
end
addEventHandler ( "onVehicleEnter", getRootElement(), cl_PlayerDriveVehicle )


function cl_VehicleRespawn ( exploded ) 
	cl_RemoveVehicleOwner ( source )
end
addEventHandler ( "OnVehicleRespawn", getRootElement(), cl_VehicleRespawn )


function cl_VehicleExplode ( )
	local theOwner = getElementData ( source, "cl_vehicleowner" )
	if ( theOwner ~= false ) then
		cl_RemoveVehicleOwner ( source )
	end
end
addEventHandler ( "onVehicleExplode", getRootElement(), cl_VehicleExplode )


function cl_SetVehicleOwner ( theVehicle, thePlayer )
	local oldVehicle = getElementData ( thePlayer, "cl_ownedvehicle" )
    for k,v in ipairs(getElementsByType ( "vehicle" )) do
		if ( oldVehicle ~= false and oldVehicle == v ) then
				removeElementData ( oldVehicle, "cl_vehicleowner" )
				removeElementData ( oldVehicle, "cl_vehiclelocked" )
				removeElementData ( oldVehicle, "cl_enginestate" )
				setVehicleLocked ( oldVehicle, false )
			--	outputDebugString("removeu - locks")
		end
	end
	--outputDebugString("colocou novo - locks ")
	setElementData ( theVehicle, "cl_vehicleowner", thePlayer )
	setElementData ( theVehicle, "cl_vehiclelocked", false )
	setElementData ( thePlayer, "cl_ownedvehicle", theVehicle )
	setElementData( theVehicle, "cl_enginestate", true )

end

function cl_RemoveVehicleOwner ( theVehicle )
	if not theVehicle then return end
	local theOwner = getElementData ( theVehicle, "cl_vehicleowner" )
	if not theOwner then return end
	if ( theOwner ~= false ) then
		removeElementData ( theOwner, "cl_ownedvehicle" )
		removeElementData ( theVehicle, "cl_vehicleowner" )
		removeElementData ( theVehicle, "cl_vehiclelocked" )
		removeElementData ( owned, "cl_enginestate" )
	end
	setVehicleLocked ( theVehicle, false )

end


function cl_FlashLights ( thePlayer )
	setTimer ( doToggleLights, 300, 4, thePlayer, true )
end

-- flash once
function cl_FlashOnce ( thePlayer )
	setTimer ( doToggleLights, 300, 2, thePlayer, true )
end

-- get vehicle owner ( according to vehicle's element data )
function cl_VehicleOwner ( theVehicle )
	return getElementData( theVehicle, "cl_vehicleowner" )

end
-- is vehicle locked ( according to vehicle's element data )
function cl_VehicleLocked ( theVehicle )
	return getElementData( theVehicle, "cl_vehiclelocked" )
end
-- messaging functions
-- send red error message
function Err_Msg ( strout, thePlayer )
	outputChatBox ( strout, thePlayer, 200, 0, 10 )
end

-- send message to all occupants of vehicle
function Car_Msg ( strout, theVehicle )
	numseats = getVehicleMaxPassengers ( theVehicle )
	for s = 0, numseats do
		local targetPlayer = getVehicleOccupant ( theVehicle, s )
		if targetPlayer ~= false then
			outputChatBox ( strout, targetPlayer, 30, 144, 255 )
		end
	end
end
-- send aquamarine message to player
function Info_Msg ( strout, thePlayer )
	outputChatBox ( strout, thePlayer, 102, 205, 170 )
end

-- commands 
function doToggleLocked ( source )
	local theVehicle , strout
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end

	if ( theVehicle ) then
		local vehiclename = getVehicleName ( theVehicle )
		-- already locked
		if ( getElementData ( theVehicle, "cl_vehiclelocked") == true ) then
			doUnlockVehicle ( source )
		else 
			doLockVehicle ( source )
		end
	else
		--Err_Msg("Você deve ter um veículo para bloquear ou desbloquear.", source)
	end
end	

function doLockVehicle ( source )
	local theVehicle , strout
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end

	if ( theVehicle ) then
		local vehiclename = getVehicleName ( theVehicle )
		-- already locked
		if ( getElementData ( theVehicle, "cl_vehiclelocked") == true ) then
			--strout = "Seu " .. vehiclename .. " já está bloqueado." 
			--Err_Msg(strout, source)
		else 
			setElementData ( theVehicle, "cl_vehiclelocked", true)
			setVehicleLocked ( theVehicle, true ) 
				local occupants = getVehicleOccupants(theVehicle) or {}
				for seat, occupant in pairs(occupants) do 
					if (occupant and getElementType(occupant) == "player") then 
						triggerClientEvent("soundlockalarme", occupant, occupant)
					outputChatBox("#d9534f[VDBG.ORG] #FFFFFFTravas elétrica #acd373Travadas",occupant,255,255,255, true)
					end
				end
			--Car_Msg( "Veículo atual " .. vehiclename .. " trancado.", theVehicle)
			--Info_Msg ( "Veículo fechado " .. vehiclename .. ".", source )
			if ( getVehicleController ( theVehicle ) == false ) then
				cl_FlashLights ( source )
			end
		end
	else
		--Err_Msg("Você deve ter um veículo para travá-lo.", source)
	end
end

function doUnlockVehicle ( source )
	local theVehicle, strout
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end
	if ( theVehicle ) then
	local vehiclename = getVehicleName ( theVehicle )
		if ( getElementData ( theVehicle, "cl_vehiclelocked") == false ) then
			--strout = "Seu " .. vehiclename .. " já está desbloqueado."
			Err_Msg(strout, source)
		else
			setElementData ( theVehicle, "cl_vehiclelocked", false)
			setVehicleLocked ( theVehicle, false )
			local occupants = getVehicleOccupants(theVehicle) or {}
				for seat, occupant in pairs(occupants) do 
					if (occupant and getElementType(occupant) == "player") then 
						triggerClientEvent("soundlockalarme", occupant, occupant)
						outputChatBox("#d9534f[VDBG.ORG] #FFFFFFTravas elétrica #d9534fDestravadas",occupant,255,255,255, true)
					end
				end
			if ( getVehicleController ( theVehicle ) == false ) then
				cl_FlashOnce ( source )
			end
		end
	else
		--Err_Msg("Você deve ter um veículo para desbloqueá-lo.", source)
	end
end


function doToggleLights ( source, beep )
	local theVehicle 
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end
	if ( theVehicle ) then
		-- if he was in one
		if ( getVehicleOverrideLights ( theVehicle ) ~= 2 ) then  -- if the current state isn't 'force on'
            setVehicleOverrideLights ( theVehicle, 2 )            -- force the lights on
			-- play sound close to element
			if ( beep == true ) then
				local theElement = theVehicle
				triggerClientEvent ( getRootElement(), "onPlaySoundNearElement", getRootElement(), theElement, 5)
			end
        else
            setVehicleOverrideLights ( theVehicle, 1 )            -- otherwise, force the lights off
        end
	else
		--Err_Msg("Você deve ter um veículo para controlar as luzes.", source )
    end
end

addCommandHandler ( "lock", doLockVehicle )
addCommandHandler ( "unlock", doUnlockVehicle )


