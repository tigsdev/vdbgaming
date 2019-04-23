
local sw,sh = guiGetScreenSize()
local font = dxCreateFont("font/opensans_semibold.ttf", 15)
local font2 = dxCreateFont("font/opensans_semibold.ttf", 13)
local boughtHouseFont = dxCreateFont("font/opensans_semibold.ttf", 12)
local boughtHouseFont2 = dxCreateFont("font/opensans_semibold.ttf", 11)
local UI = {}
local houseDX = {}
local panelCenteredX, panelCenteredY = (sw - 432)/2, (sh - 487)/2
local garageData = {}
local offSetX = 11
local DXWidth = 323
local boughtHouseRecW = 250

local garageMarker
local tRot
local teRot
local currentPickup = false
local house_DXHidden = false
local isGarageNoteDrawn
local isInsideHouse
local garage_houseID
local isGuestDXVisible
local isDXButtonVisible
local tempvar_guest_houseID
local waitingForServerResponse

local buyX = offSetX
local enterX = buyX + ( offSetX + 92 )
local closeX = enterX + ( offSetX + 92 )
local buttonsY = math.ceil((14 * sh) / 100)
local exitX = offSetX
houseDX.exit_width = 107
houseDX.warpTo_width = 138
local garX = exitX + ( offSetX + houseDX.exit_width )
local cloX = garX + ( offSetX + houseDX.warpTo_width )

local colors = {
	buyAlpha = { 150, hover = 210 },
	enterAlpha = { 150, hover = 210 },
	closeAlpha = { 150, hover = 210 }
}

