addEvent ( "VDBGEvents:Event.EverestRace:SetVehicleCollisions", true )
addEventHandler ( "VDBGEvents:Event.EverestRace:SetVehicleCollisions", root, function (x ) 
	for i, veh in pairs ( x ) do
		for i, x in pairs ( x ) do
			setElementCollidableWith ( veh, x, false )
			setElementCollidableWith ( localPlayer, getVehicleController(x), false )
		end
	end
	setPedCanBeKnockedOffBike ( localPlayer, false )
end )