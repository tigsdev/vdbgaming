local spawners = { 
	['Free'] = { },
	['Job'] = { }
}
local spawnedVehciles = { }
function createFreeSpawner ( x, y, z, rz, sx, sy, sz )
	local i = #spawners['Free']+1
	local z = z - 1
	local sx, sy, sz = sx or x, sy or y, sz or z+1.5
	local rz = rz or 0
	spawners['Free'][i] = createMarker ( x, y, z, 'cylinder', 2, 255, 255, 255, 120 )
	setElementData ( spawners['Free'][i], "SpawnCoordinates", { sx, sy, sz, rz } )
	setElementData ( spawners['Free'][i], "VDBGVehicles:SpawnVehicleList", JobVehicles['Free'] )
	setElementData ( spawners['Free'][i], "VDBGVehicles:JobRestriction", false )
	addEventHandler ( "onMarkerHit", spawners['Free'][i], onSpawnerHit )
	return spawners['Free'][i]
end

function createJobSpawner ( job, x, y, z, colors, rz, sx, sy, sz )
	local i = #spawners['Job']+1
	local z = z - 1
	local sx, sy, sz = sx or x, sy or y, sz or z+1.5
	local rz = rz or 0
	local r, g, b = unpack ( colors )
	spawners['Job'][i] = createMarker ( x, y, z, 'cylinder', 7, r, g, b, 50 )
	setElementData ( spawners['Job'][i], "SpawnCoordinates", { sx, sy, sz, rz } )
	setElementData ( spawners['Job'][i], "VDBGVehicles:SpawnVehicleList", JobVehicles[job] )
	setElementData ( spawners['Job'][i], "VDBGVehicles:JobRestriction", tostring ( job ) )
	exports.VDBG3DTEXT:create3DText ( job, { sx, sy, sz }, { r, g, b }, { nil, true },  '', "CarroJob" , 'Spawner')
	addEventHandler ( "onMarkerHit", spawners['Job'][i], onSpawnerHit )
	return spawners['Job'][i]
end


function onSpawnerHit ( p )
	local job = string.lower ( getElementData ( source, "VDBGVehicles:JobRestriction" ) or "false" )
	if ( job == 'false' ) then job = false end
	local pJob =  string.lower ( getElementData ( p, "Job" ) or "" )
	if ( job ) then
		if ( pJob ~= job ) then
			outputChatBox ( "#d9534f[VDBG.ORG] #ffffffSpawner restrito para: #FFA500"..job..".", p, 255, 255, 255, true )
			return
		end
	end
	
	if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) ) then
		local list = getElementData ( source, "VDBGVehicles:SpawnVehicleList" );
		triggerClientEvent ( p, 'VDBGSpawners:ShowClientSpawner', p, list, source )
		triggerEvent ( "VDBGSpawners:onPlayerOpenSpawner", source, p )
	end
end


addEvent ( "VDBGSpawners:spawnVehicle", true )
addEventHandler ( "VDBGSpawners:spawnVehicle", root, function ( id, x, y, z, rz, job ) 
	local c = exports['VDBGAntiRestart']:createPlayerVehicle ( source, id, x, y, z, rz, true, job )
end )



for i, v in pairs ( data ) do 
	if ( i == 'Free' ) then
		for k, e in ipairs ( v ) do 
			createFreeSpawner ( unpack ( e ) )
		end
	elseif ( i == 'Jobs' ) then
		for k, e in ipairs ( v ) do 
			createJobSpawner ( unpack ( e ) )
		end
	end
end

addEvent ( "VDBGSpawners:onPlayerOpenSpawner", true )