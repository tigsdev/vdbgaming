function onClientCallAd(player, ad,amout)
	local money = getPlayerMoney(player)
	if(money<amout)then	
		outputChatBox("#d9534f[AVISO] #0078BEVocê  #FFFFFFnao tem dinheiro suficiente!", player, 0,0,0,true)
        --exports.VDBGRadar:showBox(client, "error","Você não tem dinheiro suficiente!")
		return
	end
	takePlayerMoney(player, amout)
	outputChatBox (" ",getRootElement(),0,0,0,true)
	outputChatBox ("#0078BEAnuncio: #FFFFFF".. ad,getRootElement(),0,0,0,true)
	outputChatBox ("#acd373Por: #FFFFFF"..getElementData(source,"AccountData:Name"),getRootElement(),0,0,0,true)
	outputChatBox ("#acd373Contato: #FFFFFF/pm "..(getElementData(source, "accountID") or 0),getRootElement(),0,0,0,true)
	outputChatBox (" ", getRootElement(),0,0,0,true)
end
addEvent("onClientCallForAdData", true )
addEventHandler("onClientCallForAdData", getRootElement(), onClientCallAd)