function onRequestCreateHousePanel()
	UI.window1 = guiCreateWindow(panelCenteredX, panelCenteredY, 432, 487, "VDBG: Criação de casa", false)
	guiWindowSetSizable(UI.window1, false)
	guiSetAlpha(UI.window1, 0.85)
	showCursor(true)

	UI.BG1_1 = guiCreateStaticImage(10, 23, 190, 197, "image/dot_white.png", false, UI.window1)
	UI.BG1_2 = guiCreateStaticImage(231, 23, 190, 197, "image/dot_white.png", false, UI.window1)
	UI.BG1_3 = guiCreateStaticImage(10, 237, 190, 197, "image/dot_white.png", false, UI.window1)
	UI.BG1_4 = guiCreateStaticImage(231, 237, 190, 197, "image/dot_white.png", false, UI.window1)
	
	UI.edit1_1 = guiCreateEdit(21, 64, 165, 29, "", false, UI.window1)
	UI.edit1_2 = guiCreateEdit(21, 103, 165, 29, "", false, UI.window1)
	UI.edit1_3 = guiCreateEdit(21, 142, 165, 29, "", false, UI.window1)
	UI.label1_1 = guiCreateLabel(17, 27, 173, 31, "Coordenadas da entrada (pickup)", false, UI.window1)
	guiSetFont(UI.label1_1, "default-bold-small")
	guiLabelSetColor(UI.label1_1, 255, 246, 0)
	guiLabelSetHorizontalAlign(UI.label1_1, "center", true)
	guiLabelSetVerticalAlign(UI.label1_1, "center")
	UI.button1_1 = guiCreateButton(24, 179, 154, 31, "Pegar coordenadas", false, UI.window1)
	
	UI.label1_2 = guiCreateLabel(239, 27, 173, 31, "Coordenadas da saída (pickup)", false, UI.window1)
	guiSetFont(UI.label1_2, "default-bold-small")
	guiLabelSetColor(UI.label1_2, 255, 246, 0)
	guiLabelSetHorizontalAlign(UI.label1_2, "center", true)
	guiLabelSetVerticalAlign(UI.label1_2, "center")
	UI.edit1_4 = guiCreateEdit(244, 64, 165, 29, "", false, UI.window1)
	UI.edit1_5 = guiCreateEdit(244, 103, 165, 29, "", false, UI.window1)
	UI.edit1_6 = guiCreateEdit(244, 142, 165, 29, "", false, UI.window1)
	UI.button1_2 = guiCreateButton(249, 179, 154, 31, "Pegar coordenadas", false, UI.window1)
	
	UI.label1_3 = guiCreateLabel(17, 243, 173, 31, "Coordenadas do teleporte para dentro", false, UI.window1)
	guiSetFont(UI.label1_3, "default-bold-small")
	guiLabelSetColor(UI.label1_3, 255, 246, 0)
	guiLabelSetHorizontalAlign(UI.label1_3, "center", true)
	guiLabelSetVerticalAlign(UI.label1_3, "center")
	UI.edit1_7 = guiCreateEdit(20, 280, 165, 29, "", false, UI.window1)
	UI.edit1_8 = guiCreateEdit(20, 358, 165, 29, "", false, UI.window1)
	UI.edit1_9 = guiCreateEdit(20, 319, 165, 29, "", false, UI.window1)
	UI.button1_3 = guiCreateButton(26, 395, 154, 31, "Pegar coordenadas", false, UI.window1)
	
	UI.label1_4 = guiCreateLabel(240, 243, 173, 31, "Coordenadas do teleporte para fora", false, UI.window1)
	guiSetFont(UI.label1_4, "default-bold-small")
	guiLabelSetColor(UI.label1_4, 255, 246, 0)
	guiLabelSetHorizontalAlign(UI.label1_4, "center", true)
	guiLabelSetVerticalAlign(UI.label1_4, "center")
	UI.edit1_10 = guiCreateEdit(244, 280, 165, 29, "", false, UI.window1)
	UI.edit1_11 = guiCreateEdit(244, 319, 165, 29, "", false, UI.window1)
	UI.edit1_12 = guiCreateEdit(244, 358, 165, 29, "", false, UI.window1)
	UI.button1_4 = guiCreateButton(249, 395, 154, 31, "Pegar coordenadas", false, UI.window1)
	
	UI.nextStep = guiCreateButton(126, 444, 177, 33, "Prosseguir", false, UI.window1)
	for id=1, 12 do
		guiEditSetReadOnly( UI["edit1_"..tostring(id)], true )
	end
	for id=1, 4 do
		guiSetAlpha(UI["BG1_"..tostring(id)], 0.58)
		guiSetProperty(UI["BG1_"..tostring(id)], "ImageColours", "tl:63000000 tr:63000000 bl:63000000 br:63000000")
		guiSetEnabled(UI["BG1_"..tostring(id)], false)
	end
	
	UI.garageWindow = guiCreateWindow(panelCenteredX + 432 + math.ceil((0.19 * sw) / 100), panelCenteredY, 209, 262, "Garagem", false)
	guiWindowSetSizable(UI.garageWindow, false)
	guiSetAlpha(UI.garageWindow, 0.85)
	
	UI.enableGarage_cbox = guiCreateCheckBox(10, 31, 122, 18, "Com garagem", false, false, UI.garageWindow)
	guiSetFont(UI.enableGarage_cbox, "default-bold-small")
	guiSetProperty(UI.enableGarage_cbox, "NormalTextColour", "FF73ECFF")
	guiSetProperty(UI.enableGarage_cbox, "HoverTextColour", "FF99FFFF")
	guiSetProperty(UI.enableGarage_cbox, "PushedTextColour", "FF2070FF")
	
	UI.label1_5 = guiCreateLabel(10, 56, 63, 20, "Marca (X):", false, UI.garageWindow)
	guiSetFont(UI.label1_5, "default-bold-small")
	guiLabelSetColor(UI.label1_5, 244, 255, 81)
	guiLabelSetVerticalAlign(UI.label1_5, "center")
	UI.label1_6 = guiCreateLabel(10, 76, 63, 20, "Marca (Y):", false, UI.garageWindow)
	guiSetFont(UI.label1_6, "default-bold-small")
	guiLabelSetColor(UI.label1_6, 244, 255, 81)
	guiLabelSetVerticalAlign(UI.label1_6, "center")
	UI.label1_7 = guiCreateLabel(10, 96, 63, 20, "Marca (Z):", false, UI.garageWindow)
	guiSetFont(UI.label1_7, "default-bold-small")
	guiLabelSetColor(UI.label1_7, 244, 255, 81)
	guiLabelSetVerticalAlign(UI.label1_7, "center")

	UI.label1_8 = guiCreateLabel(79, 56, 126, 20, "", false, UI.garageWindow)
	guiLabelSetVerticalAlign(UI.label1_8, "center")
	UI.label1_9 = guiCreateLabel(79, 76, 126, 20, "", false, UI.garageWindow)
	guiLabelSetVerticalAlign(UI.label1_9, "center")
	UI.label1_10 = guiCreateLabel(79, 96, 126, 20, "", false, UI.garageWindow)
	guiLabelSetVerticalAlign(UI.label1_10, "center")
	
	UI.button1_5 = guiCreateButton(12, 127, 132, 27, "Pegar coordenadas", false, UI.garageWindow)

	UI.label1_11 = guiCreateLabel(15, 164, 162, 18, "Tamanho:", false, UI.garageWindow)
	guiSetFont(UI.label1_11, "default-bold-small")
	guiLabelSetColor(UI.label1_11, 85, 255, 209)
	guiLabelSetVerticalAlign(UI.label1_11, "center")
	
	UI.edit1_13 = guiCreateEdit(10, 186, 152, 25, "", false, UI.garageWindow)

	UI.checkbox1_1 = guiCreateCheckBox(10, 229, 122, 18, "Visualizar Marca", true, false, UI.garageWindow)
	guiSetFont(UI.checkbox1_1, "default-bold-small")
	guiSetProperty(UI.checkbox1_1, "NormalTextColour", "FF73ECFF")
	guiSetProperty(UI.checkbox1_1, "HoverTextColour", "FF99FFFF")
	guiSetProperty(UI.checkbox1_1, "PushedTextColour", "FF2070FF")
	guiSetInputMode("no_binds_when_editing")
	
	bindKey("mouse2", "down", showHide)
	addEventHandler("onClientGUIClick", guiRoot, onBtnClick)
	addEventHandler("onClientGUIChanged", UI.edit1_13, changeMarkerSize)
	addEventHandler("onClientRender", root, drawNote)
end

function changeMarkerSize()
	if guiGetText(source) == "" or not (garageMarker) then return end;
	local value = tonumber(guiGetText(source))
	if value then
		garageData[4] = value
		setMarkerSize(garageMarker, garageData[4])
	end
end

