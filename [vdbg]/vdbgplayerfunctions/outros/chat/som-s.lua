function chat (thePlayer)
triggerClientEvent("sonido",getRootElement())
end
addEventHandler ( "onPlayerChat", getRootElement(), chat )