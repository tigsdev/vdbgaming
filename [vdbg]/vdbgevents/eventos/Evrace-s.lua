events[1] = { 
	name 						= 'Motocross ( MX )',	-- The event name
	maxSlots 					= 20,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
		{ -2375.48, -2197.02, 33.32, 294.7 },-- Warp position 1
		{ -2375.7, -2194.86, 33.35, 294.7 },	
		{ -2375.7, -2192.86, 33.35, 294.7 },
		{ -2373.61, -2196.95, 33.35, 294.7 },
		{ -2369.3, -2195.01, 33.42, 294.7 },
 		{ -2365.64, -2193.24, 33.48, 294.7 },
 		{ -2360.28, -2191.11, 33.58, 294.7 },
 		{ -2354.97, -2188.29, 33.66, 294.7 },
 		{ -2348.82, -2185.61, 33.82, 294.7 },
		{ -2356.84, -2192.66, 33.76, 294.7 },
		{ -2351.23, -2190.47, 33.89, 294.7 },
		{ -2346.24, -2187.28, 34.07, 294.7 },
		{ -2348.48, -2191.77, 33.77, 294.7 },
		{ -2375.68, -2194.17, 33.33, 294.7 },
		{ -2371.4, -2192.13, 33.38, 294.7 },
 		{ -2366.91, -2189.86, 33.48, 294.7 },
 		{ -2361.77, -2187.61, 33.57, 294.7 },
		{ -2354.34, -2184.83, 33.67, 294.7 },
		{ -2346.82, -2181.75, 34.12, 294.7 },
 		{ -2340.74, -2172.23, 34.41, 294.7 },
		{ -2357.68, -2168.29, 33.33, 294.7 },
 		{ -2357.84, -2171.69, 33.46, 294.7 },
 		{ -2360.57, -2175.85, 33.61, 294.7 },
 		{ -2371.92, -2184.87, 33.45, 294.7 },
		-- Warp position 2
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 468,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Allow players to exit the vehicle
	allowPositionOffset 		= false,				-- Position offset for warps, used so players don't warp into each other
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true				-- When set to true, only person can spawn at each warp
}


function StartSanchezRace ( ) 
	local m = createMarker ( -2314.18, -1618.83, 483.77, "checkpoint", 8, 0, 255, 255, 120 )
	setElementDimension ( m, eventInfo.dim )
	triggerClientEvent ( root, "VDBGEvents:Event.EverestRace:SetVehicleCollisions", root, eventObjects.playerItems )
	addEventHandler ( "onMarkerHit", m, function ( p )
		if ( not isElement ( p ) ) then
			return
		end
		
		if ( getElementType ( p ) == "player" and getElementDimension ( p ) == getElementDimension ( source ) and getElementInterior ( p ) == 0 ) then
			if ( getElementData ( p, "VDBGEvents:IsPlayerInEvent" ) and isPedInVehicle ( p ) ) then
				EventCore.WinPlayerEvent( p )
				destroyElement ( source )
			end
		end
	end )
	
	return true
end

eventStartFunctions[1] = _G['StartSanchezRace']
StartSanchezRace = nil