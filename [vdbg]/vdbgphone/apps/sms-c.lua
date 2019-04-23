addEvent ( "VDBGPhone:App.SMS:OnPlayerReciveMessage", true )
addEventHandler ( "VDBGPhone:App.SMS:OnPlayerReciveMessage", root, function ( from, message )
	local second, minute, hour = getThisTime ( )
	outputChatBox ( getPlayerName ( from ).." Enviou-lhe uma mensagem! Use /celular -> SMS para visualizá-la.", 255, 255, 255, true )
	playSound ( ":VDBGPhone/audio/alerta.mp3" )
	if ( not pages['sms'].sMessages[from] ) then
		pages['sms'].sMessages[from] = ""
	end
	local message = "["..table.concat({hour,minute,second},":").."] Ele(a): "..message.."\n"
	pages['sms'].sMessages[from] = pages['sms'].sMessages[from]..message
	if ( pages['sms'].selectedPlayer == from ) then
		guiSetText ( pages['sms'].messages, pages['sms'].sMessages[from] )
	end
	pages['sms'].fromLast = from
	
end )

function sms_reply ( cmd, ... )
	if pages['sms'].fromLast and isElement ( pages['sms'].fromLast ) then
		if ... then
			local msg = table.concat ( { ... }, " " )
			triggerServerEvent ( "VDBGPhone:App.SMS:SendPlayerMessage", localPlayer, pages['sms'].fromLast, msg )
			outputChatBox ( "#FFA500[SMS] #ffffffA mensagem enviada "..tostring ( getPlayerName ( pages['sms'].fromLast ) ).."!", 255, 255, 255, true )
		else
			outputChatBox ( "#FFA500[SMS] #ffffffComando: /"..cmd.." [mensagem]", 255, 255, 255, true )
		end
	else
		outputChatBox ( "#FFA500[SMS] #ffffffSeu último remetente da mensagem recebida não existe mais.", 255, 255, 255, true )
	end
end
addCommandHandler ( 're', sms_reply )
addCommandHandler ( 'responder', sms_reply )