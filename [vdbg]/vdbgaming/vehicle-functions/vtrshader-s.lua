local siren = {}

addEventHandler("onVehicleEnter",root,function(player,seat)
    if(player)and(seat==0)then
		local veh = getPedOccupiedVehicle(player)
		local model = getElementModel(veh)
		if (model==598) or (model==597) or (model==596) then
			siren[1] = addVehicleSirens(source, 4, 2 )
			siren[1] = setVehicleSirens(source, 1, 0.4, -0.4, 1.0, 0, 0, 255, 255, 255) 
			siren[1] = setVehicleSirens(source, 2, -0.4, -0.4, 1.0, 255, 0, 0, 255, 255) 
			siren[1] = setVehicleSirens(source, 3, 0.2, -0.4, 1.0, 255, 255, 255, 255, 160) 
			siren[1] = setVehicleSirens(source, 4, -0.2, -0.4, 1.0, 255, 255, 255, 255, 160) 
		elseif (model==407) then -- tűzoltó 
			siren[2] = addVehicleSirens(source, 3, 2 )
			siren[2] = setVehicleSirens(source, 1, -0.7, 3.3, 1.4, 255, 0, 0, 191.3, 191.3)
			siren[2] = setVehicleSirens(source, 2, 0.6, 3.3, 1.4, 255, 0, 0, 191.3, 191.3)
			siren[2] = setVehicleSirens(source, 3, 0, 3.3, 1.4, 255, 255, 255, 191.3, 191.3)
		elseif (model==416) then -- mentő 
			siren[3] = addVehicleSirens(veh, 3, 2 )
			siren[3] = setVehicleSirens(veh, 1, -0.4, 0.9, 1.3, 255, 0, 0, 191.3, 191.3)
			siren[3] = setVehicleSirens(veh, 2, 0.4, 0.9, 1.3, 255, 0, 0, 191.3, 191.3)
			siren[3] = setVehicleSirens(veh, 3, 0, 0.9, 1.3, 255, 255, 255, 191.3, 191.3)
		elseif (model==599) then -- police ranger 
			siren[4] = addVehicleSirens(veh, 3, 2)
			siren[4] = setVehicleSirens(veh, 1, -0.3, -0.2, 1.1, 255, 0, 0, 191.3, 191.3)
			siren[4] = setVehicleSirens(veh, 2, 0.3, -0.2, 1.1, 0, 0, 255, 191.3, 191.3)
			siren[4] = setVehicleSirens(veh, 3, 0, -0.2, 1.1, 255, 102, 0, 191.3, 191.3)
		elseif (model==525) then -- towtruck
			siren[5] = addVehicleSirens(veh, 3, 2 )
			siren[5] = setVehicleSirens(veh, 1, -0.55, -0.5, 1.4, 255, 102, 0, 191.3, 255)
			siren[5] = setVehicleSirens(veh, 2, 0.55, -0.5, 1.4, 255, 102, 0, 191.3, 255)
			siren[5] = setVehicleSirens(veh, 3, 0, -0.5, 1.4, 255, 102, 0, 191.3, 255) -- narancs
		elseif (model==426) then
			siren[6] = addVehicleSirens(veh, 2, 2 )
			siren[6] = setVehicleSirens(veh, 2,0 , 0.58, 0.75, 255, 0, 0, 255, 255) -- piros
			siren[6] = setVehicleSirens(veh, 2,0 , 0.58, 0.75, 255, 0, 0, 255, 255) -- piros
		end
	end
end)

-- sziréna hang

addEventHandler("onResourceStart", resourceRoot,
	function()
		for _,v in ipairs(getElementsByType("player")) do
			bindKey(v, "h", "down", "TGS")
		end
	end
)
addEventHandler("onPlayerJoin", root,
	function()
		bindKey(source, "h", "down", "TGS")
	end
)
addCommandHandler("TGS",
	function(player, cmd)
		local vehicle = getPedOccupiedVehicle(player)
		if (vehicle) and (getVehicleController(vehicle) == player) then
			if (getElementData(vehicle, "veh:Siren")) then
				removeElementData(vehicle, "veh:Siren")
			else
				setElementData(vehicle, "veh:Siren", true, true)
			end
		end
	end
)