
local houses = {}
local garage = {}

-- Serverside events
addEvent( "VDBGHouse:OnRequestPlayerHouses", true )
addEvent( "VDBGHouse:OnPlayerSelectHouseFromList", true)
addEvent( "VDBGHouse:onClientCall", true )
addEvent( "VDBGHouse:HouseOptions_DoAction", true )

addEventHandler( "onResourceStart", resourceRoot,
	function ( )
		exports['VDBGSQL']:db_exec( "CREATE TABLE IF NOT EXISTS houses ( owner TEXT, ID INT,\
				pickupPos TEXT, iTeleportPos TEXT, iPickupPos TEXT, teleportExitPos TEXT,\
				interior INT, dimension INT, cost INT, locked INT, forSale INT,\
				house_guest TEXT, garageType INT, gmarkerPos TEXT, gmarkerSize INT )" )
		
		for i, v in ipairs( exports['VDBGSQL']:db_query( "SELECT * FROM houses" ) ) do
		
			local px,py,pz = unpack(fromJSON(v["pickupPos"]))
			local tx,ty,tz,trot = unpack(fromJSON(v["iTeleportPos"]))
			local ipx,ipy,ipz = unpack(fromJSON(v["iPickupPos"]))
			local tex,tey,tez,terot = unpack(fromJSON(v["teleportExitPos"]))
			
			-- Remova isto se fizer o auto increment
			exports["VDBGSQL"]:db_exec( "UPDATE houses SET ID='".. i .."' WHERE ID=?", v["ID"] )
			
			createHouse( false, px,py,pz, tx,ty,tz,trot, ipx,ipy,ipz, tex,tey,tez,terot,
						v["interior"], v["cost"], fromJSON(v["gmarkerPos"]), v["gmarkerSize"],
						v["dimension"], v["garageType"], v["gmarkerSize"] and true or false )
			
			setHouseOwner( i, v["owner"] )
			setHouseLocked( i, v["locked"] )
			setHouseForSale( i, v["forSale"] )
			if v["forSale"] == 0 then
				setTimer( createGarageForHouse, 50, 1, i, v["garageType"], v["dimension"] )
			end
		end
	end
)

function createHouse( add, px,py,pz, tx,ty,tz,trot, ipx,ipy,ipz, tex,tey,tez,terot,
		int, cost, markerPos, markerSize, dim, garageType, withGarage )
		
	tx, ty, tz, trot = tonumber(tx), tonumber(ty), tonumber(tz), tonumber(trot)
	tex, tey, tez, terot = tonumber(tex), tonumber(tey), tonumber(tez), tonumber(terot)
	local markerX, markerY, markerZ
	if not (tonumber(markerPos[1])) then markerPos = nil end;
	if not (markerSize) or (markerSize == 0) then markerSize = nil end
	
	local i = #houses + 1
	houses[ i ] = {}
	houses[i].pickup = createPickup( tonumber(px), tonumber(py), tonumber(pz), 3, 1273, 0 )
	setElementID(houses[i].pickup, tostring(i))
	setElementData(houses[i].pickup, "VDBGHouse-Pickup_Entrance", true)
	setElementData(houses[i].pickup, "VDBGHouse-Cost", tonumber(cost))
	
	houses[i].exitPickup = createPickup( tonumber(ipx), tonumber(ipy), tonumber(ipz), 3, 1273, 0 )
	setElementInterior(houses[i].exitPickup, tonumber(int))
	setElementID(houses[i].exitPickup, tostring(i))
	
	houses[i].houseLocation = toJSON({ getZoneName(px,py,pz), getElementCity(houses[i].pickup) })
	houses[i].teleports = { tx,ty,tz,trot, tex,tey,tez,terot, int=tonumber(int), garageType=tonumber(garageType) or false }
	
	if withGarage then
		markerSize = tonumber(markerSize)
		markerX, markerY, markerZ = unpack(markerPos)
		houses[i].garageM = createMarker(markerX, markerY, markerZ, "cylinder", markerSize, 220, 0, 0, 180)
		setElementAlpha(houses[i].garageM, 0)
		setElementData(houses[i].garageM, "VDBGHouse-house_pickup_entrance", houses[i].pickup, false)
		houses[i].garageArrowDown = createPickup(markerX, markerY, markerZ + 1.2, 3, 1318, 0)
		addEventHandler("onMarkerHit", houses[i].garageM, enterHouseGarage)
	end
	
	if add then
		local id = i
		if id == 1 then dim = 2000
		else dim = getDataFromHouse(id - 1, "dimension") + 1
		end
		exports['VDBGSQL']:db_exec ( "INSERT INTO `houses` ( `owner`, `ID`, `pickupPos`, `iTeleportPos`, `iPickupPos`, `teleportExitPos`, `interior`, `dimension`, `cost`, `locked`, `forSale`, `house_guest`, `garageType`, `gmarkerPos`, `gmarkerSize` ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );", "", id, toJSON({ px,py,pz }), toJSON({ tx,ty,tz,trot }), toJSON({ ipx,ipy,ipz }), toJSON({ tex,tey,tez,terot }), tonumber(int), dim, tonumber(cost), 0, 1, toJSON({ }), tonumber(garageType) or false, toJSON({ markerX,markerY,markerZ }), markerSize )	
		if (getElementInterior(client) ~= 0) then setElementDimension(client, dim) end
	end
	setElementDimension(houses[i].exitPickup, tonumber(dim))
	houses[i].teleports.dim = tonumber(dim)
	
	return true	
