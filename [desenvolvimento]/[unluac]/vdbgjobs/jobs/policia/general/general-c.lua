local locs = { --[[DPLS]]{1529.36, -1627.69, 13.38}, --[[DPSF]]{-1558.91, 661.5, 7.04} }

local e = { ['blip'] = { }, ['marker'] = { } }

addEvent ( "onPlayerStartArrested", true )
addEventHandler ( "onPlayerStartArrested", root, function ( p, c)
	if ( c == localPlayer ) then
		for i, v in ipairs ( locs ) do
			local x, y, z = unpack ( v )
			e['marker'][i] = createMarker ( x, y, z - 1, "checkpoint", 1.8, 0, 120, 255, 120 )
			e['blip'][i] = createBlip ( x, y,z, 30 )
			addEventHandler ( "onClientMarkerHit", e['marker'][i], function ( p )
				if ( p == localPlayer ) then
					for i, v in pairs ( e ) do 
						for i, v in pairs ( v ) do 
							if ( isElement ( v ) ) then
								destroyElement ( v )
							end
						end
					end 
					triggerServerEvent ( "vdbgpolice:onJailCopCrimals", localPlayer )
				end
			end )
		end
	end
end )

addEvent ( "onPlayerEscapeCop", true )
addEventHandler ( "onPlayerEscapeCop", root, function ( player, cop, arrestedCrims )
	if ( cop == localPlayer ) then
		if ( type ( arrestedCrims ) ~= "table" or #arrestedCrims <= 0 ) then
			for i, v in pairs ( e ) do 
				for i, v in pairs ( v ) do 
					if ( isElement ( v ) ) then
						destroyElement ( v )
					end
				end
			end 
		end
	end
end )