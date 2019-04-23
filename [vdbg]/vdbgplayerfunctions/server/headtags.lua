local playerTag = { }
addEventHandler ( "onPlayerMute", root, function ( )
	if ( isElement ( playerTag[source] ) ) then
		destroyElement ( playerTag[source] )
		playerTag[source] = nil 
	end
	setElementData(source, "mutado.admin", true)
end ) 

addEventHandler ( 'onPlayerUnmute', root, function ( )
	if ( isElement ( playerTag[source] ) ) then
		destroyElement ( playerTag[source] )
		playerTag[source] = nil
		setElementData(source, "mutado.admin", false)
	end
end )

addEventHandler ( "onPlayerQuit", root, function ( ) if ( isElement ( playerTag[source] ) ) then destroyElement ( playerTag[source] ) end end )
addEventHandler ( "onResourceStop", resourceRoot, function ( ) for i, v in pairs ( playerTag ) do  if ( isElement ( v ) ) then destroyElement ( v ) end end end )
addEventHandler ( "onResourceStart", resourceRoot, function ( ) for i, v in ipairs ( getElementsByType ( 'player' ) ) do  if ( isPlayerMuted ( v ) ) then playerTag[v] = exports['VDBGJobs']:create3DText ( "[MUTED]", { 0, 0, 0 }, { 255, 0, 0 }, source, { 5 } ) end end end )