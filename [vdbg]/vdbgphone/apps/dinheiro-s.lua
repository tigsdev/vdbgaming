addEvent ( "VDBGPhone:App.Money:sendPlayerMoney", true )
addEventHandler ( "VDBGPhone:App.Money:sendPlayerMoney", root, function ( p, amount )
	if ( getPlayerMoney ( source ) < amount ) then
		return outputChatBox ( "Você não tem muito dinheiro.", source, 255, 0, 0 )
	end
	if ( isElement ( p ) ) then
		outputChatBox ( "#FFA500[APPBANCO] #ffffffEnviando R$"..amount.." para "..getPlayerName ( p ).."!", source, 255, 255, 255, true )
		outputChatBox ( "#FFA500[APPBANCO] #ffffff"..getPlayerName ( source ).." enviou para você R$"..amount.."!", p, 255, 255, 255, true )
		takePlayerMoney ( source, amount ) 
		givePlayerMoney ( p, amount )
		
		local acc1 = getAccountName ( getPlayerAccount ( source ) )
		local acc2 = getAccountName ( getPlayerAccount ( p ) )
		exports['VDBGLogs']:outputActionLog ( getPlayerName ( source ).."("..acc1..") enviado "..getPlayerName(p).."("..acc2..") $"..amount )
	end
end )