function onBtnClick()
	if source == UI.nextStep then
		for i=1, 12, 3 do
			if guiGetText(UI["edit1_"..tostring(i)]) == "" then
				return outputChatBox("#d9534f[VDBG.ORG] #FFFFFFPegue todas as coordenadas antes de continuar !", 255, 255, 255, true)
			end
		end
		if guiCheckBoxGetSelected(UI.enableGarage_cbox) and (guiGetText(UI.label1_8) == "" or not (tonumber(guiGetText(UI.edit1_13)))) then
			return outputChatBox("#d9534f[VDBG.ORG] #FFFFFFCrie a marca para a garagem antes de prosseguir !", 255, 255, 255, true)
		end
		guiSetVisible(UI.window1, false)
		guiSetVisible(UI.garageWindow, false)
		createUIStep2()
		return
	elseif source == UI.button1_5 then
		local pos = { getElementPosition(localPlayer) }
		garageData[1], garageData[2], garageData[3] = pos[1], pos[2], pos[3] - .9
		garageData[4] = 1
		if isElement(garageMarker) then
			setMarkerSize(garageMarker, garageData[4])
		else
			garageMarker = createMarker(garageData[1], garageData[2], garageData[3], "cylinder", garageData[4], 220, 0, 0, 180)
		end
		guiSetText(UI.label1_8, tostring( garageData[1] ))
		guiSetText(UI.label1_9, tostring( garageData[2] ))
		guiSetText(UI.label1_10, tostring( garageData[3] ))
		guiSetText(UI.edit1_13, tostring( garageData[4] ))
		if not guiCheckBoxGetSelected(UI.enableGarage_cbox) then guiCheckBoxSetSelected(UI.enableGarage_cbox, true) end
		return
	elseif source == UI.checkbox1_1 then
		setElementAlpha( garageMarker, guiCheckBoxGetSelected(source) and 180 or 0 )
		return
	elseif source == UI.enableGarage_cbox then
		
	end
	if ( source == UI.checkbox2_1 or source == UI.checkbox2_2 ) then
		if guiCheckBoxGetSelected(source) == false then
			guiCheckBoxSetSelected(source, true)
		end
		for i=1, 2 do
		  if source == UI["checkbox2_"..tostring(i)] and guiCheckBoxGetSelected(UI["checkbox2_"..tostring(i==1 and 2 or 1)]) then
			guiCheckBoxSetSelected(UI["checkbox2_"..tostring(i==1 and 2 or 1)], false)
		  end
		end
	end
	for id=1, 4 do
		if source == UI["button1_"..tostring(id)] then
			local pos = { getElementPosition(localPlayer) }
			if id == 3 then
				tRot = getPedRotation(localPlayer)
			elseif id == 4 then
				teRot = getPedRotation(localPlayer)
			end
			local ev = { 1,4,7,10 }
			for i=0, 2 do
				guiSetText(UI["edit1_"..tostring( ev[id] + i )], tostring( pos[i + 1] ))
			end
		end
	end
end

