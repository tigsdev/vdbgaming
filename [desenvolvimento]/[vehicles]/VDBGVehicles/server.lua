
local sellVehicle = {}

addEvent( "playerVehicles:OnRequestPlayerVehicles", true )
addEvent( "playervehicles:OnPlayerSelectVehicleFromList", true )
addEvent( "server:VehicleOptionsDoAction", true )

addEventHandler( "playerVehicles:OnRequestPlayerVehicles", root,
	function ( fromServer )
		client = fromServer and source or client
		local acc = getPlayerAccount(client)
		if acc and not isGuestAccount(acc) then
			local vehs = getAllAccountVehicles( getAccountName(acc) )
			triggerClientEvent(client, "playerVehicles:returnVehiclesTable", client, vehs)
		end
	end
)

addEventHandler( "playervehicles:OnPlayerSelectVehicleFromList", root,
	function( id, fromServer )
		client = fromServer and source or client
		local tVehicleData = getAllVehicleData(tostring(id))[1]
		if type(tVehicleData) == "table" then
			return id and setElementData( client, "playervehicles:VehicleData", tVehicleData ) or false
		end
	end
)

function calculateVehicleCost( vehid, modelID )
	if not vehid or not tonumber(modelID) then return false end;
	local price = nil
	for i, v in pairs ( vehicleList ) do 
		for k, x in ipairs ( v ) do 
			if ( x[1] == modelID ) then 
				price = math.floor ( x[2] / 1.4 ) + math.random ( 500, 2200 )
				if price > x[2] then
					while ( price >= x[2] ) do
						price = math.floor ( x[2] / 1.4 ) + math.random ( 100, 1000 )
					end
				end
				break
			end
		end
	end
	price = price - math.min( 6000, (getDataFromVehicle(vehid, "DistanceTraveled") * 15) )
	for _,v in ipairs(fromJSON( getDataFromVehicle(vehid, "Upgrades") )) do 
		price = price + 30 + math.random(5)
	end
	return math.ceil(price)
end

addEventHandler( "server:VehicleOptionsDoAction", root,
	function (id, vehID, value)
		local ID = getDataFromVehicle(vehID, "ID")
		if id == 1 then
			if getElementData(value, "sellVehicle-vehicleData") then
				outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFHá uma outra venda para esse jogador, tente mais tarde", client, 255, 255, 255, true )
				return
			end
			triggerClientEvent(client, "playerVehicles:onRequestUpdateVehicleList", client, "hideEditBox")
			local seller = client
			local vehPrice = calculateVehicleCost( vehID, ID )
			local r,g,b
			if getPlayerTeam(value) then
				r, g, b = getTeamColor( getPlayerTeam(value) )
			else
				r, g, b = getPlayerNametagColor(value)
			end
			outputChatBox (" ", value, 255, 255, 255, true )
			outputChatBox("#428bca"..string.gsub(getPlayerName(seller), " ", "_").." #FFFFFFquer vender um veículo para você", value, 255, 255, 255, true )
			outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFVeículo: #8CFA8C"..getVehicleNameFromModel(ID).." #FFFFFFPreço: #8CFA8CR$"..convertNumber( vehPrice ), value, 255, 255, 255, true )
			outputChatBox ("#d9534f[VDBG.ORG] #428bca/comprarv #FFFFFFpara comprar ou #d9534f/recusar #FFFFFFpara recusar a compra", value, 255, 255, 255, true )
			outputChatBox (" ", value, 255, 255, 255, true )
			setElementData( value, "sellVehicle-vehicleData", { vehID, ID, vehPrice }, false )
			triggerClientEvent(seller, "playerVehicles:SetMenuVisible", seller, 1, "sellVehicle-onClickNextButton")
			sellVehicle[value] = setTimer(
				function ( player, seller )
					removeElementData(player, "sellVehicle-vehicleData")
					outputChatBox ("#d9534f[VDBG.ORG]#FFFFFFA compra do veículo #428bca "..getVehicleNameFromModel(ID).."#FFFFFF foi cancelada", player, 255, 255, 255, true )
					triggerClientEvent(seller, "playerVehicles:SetMenuVisible", seller, 1, "onSellVehicleFinish", nil, tonumber(vehID))
				end, 270000, 1, value, seller
			)
			
			addEventHandler("onPlayerQuit", value, function()
				if isTimer(sellVehicle[source]) then
					killTimer(sellVehicle[source])
					triggerClientEvent(seller, "playerVehicles:SetMenuVisible", seller, 1, "onSellVehicleFinish", nil, tonumber(vehID))
				end
				if sellVehicle[source] then sellVehicle[source] = nil end
			end)
			
			addEventHandler("onPlayerLogout", value, function()
				if isTimer(sellVehicle[source]) then
					killTimer(sellVehicle[source])
					triggerClientEvent(seller, "playerVehicles:SetMenuVisible", seller, 1, "onSellVehicleFinish", nil, tonumber(vehID))
				end
				if sellVehicle[source] then sellVehicle[source] = nil end
			end)
		elseif id == 2 then
			if isElement( vehicles[vehID] ) then
				outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFGuarde seu veículo antes de deletar", client, 255, 255, 255 )
			end
			if deletePlayerVehicle( vehID ) then
			  outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFSeu veículo #428bca"..getVehicleNameFromModel(ID).." #FFFFFFfoi deletado!", client, 255, 255, 255 )
			end
		elseif id == 3 then
			local money = getPlayerMoney(client)
			if (money < value) then
				outputChatBox ("#d9534f[VDBG.ORG]#FFFFFFVocê precisa de mais #acd373R$"..(value - money)..".00#FFFFFF para rebocar seu veículo!", client, 255, 255, 255, true )
				return
			end
			if isElement(vehicles[vehID]) then
				fixVehicle(vehicles[vehID])
			end
			showVehicle(vehID, false)
			local positionnew = '[ "-11.33, -359.34, 5.43" ]'
			local rotationnew = '[ "0, 0, 0" ]'
			exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Health=? WHERE VehicleID=?", "310", vehID )
			exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Impounded=? WHERE VehicleID=?", "1", vehID )
			takePlayerMoney(client, value)
			outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFSeu veículo foi rebocado por #acd373R$"..tostring(value)..".00 #FFFFFFaté a #428bcaPorto Seguros.", client,255, 255, 255, true )
			triggerEvent("playervehicles:OnPlayerSelectVehicleFromList", client, vehID, true)
		elseif id == 4 then
			local impounded = tostring( getDataFromVehicle(vehID, "Impounded") )
			if not isElement(vehicles[vehID]) then
				if impounded == "0" then -- Ok, não está quebrado
					showVehicle( tonumber(vehID), true, client )	
					if exports.VDBGVIP:getVipLevelFromName ( getElementData ( client, "VIP" ) ) >= 3 then
					setTimer( warpVehicleToPlayer, 50, 1, tonumber(vehID), client )
					end
					triggerEvent("playervehicles:OnPlayerSelectVehicleFromList", client, vehID, true)
					triggerClientEvent(client, "playerVehicles:DoTogglePanelVisible", client)
				else -- Veículo quebrado. Informar o jogador
					outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFEsse veículo está quebrado!", client, 255, 255, 255, true )
				end
			else -- O jogador já está com o veículo
				showVehicle( tonumber(vehID), false, client )
				setTimer(triggerEvent, 50, 1, "playervehicles:OnPlayerSelectVehicleFromList", client, vehID, true)
			end
		end
		if (id == 2 or id == 3) then
			triggerClientEvent(client, "playerVehicles:SetMenuVisible", client, id, false, true)
		end
	end
)

