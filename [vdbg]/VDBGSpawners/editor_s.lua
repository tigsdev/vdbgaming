addCommandHandler ( "spawners", function ( p )
	if ( exports['VDBGAdministration']:isPlayerStaff ( p ) ) then
		if ( exports['VDBGAdministration']:getPlayerStaffLevel ( p, 'int' ) >= 10 ) then
			local f = fileOpen ( 'data.lua' )
			local data = fileRead ( f, fileGetSize ( f ) )
			fileClose ( f )
			triggerClientEvent ( p, "VDBGSpawners:onStaffOpenEditor", p, data )
		end
	end
end )

addEvent ( 'VDBGSpawners:onAdminEditSpawnerList', true )
addEventHandler ( 'VDBGSpawners:onAdminEditSpawnerList', root, function ( data )
	local f = fileOpen ( 'data.lua' )
	fileWrite ( f, tostring ( data ) )
	fileClose ( f  )
	exports['VDBGLogs']:outputActionLog ( "Spawners updated" )
	restartResource ( getThisResource ( ) ) 
end )