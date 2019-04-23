
local sw, sh = guiGetScreenSize()
local panel = { }
local houseListTexts = {}
local selectedHouse = {}
local houseDXList = createElement("dxlist_house")

panel.showing = false
panel.menuShowing = false
panel.x, panel.y = (sw - 770)/2, (sh - 453)/2
local isHouseInfoShowing = false
local hasPlayerElement = false
local houseGuestSecondStep
local houseSellSecondStep
local listOffSetY = 10

local colors = {
	sellColor = { { 0,0,0, hover={80, 135, 250} }, { 0,0,0, hover={250, 140, 50} },
					{ 0,0,0, hover={80, 135, 250} }, { 0,0,0, hover={230, 30, 70} }
	},
	deleteColor = { { 0,0,0, hover={250, 35, 65} }, { 0,0,0, hover={80, 135, 250} } },
	lockColor = { { 0,0,0, hover={95, 215, 95} }, { 0,0,0, hover={230, 30, 70} } },
	guestColor = { { 0,0,0, hover={80, 135, 250} }, { 0,0,0, hover={250, 140, 50} }, { 0,0,0, hover={230, 30, 70} },
					{ 0,0,0, hover={80, 135, 250} }, { 0,0,0, hover={250, 140, 50} }
	}
}

-- Client events
addEvent( "VDBGHouse:onDXButtonClick" )
addEvent( "onHouseOptionsButtonClick" )
addEvent( "VDBGHouse:returnHousesTable", true )
addEvent( "VDBGHouse:onRequestUpdateHouseList", true )
addEvent( "VDBGHouse:DoTogglePanelVisible", true )
addEvent( "VDBGHouse:SetMenuVisible", true )

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		panel.btnPos = {panel.x + 388, 344, 35}
		panel.btnsYPos = {panel.y + 240, panel.y + 285, panel.y + 330, panel.y + 375}
		
		panel.sellBtnColor = { 0,0,0, hover = {40, 125, 250} }
		panel.deleteBtnColor = { 0,0,0, hover = {250, 35, 65} }
		panel.lockunlockBtnColor = { 0,0,0, hover = {138, 240, 97} }
		panel.guestBtnColor = { 0,0,0, hover = {250, 140, 35} }
		
		panel.houseOptionsPos = {
			posX = panel.x + 398,
			sellNext_Y = panel.y + 143, sellBack_Y = panel.y + 185,
			sellConfirm_Y = panel.y + 142, sellNO_Y = panel.y + 184,
			deleteYES_Y = panel.y + 138, deleteNO_Y = panel.y + 180,
			guestADD_Y = panel.y + 114, guestRemove_Y = panel.y + 150, guestBack_Y = panel.y + 190
		}
		
		setTimer( triggerServerEvent, 50, 1, "VDBGHouse:OnRequestPlayerHouses", localPlayer )
		bindKey( "F4", "down", togglePanel )
		addCommandHandler( "vercasas", togglePanel, false )
		addEventHandler( "onDxLibGridlistHouseClick", root, onDxLibGridlistClickHandler )
		addEventHandler( "onClientClick", root, onButtonClick )
	end
)

local function getHouseIDFromString( text )
	if text and text ~= "" then
		return text:sub( 1, text:find(" ") - 1 )
	end
	return false
end

local function isCursorOverButton(id)
	if tonumber(id) then
		return isMouseWithinRangeOf(panel.btnPos[1], panel.btnPos[2], panel.btnsYPos[id], panel.btnPos[3])
	end
	return false
end

