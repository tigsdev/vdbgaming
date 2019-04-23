addEvent("playerChatting", true )
addEvent("playerNotChatting", true )

function playerChatting()
		
	triggerClientEvent("updateChatList", getRootElement(), source, true)
end

function playerNotChatting()
		
	triggerClientEvent("updateChatList", getRootElement(), source, false)
end

addEventHandler("playerChatting", getRootElement(), playerChatting)
addEventHandler("playerNotChatting", getRootElement(), playerNotChatting)
addEventHandler ("onPlayerQuit", getRootElement(), playerNotChatting )