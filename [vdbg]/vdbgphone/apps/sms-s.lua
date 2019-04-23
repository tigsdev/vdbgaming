addEvent ( 'VDBGPhone:App.SMS:SendPlayerMessage', true )
addEventHandler ( 'VDBGPhone:App.SMS:SendPlayerMessage', root, function ( who, message )
	if ( who and isElement ( who ) ) then
		triggerClientEvent ( who, 'VDBGPhone:App.SMS:OnPlayerReciveMessage', who, source, message )
		exports['VDBGLogs']:outputChatLog ( "Phone:SMS", "From "..getPlayerName(source).." | To: "..getPlayerName(who).." | Message: "..message )
		outputChatBox( "#FFA500[VDBG.ORG] #ffffffSMS para #428bca[" ..getElementData(who,"id" ).. "] " .. getPlayerName( who ) .. ": #ffffff" .. message, source, 255, 255, 255, true )
		outputChatBox( "#FFA500[VDBG.ORG] #ffffffSMS de #428bca[" .. getElementData ( source, "id" ) .. "] " .. getPlayerName( source ) .. ": #ffffff" .. message, who, 255, 255, 255, true )
	end
end )