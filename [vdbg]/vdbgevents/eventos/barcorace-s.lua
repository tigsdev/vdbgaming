events[4] = { 
	name 						= 'Boat Racing',	-- The event name
	maxSlots 					= 20,				-- The max players for the event
	minSlots 					= 2,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
		{ 2943.79, -1535.86, -0.55, -20  },
		{ 2943.79, -1555.86, -0.55, -20 },
		{ 2943.79, -1575.86, -0.55, -20 },
		{ 2943.79, -1595.86, -0.55, -20 },
		{ 2943.79, -1615.86, -0.55, -20 },
		{ 2943.79, -1635.86, -0.55, -20 },
		{ 2943.79, -1655.86, -0.55, -20 },
		{ 2943.79, -1675.86, -0.55, -20 },
		{ 2943.79, -1695.86, -0.55, -20 },
		{ 2943.79, -1715.86, -0.55, -20 },
		{ 2943.79, -1735.86, -0.55, -20 },
		{ 2939.22, -1535.43, -0.55, -20 },
		{ 2939.22, -1555.43, -0.55, -20 },
		{ 2939.22, -1575.43, -0.55, -20 },
		{ 2939.22, -1595.43, -0.55, -20 },
		{ 2939.22, -1615.43, -0.55, -20 },
		{ 2939.22, -1635.43, -0.55, -20 },
		{ 2939.22, -1675.43, -0.55, -20 },
		{ 2939.22, -1695.43, -0.55, -20 },
		{ 2939.22, -1715.43, -0.55, -20 },
		{ 2939.22, -1735.43, -0.55, -20 },
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 473,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Apermitir aos jogadores para sair do veículo
	allowPositionOffset 		= true,			-- Deslocamento para urdiduras posição, usado para que os jogadores não deformar um no outro
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true				-- Quando definido como verdadeiro, única pessoa pode gerar em cada warp
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "VDBGEvents:Modules->BARCOStreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
		
	end
	return true
end

eventStartFunctions[4] = _G['tempFunction']
tempFunction = nil

addEvent ( "VDBGEvents:Modules->BARCORace:ThisPlayerWinsRace", true )
addEventHandler ( "VDBGEvents:Modules->BARCORace:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "VDBGEvents:Modules->BARCOStreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )