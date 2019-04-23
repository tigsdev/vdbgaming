function lossHealthOnHurt(loss)
	if getElementHealth(source) < 250 or getElementHealth(source) == 250 then
		setVehicleEngineState(source, false)
	end
	if getVehicleOccupant(source) then
		player = getVehicleOccupant(source)
		health = getElementHealth(player)
		if loss == 50 or loss < 50 and loss > 25 then
			if health < 2.5 then
				killPed(player)
			else
				setElementHealth(player, health - 2.5)
				fadeCamera(player, false, 1, 255, 0, 0)
				setTimer(fadeCamera, 250, 1, player, true)
			end
		elseif loss == 100 or loss < 100 and loss > 50 then
			if health < 5 then
				killPed(player)
			else
				setElementHealth(player, health - 5)
				fadeCamera(player, false, 1, 255, 0, 0)
				setTimer(fadeCamera, 300, 1, player, true)
			end
		elseif loss == 500 or loss < 500 and loss > 100 then
			if health < 5 then
				killPed(player)
			else
				setElementHealth(player, health - 8)
				fadeCamera(player, false, 1, 255, 0, 0)
				setTimer(fadeCamera, 350, 1, player, true) 
			end
		end
	end
end
addEventHandler("onVehicleDamage", getRootElement(), lossHealthOnHurt)

function damagedCars(theVehicle, seat, jacked)
	if getElementHealth(theVehicle) < 250 or getElementHealth(theVehicle) == 250 then
		setTimer(setVehicleEngineState, 250, 1, theVehicle, false)
	end
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), damagedCars)

for i,vehicles in ipairs(getElementsByType("vehicle")) do
	setElementData(vehicles, "StartedScript", "no")
end