function drawInterface()
	-- background rectangle
	dxDrawLinedRectangle( panel.x, panel.y, 770, 453, tocolor(0, 0, 0, 155), tocolor(0, 0, 0, 200) )
	
	dxDrawRectangle(panel.x + 376, panel.y + 37, 368, 385, tocolor(0, 0, 0, 160), false)
	-- Title rectangle
	dxDrawRectangle(panel.x, panel.y - 32, 770, 32, tocolor(0, 0, 0, 190), false)
	dxDrawText("#E6E6E6VDB#5592FFGaming - #FF5050Minhas casas", panel.x + 8, panel.y - 32, (panel.x + 8) + 250, (panel.y - 32) + 30, tocolor(255, 255, 255, 255), 1.3, "clear", "left", "center", false, false, false, true)
	-- panel separator line
	dxDrawRectangle(panel.x, panel.y - 2, 770, 2, tocolor(230, 230, 230, 200), false)
	
	drawShadowText("Casas disponíveis ("..#houseListTexts.." / "..getElementData(localPlayer, "maxPlayerHouseSlots")..")  #acd373[O limite de casas, pode ser aumentado na #2F7CCCLOJA DE DIAMANTES#acd373!]", panel.x + 32, panel.y + 13, (panel.x + 32) + 764, (panel.y + 13) + 24, tocolor(20, 122, 192, 255), 1.2, "arial", "left", "center", false, false, false, true)
	
	dxLibCreateGridlist(houseDXList, houseListTexts, panel.x + 26, panel.y + 37, 313, 385, 1.7, "", 20, 180, 230)
	cursorOverHouseButton()
	
	local x,w,h = unpack(panel.btnPos)
	-- Sell button
	dxDrawRectangle(x, panel.btnsYPos[1], w, h, tocolor(panel.sellBtnColor[1], panel.sellBtnColor[2], panel.sellBtnColor[3], 145), false)
	dxDrawText("Vender", x, panel.btnsYPos[1], x + 345, panel.btnsYPos[1] + 35, tocolor(255, 255, 255, 255), 1.4, "arial", "center", "center")
	-- Delete button
	dxDrawRectangle(x, panel.btnsYPos[2], w, h, tocolor(panel.deleteBtnColor[1], panel.deleteBtnColor[2], panel.deleteBtnColor[3], 145), false)
	dxDrawText("Deletar", x, panel.btnsYPos[2], x + 345, panel.btnsYPos[2] + 35, tocolor(255, 255, 255, 255), 1.4, "arial", "center", "center")
	-- (Un)Lock button
	dxDrawRectangle(x, panel.btnsYPos[3], w, h, tocolor(panel.lockunlockBtnColor[1], panel.lockunlockBtnColor[2], panel.lockunlockBtnColor[3], 145), false)
	dxDrawText((selectedHouse.locked == "Sim") and "Abrir" or "Trancar", x, panel.btnsYPos[3], x + 345, panel.btnsYPos[3] + 35, tocolor(255, 255, 255, 255), 1.4, "arial", "center", "center")
	-- Guest button
	dxDrawRectangle(x, panel.btnsYPos[4], w, h, tocolor(panel.guestBtnColor[1], panel.guestBtnColor[2], panel.guestBtnColor[3], 145), false)
	dxDrawText("Hóspede", x, panel.btnsYPos[4], x + 345, panel.btnsYPos[4] + 35, tocolor(255, 255, 255, 255), 1.4, "arial", "center", "center")
end

local currentHoverButton, lastHoverButton
local buttons = { "sellBtnColor", "deleteBtnColor", "lockunlockBtnColor", "guestBtnColor" }
function cursorOverHouseButton()
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

function drawHouseInfo()

	
	local rowText = dxLibGridlistGetSelectedRowText(houseDXList)
	local houseID = rowText and getHouseIDFromString( rowText ) or ""
	
	local city = selectedHouse.city and "("..(selectedHouse.city or "-")..")" or ""
	local location = (selectedHouse.location or "Desconhecida") .." ".. city
	dxDrawText(selectedHouse.location or "N/A", panel.x + 376, panel.y + 37, (panel.x+376) + 367, (panel.y+37) + 30, tocolor(37, 222, 0, 210), 1.7, "arial", "center", "bottom")
	dxDrawText("[ID: "..houseID.."]", panel.x + 376, panel.y + 68, (panel.x+376) + 367, (panel.y+68) + 23, tocolor(160, 160, 160, 210), 1.2, "arial", "center", "top")
	
	dxDrawRectangle(panel.x + 376, panel.y + 100, 368, 25, tocolor(75, 75, 75, 150), false)
	dxDrawText("#FFFFFFPreço: #3090FF"..convertNumber((selectedHouse.cost or 0)), panel.x + 385, panel.y + 100, (panel.x+385) + 358, (panel.y+100) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
	dxDrawText("Localização: #3090FF"..location, panel.x + 385, panel.y + 125, (panel.x+385) + 358, (panel.y+125) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
	
	dxDrawRectangle(panel.x + 376, panel.y + 150, 368, 25, tocolor(75, 75, 75, 150), false)
	dxDrawText("Hóspedes: #3090FF"..(selectedHouse.guest or "0"), panel.x + 385, panel.y + 150, (panel.x+385) + 358, (panel.y+150) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
	dxDrawText("Trancada: #3090FF"..(selectedHouse.locked or "N/A"), panel.x + 385, panel.y + 175, (panel.x+385) + 358, (panel.y+175) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
	
	dxDrawRectangle(panel.x + 376, panel.y + 200, 368, 25, tocolor(75, 75, 75, 150), false)
	dxDrawText("Garagem: #3090FF"..(selectedHouse.garage or "N/A"), panel.x + 385, panel.y + 200, (panel.x+385) + 358, (panel.y+200) + 25, tocolor(255, 255, 255, 220), 1.2, "default-bold", "left", "center", false, false, false, true)
end

function drawSellOption()
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	
	drawShadowText("Clique no botão #AFC8F7Vender #F5F5F5para", panel.x + 390, panel.y + 65, (panel.x+390) + 339, (panel.y+65) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("ir para a próxima etapa", panel.x + 390, panel.y + 88, (panel.x+390) + 339, (panel.y+88) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center")
	
	houseOptionsCursorHover()
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.sellNext_Y, 323, 30, tocolor(colors.sellColor[1][1], colors.sellColor[1][2], colors.sellColor[1][3], 165), false)
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.sellBack_Y, 323, 30, tocolor(colors.sellColor[2][1], colors.sellColor[2][2], colors.sellColor[2][3], 165), false)
	
	dxDrawText("Vender", panel.x + 398, panel.y + 141, (panel.x+398) + 323, (panel.y+141) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
	dxDrawText("Voltar", panel.x + 398, panel.y + 186, (panel.x+398) + 323, (panel.y+186) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
end

function drawSellOptionNextStep()
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	
	drawShadowText("#95FF95Você tem certeza #F5F5F5que deseja vender", panel.x + 390, panel.y + 60, (panel.x+390) + 339, (panel.y+60) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("esta casa por R$"..tostring(convertNumber((selectedHouse.cost))).." ?", panel.x + 390, panel.y + 80, (panel.x+390) + 339, (panel.y+80) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("Esta operação não poderá ser desfeita!", panel.x + 390, panel.y + 101, (panel.x+390) + 339, (panel.y+101) + 20, tocolor(43, 127, 255, 230), 1.2, "arial", "center", "center")
	houseOptionsCursorHover()
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.y + 142, 323, 30, tocolor(colors.sellColor[3][1], colors.sellColor[3][2], colors.sellColor[3][3], 165), false)
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.y + 184, 323, 30, tocolor(colors.sellColor[4][1], colors.sellColor[4][2], colors.sellColor[4][3], 165), false)
	
	dxDrawText("Sim, tenho!", panel.x + 398, panel.y + 140, (panel.x+398) + 323, (panel.y+140) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
	dxDrawText("Não!", panel.x + 398, panel.y + 182, (panel.x+398) + 323, (panel.y+182) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
end

function drawDeleteOption()
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	drawShadowText("#95FF95Você tem certeza", panel.x + 390, panel.y + 53, (panel.x+390) + 339, (panel.y+53) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("que deseja #FF7070deletar #FFFFFFesta casa?", panel.x + 390, panel.y + 73, (panel.x+390) + 339, (panel.y+73) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("Esta operação não poderá ser desfeita!", panel.x + 390, panel.y + 94, (panel.x+390) + 339, (panel.y+94) + 20, tocolor(43, 127, 255, 230), 1.2, "arial", "center", "center")
	
	houseOptionsCursorHover()
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.deleteYES_Y, 323, 30, tocolor(colors.deleteColor[1][1], colors.deleteColor[1][2], colors.deleteColor[1][3], 165), false)
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.deleteNO_Y, 323, 30, tocolor(colors.deleteColor[2][1], colors.deleteColor[2][2], colors.deleteColor[2][3], 165), false)
	dxDrawText("Sim, tenho!", panel.x + 398, panel.y + 136, (panel.x+398) + 323, (panel.y+136) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
	dxDrawText("Não!", panel.x + 398, panel.y + 178, (panel.x+398) + 323, (panel.y+178) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
end

function drawLockunlockOption()
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	drawShadowText("#95FF95Você tem certeza", panel.x + 390, panel.y + 60, (panel.x+390) + 339, (panel.y+60) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("que deseja deixar a sua casa #82BEFF".. (selectedHouse.locked == "Não" and "trancada" or "aberta") .." #F5F5F5?", panel.x + 390, panel.y + 82, (panel.x+390) + 339, (panel.y+82) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	
	houseOptionsCursorHover()
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.deleteYES_Y, 323, 30, tocolor(colors.lockColor[1][1], colors.lockColor[1][2], colors.lockColor[1][3], 165), false)
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.deleteNO_Y, 323, 30, tocolor(colors.lockColor[2][1], colors.lockColor[2][2], colors.lockColor[2][3], 165), false)
	dxDrawText("Sim, tenho!", panel.x + 398, panel.y + 136, (panel.x+398) + 323, (panel.y+136) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
	dxDrawText("Não!", panel.x + 398, panel.y + 178, (panel.x+398) + 323, (panel.y+178) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
end

function drawGuestOption()
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	drawShadowText("#9BCBFFEscolha uma das opções abaixo:", panel.x + 390, panel.y + 63, (panel.x+390) + 339, (panel.y+63) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	
	houseOptionsCursorHover()
	
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.guestADD_Y, 323, 30, tocolor(colors.guestColor[1][1], colors.guestColor[1][2], colors.guestColor[1][3], 165), false)
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.guestRemove_Y, 323, 30, tocolor(colors.guestColor[2][1], colors.guestColor[2][2], colors.guestColor[2][3], 165), false)
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.houseOptionsPos.guestBack_Y, 323, 30, tocolor(colors.guestColor[3][1], colors.guestColor[3][2], colors.guestColor[3][3], 165), false)
	
	dxDrawText("Adicionar hóspede", panel.x + 398, panel.y + 112, (panel.x+398) + 323, (panel.y+112) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
	dxDrawText("Remover hóspede", panel.x + 398, panel.y + 148, (panel.x+398) + 323, (panel.y+148) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
	dxDrawText("Voltar", panel.x + 398, panel.y + 188, (panel.x+398) + 323, (panel.y+188) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
end

function drawGuestSecondStep()
	if not houseGuestSecondStep then return end;
	dxDrawRectangle(panel.x + 386, panel.y + 47, 347, 185, tocolor(55, 55, 55, 145), false)
	drawShadowText("Digite o #95FF95nome do jogador", panel.x + 390, panel.y + 53, (panel.x+390) + 339, (panel.y+53) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	drawShadowText("que você deseja #A3E4FF".. (houseGuestSecondStep == "add" and "adicionar" or "remover") .." #F5F5F5como hóspede", panel.x + 390, panel.y + 73, (panel.x+390) + 339, (panel.y+73) + 20, tocolor(245, 245, 245, 240), 1.3, "arial", "center", "center", false, false, false, true)
	
	houseOptionsCursorHover()
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.y + 158, 323, 30, tocolor(colors.guestColor[4][1], colors.guestColor[4][2], colors.guestColor[4][3], 165), false)
	dxDrawRectangle(panel.houseOptionsPos.posX, panel.y + 194, 323, 30, tocolor(colors.guestColor[5][1], colors.guestColor[5][2], colors.guestColor[5][3], 165), false)
	
	local r,g,b = 0,0,0
	local str = ""
	if (guiGetText(panel.guestEdit):len() > 0) then
		if not hasPlayerElement then
			r, g, b = 255, 43, 43
			str = "Jogador não encontrado!"
		else
			r, g, b = 43, 220, 43
			if (getPlayerFromPartialName(guiGetText(panel.guestEdit)) == localPlayer) then
				r, g, b = 255, 43, 43
				str = "Você não pode adicionar ou remover o dono"
			else
				str = "Jogador encontrado"
			end
		end
	end
	dxDrawText(str, panel.x + 385, panel.y + 129, (panel.x+385) + 348, (panel.y+129) + 23, tocolor(r, g, b, 230), 1.2, "arial", "center", "center")
	dxDrawText((houseGuestSecondStep == "add" and "Adicionar" or "Remover") .." hóspede", panel.x + 398, panel.y + 156, (panel.x+398) + 323, (panel.y+156) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
	dxDrawText("Voltar", panel.x + 398, panel.y + 192, (panel.x+398) + 323, (panel.y+192) + 32, tocolor(250, 250, 250, 250), 1.3, "arial", "center", "center")
end

function houseOptionsCursorHover()
	local posY
	local indexEnd = 2
	if (getMenuShowing() ~= "Sell" and getMenuShowing() ~= "Delete" and
		getMenuShowing() ~= "LockUnlock" and getMenuShowing() ~= "Guest") then
	return end
	
	if (getMenuShowing() == "Sell") and not houseSellSecondStep then
		posY = { panel.houseOptionsPos.sellNext_Y, panel.houseOptionsPos.sellBack_Y }
	elseif (getMenuShowing() == "Delete") or (getMenuShowing() == "LockUnlock") then
		posY = { panel.houseOptionsPos.deleteYES_Y, panel.houseOptionsPos.deleteNO_Y }
	elseif (getMenuShowing() == "Guest") and not houseGuestSecondStep then
		posY = { panel.houseOptionsPos.guestADD_Y, panel.houseOptionsPos.guestRemove_Y, panel.houseOptionsPos.guestBack_Y }
		indexEnd = 3
	end

	local t = (getMenuShowing() == "Sell") and colors.sellColor
			or (getMenuShowing() == "Delete") and colors.deleteColor
			or (getMenuShowing() == "LockUnlock") and colors.lockColor
			or (getMenuShowing() == "Guest") and colors.guestColor
	
	if houseGuestSecondStep then
		posY = { [4] = panel.y + 158, [5] = panel.y + 194 }
	elseif houseSellSecondStep then
		posY = { [3] = panel.y + 142, [4] = panel.y + 184 }
	end
	for ID=1, indexEnd do
		if houseGuestSecondStep then ID = ID + 3
		elseif houseSellSecondStep then ID = ID + 2
		end
		if isMouseWithinRangeOf(panel.houseOptionsPos.posX, 323, posY[ID], 30) then
			t[ID][1], t[ID][2], t[ID][3] = unpack( t[ID].hover )
		else
			if t[ID][1] ~= 0 then
				t[ID][1], t[ID][2], t[ID][3] = 0,0,0
			end
		end
	end
end

addEventHandler( "onHouseOptionsButtonClick", root, 
	function (menu, menuButton)
		if menu == "Sell" then
			if menuButton == "sell_ok" then
				showSellDX( true )
			elseif menuButton == "back" then
				setMenuVisible(1, false, true)
			end
		elseif menu == "Sell-nextStep" then
			if menuButton == "sell_confirm" then
				triggerServerEvent("VDBGHouse:HouseOptions_DoAction", localPlayer, 1, getSelectedHouseID())
			elseif menuButton == "no" then
				setMenuVisible(1, false, true, "sell")
			end
		elseif menu == "Delete" then
			if menuButton == "yes" then
				triggerServerEvent( "VDBGHouse:HouseOptions_DoAction", localPlayer, 2, getSelectedHouseID() )
			elseif menuButton == "no" then
				setMenuVisible(2, false, true)
			end
		elseif menu == "LockUnlock" then
			if menuButton == "yes" then
				triggerServerEvent( "VDBGHouse:HouseOptions_DoAction", localPlayer, 3, getSelectedHouseID(), (selectedHouse.locked == "Não" and 1 or 0) )
			elseif menuButton == "no" then
				setMenuVisible(3, false, true)
			end
		elseif menu == "Guest" then
			if type(menuButton) ~= "string" then return end;
			if menuButton == "add" then
				setTimer( showGuestDX, 50, 1, true, true )
			elseif menuButton == "remove" then
				setTimer( showGuestDX, 50, 1, false, true )
			elseif menuButton == "back" then
				setMenuVisible(4, false, true)
			end
		elseif menu == "Guest-nextStep" then
			if ( menuButton == "add" or menuButton == "remove" ) then
				if (guiGetText(panel.guestEdit) == "") then outputChatBox("#d9534f[VDBG.ORG] #FFFFFFDigite o nome do jogador!", 255, 255, 255, true) return end;
				panel.targetPlayer = getPlayerFromPartialName( guiGetText(panel.guestEdit) )
				if not isElement(panel.targetPlayer) or (panel.targetPlayer == localPlayer) then
				return end
			end
			if menuButton == "add" then
				triggerServerEvent("VDBGHouse:HouseOptions_DoAction", localPlayer, 4, getSelectedHouseID(), menuButton, panel.targetPlayer)
			elseif menuButton == "remove" then
				triggerServerEvent("VDBGHouse:HouseOptions_DoAction", localPlayer, 4, getSelectedHouseID(), menuButton, panel.targetPlayer)
			elseif menuButton == "back" then
				showGuestDX( nil, false, true )
			end
		end
	end
)

function showGuestDX( add, visible, showGuestDXMain )
	if visible then
		removeEventHandler( "onClientRender", root, drawGuestOption )
		panel.guestEdit = guiCreateEdit(panel.x + 398, panel.y + 98, 323, 30, "", false)
		guiSetFont(panel.guestEdit, "clear-normal")
		guiSetInputMode("no_binds_when_editing")
		addEventHandler( "onClientGUIChanged", panel.guestEdit, onEditTextChange )
		houseGuestSecondStep = add and "add" or "remove"
		addEventHandler( "onClientRender", root, drawGuestSecondStep )
	else
		if not isElement(panel.guestEdit) then return end;
		destroyElement(panel.guestEdit)
		guiSetInputMode("allow_binds")
		houseGuestSecondStep = nil
		removeEventHandler( "onClientRender", root, drawGuestSecondStep )
		if showGuestDXMain then
			setTimer( function()
				addEventHandler( "onClientRender", root, drawGuestOption )
			end, 50, 1 )
		end
	end
end

function showSellDX( visible, showSellStart )
	if visible then
		removeEventHandler( "onClientRender", root, drawSellOption )
		houseSellSecondStep = true
		addEventHandler( "onClientRender", root, drawSellOptionNextStep )
	else
		houseSellSecondStep = nil
		removeEventHandler( "onClientRender", root, drawSellOptionNextStep )
		if showSellStart then
			setTimer( function()
				addEventHandler( "onClientRender", root, drawSellOption )
			end, 50, 1 )
		end
	end
end

function onDxLibGridlistClickHandler( gridlistElement )
	triggerServerEvent("VDBGHouse:OnPlayerSelectHouseFromList", localPlayer, getSelectedHouseID())
	if (type(panel.menuShowing) == "string") then setMenuVisible( panel.menuShowing, false, true ) end;
	if houseGuestSecondStep then showGuestDX()
	elseif houseSellSecondStep then showSellDX()
	end
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

function setMenuVisible(id, value, showHouseInfo, DXsecondStep)
	if type(id) == "string" then
		id = (id == "Sell" and 1) or (id == "Delete" and 2) or (id == "LockUnlock" and 3) or (id == "Guest" and 4)
	end
	if id == 1 then
		if not DXsecondStep then
			_G[ (value and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawSellOption )
		elseif DXsecondStep == "sell" and value == false then
			showSellDX()
		end
	elseif id == 2 then
		_G[ (value and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawDeleteOption )
	elseif id == 3 then
		_G[ (value and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawLockunlockOption )
	elseif id == 4 then
		if not DXsecondStep then
			_G[ (value and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawGuestOption )
		elseif DXsecondStep == "guest" and value == false then
			showGuestDX()
		end
	end
	if showHouseInfo then
		addEventHandler("onClientRender", root, drawHouseInfo)
		isHouseInfoShowing = true
	end
	if value == false then
		panel.menuShowing = false
		return
	end
	panel.menuShowing = (id == 1 and "Sell") or (id == 2 and "Delete") or (id == 3 and "LockUnlock") or (id == 4 and "Guest")
end
addEventHandler("VDBGHouse:SetMenuVisible", root, setMenuVisible)

addEventHandler( "VDBGHouse:onDXButtonClick", root,
	function (buttonID)
		if not (#houseListTexts > 0) then return end;
		if type( dxLibGridlistGetSelectedRowText(houseDXList) ) ~= "string" then return end;
		
		if tonumber(buttonID) then
			if isHouseInfoShowing then removeEventHandler("onClientRender", root, drawHouseInfo) isHouseInfoShowing = false end;
			
			if type(panel.menuShowing) == "string" and not houseGuestSecondStep and not houseSellSecondStep then
				setMenuVisible( panel.menuShowing, false )
			elseif houseGuestSecondStep then
				showGuestDX()
			elseif houseSellSecondStep then
				showSellDX()
			end
			setMenuVisible( buttonID, true )
		end
	end
)

addEventHandler( "onClientElementDataChange", localPlayer,
	function (dataName, oldValue)
		if (dataName == "VDBGHouse:HouseData") then
			local data = getElementData(localPlayer, dataName)
			selectedHouse.location = data["location"] or false
			selectedHouse.city = data["city"] or false
			selectedHouse.cost = data["cost"] or "0"
			selectedHouse.guest = tostring(#fromJSON(data["house_guest"])) or "0"
			selectedHouse.locked = ( tonumber(data["locked"]) == 0 and "Não" or "Sim" )
			selectedHouse.garage = data["garageType"] and "Sim (tipo: "..tostring(data["garageType"])..")"
		end
	end
)

function onButtonClick(button, state)
	if (button == "left") and (state == "up") and panel.showing and not isConsoleActive() and not isMainMenuActive() then		
		for ID=1, 4 do
			if isCursorOverButton(ID) then		
				playSound(":VDBGPanelSound/navegacao.mp3")	
				return triggerEvent( "VDBGHouse:onDXButtonClick", resourceRoot, ID )
			end
		end
		local posY
		local DXMenu
		local indexEnd = 2
		for i, v in pairs( {"Sell", "Delete", "LockUnlock", "Guest"} ) do
			if getMenuShowing() == v then DXMenu = v end
		end
		if not DXMenu then return end;
		
		if (getMenuShowing() == "Sell") and not houseSellSecondStep then
			posY = { panel.houseOptionsPos.sellNext_Y, panel.houseOptionsPos.sellBack_Y, "sell_ok", "back" }
			playSound(":VDBGPanelSound/navegacao.mp3")
		elseif (getMenuShowing() == "Delete") or (getMenuShowing() == "LockUnlock") then
			posY = { panel.houseOptionsPos.deleteYES_Y, panel.houseOptionsPos.deleteNO_Y, "yes", "no" }
		elseif (getMenuShowing() == "Guest") and not houseGuestSecondStep then
				playSound(":VDBGPanelSound/navegacao.mp3")	
			posY = {
				panel.houseOptionsPos.guestADD_Y,
				panel.houseOptionsPos.guestRemove_Y,
				panel.houseOptionsPos.guestBack_Y, "add", "remove", "back"
			}
			indexEnd = 3
		end
		if houseGuestSecondStep then
			posY = { panel.y + 158, panel.y + 194, houseGuestSecondStep, "back" }
			DXMenu = "Guest-nextStep"
			playSound(":VDBGPanelSound/navegacao.mp3")	
		elseif houseSellSecondStep then
			posY = { panel.y + 142, panel.y + 184, "sell_confirm", "no" }
			DXMenu = "Sell-nextStep"
			playSound(":VDBGPanelSound/navegacao.mp3")	
		end
		for ID=1, indexEnd do
			if isMouseWithinRangeOf(panel.houseOptionsPos.posX, 323, posY[ID], 30) then
				return triggerEvent( "onHouseOptionsButtonClick", resourceRoot,
						DXMenu, posY[ID + indexEnd]  )
			end
		end
	end
end

function togglePanel()
	if (getElementData(localPlayer,"logado") == false) then return end;
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	panel.showing = not panel.showing
	if (type(panel.menuShowing) == "string")
		and not houseGuestSecondStep
		or not houseSellSecondStep then
		setMenuVisible( panel.menuShowing, false )
	end
	if houseGuestSecondStep then showGuestDX()
	elseif houseSellSecondStep then showSellDX()
	end
	_G[ (panel.showing and "add" or "remove").."EventHandler" ]( "onClientRender", root, drawInterface )
	
	if isHouseInfoShowing and panel.showing == false then
		removeEventHandler( "onClientRender", root, drawHouseInfo )
		isHouseInfoShowing = false
		setElementData(localPlayer, "opendashboard", false)
		playSound(":VDBGPanelSound/fecha.mp3")
	elseif panel.showing then
		setElementData(localPlayer, "opendashboard", true)
		addEventHandler( "onClientRender", root, drawHouseInfo )
		isHouseInfoShowing = true
		playSound(":VDBGPanelSound/abre.mp3")
	end
	showCursor(panel.showing)
end
addEventHandler("VDBGHouse:DoTogglePanelVisible", root, togglePanel)

function getMenuShowing()
	return panel.menuShowing
end

function getSelectedHouseID()
	return tonumber(getHouseIDFromString( (dxLibGridlistGetSelectedRowText(houseDXList) or "") ))
end

addEventHandler( "VDBGHouse:returnHousesTable", root,
	function( t )
		for i, v in ipairs(t) do
			houseListTexts[ i ] = tostring(v[1]) .. "  | " .. v[2]
		end
	end
)

addEventHandler( "VDBGHouse:onRequestUpdateHouseList", root,
	function( action_id, value, removeData, selectedHouse_newval )
	  if action_id == 1 then
		if removeData then
			for i=1, #houseListTexts do
				local str = houseListTexts[i]
				if tostring(value):find( str:sub( 1, str:find(" ") - 1 ) ) then
					table.remove(houseListTexts, i)
					break
				end
			end
			selectedHouse.location = false
			selectedHouse.city = false
			selectedHouse.cost = "0"
			selectedHouse.guest = "N/A"
			selectedHouse.locked = "N/A"
			selectedHouse.garage = "N/A"
			setElementData(houseDXList,"house_dxGridlistSelected",0,false)
		else
			houseListTexts[#houseListTexts + 1] = tostring(fromJSON(value)[1]) .. "  | " .. fromJSON(value)[2]
		end
	  elseif action_id == 2 then
		  if tostring(value) == "locked" then
			  selectedHouse_newval = ( selectedHouse_newval == 0 and "Não" or "Sim" )
		  elseif tostring(value) == "guest" then
			  selectedHouse_newval = tostring(#fromJSON(selectedHouse_newval))
		  end
		  selectedHouse[tostring(value)] = selectedHouse_newval
	  end
	end
)

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
