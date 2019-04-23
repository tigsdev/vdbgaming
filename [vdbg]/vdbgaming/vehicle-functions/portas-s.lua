------------------------------------
-- QUANTUMZ - QUANTUMZ - QUANTUMZ --
------------------------------------
--         2011 - Romania	  	  -- 	    
------------------------------------
-- You can modify this file but   --
-- don't change the credits.      --
------------------------------------
------------------------------------
--  VEHICLECONTROL v1.0 for MTA   --
------------------------------------


function openDoor(door, position)
	local vehicle = getPedOccupiedVehicle(source)
	if getPedOccupiedVehicleSeat(source) == 0 then
		if door == 0 then
			if position==0 then
				setVehicleDoorOpenRatio(vehicle, 0, 0, 0.5)
			end
			if position==100 then
				setVehicleDoorOpenRatio(vehicle, 0, 1, 0.5)
			end
			if position>0 and position<100 then
				setVehicleDoorOpenRatio(vehicle, 0, position/100, 0.5)
			end
		end
		if door == 1 then
			if position==0 then
				setVehicleDoorOpenRatio(vehicle, 1, 0, 0.5)
			end
			if position==100 then
				setVehicleDoorOpenRatio(vehicle, 1, 1, 0.5)
			end
			if position>0 and position<100 then
				setVehicleDoorOpenRatio(vehicle, 1, position/100, 0.5)
			end
		end
		if door == 2 then
			if position==0 then
				setVehicleDoorOpenRatio(vehicle, 2, 0, 0.5)
			end
			if position==100 then
				setVehicleDoorOpenRatio(vehicle, 2, 1, 0.5)
			end
			if position>0 and position<100 then
				setVehicleDoorOpenRatio(vehicle, 2, position/100, 0.5)
			end
		end
		if door == 3 then
			if position==0 then
				setVehicleDoorOpenRatio(vehicle, 3, 0, 0.5)
			end
			if position==100 then
				setVehicleDoorOpenRatio(vehicle, 3, 1, 0.5)
			end
			if position>0 and position<100 then
				setVehicleDoorOpenRatio(vehicle, 3, position/100, 0.5)
			end
		end
		if door == 4 then
			if position==0 then
				setVehicleDoorOpenRatio(vehicle, 4, 0, 0.5)
			end
			if position==100 then
				setVehicleDoorOpenRatio(vehicle, 4, 1, 0.5)
			end
			if position>0 and position<100 then
				setVehicleDoorOpenRatio(vehicle, 4, position/100, 0.5)
			end
		end
		if door == 5 then
			if position==0 then
				setVehicleDoorOpenRatio(vehicle, 5, 0, 0.5)
			end
			if position==100 then
				setVehicleDoorOpenRatio(vehicle, 5, 1, 0.5)
			end
			if position>0 and position<100 then
				setVehicleDoorOpenRatio(vehicle, 5, position/100, 0.5)
			end
		end
	end
end		
addEvent("moveThisShit", true)
addEventHandler("moveThisShit", getRootElement(), openDoor)