end
addEvent("VDBG:CreateHouse", true)
addEventHandler("VDBG:CreateHouse", root, createHouse)

addCommandHandler( "criarcasa",
	function ( sourcePlayer )
		if not isGuestAccount( getPlayerAccount(sourcePlayer) ) and isAdmin(sourcePlayer) then
			triggerClientEvent(sourcePlayer, "VDBGHouse:onServerCall", sourcePlayer, 1)
		end
	end, false, false
)

addCommandHandler( "deletarcasa",
	function ( sourcePlayer, cmd, houseID )
		if isAdmin(sourcePlayer) then
			houseID = tonumber(houseID)
			if exports["VDBGSQL"]:db_exec ( "DELETE FROM houses WHERE ID=?", houseID ) then
				local pos = { getElementPosition(houses[houseID].pickup) }
				local acc_owner = getElementData( houses[houseID].pickup, "VDBGHouse-HouseOwner" ) or false
				for _, houseElem in pairs( {houses[houseID].pickup, houses[houseID].exitPickup, houses[houseID].garageM, houses[houseID].garageArrowDown} ) do
					if isElement(houseElem) then destroyElement(houseElem) end
				end
				setTimer(destroyHouseGarage, 80, 1, getAccountPlayer(getAccount(acc_owner)), houseID)
				if acc_owner and getAccount(acc_owner) and getAccountPlayer( getAccount(acc_owner) ) then
					triggerClientEvent( getAccountPlayer( getAccount(acc_owner) ), "VDBGHouse:onRequestUpdateHouseList",
								getAccountPlayer( getAccount(acc_owner) ), 1, houseID, true )
				end
				outputChatBox("#d9534f[VDBG.ORG] #FFFFFFCasa deletada com sucesso! (ID: ".. tostring(houseID) ..")", sourcePlayer, 255, 255, 255, true)
				outputServerLog("[/deletarcasa] '"..getPlayerName(sourcePlayer).."' deletou a casa #"..tostring(houseID))
				houses[houseID] = nil
			end
		end
	end, false, false
)

