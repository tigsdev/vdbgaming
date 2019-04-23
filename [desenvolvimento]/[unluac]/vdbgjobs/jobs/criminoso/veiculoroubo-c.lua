-- Criminal:Theft:setWaypointsVisible


local waypoints = {
	{ 1851.74, -1863.01, 13.58 },
	{ 1850.68, -1884.32, 13.44 },
	{ -2436.11, 1037.87, 50.39 },
}
local waypoint = { blip = { }, marker = { } }
addEvent ( "Criminal:Theft:setWaypointsVisible", true )
addEventHandler ( "Criminal:Theft:setWaypointsVisible", root, function ( s )
	if ( s ) then
		for i, v in pairs ( waypoint ) do 
			for k, e in pairs ( v ) do 
				destroyElement ( e )
			end
		end
		waypoint = { blip = { }, marker = { } }
		for i, v in ipairs ( waypoints ) do
			local x, y, z = unpack ( v )
			waypoint.blip[i] = createBlip ( x, y, z, 53 )
			waypoint.marker[i] = createMarker ( x, y, z-1.3, "cylinder", 5, 255, 255, 0, 120 )
			addEventHandler ( 'onClientMarkerHit', waypoint.marker[i], CriminosoVehicleTheftCapture )
		end
	else
		for i, v in pairs ( waypoint ) do 
			for k, e in pairs ( v ) do 
				destroyElement ( e )
			end
		end
		waypoint = { blip = { }, marker = { } }
	end
end )

function CriminosoVehicleTheftCapture ( p )
	if ( p  and p == localPlayer and isPedInVehicle ( p ) ) then
		for i, v in pairs ( waypoint ) do 
			for k, e in pairs ( v ) do 
				destroyElement ( e )
			end
		end
		waypoint = { blip = { }, marker = { } }
		triggerServerEvent ( "Criminal:Theft:onPlayerCaptureVehicle", localPlayer )
	end
end
