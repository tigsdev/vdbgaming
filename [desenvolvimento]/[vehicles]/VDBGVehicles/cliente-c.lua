
local sw, sh = guiGetScreenSize()
local panel = { }
local vehicleListTexts = {}
local selectedVehicle = {}
local vehiclelist = createElement("dxGridlist")

panel.showing = false
panel.menuShowing = false
panel.x, panel.y = (sw - 770)/2, (sh - 453)/2
local isVehicleInfoShowing = false
local hasPlayerElement = false
local listOffSetY = 10
local som = "clica"

local colors = {
	sellColor = { { 0,0,0, hover={80, 135, 250} }, { 0,0,0, hover={220, 120, 15} } },
	deleteColor = { { 0,0,0, hover={250, 35, 65} }, { 0,0,0, hover={80, 135, 250} } },
	repairColor = { { 0,0,0, hover={95, 215, 95} }, { 0,0,0, hover={230, 30, 70} } }
}

-- Client events
addEvent( "onClientDXVehicleButtonClick" )
addEvent( "onVehicleOptionsButtonClick" )
addEvent( "playerVehicles:returnVehiclesTable", true )
addEvent( "playerVehicles:onRequestUpdateVehicleList", true )
addEvent( "playerVehicles:DoTogglePanelVisible", true )
addEvent( "playerVehicles:SetMenuVisible", true )

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		panel.btnPos = {panel.x + 388, 344, 35}
		panel.btnsYPos = {panel.y + 240, panel.y + 285, panel.y + 330, panel.y + 375}
		
		panel.sellBtnColor = { 0,0,0, hover = {40, 125, 250} }
		panel.deleteBtnColor = { 0,0,0, hover = {250, 35, 65} }
		panel.repairBtnColor = { 0,0,0, hover = {138, 240, 97} }
		panel.spawnBtnColor = { 0,0,0, hover = {250, 140, 35} }
		
		panel.vehOptionsPos = {
			posX = panel.x + 398,
			sellNext_Y = panel.y + 158,
			sellBack_Y = panel.y + 194,
			deleteYES_Y = panel.y + 138,
			deleteNO_Y = panel.y + 180,
		}
		
		triggerServerEvent("playerVehicles:OnRequestPlayerVehicles", localPlayer)
		bindKey( "F3", "down", togglePanel )
		addCommandHandler( "meusveiculos", togglePanel, false )
		addEventHandler( "onDxLibGridlistClick", root, onDxLibGridlistClickHandler )
		addEventHandler( "onClientClick", root, onButtonClick )
	end
)

local function getVehicleIDFromString( text )
	if text and text ~= "" then
		return text:sub( 1, text:find(" ") - 1 )
	end
	return false
end

