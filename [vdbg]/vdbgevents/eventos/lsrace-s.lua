events[3] = { 
	name 						= 'Racha na Pinheiros',	-- The event name
	maxSlots 					= 20,				-- The max players for the event
	minSlots 					= 1,				-- The required amount of players
	warpPoses = {									-- Positions players will warp to on start
		-- { x, y, z, rot },
		{ 1329.92, -1408.34, 13.8, 90 },
		{ 1320.92, -1408.34, 13.76, 90 },
		{ 1308.92, -1408.34, 13.7, 90 },
		{ 1299.92, -1408.34, 13.68, 90 },
		{ 1286.92, -1408.34, 13.59, 90 },
		{ 1329.92, -1402.58, 13.83, 90 },
		{ 1320.92, -1402.58, 13.76, 90 },
		{ 1308.92, -1402.58, 13.7, 90 },
		{ 1299.92, -1402.58, 13.68, 90 },
		{ 1286.92, -1402.58, 13.59, 90 },
		{ 1329.92, -1397.84, 13.82, 90 },
		{ 1320.92, -1397.84, 13.76, 90 },
		{ 1308.92, -1397.84, 13.7, 90 },
		{ 1299.92, -1397.84, 13.68, 90 },
		{ 1286.92, -1397.84, 13.59, 90 },
		{ 1329.92, -1392.62, 13.77, 90 },
		{ 1320.92, -1392.62, 13.76, 90 },
		{ 1308.92, -1392.62, 13.7, 90 },
		{ 1299.92, -1392.62, 13.68, 90 },
		{ 1286.92, -1392.62, 13.59, 90 },
	},
	
	disableWeapons 				= true,				-- Force no weapons
	useGodmode 					= true,				-- Set players in godmode for the whole event
	warpVehicle 				= 503,				-- Model ID for players to be warped to, use false for none
	allowedVehicleExit 			= false,			-- Apermitir aos jogadores para sair do veículo
	allowPositionOffset 		= false,			-- Deslocamento para urdiduras posição, usado para que os jogadores não deformar um no outro
	allowLeaveCommand			= true,				-- Enable the player to use /leaveevent
	onlyOnePersonPerWarp		= true				-- Quando definido como verdadeiro, única pessoa pode gerar em cada warp
}


function tempFunction ( ) 
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "VDBGEvents:Modules->LSStreetRace:CreateCheckpoints", v, "CreateElements", getElementDimension ( v ) )
	end
	return true
end

eventStartFunctions[3] = _G['tempFunction']
tempFunction = nil

addEvent ( "VDBGEvents:Modules->LSRace:ThisPlayerWinsRace", true )
addEventHandler ( "VDBGEvents:Modules->LSRace:ThisPlayerWinsRace", root, function ( )
	for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		triggerClientEvent ( v, "VDBGEvents:Modules->LSStreetRace:CreateCheckpoints", v, "DestroyElements", getElementDimension ( v ) )
	end
	
	EventCore.WinPlayerEvent ( source )
end )