function createUIStep2()
	UI.window2 = guiCreateWindow((sw - 322)/2, (sh - 268)/2, 322, 273, "VDBG: Criação de casa", false)
	guiWindowSetSizable(UI.window2, false)
	guiSetAlpha(UI.window2, 0.85)

	UI.BG2_1 = guiCreateStaticImage(9, 24, 302, 104, "image/dot_white.png", false, UI.window2)
	guiSetAlpha(UI.BG2_1, 0.58)
	guiSetProperty(UI.BG2_1, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetEnabled(UI.BG2_1, false)
	
	UI.edit2_1 = guiCreateEdit(19, 56, 136, 30, "", false, UI.window2)
	guiSetFont(UI.edit2_1, "clear-normal")
	UI.label2_1 = guiCreateLabel(19, 30, 136, 21, "ID do Interior", false, UI.window2)
	guiSetFont(UI.label2_1, "default-bold-small")
	guiLabelSetColor(UI.label2_1, 255, 246, 0)
	guiLabelSetHorizontalAlign(UI.label2_1, "center", true)
	guiLabelSetVerticalAlign(UI.label2_1, "center")
	UI.button2_1 = guiCreateButton(29, 91, 116, 27, "Pegar Interior", false, UI.window2)
	
	UI.edit2_2 = guiCreateEdit(168, 56, 136, 30, "", false, UI.window2)
	guiSetFont(UI.edit2_2, "clear-normal")
	UI.label2_2 = guiCreateLabel(168, 30, 136, 21, "Preço da casa", false, UI.window2)
	guiSetFont(UI.label2_2, "default-bold-small")
	guiLabelSetColor(UI.label2_2, 255, 246, 0)
	guiLabelSetHorizontalAlign(UI.label2_2, "center", true)
	guiLabelSetVerticalAlign(UI.label2_2, "center")
	
	UI.label2_3 = guiCreateLabel(12, 138, 193, 19, "Escolha a garagem para a casa", false, UI.window2)
	guiSetFont(UI.label2_3, "default-bold-small")
	guiLabelSetColor(UI.label2_3, 83, 253, 223)
	UI.checkbox2_1 = guiCreateCheckBox(10, 163, 139, 16, "Garagem 1", guiCheckBoxGetSelected(UI.enableGarage_cbox), false, UI.window2)
	guiSetFont(UI.checkbox2_1, "default-bold-small")
	UI.checkbox2_2 = guiCreateCheckBox(10, 185, 139, 16, "Garagem 2", false, false, UI.window2)
	guiSetFont(UI.checkbox2_2, "default-bold-small")
	if guiCheckBoxGetSelected(UI.enableGarage_cbox) ~= true then
		guiSetEnabled(UI.checkbox2_1, false)
		guiSetEnabled(UI.checkbox2_2, false)
	end
	
	UI.create = guiCreateButton(101, 220, 121, 40, "Criar Casa", false, UI.window2)
	UI.back = guiCreateButton(9, 225, 76, 31, "Voltar", false, UI.window2)
	UI.close = guiCreateButton(237, 225, 76, 28, "Sair", false, UI.window2)
	guiSetProperty(UI.create, "HoverTextColour", "FF30FF30")
	guiSetProperty(UI.create, "PushedTextColour", "FF609910")
	guiSetProperty(UI.back, "HoverTextColour", "FF0099FF")
	guiSetProperty(UI.back, "PushedTextColour", "FF5050FF")
	guiSetProperty(UI.close, "HoverTextColour", "FFFF3030")
	guiSetProperty(UI.close, "PushedTextColour", "FFFF8015")
	
	addEventHandler("onClientGUIChanged", UI.edit2_2, onEditChanged)
	addEventHandler("onClientGUIClick", UI.create, onClickCreateHouseBtn, false)
	addEventHandler("onClientGUIClick", UI.back, backToFirstPanel, false)
	addEventHandler("onClientGUIClick", UI.close, closePanel, false)
	
	addEventHandler( "onClientGUIClick", UI.button2_1, 
		function()
			triggerServerEvent("VDBGHouse:onClientCall", localPlayer, 5)
		end, false
	)
end

function showHide()
	showCursor( not isCursorShowing() );
	if guiGetVisible(UI.window1) then
		guiSetAlpha(UI.window1, isCursorShowing() and 0.85 or 0.3)
		guiSetAlpha(UI.garageWindow, isCursorShowing() and 0.85 or 0.3)
		return
	end
	guiSetAlpha(UI.window2, isCursorShowing() and 0.85 or 0.3)
end

function onClickCreateHouseBtn()
	local hCost = tonumber(tostring(guiGetText( UI.edit2_2 ):gsub( "%p", "" )))
	if (hCost > 99999999) or (hCost <= 0) then return outputChatBox("#d9534f[VDBG.ORG] #FFFFFF O valor da casa não está na faixa!", 255, 255, 255, true) end;
	local gType = guiCheckBoxGetSelected(UI.checkbox2_1) == true and 1 or 2
	if not guiCheckBoxGetSelected(UI.enableGarage_cbox) then
		gType = nil
	end
	triggerServerEvent( "VDBG:CreateHouse", localPlayer,
				true, tonumber(guiGetText( UI.edit1_1 )), tonumber(guiGetText( UI.edit1_2 )), tonumber(guiGetText( UI.edit1_3 )),
				tonumber(guiGetText( UI.edit1_7 )), tonumber(guiGetText( UI.edit1_8 )), tonumber(guiGetText( UI.edit1_9 )), tRot,
				tonumber(guiGetText( UI.edit1_4 )), tonumber(guiGetText( UI.edit1_5 )), tonumber(guiGetText( UI.edit1_6 )),
				tonumber(guiGetText( UI.edit1_10 )), tonumber(guiGetText( UI.edit1_11 )), tonumber(guiGetText( UI.edit1_12 )), teRot,
				tonumber(guiGetText( UI.edit2_1 )), hCost, { garageData[1], garageData[2], garageData[3] },
				garageData[4], nil, gType, guiCheckBoxGetSelected(UI.enableGarage_cbox)
	)
	setTimer(closePanel, 50, 1)
end

function onEditChanged()
	local value = guiGetText(source):gsub("%p", "")
	if tonumber(value) then
		guiSetText(source, tostring(convertNumber( tonumber(value) )))
		guiEditSetCaretIndex(source, #guiGetText(source))
	end
end

function backToFirstPanel()
	destroyElement(UI.window2)
	guiSetVisible(UI.window1, true)
	guiSetVisible(UI.garageWindow, true)
end

function closePanel()
	destroyElement(UI.window1)
	destroyElement(UI.window2)
	destroyElement(UI.garageWindow)
	guiSetInputMode("allow_binds")
	unbindKey("mouse2", "down", showHide)
	removeEventHandler("onClientGUIClick", guiRoot, onBtnClick)
	removeEventHandler("onClientRender", root, drawNote)
	showCursor(false)
	if isElement(garageMarker) then destroyElement(garageMarker) end
end

local function getHousePickups()
	local pickups = {}
	for _,v in pairs(getElementsByType("pickup", resourceRoot)) do
		if getElementData(v, "VDBGHouse-Pickup_Entrance") == true then
			pickups[ #pickups + 1 ] = v
		end
	end
	return pickups
end

function drawNote()
	local offY = (46 * 100) /sh + dxGetFontHeight(1.2, "default-bold")
	drawCustomText("Pressione 'RMB' para mostrar/ocultar o mouse", (sw - 342)/2, panelCenteredY - offY, ((sw - 342)/2) + 342, (panelCenteredY - offY) + 19, tocolor(255, 175, 60, 255), 1.2, 1, "default-bold", "center", "center")
end

addEventHandler( "onClientPickupHit", resourceRoot,
	function (player)
		if not (player == localPlayer) or isPedInVehicle(localPlayer) or (getElementModel(source) == 1318) then return end;
		if getElementData(source, "VDBGHouse-Pickup_Entrance") and not getHouseOwnerFromPickupData(source) then
			showCursor(true)
		elseif getElementData(source, "VDBGHouse-Pickup_Entrance") ~= true then
			if not isInteriorExitDXShowing then
				isInteriorExitDXShowing = true
				isInsideHouse = true
				showCursor(true)
				addEventHandler( "onClientRender", root, drawInteriorExitButtons )
			end
		end
		currentPickup = source
	end
)

addEventHandler( "onClientPickupLeave", resourceRoot,
	function (player)
		if (player ~= localPlayer) or isPedInVehicle(localPlayer) or (getElementModel(source) == 1318) then return end;
		if getElementData(source, "VDBGHouse-Pickup_Entrance") then
			showCursor(false)
			if isElement(house_DXHidden) then
				house_DXHidden = false
			end
			if tempvar_guest_houseID then
				tempvar_guest_houseID = nil
				waitingForServerResponse = nil
			end
		else
			isInteriorExitDXShowing = false
			showCursor(false)
			removeEventHandler( "onClientRender", root, drawInteriorExitButtons )
			isInsideHouse = nil
		end
		currentPickup = false
	end
)

local function remHex(str)
	return str and str:gsub("#%x%x%x%x%x%x","") or false
end

local function isCursorOverButton( id )
	if tonumber(id) then
		local btns = { "buy", "enter", "close", "exit", "warpTo", "closeDX" }
		if id <= 3 then
			return isMouseWithinRangeOf( houseDX[ btns[id].."_left" ], 92, houseDX.buttonsY, 36 )
		elseif id > 3 and id <= 6 then
			local exitHouseBtnsW = { [4] = houseDX.exit_width, [5] = houseDX.warpTo_width, [6] = 86 }
			return isMouseWithinRangeOf( houseDX[ btns[id].."_left" ], exitHouseBtnsW[id], houseDX.interiorExButtonsY, 36 )
		end
	end
	return false
end

function drawPickupEntranceInterface()
	if #getHousePickups() < 1 then return end;
	for i, pickup in pairs( getHousePickups() ) do
		local cx,cy,cz = getCameraMatrix()
		local px,py,pz = getElementPosition(pickup)
		if getDistanceBetweenPoints3D(cx,cy,cz, px,py,pz) <= 10 and house_DXHidden == false then
		  if isElementOnScreen(pickup) and isLineOfSightClear(cx,cy,cz, px,py,pz, true, true, false, true, false) then
			local dist = getDistanceBetweenPoints3D(cx,cy,cz, px,py,pz)
			local scx, scy = getScreenFromWorldPosition(px, py, pz + 1)
			if not tonumber(scx) then
				if currentPickup then showCursor(false) end;
				return
			end
			scx = scx + math.ceil((1.7 * sw) /100)
			local x, y = math.ceil(scx - (DXWidth /2)), math.ceil(scy - math.ceil((3.1 * sh) /100))
			if getHouseOwnerFromPickupData( pickup ) then
			
			  x = math.ceil((scx - ((DXWidth - 25)) /2))			  
			  y = y + math.ceil((1.9 * sh) /100)
			  
			  local ownerStr = "["..getElementID(pickup).."] "..getZoneName(px,py,pz).." ("..getElementCity(pickup)..")"
			  local ownerW = dxGetTextWidth(ownerStr, 1, boughtHouseFont)
			
			  if ownerW > (boughtHouseRecW - 7) then
				boughtHouseRecW = ownerW + 9
			  end
			  if x + (boughtHouseRecW - offSetX) > sw then if isCursorShowing() then showCursor(false) end return end;
			  
			  drawHouseLinedRectangle(x, y, boughtHouseRecW, 70,	tocolor(0, 0, 0, 170), tocolor(0, 0, 0, 210), false)
			  drawShadowText( ownerStr, x+7, y, (x+7)+257, y+26,
						tocolor(180, 255, 143, 240), 1, boughtHouseFont, "left", "center", false, false, false, false, true )
			  drawShadowText( "Dono: #A9FFA9"..tostring((getElementData(pickup, "VDBGHouse-HouseOwner") or "")),
						x+7, y+26, (x+7)+257, (y+26)+22,
						tocolor(230, 230, 230, 240), 1, boughtHouseFont2, "left", "center", false, false, false, true, true )
			  drawShadowText( "Aberta: ".. (getElementData(pickup, "VDBGHouse-HouseLockedState") == 0 and "#A9FFA9Sim" or "#FF5E5ENão"),
						x+7, y+46, (x+7)+257, (y+46)+22,
						tocolor(230, 230, 230, 240), 1, boughtHouseFont2, "left", "center", false, false, false, true, true )
			else
				if x + (DXWidth - offSetX) > sw then if isCursorShowing() then showCursor(false) end return end;
				
				y = math.ceil(scy - math.ceil((5 * sh) /100))
				local costStr = "Preço: #BDFFA8R$"..convertNumber((getElementData(pickup, "VDBGHouse-Cost") or 0))
				local iStr = "Digite #BDFFA8/comprar #E6E6E6para comprar a casa"
				local costW = dxGetTextWidth(remHex(costStr), 1, font2)
				local iW = dxGetTextWidth(remHex(iStr), 1, font2)
				drawHouseLinedRectangle(x, y, DXWidth, 85, tocolor(0, 0, 0, 170),tocolor(0, 0, 0, 210), false)
				
				drawShadowText( "#BDFFA8["..getElementID(pickup).."] #E6E6E6- Esta casa está a venda!", x, y, x+DXWidth, y+30,
							tocolor(230, 230, 230, 240), 1, font, "center", "center", false, false, false, true, true )
				drawShadowText( costStr, x, y+27, x+DXWidth, (y+27) + 30,
							tocolor(230, 230, 230, 240), 1, font2, "center", "center", false, false, false, true )
				drawShadowText( iStr, x, y+51, x + DXWidth, (y+51) + 30,
							tocolor(230, 230, 230, 240), 1, font2, "center", "center", false, false, false, true )
			end
			if ( currentPickup ~= pickup ) then
				return
			else if isGuestDXVisible ~= true and getHouseOwnerFromPickupData( pickup ) then isGuestDXVisible = true end
			end
			if not isCursorShowing() and (getElementData(pickup, "VDBGHouse-HouseLockedState") or -1) == 0 then showCursor(true) end;
			-- Botões em DX da pickup
			if not getHouseOwnerFromPickupData( pickup ) then -- Casa a venda
				if isGuestDXVisible then isGuestDXVisible = nil end;
				houseDX.buy_left = x + buyX
				houseDX.enter_left = x + enterX
				houseDX.close_left = x + closeX
				houseDX.buttonsY = y + buttonsY
		
				pickupEntrance_cursorHover(true)
			
				dxDrawRectangle(x, houseDX.buttonsY - 12, DXWidth, 60, tocolor(0, 0, 0, 200), false)
				dxDrawRectangle(houseDX.buy_left, houseDX.buttonsY, 92, 36, tocolor(129, 252, 123, colors.buyAlpha[1]), false)
				dxDrawText("Comprar", houseDX.buy_left, houseDX.buttonsY, houseDX.buy_left+92, houseDX.buttonsY + 36, tocolor(230, 230, 230, 255), 1.4, "arial", "center", "center")
				dxDrawRectangle(houseDX.enter_left, houseDX.buttonsY, 92, 36, tocolor(120, 224, 254, colors.enterAlpha[1]), false)
				dxDrawText("Entrar", houseDX.enter_left, houseDX.buttonsY, houseDX.enter_left+92, houseDX.buttonsY + 36, tocolor(230, 230, 230, 255), 1.4, "arial", "center", "center")
				dxDrawRectangle(houseDX.close_left, houseDX.buttonsY, 92, 36, tocolor(255, 87, 87, colors.closeAlpha[1]), false)
				dxDrawText("Sair", houseDX.close_left, houseDX.buttonsY, houseDX.close_left+92, houseDX.buttonsY + 36, tocolor(230, 230, 230, 255), 1.4, "arial", "center", "center")
				if not isDXButtonVisible then isDXButtonVisible = true end
			elseif getHouseOwnerFromPickupData( pickup ) then --Com dono, mostrar botões em DX
				--Verificar se têm a chave da casa
				if localPlayer then
					showCursor(true)
					drawHouseEntranceButtons(x, y)
				return end
				--Se for hóspede e a casa tiver trancada
				if (getElementData(pickup, "VDBGHouse-HouseLockedState") or -1) == 1 then
					if not waitingForServerResponse and not tempvar_guest_houseID then
						triggerServerEvent("VDBGHouse:onClientCall", localPlayer, 6, tonumber(getElementID(pickup)))
						waitingForServerResponse = true
						return
					elseif waitingForServerResponse and tempvar_guest_houseID then
						waitingForServerResponse = nil
						if tonumber(tempvar_guest_houseID) ~= -1 then
							showCursor(true)
						else return end
					elseif not waitingForServerResponse and tonumber(tempvar_guest_houseID) == -1 then return end
				end
				drawHouseEntranceButtons(x, y)
			end
		  end
		end
	end
end
addEventHandler( "onClientRender", root, drawPickupEntranceInterface )

function drawHouseEntranceButtons( x,y )
	x = x + ( (boughtHouseRecW - (DXWidth - 110)) / 2 )
	local _offSetX = offSetX - 2
	houseDX.enter_left = x + _offSetX
	houseDX.close_left = (x + _offSetX) + (_offSetX + 92)
	houseDX.buttonsY = y + math.ceil((12 * sh) / 100)
	
	pickupEntrance_cursorHover()
	dxDrawRectangle(x, houseDX.buttonsY - 10, DXWidth - 110, 56, tocolor(0, 0, 0, 200), false)
	dxDrawRectangle(houseDX.enter_left, houseDX.buttonsY, 92, 36, tocolor(120, 224, 254, colors.enterAlpha[1]), false)
	dxDrawText("Entrar", houseDX.enter_left, houseDX.buttonsY, houseDX.enter_left+92, houseDX.buttonsY + 36, tocolor(230, 230, 230, 255), 1.4, "arial", "center", "center")
	dxDrawRectangle(houseDX.close_left, houseDX.buttonsY, 92, 36, tocolor(255, 87, 87, colors.closeAlpha[1]), false)
	dxDrawText("Sair", houseDX.close_left, houseDX.buttonsY, houseDX.close_left+92, houseDX.buttonsY + 36, tocolor(230, 230, 230, 255), 1.4, "arial", "center", "center")
	if not isDXButtonVisible then isDXButtonVisible = true end
end

function drawInteriorExitButtons()
	local px,py,pz = getElementPosition(currentPickup)
	if not isInsideHouse then pz = pz - 0.9 end
	local scx, scy = getScreenFromWorldPosition(px, py, pz + 1)
	if isCursorShowing() and not tonumber(scx) then
		showCursor(false)
		isInteriorExitDXShowing = false
		removeEventHandler( "onClientRender", root, drawInteriorExitButtons )
		return
	end
	if not (scx) then return end;
	
	local x = math.ceil(scx - (375 /2))
	local y = math.ceil(scy - math.ceil((3 * sh) /100))
	if x + (375 - offSetX) > sw then
		showCursor(false)
		if isInteriorExitDXShowing then isInteriorExitDXShowing = false; removeEventHandler( "onClientRender", root, drawInteriorExitButtons ) end
		return
	end
	
	if not isInsideHouse and houseDX.exit_width ~= 138 then
		houseDX.exit_width = 138
		houseDX.warpTo_width = 107
		garX = exitX + ( offSetX + houseDX.exit_width )
		cloX = garX + ( offSetX + houseDX.warpTo_width )
	end
	drawHouseLinedRectangle(x, y, 375, 100, tocolor(0, 0, 0, 170),tocolor(0, 0, 0, 210), false)
	dxDrawRectangle(x, y+25, 375, 2, tocolor(230, 230, 230, 190), false)
	dxDrawText("Sair da "..(isInsideHouse and "casa" or "garagem")..": Opções", x+5, y, (x+5) + 370, y+25, tocolor(145, 254, 176, 224), 1.20, "arial", "left", "center")
	
	houseDX.exit_left = x + exitX
	houseDX.warpTo_left = x + garX
	houseDX.closeDX_left = x + cloX
	houseDX.interiorExButtonsY = y + math.ceil((6.6 * sh) /100)
	interiorExitCursorHover()
	
	dxDrawRectangle(houseDX.exit_left, houseDX.interiorExButtonsY, houseDX.exit_width, 36, tocolor(129, 252, 123, colors.buyAlpha[1]), false)
	dxDrawText("Sair da "..(isInsideHouse and "casa" or "garagem"), houseDX.exit_left, houseDX.interiorExButtonsY, houseDX.exit_left+houseDX.exit_width, houseDX.interiorExButtonsY + 36, tocolor(230, 230, 230, 255), 1.4, "arial", "center", "center")
	dxDrawRectangle(houseDX.warpTo_left, houseDX.interiorExButtonsY, houseDX.warpTo_width, 36, tocolor(120, 224, 254, colors.enterAlpha[1]), false)
	dxDrawText("Ir para "..(isInsideHouse and "garagem" or "casa"), houseDX.warpTo_left, houseDX.interiorExButtonsY, houseDX.warpTo_left+houseDX.warpTo_width, houseDX.interiorExButtonsY + 36, tocolor(230, 230, 230, 255), 1.4, "arial", "center", "center")
	dxDrawRectangle(houseDX.closeDX_left, houseDX.interiorExButtonsY, 86, 36, tocolor(255, 87, 87, colors.closeAlpha[1]), false)
	dxDrawText("Sair", houseDX.closeDX_left, houseDX.interiorExButtonsY, houseDX.closeDX_left+86, houseDX.interiorExButtonsY + 36, tocolor(230, 230, 230, 255), 1.4, "arial", "center", "center")
end

function pickupEntrance_cursorHover( forSale )
	local btnsCol = { "buyAlpha", "enterAlpha", "closeAlpha" }
	local start = forSale and 1 or 2
	for ID=start, 3 do
		if isCursorOverButton( ID ) then
			colors[ btnsCol[ID] ][1] = colors[ btnsCol[ID] ].hover
		else
			if colors[ btnsCol[ID] ][1] ~= 150 then
				colors[ btnsCol[ID] ][1] = 150
			end
		end
	end
end

function interiorExitCursorHover()
	local btnsCol = { "buyAlpha", "enterAlpha", "closeAlpha" }
	for ID=1, 3 do
		if isCursorOverButton( ID + 3 ) then
			colors[ btnsCol[ID] ][1] = colors[ btnsCol[ID] ].hover
		else
			if colors[ btnsCol[ID] ][1] ~= 150 then
				colors[ btnsCol[ID] ][1] = 150
			end
		end
	end
end

function onHouseBtnClick(button, state)
	if (button == "left") and (state == "up") and not isConsoleActive() and not isMainMenuActive() then
		if isInteriorExitDXShowing then
			local clicked
			for ID=4, 6 do
				if isCursorOverButton(ID) then
				  local houseID = tonumber(getElementID(currentPickup)) or garage_houseID
				  if ID == 4 then
					if isInsideHouse then -- Sair da casa
						if tempvar_guest_houseID then tempvar_guest_houseID = nil end;
					end
					toggleAllControls(false, true, false)
					fadeCamera(false, 1.0)
					setTimer( triggerServerEvent, 1000, 1, "VDBGHouse:onClientCall", localPlayer, 3, houseID, garage_houseID and true or nil )
					if garage_houseID then garage_houseID = nil end;
					clicked = true
				  elseif ID == 5 then
					if not isInsideHouse and not isPedInVehicle(localPlayer) then -- Entrar na casa
						toggleAllControls(false, true, false)
						fadeCamera(false, 1.0)
						setTimer( triggerServerEvent, 1000, 1, "VDBGHouse:onClientCall", localPlayer, 4, houseID, garage_houseID and true or nil )
						if garage_houseID then garage_houseID = nil end;
					elseif not isInsideHouse and isPedInVehicle(localPlayer) then -- Com veículo. Não pode ir à casa
						outputChatBox("#d9534f[VDBG.ORG] #FFFFFFVocê não pode entrar na casa com um veículo!", 255, 255, 255, true)
					else
						if not tonumber(tempvar_guest_houseID) then
							triggerServerEvent( "VDBGHouse:onClientCall", localPlayer, 2, houseID )
						elseif tonumber(tempvar_guest_houseID) then
							outputChatBox("#d9534f[VDBG.ORG] #FFFFFFSomente o dono pode ir para a garagem!", 255, 255, 255, true)
						end
					end
					clicked = true
				  elseif ID == 6 then
					clicked = true
				  end
				end
			end
			if clicked then
				removeEventHandler( "onClientRender", root, drawInteriorExitButtons )
				showCursor(false)
				isInteriorExitDXShowing = false
				if isInsideHouse then
					isInsideHouse = nil
				else
					houseDX.exit_width = 107
					houseDX.warpTo_width = 138
					garX = exitX + ( offSetX + houseDX.exit_width )
					cloX = garX + ( offSetX + houseDX.warpTo_width )
				end
			end
			return
		end
		if not currentPickup or not isDXButtonVisible then return end
		local start = isGuestDXVisible and 2 or 1
		for ID=start, 3 do
			if isCursorOverButton(ID) then
				if ID == 1 then
					triggerServerEvent("VDBGHouse:onClientCall", localPlayer, 1, tonumber(getElementID(currentPickup)))
				elseif ID == 2 then
					toggleAllControls(false, true, false)
					fadeCamera(false, 1.0)
					setTimer(triggerServerEvent, 1000, 1, "VDBGHouse:onClientCall", localPlayer, 4, tonumber(getElementID(currentPickup)))
				elseif ID == 3 then
					house_DXHidden = currentPickup
					showCursor(false)
				end
				currentPickup = false
				showCursor(false)
				if start == 2 then  isGuestDXVisible = nil end
				if isDXButtonVisible then isDXButtonVisible = nil end
			end
		end
	end
end
addEventHandler( "onClientClick", root, onHouseBtnClick )

addEvent("VDBGHouse:onServerCall", true)
addEventHandler( "VDBGHouse:onServerCall", root,
	function ( action_id, arg1, dim )
		if action_id == 1 then
			if not isElement(UI.window1) then
				onRequestCreateHousePanel()
			end
		elseif action_id == 2 then
			guiSetText(UI.edit2_1, tostring(arg1))
		elseif action_id == 3 then
			tempvar_guest_houseID = arg1
		end
	end
)

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		addEventHandler("onClientMarkerHit", resourceRoot, garageExitFunc)
	end
)

function garageExitFunc(hitElement, dim)
	if dim then
		local idstr = getElementID(source)
		if not ( idstr ) or not ( idstr:find("VDBGHouse:Marker_Exit_Garage") ) then
			return
		end
		if not isInteriorExitDXShowing then
			isInteriorExitDXShowing = true
			currentPickup = source
			garage_houseID = tonumber( idstr:sub(30) )
			showCursor(true)
			addEventHandler( "onClientRender", root, drawInteriorExitButtons )
		end
	end
end

addEvent("VDBGHouse:showGarageInfoToPlayer", true)
addEventHandler("VDBGHouse:showGarageInfoToPlayer", root,
	function ( houseID )
		garageEntrance_UI( houseID )
		bindKey("e", "down", teleportToGarage)
		garage_houseID = houseID
		
		addEventHandler("onClientMarkerLeave", source,
		function ( hitElement )
			if (hitElement == localPlayer) then
				removeGarageFunctions()
			end
		end)
	end
)

function teleportToGarage()
	triggerServerEvent("VDBGHouse:onClientCall", localPlayer, 2, garage_houseID)
	removeGarageFunctions()
end

function removeGarageFunctions()
	guiSetVisible(garageInfoUI, false)
	removeEventHandler("onClientRender", root, drawGarageNote)
	unbindKey("e", "down", teleportToGarage)
	isGarageNoteDrawn = nil
end

function garageEntrance_UI( garageID )
	if isElement(garageInfoUI) then
		guiSetText(lbl_garageUI, "Garagem [ID: "..tostring(garageID).."]")
		guiSetVisible(garageInfoUI, true)
		if isGarageNoteDrawn then
			removeEventHandler("onClientRender", root, drawGarageNote)
		end
		addEventHandler("onClientRender", root, drawGarageNote)
		isGarageNoteDrawn = true
		return
	end
	UI.garageIX = (sw - 253)/2
	UI.garageIY = math.ceil( (80 * sh) /100 )
	garageInfoUI = guiCreateStaticImage(UI.garageIX, UI.garageIY, 253, 56, "image/status.png", false)
	guiSetAlpha(garageInfoUI, .95)

	lbl_garageUI = guiCreateLabel(55, 1, 193, 23, "Garagem [ID: "..tostring(garageID).."]", false, garageInfoUI)
	guiSetFont(lbl_garageUI, guiCreateFont("font/opensans_semibold.ttf", 11))
	guiLabelSetColor(lbl_garageUI, 192, 254, 191)
	guiLabelSetVerticalAlign(lbl_garageUI, "center")
	addEventHandler("onClientRender", root, drawGarageNote)
	isGarageNoteDrawn = true
end

drawGarageNote = function()
	dxDrawText("Para entrar pressione #26AEFFe", UI.garageIX+55, UI.garageIY+30, (UI.garageIX+55)+193, (UI.garageIY+30)+20, tocolor(230, 230, 230, 240), 1.2, "default", "left", "center", false, false, true, true)
end

function isMouseWithinRangeOf(psx,pssx,psy,pssy)
	if not isCursorShowing() then return false end;
	local cx,cy = getCursorPosition()
	cx,cy = cx*sw,cy*sh
	if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
		return true
	end
	return false
end

function drawHouseLinedRectangle( startX,startY,width,height,color,foregroundColor,postGUI )
	-- Main rectangle
	dxDrawRectangle(startX+2, startY+2, width-2, height-2, color, postGUI)
	-- Border rectangles
	dxDrawRectangle(startX, startY, 2, height, foregroundColor, postGUI) -- vertical
	dxDrawRectangle(startX + (width - 2), startY, 2, height, foregroundColor, postGUI) -- vertical
	dxDrawRectangle(startX+2, startY, width-2, 2, foregroundColor, postGUI)
	dxDrawRectangle(startX+2, startY + (height - 2), width-2, 2, foregroundColor, postGUI)
end

function drawShadowText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning)
	dxDrawText(text:gsub("#%x%x%x%x%x%x",""), left + 1, top + 1, right + 1, bottom + 1, tocolor(0, 0, 0, bitExtract(color,24,8)), scale, font, alignX, alignY, clip, wordBreak, postGUI, subPixelPositioning)
	dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
end

function drawCustomText(text, left, top, right, bottom, color, scale, outlinesize, font, alignX, alignY, clip, wordBreak, postGUI)
	outlinesize = math.min(scale, outlinesize)
	if outlinesize > 0 then
		for offsetX=-outlinesize,outlinesize,outlinesize do
			for offsetY=-outlinesize,outlinesize,outlinesize do
				if not (offsetX == 0 and offsetY == 0) then
					dxDrawText(text, left+offsetX, top+offsetY, right+offsetX, bottom+offsetY, tocolor(0, 0, 0, bitExtract(color,24,8)), scale, font or "default", alignX or "left", alignY or "top", clip or false, wordBreak or false, postGUI or false)
				end
			end
		end
	end
	dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
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

function getHouseOwnerFromPickupData( pickup )
	if isElement(pickup) then
		if type(getElementData(pickup, "VDBGHouse-HouseOwner")) == "string" and getElementData(pickup, "VDBGHouse-HouseOwner") ~= "" then
			return getElementData(pickup, "VDBGHouse-HouseOwner")
		end
		return false
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
