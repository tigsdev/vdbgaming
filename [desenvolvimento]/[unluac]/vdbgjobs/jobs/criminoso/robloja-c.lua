
cooldown = {}
function targetingActivated ( target )

	local theTeam = getPlayerTeam ( localPlayer )
	if not isTimer(cooldown[localPlayer] ) and getControlState("aim_weapon") and 
		getElementInterior( localPlayer ) > 0 and isElement( target ) and 
		( getPlayerTeam( localPlayer ) == getTeamFromName( "Criminoso" ) or
		getPlayerTeam( localPlayer ) == getTeamFromName( "Civilizante" ) or
		getPlayerTeam( localPlayer ) == getTeamFromName( "Desempregado" )) then 
		
		outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFVocê roubou a loja, fuja antes que os policias cheguem!", player, 255, 255, 0 )
        triggerServerEvent( "onRob", localPlayer, target ) 
        cooldown[localPlayer] = setTimer(function() end, 200000, 1 )
    end
end
addEventHandler ( "onClientPlayerTarget", getRootElement(), targetingActivated )

function showTimeLeft( )
	if getElementData( localPlayer, "rob" ) then
		local endTime = tonumber( getElementData( localPlayer, "robTime" ))
		local currentTime = tonumber( getElementData( localPlayer, "robTime2" ))
		local sx, sy = guiGetScreenSize( )
		dxDrawText ( "Tempo restante: "..tostring(math.floor((endTime-currentTime)/1000)), sx-300, sy-50, 0, 0, tocolor( 255, 0, 0, 255 ), 1.5, "default-bold" )
	end
end
addEventHandler( "onClientRender", root, showTimeLeft )

addEventHandler( "onClientResourceStop", ResourceRoot,
function()
removeEventHandler( "onClientRender", root, showTimeLeft )
end)