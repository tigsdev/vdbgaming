local isDx = false
local sx,sy = guiGetScreenSize ( )
remainingTimeK = 30
l_tick = getTickCount ( )

function dxDrawKill ( )
	isDx = true
	showCursor ( true )    
	dxDrawText ( "Você será morto em: "..tostring ( remainingTimeK ).. " segundos", 0, 0, (sx/1.1)+2, (sy/1.1)+2, tocolor ( 0, 0, 0, 255 ), 2.5, 'default-bold', 'right', 'bottom' )
	dxDrawText ( "Você será morto em: "..tostring ( remainingTimeK ).. " segundos", 0, 0, sx/1.1, sy/1.1, tocolor ( 255, 255, 0, 255 ), 2.5, 'default-bold', 'right', 'bottom' )
	if ( getTickCount ( ) - l_tick >= 1000 ) then
		remainingTimeK = remainingTimeK - 1
		l_tick = getTickCount ( )
		if ( remainingTimeK < 0 ) then
			remainingTimeK = nil
			l_tick = nil
			isDx = false
			removeEventHandler ( "onClientRender", root, dxDrawKill )
			triggerServerEvent ( "killP", localPlayer, localPlayer )
			showCursor ( false )
		end
	end
end

function turnDxOn ( )
	if isPedInVehicle ( localPlayer ) then
		exports['VDBGMessages']: sendClientMessage ( "Por favor, saia de seu veículo.", 255, 255, 0 )
	elseif getElementData ( localPlayer, "VDBGEvents:IsPlayerInEvent" ) then
		exports['VDBGMessages']: sendClientMessage ( "Você não pode ser morto em um evento.", 255, 255, 0 )
	elseif getElementData ( localPlayer, "VDBGPolice:JailTime" ) then
		exports['VDBGMessages']: sendClientMessage ( "Você não pode ser morto em uma prisão.", 255, 255, 0 )
	else
		if not isDx	then 
			l_tick = getTickCount ( )
			remainingTimeK = 5
			addEventHandler ( "onClientRender", root, dxDrawKill )
		else
			isDx = false
			exports.VDBGMessages:sendClientMessage ( "Suícidio cancelado", 255, 255, 0 )
			removeEventHandler ( "onClientRender", root, dxDrawKill )
		end
	end
end
addCommandHandler ( "kill", turnDxOn )