addCommandHandler( "hospedes",
	function ( player, cmd, houseID )
		if not tonumber(houseID) or not isElement(houses[tonumber(houseID)].pickup) then return end;
		if getAccountName(getPlayerAccount(player)) == (getElementData( houses[tonumber(houseID)].pickup, "VDBGHouse-HouseOwner" ) or "")
			or isAdmin(player) then
			local guestTable = fromJSON( getDataFromHouse(tonumber(houseID), "house_guest") )
			if #guestTable < 1 then return outputChatBox("#d9534f[VDBG.ORG] #FFFFFFA casa #"..tostring(houseID).." não tem nenhum hóspede", player, 255, 255, 255, true) end;
			outputChatBox("#d9534f[VDBG.ORG] #FFFFFFHóspedes - casa #"..tostring(houseID).." ("..#guestTable.." Hóspede"..(#guestTable > 1 and "s" or "").."):", player, 255, 255, 255, true)
			for i, name in ipairs(guestTable) do
				outputChatBox("#d9534f[VDBG.ORG] #FFFFFF* "..tostring(name), player, 255, 255, 255, true)
			end
		end
	end, false, false
)

function tryBuyHouse( id )
	local acc = getPlayerAccount(client)
	local q = exports['VDBGSQL']:db_query ( "SELECT * FROM houses WHERE owner=? ", tostring(getAccountName(acc)) )
	if #q <= getElementData(client,"maxPlayerHouseSlots") then
		if tonumber(id) and getPlayerAccount(client) and not isGuestAccount(getPlayerAccount(client)) then
			local acc = getPlayerAccount(client)
			id = tonumber(id)
			if getPlayerMoney(client) >= tonumber(getDataFromHouse(id, "cost")) then
				takePlayerMoney(client, tonumber(getDataFromHouse(id, "cost")))
				setHouseOwner( id, getAccountName(acc) )
				setHouseForSale( id, 0 )
				setTimer( createGarageForHouse, 80, 1, id, houses[id].teleports.garageType, houses[id].teleports.dim )
				local px,py,pz = getElementPosition(houses[id].pickup)
				triggerClientEvent(client, "VDBGHouse:onRequestUpdateHouseList", client, 1, toJSON({ id, getZoneName(px,py,pz) }))
				outputChatBox("#d9534f[VDBG.ORG] #FFFFFFVocê adquiriu essa casa por R$"..convertNumber( tonumber(getDataFromHouse(id, "cost")) ).." !", client, 255, 255, 255, true)
			else
				outputChatBox("#d9534f[VDBG.ORG] #FFFFFFDinheiro insuficiente para comprar essa casa.", client, 255, 255, 255, true)
			end
		end
	else
		outputChatBox("#d9534f[VDBG.ORG] #FFFFFFVocê atingiu o limite de casas.", client, 255, 255, 255, true)
	end
end

addEventHandler( "VDBGHouse:onClientCall", root, 
	function( action_id, houseid, insideGarage )
		if houseid then
			houseid = tonumber(houseid)
		end
		if (action_id == 1) then
			tryBuyHouse( houseid )
		elseif (action_id == 2) then
			pre_warpPlayerToGarage( client, houseid )
		elseif (action_id == 3) then
			setPlayerOutside( houseid, client, insideGarage )
		elseif (action_id == 4) then
			setPlayerInsideInterior( houseid )
		elseif (action_id == 5) then
			onClientRequestInterior()
		elseif (action_id == 6) then
			local id = -1
			for i, name in pairs( fromJSON(getDataFromHouse(houseid, "house_guest")) ) do
				if getAccountName(getPlayerAccount(client)) == name then id = houseid end
			end
			if getElementData(houses[houseid].pickup, "VDBGHouse-HouseOwner") == getAccountName(getPlayerAccount(client)) then
				id = "owner"
			end
			triggerClientEvent(client, "VDBGHouse:onServerCall", client, 3, id)
		end
	end
)

function createGarageForHouse( houseID, htype, dim )
	houseID = tonumber(houseID)
	garage[houseID] = {}
	if htype == 1 then
		-- Garagem 1 mapeada aqui
		garage[houseID].hgarage = createObject(11326, 2438.7, -1562.6, 3186.8)
		garage[houseID].hgaragedoor = createObject(11327, 2453.7, -1554.5, 3187.1001, 0,0,270)
		-- Estes 2 permanecem (só muda a posição)
		garage[houseID].markerExit = createMarker(2453.54, -1556.6, 3184.6, "cylinder", 2, 220,0,0,160)
		garage[houseID].arrowDown = createPickup(2453.54, -1556.6, 3184.6 + 1.2, 3, 1318, 0)
		
		setElementDimension(garage[houseID].hgarage, tonumber(dim))
		setElementDimension(garage[houseID].hgaragedoor, tonumber(dim))
		--
		setElementDimension(garage[houseID].markerExit, tonumber(dim))
		setElementDimension(garage[houseID].arrowDown, tonumber(dim))
		setElementID(garage[houseID].markerExit, "VDBGHouse:Marker_Exit_Garage_"..tostring(houseID))
		setTimer(setElementAlpha, 50, 1, garage[houseID].markerExit, 0)
	elseif htype == 2 then
		-- Garagem 2 mapeada aqui
		garage[houseID].hgarage = createObject(11326, 2438.7, -1562.6, 3196.8)
		
		garage[houseID].markerExit = createMarker(2453.54, -1556.6, 3184.6, "cylinder", 2, 220,0,0,160)
		garage[houseID].arrowDown = createPickup(2453.54, -1556.6, 3184.6 + 1.2, 3, 1318, 0)
		
		setElementDimension(garage[houseID].hgarage, tonumber(dim))
		--
		setElementDimension(garage[houseID].markerExit, tonumber(dim))
		setElementDimension(garage[houseID].arrowDown, tonumber(dim))
		setElementID(garage[houseID].markerExit, "VDBGHouse:Marker_Exit_Garage_"..tostring(houseID))
		setTimer(setElementAlpha, 50, 1, garage[houseID].markerExit, 0)
	end
end

function destroyHouseGarage( player, houseID )
	houseID = tonumber(houseID)
	if garage[houseID] then
		if isElement(garage[houseID].vehicle) then
			respawnVehicle(garage[houseID].vehicle)
			garage[houseID].vehicle = nil
			if isElement(player) then outputChatBox("#d9534f[VDBG.ORG] #FFFFFFO seu veículo foi respawnado", player, 255, 255, 255, true) end
		end
		for k, v in pairs( garage[houseID] ) do
			destroyElement( garage[houseID][k] )
		end
		garage[houseID] = nil
		return true
	end
	return false
end

function createGarageForPlayer(player, houseID)
	if isElement(player) then
		local garageType = houses[ tonumber(houseID) ].teleports.garageType
		garage[ player ] = {
			{
				-- Garagem 1 mapeada aqui
				hgarage1 = createObject(11326, 2438.7, -1562.6, 3186.8),
				hgaragedoor = createObject(11327, 2453.7, -1554.5, 3187.1001, 0, 0, 270),
				markerExit = createMarker(2453.54, -1556.6, 3184.6,"cylinder",2, 220,0,0,160),
				createPickup(2453.54, -1556.6, 3184.6 + 1.2, 3, 1318, 0)
			 },
			{
				-- Garagem 2 mapeada aqui
				hgarage = createObject(11326, 2438.7, -1562.6, 3196.8),
				markerExit = createMarker(2453.54, -1556.6, 3184.6,"cylinder",2, 220,0,0,160),
				createPickup(2453.54, -1556.6, 3184.6 + 1.2, 3, 1318, 0)
			}
		}
		for i, v in pairs( garage[player][garageType] ) do
			setElementDimension(v, houses[ tonumber(houseID) ].teleports.dim)
			setElementVisibleTo(v, root, false)
			setElementVisibleTo(v, player, true)
		end
		setElementID(garage[player][garageType].markerExit, "VDBGHouse:Marker_Exit_Garage_"..tostring(houseID))
		setTimer(setElementAlpha, 50, 1, garage[player][garageType].markerExit, 0)
	end
end

function warpPlayerToGarage(player, houseID)
	local garageType = houses[ tonumber(houseID) ].teleports.garageType
	-- Teleporte do veículo para dentro da garagem
	local tele = { { 2453.32935, -1561.16345, 3185.82 }, { 2453.32935, -1561.16345, 3195.82 } }
	local tele_elements = { player, getPedOccupiedVehicle(player) or nil }
	for _, element in ipairs(tele_elements) do
		setElementInterior(element, 0)
		setElementDimension(element, houses[ tonumber(houseID) ].teleports.dim)
		setElementPosition(element, tele[garageType][1], tele[garageType][2], tele[garageType][3])
		if isElement(tele_elements[2]) then
			setElementRotation(tele_elements[2], 0, 0, 357.4) -- Rotação do veículo quando ir pra garagem
			garage[houseID].vehicle = tele_elements[2]
		else
			setPedRotation(element, 357.4) -- Rotação do jogador
		end
	end
	setTimer(setCameraPlayerMode, 300, 1, player)
	toggleAllControls(player, true, true, false)
	setTimer(fadeCamera, 500, 1, player, true, 1.0)
end

addEventHandler( "VDBGHouse:HouseOptions_DoAction", root,
	function ( menuid, houseid, arg3, player )
		if menuid == 1 then
			houseid = tonumber(houseid)
			if setHouseForSale(houseid, 1) then
				local cost = getDataFromHouse(houseid, "cost")
				setHouseOwner(houseid, "")
				setHouseLocked(houseid, 0 )
				setTimer(destroyHouseGarage, 80, 1, client, houseid)
				
				givePlayerMoney(client, tonumber(cost))
				outputChatBox("#d9534f[VDBG.ORG] #FFFFFFVocê vendeu a casa '#FFB478".. tostring(houseid) .."#B4FFB4' por R$".. convertNumber(cost), client, 255, 255, 255, true)
				
				setTimer(triggerClientEvent, 50, 1, client, "VDBGHouse:onRequestUpdateHouseList", client, 1, houseid, true)
				setTimer(triggerClientEvent, 50, 1, client, "VDBGHouse:SetMenuVisible", client, 1, false, true, "sell")
			end
		elseif menuid == 2 then
			houseid = tonumber(houseid)
			if exports["VDBGSQL"]:db_exec( "DELETE FROM houses WHERE ID=?", houseid ) then
				local pos = { getElementPosition(houses[houseid].pickup) }
				for _, houseElem in pairs( {houses[houseid].pickup, houses[houseid].exitPickup, houses[houseid].garageM, houses[houseid].garageArrowDown} ) do
					if isElement(houseElem) then destroyElement(houseElem) end
				end
				setTimer(destroyHouseGarage, 80, 1, client, houseid)
				triggerClientEvent(client, "VDBGHouse:onRequestUpdateHouseList", client, 1, houseid, true)
				outputChatBox("#d9534f[VDBG.ORG] #FFFFFF#FF3852Casa removida! #FF878BLocal: #E0E0E0"..getZoneName(pos[1], pos[2], pos[3]).." #FF878BID: #E0E0E0"..tostring(houseid), client, 255, 255, 255, true)
				houses[houseid] = nil
			else
				outputChatBox("#d9534f[VDBG.ORG] #FFFFFFOcorreu um erro ao deletar a casa!", client, 255, 255, 255, true)
				outputDebugString("VDBGHouse: Erro ao deletar casa do cliente: '"..getPlayerName(client).."'", 3, 255, 255, 255, true)
			end
		elseif menuid == 3 then
			local locked = getDataFromHouse(houseid, "locked")
			if not tonumber(locked) then return end;
			if tonumber(arg3) == locked then return outputChatBox("#d9534f[VDBG.ORG] #FFFFFF#FF496BEssa casa já está ".. (arg3 == 0 and "aberta" or "trancada") .."!", client, 255, 255, 255, true) end
			setHouseLocked(houseid, arg3)
			outputChatBox("#d9534f[VDBG.ORG] #FFFFFF#B4FFB4Você #A0DCFF".. (locked == 0 and "trancou" or "abriu") .." #B4FFB4a casa "..tostring(houseid), client, 255, 255, 255, true)
			triggerClientEvent(client, "VDBGHouse:onRequestUpdateHouseList", client, 2, "locked", false, tonumber(arg3))
			setTimer(triggerClientEvent, 50, 1, client, "VDBGHouse:SetMenuVisible", client, 3, false, true)
		elseif menuid == 4 then
			if isGuestAccount(getPlayerAccount(player)) then return end;
			
			local guestTable = fromJSON( getDataFromHouse(houseid, "house_guest") )
			if arg3 == "add" then
				if house_isAccountInGuestList(houseid, getAccountName(getPlayerAccount(player))) then
					outputChatBox("#d9534f[VDBG.ORG] #FFFFFFEssa conta já está na lista de hóspedes", client, 255, 255, 255, true)
				else
					if type(guestTable) ~= "table" then return end;
					guestTable[ #guestTable + 1 ] = getAccountName(getPlayerAccount(player))
					
					exports["VDBGSQL"]:db_exec( "UPDATE houses SET house_guest='".. toJSON(guestTable) .."' WHERE ID=?", houseid )
					outputChatBox("#d9534f[VDBG.ORG] #FFFFFF#B4FFB4Hóspede adicionado com sucesso para a casa #87FFF1".. tostring(houseid), client, 255, 255, 255, true)
					setTimer(triggerClientEvent, 50, 1, client, "VDBGHouse:SetMenuVisible", client, 4, false, true, "guest")
					setTimer(triggerClientEvent, 50, 1, client, "VDBGHouse:onRequestUpdateHouseList", client, 2, "guest", false, toJSON(guestTable))
				end
			elseif arg3 == "remove" then
				local bool, i = house_isAccountInGuestList(houseid, getAccountName(getPlayerAccount(player)))
				if bool then
					table.remove(guestTable, i)
					exports["VDBGSQL"]:db_exec( "UPDATE houses SET house_guest='".. toJSON(guestTable) .."' WHERE ID=?", houseid )
					outputChatBox("#d9534f[VDBG.ORG] #FFFFFF#B4FFB4O Hóspede '".. getAccountName(getPlayerAccount(player)) .."' foi removido com sucesso da casa '#87FFF1".. tostring(houseid) .."'", client, 255, 255, 255, true)
					setTimer(triggerClientEvent, 50, 1, client, "VDBGHouse:SetMenuVisible", client, 4, false, true, "guest")
					setTimer(triggerClientEvent, 50, 1, client, "VDBGHouse:onRequestUpdateHouseList", client, 2, "guest", false, toJSON(guestTable))
				else
					outputChatBox("#d9534f[VDBG.ORG] #FFFFFFEssa conta não está como hóspede", client, 255, 255, 255, true)
				end
			end
		end
	end
)

function house_isAccountInGuestList(id, accName)
	local guestTable = fromJSON( getDataFromHouse(id, "house_guest") )
	if type(guestTable) == "table" then
		for i, name in pairs(guestTable) do
			if (name == tostring(accName)) then return true, i end
		end
	end
	return false
end

function setHouseOwner(id, name)
	if tonumber(id) and type(name) == "string" and name ~= "" then
		exports["VDBGSQL"]:db_exec( "UPDATE houses SET owner='".. name .."' WHERE ID=?", id )
		return setElementData( houses[id].pickup, "VDBGHouse-HouseOwner", name )
	elseif tonumber(id) and name == "" then
		exports["VDBGSQL"]:db_exec( "UPDATE houses SET owner='".. name .."' WHERE ID=?", id )
		if getElementData( houses[id].pickup, "VDBGHouse-HouseOwner" ) then
			removeElementData( houses[id].pickup, "VDBGHouse-HouseOwner" )
		end
		return true
	end
	return false
end

function setHouseLocked(id, value)
	if tonumber(id) and type(value) == "number" then
		exports["VDBGSQL"]:db_exec( "UPDATE houses SET locked='".. value .."' WHERE ID=?", id )
		setElementData(houses[id].pickup, "VDBGHouse-HouseLockedState", tonumber(value))
	end
end

function setHouseForSale(id, value)
	if tonumber(id) and type(value) == "number" then
		id = tonumber(id)
		local isForSale = getDataFromHouse(id, "forSale")
		if isForSale ~= value then
			exports["VDBGSQL"]:db_exec( "UPDATE houses SET forSale='".. value .."' WHERE ID=?", id )
		end
		return setPickupType( houses[id].pickup, 3, ( value == 1 ) and 1273 or 1272 )
	end
	return false
end

function enterHouseGarage( player, dim )
	if getElementType(player) == "player" and dim and not isGuestAccount(getPlayerAccount(player)) then
		local houseID = tonumber( getElementID(getElementData(source, "VDBGHouse-house_pickup_entrance")) )
		local hAccountOwner = getElementData( getElementData(source, "VDBGHouse-house_pickup_entrance"), "VDBGHouse-HouseOwner" )
		for i, name in ipairs( fromJSON(getDataFromHouse(houseID, "house_guest")) ) do
			if getAccountPlayer(getAccount(name)) then
				return triggerClientEvent( getAccountPlayer(getAccount(name)), "VDBGHouse:showGarageInfoToPlayer", source, houseID )
			end
		end
		if hAccountOwner == getAccountName(getPlayerAccount(player)) then
			triggerClientEvent( player, "VDBGHouse:showGarageInfoToPlayer", source, houseID )
		end
	end
end

function pre_warpPlayerToGarage( player, houseid )
	toggleAllControls(player, false, true, false)
	fadeCamera(player, false, 1.0)
	setTimer(warpPlayerToGarage, 1000, 1, player, houseid)
end

function setPlayerInsideInterior( hID )
	local x,y,z = houses[ hID ].teleports[1], houses[ hID ].teleports[2], houses[ hID ].teleports[3]
	setElementInterior( client, houses[ hID ].teleports.int, x, y, z )
	setPedRotation( client, houses[ hID ].teleports[4] )
	setElementDimension( client, houses[ hID ].teleports.dim )
	setTimer( setCameraPlayerMode, 200, 1, client )
	toggleAllControls( client, true, true, false )
	setTimer( fadeCamera, 500, 1, client, true, 1.0 )
end

function setPlayerOutside( hID, player, garageExit )
	local x,y,z = houses[ hID ].teleports[5], houses[ hID ].teleports[6], houses[ hID ].teleports[7]
	if garageExit and isPedInVehicle(player) then
		setElementDimension( garage[hID].vehicle, 0 )
		setElementPosition( garage[hID].vehicle, tonumber(x), tonumber(y), tonumber(z) )
		setElementRotation( garage[hID].vehicle, 0, 0, houses[ hID ].teleports[8] )
		garage[hID].vehicle = nil
	else
		setElementPosition( player, tonumber(x), tonumber(y), tonumber(z) )
		setPedRotation( player, houses[ hID ].teleports[8] )
	end
	setElementDimension( player, 0 )
	setElementInterior( player, 0 )
	
	setTimer( setCameraPlayerMode, 200, 1, player )
	toggleAllControls( player, true, true, false )
	setTimer( fadeCamera, 500, 1, player, true, 1.0 )
end

addEventHandler( "VDBGHouse:OnRequestPlayerHouses", root,
  function ( fromServer )
	source = fromServer and source or client
	local acc = getPlayerAccount(source)
	if acc and not isGuestAccount(acc) then
		local listInfos = {}
		for i, t in pairs(getAccountHouses( getAccountName(acc) )) do
			local curIndex = #listInfos + 1
			listInfos[ curIndex ] = {}
			local id = tonumber(t["ID"])
			listInfos[ curIndex ][1] = id
			local px,py,pz = getElementPosition(houses[id].pickup)
			listInfos[ curIndex ][2] = getZoneName( px,py,pz )
		end
		triggerClientEvent(source, "VDBGHouse:returnHousesTable", source, listInfos)
	end
  end
)

addEventHandler( "VDBGHouse:OnPlayerSelectHouseFromList", root,
	function ( id )
		local hDataTable = {
			["cost"] = "false",
			["locked"] = "false",
			["house_guest"] = "false",
			["garageType"] = "false",
			["location"] = "false",
			["city"] = "false",
		}
		for k, v in pairs(getAllHouseData(tonumber(id))) do
			if hDataTable[k] == "false" then
				hDataTable[k] = v
			end
		end
		local px,py,pz = getElementPosition(houses[tonumber(id)].pickup)
		hDataTable["location"] = getZoneName( px,py,pz )
		hDataTable["city"] = getElementCity(houses[tonumber(id)].pickup)
		
		return id and setElementData( client, "VDBGHouse:HouseData", hDataTable ) or false
	end
)

function onClientRequestInterior()
	triggerClientEvent(client, "VDBGHouse:onServerCall", client, 2, getElementInterior(client))
end

addEventHandler("onPlayerLogin", root, function()
	triggerEvent( "VDBGHouse:OnRequestPlayerHouses", source, true )
end)

addEventHandler("onPlayerLogout", root, function( prevAcc )
	for _, v in ipairs(getAccountHouses( getAccountName(prevAcc) )) do
		triggerClientEvent( source, "VDBGHouse:onRequestUpdateHouseList", source, 1, v["ID"], true )
	end
end)

function getAllHouseData( hID )
	local q = exports['VDBGSQL']:db_query ( "SELECT * FROM houses WHERE ID=? LIMIT 1", tonumber(hID) )
	if ( q and type ( q ) == 'table' and #q > 0 ) then
		return q[1]
	end
	return false
end

function getAccountHouses( accName )
	local h = { } 
	local q = exports['VDBGSQL']:db_query ( "SELECT * FROM houses WHERE owner=? ", tostring(accName) )
	for i, v in pairs ( q ) do 
		table.insert ( h, v )
	end
	return h
end

function getDataFromHouse(id, data)
	if id and type(data) == "string" then
		return exports["VDBGSQL"]:db_query( "SELECT "..data.." FROM houses WHERE ID=?", id )[1][data]
	end
end

function isAdmin(player)
	if not isElement(player) then return false end;
	for _, group in ipairs({ "Admin", "Console" }) do
		if isObjectInACLGroup( "user."..getAccountName(getPlayerAccount(player)), aclGetGroup(group) ) then
			return true
		end
	end
	return false
end

function getElementCity(e)
	local citynames = {
		["Los Santos"] = "LS", ["San Fierro"] = "SF", ["Las Venturas"] = "LV",
		["Tierra Robada"] = "TR", ["Bone County"] = "BC", ["Red County"] = "RC",
		["Flint County"] = "FC", ["Whetstone"] = "WT"
	}
	local pos = { getElementPosition(e) }
	return citynames[getZoneName( pos[1], pos[2], pos[3], true)] or false
end

function setCameraPlayerMode( player )
	local x, y, z = getElementPosition(player)
	local r = getPedRotation(player)
	setCameraMatrix(player, x - 4*math.cos(math.rad(r + 90)), y - 4*math.sin(math.rad(r + 90)), z + 1, x, y, z + 1)
	setTimer(setCameraTarget, 100, 1, player, player)
end

function convertNumber ( number )
	local formatted = number
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end