function sellVehicleOnPlayerCommand(sourceP, cmdName)
	if isTimer(sellVehicle[sourceP]) then
		killTimer(sellVehicle[sourceP])
		sellVehicle[sourceP] = nil
	end
	if not getElementData(sourceP, "sellVehicle-vehicleData") then return end;
	if isGuestAccount(getPlayerAccount(sourceP)) then return end;
	local vehicleID, modelID, price = unpack(getElementData(sourceP, "sellVehicle-vehicleData"))
	local owner = getAccountPlayer(getAccount( getDataFromVehicle(vehicleID, "Owner") ))
	if (cmdName == "comprarv") then
		if getPlayerMoney(sourceP) >= price then
			takePlayerMoney(sourceP, price)
			exports["VDBGSQL"]:db_exec( "UPDATE vehicles SET Owner='"..getAccountName(getPlayerAccount(sourceP)).."' WHERE VehicleID=?", vehicleID )
			outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFVocê comprou o veículo #428bca"..getVehicleNameFromModel(modelID).."#FFFFFF Por #acd373R$"..convertNumber(price).."", sourceP, 255, 255, 255, true )
			if isElement(owner) then
				outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFVenda do veículo #428bca"..getVehicleNameFromModel(modelID).." #FFFFFFbem sucedida. Valor de venda: #acd373R$"..convertNumber(price)..".00", owner, 255, 255, 255, true )
				givePlayerMoney(owner, price)
				triggerClientEvent(owner, "playerVehicles:onRequestUpdateVehicleList", owner, vehicleID, true)
			end
		else
			outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFVocê precisa de mais #acd373R$"..(price - getPlayerMoney(sourceP))..".00#FFFFFF para comprar o veículo!", sourceP, 255, 255, 255, true )
		end
	elseif (cmdName == "recusar") then
		outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFVocê cancelou a compra do veículo #428bca"..getVehicleNameFromModel(modelID), sourceP, 255, 255, 255, true )
	end
	triggerClientEvent(owner, "playerVehicles:SetMenuVisible", owner, 1, "onSellVehicleFinish", nil, tonumber(vehicleID))
	removeElementData(sourceP, "sellVehicle-vehicleData")
end
addCommandHandler( "comprarv", sellVehicleOnPlayerCommand, false )
addCommandHandler( "recusar", sellVehicleOnPlayerCommand, false )

function getDataFromVehicle(id, data)
	if id and type(data) == "string" then
		return exports["VDBGSQL"]:db_query( "SELECT "..data.." FROM vehicles WHERE VehicleID=?", id )[1][data]
	end
end

function deletePlayerVehicle( vehicleID, quem )
	local sucess = exports["VDBGSQL"]:db_exec( "DELETE FROM vehicles WHERE VehicleID=?", tostring(vehicleID) )
	if sucess then
		triggerClientEvent(client, "playerVehicles:onRequestUpdateVehicleList", client, vehicleID, true)
		vehicles[vehicleID] = nil
		return true
	end
	return false
end


function deletePlayerVehicleFromUsedVehicles( vehicleID, source )
	local sucess = exports["VDBGSQL"]:db_exec( "DELETE FROM vehicles WHERE VehicleID=?", tostring(vehicleID) )
	if sucess then
		triggerClientEvent(source, "playerVehicles:onRequestUpdateVehicleList", source, vehicleID, true)
		vehicles[vehicleID] = nil
		return true
	end
	return false
end
