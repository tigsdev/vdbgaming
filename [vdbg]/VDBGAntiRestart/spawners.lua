local playerVehicles = { }
function createPlayerVehicle ( p, id, marker, warp )
	if ( isElement ( playerVehicles[p] ) ) then
		destroyElement ( playerVehicles[p] )
	end
	
	local x, y, z, rz = unpack ( getElementData ( marker, "SpawnCoordinates" ) )
	local job = getElementData ( marker, "VDBGVehicles:JobRestriction" ) or false
	
	playerVehicles[p] = createVehicle ( id, x, y, z, 0, 0, rz )
	exports['VDBGLogs']:outputActionLog ( getPlayerName ( p ).." spawned a(n) "..getVehicleNameFromModel ( id ) )
	if ( warp and isElement ( playerVehicles[p] ) ) then
		warpPedIntoVehicle ( p, playerVehicles[p] )
	end
	
	if job then
		setElementData ( playerVehicles[p], "VDBGAntiRestart:VehicleJobRestriction", tostring ( job ) )
		addEventHandler ( "onVehicleStartEnter", playerVehicles[p], checkRestrictions )
	end

	return playerVehicles[p]
end 

function checkRestrictions ( p, seat )
	if ( seat == 0 ) then
		local job = string.lower ( getElementData ( source, "VDBGAntiRestart:VehicleJobRestriction" ) or "false" )
		local pJob = string.lower ( getElementData ( p, "Job" ) or "" )
		if ( pJob ~= job and getElementData ( p, "Job Rank" ) ~= 'Level 5' ) then
			outputChatBox ( "#d9534f[VDBG.ORG] #ffffffEsse veículo é restrito para "..job.." você não pode entrar.", p, 255, 255, 255, true )
			cancelEvent ( )
		end
	end
end

addEventHandler ( 'onPlayerQuit', root, function ( )
	if ( isElement ( playerVehicles[source] ) ) then
		destroyElement ( playerVehicles[source] )
	end
end )




addEvent ( "VDBGSpawners:onVehicleCreated", true )