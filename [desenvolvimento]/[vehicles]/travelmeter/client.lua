
local distanceTraveled = {}

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		addEventHandler("onClientRender",root,monitoring)
	end
)

function monitoring()
	if getPedOccupiedVehicle(localPlayer) then
		local veh = getPedOccupiedVehicle(localPlayer)
		local x,y,z = getElementPosition( veh )
		if not distanceTraveled[veh] then
			distanceTraveled[veh] = {}
			distanceTraveled[veh].oldpos = { x,y,z }
			distanceTraveled[veh].dist = (getElementData(veh, "travelmeter-vehicleDistanceTraveled") or 0) * 1000
		end
		distanceTraveled[veh].dist = distanceTraveled[veh].dist + getDistanceBetweenPoints3D(x,y,z, distanceTraveled[veh].oldpos[1],distanceTraveled[veh].oldpos[2],distanceTraveled[veh].oldpos[3])
		distanceTraveled[veh].oldpos = { x, y, z }
		local dt = math.round(distanceTraveled[veh].dist / 1000, 1)
		if getElementData(veh, "travelmeter-vehicleDistanceTraveled") ~= dt then
			setElementData(veh, "travelmeter-vehicleDistanceTraveled", dt)
		end
	end
end

function getVehicleDistanceTraveled(vehicle, unit)
	if not (vehicle) or not (distanceTraveled[vehicle]) then return false end
	local v = ((unit or ""):lower() == "m") and 1 or 1000
	return (getElementType(vehicle) == "vehicle") and math.round((distanceTraveled[vehicle].dist or 0) / v, 1) or false
end

function setVehicleDistanceTraveled(vehicle, distance)
	if vehicle and (getElementType(vehicle) == "vehicle") and tonumber(distance) then
		if not distanceTraveled[vehicle] then
			distanceTraveled[vehicle] = {}
			distanceTraveled[vehicle].oldpos = { getElementPosition(vehicle) }
		end
		distanceTraveled[vehicle].dist = math.round(distance, 1) * 1000
		setElementData(vehicle, "travelmeter-vehicleDistanceTraveled", math.round(distance, 1))
		return true
	end
	return false
end
addEvent("travelmeter:setVehicleDistanceTraveled", true)
addEventHandler("travelmeter:setVehicleDistanceTraveled", root, setVehicleDistanceTraveled)

function resetVehicleDistanceTraveled(vehicle)
	if vehicle and (getElementType(vehicle) == "vehicle") and distanceTraveled[vehicle] then
		distanceTraveled[vehicle].dist = 0
		setElementData(vehicle, "travelmeter-vehicleDistanceTraveled", 0)
		return true
	end
	return false
end
addEvent("travelmeter:resetVehicleDistanceTraveled", true)
addEventHandler("travelmeter:resetVehicleDistanceTraveled", root, resetVehicleDistanceTraveled)

addEventHandler( "onClientVehicleExplode", root,
	function()
		removeVehicleDistanceTraveled(source)
	end
)

addEventHandler( "onClientElementDestroy", root,
	function ()
		if (getElementType(source) == "vehicle") then
			removeVehicleDistanceTraveled(source)
		end
	end
)

function removeVehicleDistanceTraveled(veh)
	if distanceTraveled[veh] then
		distanceTraveled[veh] = nil
	end
	if getElementData(veh, "travelmeter-vehicleDistanceTraveled") then
		setElementData(veh, "travelmeter-vehicleDistanceTraveled", 0)
	end
end

function math.round(number, decimals)
    return tonumber(("%."..(decimals or 0).."f"):format(number))
end
