
function getVehicleDistanceTraveled(player, vehicle)
	if isElement(player) and vehicle and (getElementType(vehicle) == "vehicle") then
		return math.round( getElementData(vehicle, "travelmeter-vehicleDistanceTraveled"), 1 ) or 0
	end
	return false
end

function setVehicleDistanceTraveled(player, vehicle, distance)
	if isElement(player) and vehicle and (getElementType(vehicle) == "vehicle") and tonumber(distance) then
		return triggerClientEvent(player, "travelmeter:setVehicleDistanceTraveled", player, vehicle, math.round(distance, 1))
	end
	return false
end

function resetVehicleDistanceTraveled(player, vehicle)
	if isElement(player) and vehicle and (getElementType(vehicle) == "vehicle") then
		return triggerClientEvent(player, "travelmeter:resetVehicleDistanceTraveled", player, vehicle)
	end
	return false
end

function math.round(number, decimals)
    return tonumber(("%."..(decimals or 0).."f"):format(number))
end