function drawInterface()
	-- background rectangle
	dxDrawLinedRectangle( panel.x, panel.y, 770, 453, tocolor(0, 0, 0, 155), tocolor(0, 0, 0, 200) )
	-- vehicle functions & info rectangle
	dxDrawRectangle(panel.x + 376, panel.y + 37, 368, 385, tocolor(0, 0, 0, 160), false)
	-- Title rectangle
	dxDrawRectangle(panel.x, panel.y - 32, 770, 32, tocolor(0, 0, 0, 190), false)
	dxDrawText("#FFFFFFVDB#2F7CCCGaming - #d9534fMeus veículos", panel.x + 8, panel.y - 32, (panel.x + 8) + 250, (panel.y - 32) + 30, tocolor(255, 255, 255, 255), 1.3, "clear", "left", "center", false, false, false, true)
	-- panel separator line
	dxDrawRectangle(panel.x, panel.y - 2, 770, 2, tocolor(255, 255, 255, 190), false)
	
	drawShadowText("#2F7CCCVeículos disponíveis ("..#vehicleListTexts.." / "..getElementData(localPlayer, "maxPlayerVehicleSlots")..")  #acd373[O limite de veículos, pode ser aumentado na #2F7CCCLOJA DE DIAMANTES#acd373!]", panel.x + 32, panel.y + 13, (panel.x + 32) + 764, (panel.y + 13) + 24, tocolor(20, 122, 192, 255), 1.2, "arial", "left", "center", false, false, false, true)
	
	
	dxLibCreateGridlist(vehiclelist, vehicleListTexts, panel.x + 26, panel.y + 37, 313, 385, 2, 0, 20, 180, 230)
	vehicleButtonCursorHover()
	
	local x,w,h = unpack(panel.btnPos)
	-- Sell button
	dxDrawRectangle(x, panel.btnsYPos[1], w, h, tocolor(panel.sellBtnColor[1], panel.sellBtnColor[2], panel.sellBtnColor[3], 145), false)
	dxDrawText("Vender", x, panel.btnsYPos[1], x + 345, panel.btnsYPos[1] + 35, tocolor(255, 255, 255, 255), 1.4, "arial", "center", "center")
	-- Delete button
	dxDrawRectangle(x, panel.btnsYPos[2], w, h, tocolor(panel.deleteBtnColor[1], panel.deleteBtnColor[2], panel.deleteBtnColor[3], 145), false)
	dxDrawText("Deletar", x, panel.btnsYPos[2], x + 345, panel.btnsYPos[2] + 35, tocolor(255, 255, 255, 255), 1.4, "arial", "center", "center")
	-- Repair button
	dxDrawRectangle(x, panel.btnsYPos[3], w, h, tocolor(panel.repairBtnColor[1], panel.repairBtnColor[2], panel.repairBtnColor[3], 145), false)
	dxDrawText("Rebocar", x, panel.btnsYPos[3], x + 345, panel.btnsYPos[3] + 35, tocolor(255, 255, 255, 255), 1.4, "arial", "center", "center")
	-- Spawn button
	dxDrawRectangle(x, panel.btnsYPos[4], w, h, tocolor(panel.spawnBtnColor[1], panel.spawnBtnColor[2], panel.spawnBtnColor[3], 145), false)
	dxDrawText(--[[(selectedVehicle.visible == 1) and "Guardar" or "Spawn"]]"Spawn", x, panel.btnsYPos[4], x + 345, panel.btnsYPos[4] + 35, tocolor(255, 255, 255, 255), 1.4, "arial", "center", "center")
end

local currentHoverButton, lastHoverButton
local buttons = { "sellBtnColor", "deleteBtnColor", "repairBtnColor", "spawnBtnColor" }
function vehicleButtonCursorHover()
	for ID=1, 4 do
		if isCursorOverButton(ID) then
			if ( panel[ buttons[ID] ][1] ~= panel[ buttons[ID] ].hover[1] ) then
			  currentHoverButton = ID
			end
		else
			if ( panel[ buttons[ID] ][1] ~= 0 ) then
				lastHoverButton = ID
			end
		end
	end
	local curID = currentHoverButton
	if tonumber(lastHoverButton) then
		panel[ buttons[lastHoverButton] ][1], panel[ buttons[lastHoverButton] ][2], panel[ buttons[lastHoverButton] ][3] = 0,0,0
		lastHoverButton = nil
	end
	if tonumber(curID) and not isCursorOverButton(curID) then
		currentHoverButton = nil
	elseif tonumber(curID) then
		panel[ buttons[curID] ][1], panel[ buttons[curID] ][2], panel[ buttons[curID] ][3] = unpack(panel[ buttons[curID] ].hover)
	end
end

function drawVehicleInfo()
	
	
	local rowText = dxLibGridlistGetSelectedRowText(vehiclelist)
	local vehicleID = rowText and getVehicleIDFromString( rowText ) or "-"
	if getPedOccupiedVehicle(localPlayer) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if getElementData(vehicle, "VDBGVehicles:VehicleID") == tonumber(vehicleID) then
			selectedVehicle.health = math.round( getElementHealth(vehicle), 1 )
			selectedVehicle.fuel = math.round( getElementData(vehicle, "fuel"), 1 )
			selectedVehicle.distanceTraveled = getElementData(vehicle, "travelmeter-vehicleDistanceTraveled")
		end
	end
	dxDrawText(selectedVehicle.vehicleName or "N/A", panel.x + 376, panel.y + 37, (panel.x+376) + 367, (panel.y+37) + 30, tocolor(37, 222, 0, 210), 1.7, "arial", "center", "bottom")
	dxDrawText("[ID: "..vehicleID.."]", panel.x + 376, panel.y + 68, (panel.x+376) + 367, (panel.y+68) + 23, tocolor(160, 160, 160, 210), 1.2, "arial", "center", "top")
	-- vehicle info rectangle 1
	dxDrawRectangle(panel.x + 376, panel.y + 100, 368, 25, tocolor(75, 75, 75, 150), false)
	dxDrawText("#FFFFFFSaúde: #3090FF"..(selectedVehicle.health or "1000"), panel.x + 385, panel.y + 100, (panel.x+385) + 358, (panel.y+100) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
	dxDrawText("Gasolina: #3090FF"..math.round( (selectedVehicle.fuel or "100"), 1).."%", panel.x + 385, panel.y + 125, (panel.x+385) + 358, (panel.y+125) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
	-- vehicle info rectangle 2
	dxDrawRectangle(panel.x + 376, panel.y + 150, 368, 25, tocolor(75, 75, 75, 150), false)
	dxDrawText("Nitro: #3090FF"..(selectedVehicle.nitro or "0").."%", panel.x + 385, panel.y + 150, (panel.x+385) + 358, (panel.y+150) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
	dxDrawText("Distância percorrida: #3090FF"..(selectedVehicle.distanceTraveled or "0").." km.", panel.x + 385, panel.y + 175, (panel.x+385) + 358, (panel.y+175) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
	
	-- vehicle info rectangle 3
	dxDrawRectangle(panel.x + 376, panel.y + 200, 368, 25, tocolor(75, 75, 75, 150), false)
	dxDrawText("Tipo: #3090FF"..(selectedVehicle.type or "Desconhecido"), panel.x + 385, panel.y + 200, (panel.x+385) + 358, (panel.y+200) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
end

function drawSellVehicle()
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	if type(panel.sellVehiclePending) == "table" and isElement(panel.targetPlayer) then
	  for i,id in pairs(panel.sellVehiclePending) do
		if (id == getSelectedVehicleID()) then
		  drawShadowText("O jogador "..getPlayerName(panel.targetPlayer), panel.x + 392, panel.y + 60, (panel.x+392) + 331, (panel.y+60) + 20, tocolor(140, 245, 140, 240), 1.3, "arial", "center", "center", false, false, false, true)
		  drawShadowText("já foi informado sobre a venda deste veículo", panel.x + 396, panel.y + 79, (panel.x+396) + 327, (panel.y+79) + 20, tocolor(140, 245, 140, 240), 1.3, "arial", "center", "center", false, false, false, true)
		  return
		end
	  end
	end
	drawShadowText("Digite o #95FF95nome do jogador", panel.x + 390, panel.y + 53, (panel.x+390) + 339, (panel.y+53) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("que você deseja vender o veículo", panel.x + 390, panel.y + 73, (panel.x+390) + 339, (panel.y+73) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, true)
	vehicleOptionsCursorHover()
	dxDrawRectangle(panel.vehOptionsPos.posX, panel.vehOptionsPos.sellNext_Y, 323, 30, tocolor(colors.sellColor[1][1], colors.sellColor[1][2], colors.sellColor[1][3], 165), false)
	dxDrawRectangle(panel.vehOptionsPos.posX, panel.vehOptionsPos.sellBack_Y, 323, 30, tocolor(colors.sellColor[2][1], colors.sellColor[2][2], colors.sellColor[2][3], 165), false)
	
	local r,g,b = 0,0,0
	local str = ""
	if isElement(panel.targetName) and (guiGetText(panel.targetName):len() > 0) then
		if not hasPlayerElement then
			r, g, b = 255, 43, 43
			str = "Jogador não encontrado!"
		else
			r, g, b = 43, 220, 43
			if (getPlayerFromPartialName(guiGetText(panel.targetName)) == localPlayer) then
				r, g, b = 255, 43, 43
				str = "Você não pode vender a si próprio"
			else
				str = "Jogador encontrado"
			end
		end
	end
	dxDrawText(str, panel.x + 385, panel.y + 129, (panel.x+385) + 348, (panel.y+129) + 23, tocolor(r, g, b, 230), 1.2, "arial", "center", "center")
	dxDrawText("Próximo", panel.x + 398, panel.y + 156, (panel.x+398) + 323, (panel.y+156) + 32, tocolor(255, 255, 255, 255), 1.3, "arial", "center", "center")
	dxDrawText("Voltar", panel.x + 398, panel.y + 192, (panel.x+398) + 323, (panel.y+192) + 32, tocolor(255, 255, 255, 255), 1.3, "arial", "center", "center")
end

function drawDeleteVehicle()
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	drawShadowText("#95FF95Você tem certeza", panel.x + 390, panel.y + 53, (panel.x+390) + 339, (panel.y+53) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("que deseja #FF7070deletar #FFFFFFo seu veículo?", panel.x + 390, panel.y + 73, (panel.x+390) + 339, (panel.y+73) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("Esta operação não poderá ser desfeita!", panel.x + 390, panel.y + 94, (panel.x+390) + 339, (panel.y+94) + 20, tocolor(43, 127, 255, 230), 1.2, "arial", "center", "center")
	
	vehicleOptionsCursorHover()
	dxDrawRectangle(panel.vehOptionsPos.posX, panel.vehOptionsPos.deleteYES_Y, 323, 30, tocolor(colors.deleteColor[1][1], colors.deleteColor[1][2], colors.deleteColor[1][3], 165), false)
	dxDrawRectangle(panel.vehOptionsPos.posX, panel.vehOptionsPos.deleteNO_Y, 323, 30, tocolor(colors.deleteColor[2][1], colors.deleteColor[2][2], colors.deleteColor[2][3], 165), false)
	dxDrawText("Sim, tenho!", panel.x + 398, panel.y + 136, (panel.x+398) + 323, (panel.y+136) + 32, tocolor(255, 255, 255, 255), 1.3, "arial", "center", "center")
	dxDrawText("Não!", panel.x + 398, panel.y + 178, (panel.x+398) + 323, (panel.y+178) + 32, tocolor(255, 255, 255, 255), 1.3, "arial", "center", "center")
end

function drawRepairVehicle()
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	if tonumber(selectedVehicle.health) == 1000 then
		drawShadowText("Este veículo não está danificado", panel.x + 390, panel.y + 120, (panel.x+390) + 339, (panel.y+120) + 20, tocolor(20, 220, 0, 240), 1.4, "arial", "center", "center", false, false, false, true)
		return
	end
	drawShadowText("#95FF95Você tem certeza", panel.x + 390, panel.y + 53, (panel.x+390) + 339, (panel.y+53) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("que deseja #FF7070rebocar #FFFFFFo seu veículo por #FF7070$"..(selectedVehicle.repairCost or "0").."?", panel.x + 390, panel.y + 73, (panel.x+390) + 339, (panel.y+73) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	
	vehicleOptionsCursorHover()
	dxDrawRectangle(panel.vehOptionsPos.posX, panel.vehOptionsPos.deleteYES_Y, 323, 30, tocolor(colors.repairColor[1][1], colors.repairColor[1][2], colors.repairColor[1][3], 165), false)
	dxDrawRectangle(panel.vehOptionsPos.posX, panel.vehOptionsPos.deleteNO_Y, 323, 30, tocolor(colors.repairColor[2][1], colors.repairColor[2][2], colors.repairColor[2][3], 165), false)
	dxDrawText("Sim, tenho!", panel.x + 398, panel.y + 136, (panel.x+398) + 323, (panel.y+136) + 32, tocolor(255, 255, 255, 255), 1.3, "arial", "center", "center")
	dxDrawText("Não!", panel.x + 398, panel.y + 178, (panel.x+398) + 323, (panel.y+178) + 32, tocolor(255, 255, 255, 255), 1.3, "arial", "center", "center")
end

function vehicleOptionsCursorHover()
	local posY
	if (getMenuShowing() == "Sell") then
		posY = { panel.vehOptionsPos.sellNext_Y, panel.vehOptionsPos.sellBack_Y }
	elseif (getMenuShowing() == "Delete") or (getMenuShowing() == "Repair") then
		posY = { panel.vehOptionsPos.deleteYES_Y, panel.vehOptionsPos.deleteNO_Y }
	else return end
	
	local t = (getMenuShowing() == "Sell") and colors.sellColor
			or (getMenuShowing() == "Delete") and colors.deleteColor
			or (getMenuShowing() == "Repair") and colors.repairColor
	for ID=1, 2 do
		if isMouseWithinRangeOf(panel.vehOptionsPos.posX, 323, posY[ID], 30) then
			t[ID][1], t[ID][2], t[ID][3] = unpack( t[ID].hover )
		else
			if t[ID][1] ~= 0 then
				t[ID][1], t[ID][2], t[ID][3] = 0,0,0
			end
		end
	end
end

addEventHandler( "onVehicleOptionsButtonClick", root, 
	function (menu, menuButton)
		if menu == "Sell" then
			if menuButton == "next" then
				panel.targetPlayer = getPlayerFromPartialName( guiGetText(panel.targetName) )
				if (panel.targetPlayer == localPlayer) then return end;
				if not isElement(panel.targetPlayer) then outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFEsse jogador não existe!", 255, 255, 255, true ) return end;
				triggerServerEvent( "server:VehicleOptionsDoAction", localPlayer, 1, getSelectedVehicleID(), panel.targetPlayer )
			elseif menuButton == "back" then
				setMenuVisible(1, false, true)
			end
		elseif menu == "Delete" then
			if menuButton == "yes" then
				triggerServerEvent( "server:VehicleOptionsDoAction", localPlayer, 2, getSelectedVehicleID() )
			elseif menuButton == "no" then
				setMenuVisible(2, false, true)
			end
		elseif menu == "Repair" then
			if menuButton == "yes" then
				triggerServerEvent( "server:VehicleOptionsDoAction", localPlayer, 3, getSelectedVehicleID(), selectedVehicle.repairCost )
			elseif menuButton == "no" then
				setMenuVisible(3, false, true)
			end
		end
	end
)

function onDxLibGridlistClickHandler( gridlistElement )
	triggerServerEvent("playervehicles:OnPlayerSelectVehicleFromList", localPlayer, getSelectedVehicleID())
	playSound(":VDBGPanelSound/navegacao.mp3")
	if (type(panel.menuShowing) == "string") then setMenuVisible( panel.menuShowing, false, true ) end;
end

function onEditTextChange()
	if (guiGetText(source) ~= "") then
		local player = getPlayerFromPartialName( guiGetText(source) )
		if isElement(player) then hasPlayerElement = true
			else hasPlayerElement = false
		end
	else
		if hasPlayerElement then hasPlayerElement = false end;
	end
end

function setMenuVisible(id, value, showVehicleInfo, vehID)
	if type(id) == "string" then
		id = (id == "Sell" and 1) or (id == "Delete" and 2) or (id == "Repair" and 3)
	end
	if (id == 1 and value == "sellVehicle-onClickNextButton") then
		if not panel.sellVehiclePending then panel.sellVehiclePending = {} end
		table.insert(panel.sellVehiclePending, getSelectedVehicleID())
		return
	elseif (id == 1 and value == "onSellVehicleFinish") then
		panel.targetPlayer = nil
		if type(panel.sellVehiclePending) ~= "table" then return end;
		for i, id in pairs(panel.sellVehiclePending) do
			if id == tonumber(vehID) then
				table.remove(panel.sellVehiclePending, i)
				if (#panel.sellVehiclePending == 0) then panel.sellVehiclePending = false end;
			end
		end
		return
	end
	if id == 1 then
		_G[ (value and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawSellVehicle )
		if value then
			panel.targetName = guiCreateEdit(panel.x + 398, panel.y + 98, 323, 30, "", false)
			guiSetFont(panel.targetName, "clear-normal")
		end
		guiSetInputMode(value and "no_binds_when_editing" or "allow_binds")
		if isElement(panel.targetName) then
			_G[ (value and "add" or "remove").."EventHandler" ]( "onClientGUIChanged", panel.targetName, onEditTextChange )
			if not (value) then destroyElement(panel.targetName) end;
		end
	elseif id == 2 then
		if type(panel.sellVehiclePending) == "table" then
			for i,id in pairs(panel.sellVehiclePending) do if (id == getSelectedVehicleID()) then return end end;
		end
		_G[ (value and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawDeleteVehicle )
	elseif id == 3 then
		if type(panel.sellVehiclePending) == "table" then
			for i,id in pairs(panel.sellVehiclePending) do if (id == getSelectedVehicleID()) then return end end;
		end
		_G[ (value and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawRepairVehicle )
	end
	if showVehicleInfo then
		addEventHandler("onClientRender", root, drawVehicleInfo)
		isVehicleInfoShowing = true
	end
	if value == false then
		panel.menuShowing = false
		return
	end
	panel.menuShowing = (id == 1 and "Sell") or (id == 2 and "Delete") or (id == 3 and "Repair")
end
addEventHandler("playerVehicles:SetMenuVisible", root, setMenuVisible)

addEventHandler( "onClientDXVehicleButtonClick", root,
	function (buttonID) 
		if not (#vehicleListTexts > 0) then 
			playSound(":VDBGPanelSound/navegacao.mp3") return end;
		if type( dxLibGridlistGetSelectedRowText(vehiclelist) ) ~= "string" then return end;
		
		if type(panel.sellVehiclePending) == "table" then
			for i,id in pairs(panel.sellVehiclePending) do
				if (id == getSelectedVehicleID()) then return outputChatBox ("#d9534f[VDBG.ORG] #FFFFFFEsse veículo está com uma venda pendente", 255, 255, 255, true ) end;
			end
		end
		if buttonID >= 1 and buttonID <= 3 then
			playSound(":VDBGPanelSound/navegacao.mp3")
			if isVehicleInfoShowing then removeEventHandler("onClientRender", root, drawVehicleInfo) isVehicleInfoShowing = false end;
			if type(panel.menuShowing) == "string" then
				setMenuVisible( panel.menuShowing, false )
			end
			if (buttonID == 3 and tonumber(selectedVehicle.health) ~= 1000) then
				selectedVehicle.repairCost = math.ceil((tonumber(selectedVehicle.health)) * 5.5)
			end
			setMenuVisible( buttonID, true )
		elseif buttonID == 4 then
			triggerServerEvent("server:VehicleOptionsDoAction", localPlayer, buttonID, getSelectedVehicleID())
		end
	end
)

addEventHandler( "onClientElementDataChange", localPlayer,
	function (dataName, oldValue)
		if (dataName == "playervehicles:VehicleData") then
			local vehData = getElementData(localPlayer, dataName)
			selectedVehicle.vehicleName = returnInfos(vehData["ID"], "nome")
			selectedVehicle.health = vehData["Health"]
			selectedVehicle.fuel = vehData["Fuel"]
			selectedVehicle.nitro = vehData["Nitro"]
			selectedVehicle.distanceTraveled = math.round(vehData["DistanceTraveled"], 1)
			selectedVehicle.type = vehData["Type"]
			selectedVehicle.visible = vehData["Visible"]
		end
	end
)

function onButtonClick(button, state)
	if (button == "left") and (state == "up") and panel.showing and not isConsoleActive() and not isMainMenuActive() then
		for ID=1, 4 do
			if isCursorOverButton(ID) then			
			playSound(":VDBGPanelSound/navegacao.mp3")
				return triggerEvent( "onClientDXVehicleButtonClick", resourceRoot, ID )
			end
		end
		local posY
		if (getMenuShowing() == "Sell") then
			playSound(":VDBGPanelSound/navegacao.mp3")
			posY = { panel.vehOptionsPos.sellNext_Y, panel.vehOptionsPos.sellBack_Y, "next", "back" }
		elseif (getMenuShowing() == "Delete") or (getMenuShowing() == "Repair") then
			if (getMenuShowing() == "Repair" and tonumber(selectedVehicle.health) == 1000) then
				return
			end
			posY = { panel.vehOptionsPos.deleteYES_Y, panel.vehOptionsPos.deleteNO_Y, "yes", "no" }
		else return end
		
		for ID=1, 2 do
			if isMouseWithinRangeOf(panel.vehOptionsPos.posX, 323, posY[ID], 30) then
				playSound(":VDBGPanelSound/navegacao.mp3")
				return triggerEvent( "onVehicleOptionsButtonClick", resourceRoot, getMenuShowing(), posY[ID + 2]  )
			end
		end
	end
end

function togglePanel()
	if (getElementData(localPlayer,"logado") == false) then return end;
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	triggerServerEvent("playerVehicles:OnRequestPlayerVehicles", localPlayer)
	panel.showing = not panel.showing
	if (type(panel.menuShowing) == "string") then setMenuVisible( panel.menuShowing, false ) end;
	_G[ (panel.showing and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawInterface )
	if isVehicleInfoShowing and panel.showing == false and getElementData ( localPlayer, "opendashboard") == true then
		removeEventHandler( "onClientRender", root, drawVehicleInfo )
		playSound(":VDBGPanelSound/fecha.mp3")
		setElementData(localPlayer, "opendashboard", false)
		isVehicleInfoShowing = false
	elseif panel.showing then
		setElementData(localPlayer, "opendashboard", true)
		addEventHandler( "onClientRender", root, drawVehicleInfo )
		isVehicleInfoShowing = true
		playSound(":VDBGPanelSound/abre.mp3")
	end
	showCursor(panel.showing)
end
addEventHandler("playerVehicles:DoTogglePanelVisible", root, togglePanel)

function getMenuShowing()
	return panel.menuShowing
end

function getSelectedVehicleID()
	return tonumber(getVehicleIDFromString( (dxLibGridlistGetSelectedRowText(vehiclelist) or "") ))
end

function isCursorOverButton(id)
	if tonumber(id) then
		return isMouseWithinRangeOf(panel.btnPos[1], panel.btnPos[2], panel.btnsYPos[id], panel.btnPos[3])
	end
	return false
end

addEventHandler( "playerVehicles:returnVehiclesTable", root,
	function( t )
		for i, v in ipairs(t) do
			vehicleListTexts[ i ] = tostring(v["VehicleID"]) .. "   |  " .. returnInfos(v["ID"], "nome")
		end
	end
)

addEventHandler( "playerVehicles:onRequestUpdateVehicleList", root,
	function( value, removeValue )
		if value == "hideEditBox" then
			destroyElement(panel.targetName)
			guiSetInputMode("allow_binds")
			return
		end
		if removeValue then
			for i=1, #vehicleListTexts do
				local str = vehicleListTexts[i]
				if tostring(value):find( str:sub( 1, str:find(" ") - 1 ) ) then
					table.remove(vehicleListTexts, i)
					break
				end
			end
			selectedVehicle.vehicleName = "N/A"
			selectedVehicle.health = "1000"
			selectedVehicle.fuel = "100"
			selectedVehicle.nitro = "100"
			selectedVehicle.distanceTraveled = "0"
			selectedVehicle.type = "Desconhecido"
			setElementData(vehiclelist,"dxGridlistSelected",0,false)
		else
			local name, ID = unpack( fromJSON(value) )
	
			vehicleListTexts[#vehicleListTexts + 1] = tostring(ID) .. "   |  " .. name
		end
	end
)

function getColorAlpha(color)
   return bitExtract(color,24,8)
end

function drawShadowText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
	dxDrawText(text:gsub("#%x%x%x%x%x%x",""), left + 1, top + 1, right + 1, bottom + 1, tocolor(0, 0, 0, getColorAlpha(color)), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
end

function dxDrawLinedRectangle( startX,startY,width,height,color,foregroundColor,postGUI )
	-- Main rectangle
	dxDrawRectangle(startX+4, startY+4, width-8, height-8, color, postGUI)
	-- Border rectangles
	dxDrawRectangle(startX, startY, 4, height, foregroundColor, postGUI) -- vertical
	dxDrawRectangle(startX + (width - 4), startY, 4, height, foregroundColor, postGUI) -- vertical
	dxDrawRectangle(startX+4, startY, width-8, 4, foregroundColor, postGUI)
	dxDrawRectangle(startX+4, startY + (height - 4), width-8, 4, foregroundColor, postGUI)
end

function getPlayerFromPartialName(name)
	if not (name) or (#name == 0) then return false end;
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
	return false
end

function math.round(number, decimals)
    return tonumber(("%."..(decimals or 0).."f"):format(number))
end

function isMouseWithinRangeOf(psx,pssx,psy,pssy)
  if not isCursorShowing() then
    return false
  end
  local cx,cy = getCursorPosition()
  cx,cy = cx*sw,cy*sh
  if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
    return true
  else
    return false
  end
end
