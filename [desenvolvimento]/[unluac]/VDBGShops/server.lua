function buyItem(item, value, price, db, count, activeitem, name)
	if tonumber(price) > 1 then 
	 newprice = price * --[[multiplica pela quantidade :v ]] count
	end
	 orprice = getPlayerMoney(source) - newprice
	 if getPlayerMoney (source) > newprice then
	 exports.VDBGItem:giveItem(source, item, value, count, db)
	 outputChatBox("#d9534f[VDBG.ORG] #ffffffVocê comprou #acd373("..count..") #1c8ae8"..tostring(name).." #ffffffpor #1c8ae8 R$ "..tonumber(newprice)..",00 #ffffffreais",source, 255, 255, 255, true )
	 takePlayerMoney ( source, tonumber(newprice) ) 
	 else
	 outputChatBox("#d9534f[VDBG.ORG] #ffffffVocê precisa de #acd373R$ "..string.gsub(orprice, "-", "")..",00 reais #ffffffpara concluir a compra de #acd373("..count..") #1c8ae8"..tostring(name).."",source, 255, 255, 255, true )
	 end
end
addEvent("addItem", true)
addEventHandler("addItem", getRootElement(), buyItem)



