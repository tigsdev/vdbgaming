local remainingTime = nil
local sx, sy = guiGetScreenSize ( )

addEvent ( "onPlayerArrested", true )
addEventHandler ( "onPlayerArrested", root, function ( dur )
	if dur then
		remainingTime = dur
		l_tick = getTickCount ( )
		addEventHandler ( 'onClientRender', root, dxDrawRemainingJailTime )
	end
end )

function dxDrawRemainingJailTime ( )
	dxDrawText ( tostring ( remainingTime ).. " segundos", 0, 0, (sx/1.1)+2, (sy/1.1)+2, tocolor ( 0, 0, 0, 255 ), 2.5, 'default-bold', 'right', 'bottom' )
	dxDrawText ( tostring ( remainingTime ).. " segundos", 0, 0, sx/1.1, sy/1.1, tocolor ( 255, 255, 0, 255 ), 2.5, 'default-bold', 'right', 'bottom' )
	if ( getTickCount ( ) - l_tick >= 1000 ) then
		remainingTime = remainingTime - 1
		l_tick = getTickCount ( )
		setElementData ( localPlayer, "VDBGPolice:JailTime", remainingTime ) 
		if ( remainingTime < 0 ) then
			triggerServerEvent ( "VDBGJail:UnjailPlayer", localPlayer, false )
			remainingTime = nil
			l_tick = nil
			removeEventHandler ( "onClientRender", root, dxDrawRemainingJailTime )
		end
	end
end

addEvent ( "VDBGJail:StopJailClientTimer", true )
addEventHandler ( "VDBGJail:StopJailClientTimer", root, function ( )
	remainingTime = nil
	l_tick = nil
	removeEventHandler ( "onClientRender", root, dxDrawRemainingJailTime )
end )