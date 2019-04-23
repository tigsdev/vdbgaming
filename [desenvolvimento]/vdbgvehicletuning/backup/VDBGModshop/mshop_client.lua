local sx, sy = guiGetScreenSize()
local items = {}
local selectedItem = 1
local upgrades = {}
local GUI = {}
GUI["selection"] = {}
GUI["upgrades"] = {}
local bankGothicFont = guiCreateFont( "bankgothic.ttf", 20 )
local selected = "selection"
local size2 = 0
local tempUpgrades = {}
local facing = 0
local lowriders = { [536]=true, [575]=true, [534]=true, [567]=true, [535]=true, [576]=true, [412]=true }
local racers = { [562]=true, [565]=true, [559]=true, [561]=true, [560]=true, [558]=true }
local paintjobSet = false
local selectedColor = 1
local marker = nil
local vipDiscount = {[1]=30, [2]=50, [3]=75}
local startTick = getTickCount()
local modShopPickups = {}

addEventHandler("onClientResourceStart",resourceRoot,
function ()
	local garages={8, 10, 11, 12, 19, 27, 32, 36, 40, 41, 47}
	for index, garage in ipairs(garages) do
		setGarageOpen(garage, true)
	end
	if engineSetAsynchronousLoading then
		engineSetAsynchronousLoading( true )
	end
	setTimer(function ()
	local txd = engineLoadTXD("models/modShop.txd")
	engineImportTXD(txd, 2223)
	local dff = engineLoadDFF("models/modShop.dff", 0)
	engineReplaceModel(dff, 2223)
	-- Double draw distance for pickups
	engineSetModelLODDistance( 2223, 60 )
	end, 500, 1)
	triggerServerEvent("modShop:getModShops",localPlayer)
end)

addEvent("modShop:createPickups",true)
addEventHandler("modShop:createPickups",root,
function (modShops)
	for index, loc in pairs(modShops) do
		modShopPickups[loc.name] = createObject(2223, loc.x, loc.y, loc.z+1)
		setElementParent(modShopPickups[loc.name], getElementByID("carPickups"))
	end
end)

function renderModShop()
	dxDrawRectangle((33/1024)*sx,(50/768)*sy,(268/1024)*sx,(80/768)*sy,tocolor(0,0,0,100),false)
    dxDrawBorderedText("Use as setas SUBIR e DESCER.\nPrescione ESPAÇO para selecionar.\nPrescione ENTER para sair.",(45/1024)*sx,(60/768)*sy,(258/1024)*sx,(241/768)*sy,tocolor(255,255,255,255),(sx/1024)*1.1,"default-bold","left","top",false,false,true)
	if (selected == "selection") then
		dxDrawBorderedText("VDBG Mod",(37/1024)*sx,(140/768)*sy,(250/1024)*sy,(299/768)*sy,tocolor(255,255,255,255),(sx/1024)*1.0,"pricedown","left","top",false,false,true)
		size = tonumber(#GUI[selected]) * 30
	elseif (selected == "upgrades") then
		size = tonumber(size2) * 30
		dxDrawBorderedText("Nome",(39/1024)*sx,(150/768)*sy,(250/1024)*sy,(299/768)*sy,tocolor(255,255,255,255),(sx/1024)*1.0,"pricedown","left","top",false,false,true)
		dxDrawBorderedText("Preço",(200/1024)*sx,(150/768)*sy,(250/1024)*sy,(299/768)*sy,tocolor(255,255,255,255),(sx/1024)*1.0,"pricedown","left","top",false,false,true)
	end
	local x, y = relativeToAbsolute(guiGetSize(GUI[selected][1], true))
	local x = x - 50
	dxDrawRectangle((33/1024)*sx,(180/768)*sy,(x/2000)*sx,(size/768)*sy,tocolor(0,0,0,100),false)
	local cost = getShoppingCosts()
	local vip = exports["[VDBG]Tools"]:isPlayerVIP(localPlayer)
	if vip and vip > 0 then
		cost = exports["[VDBG]Tools"]:modifyPercent(cost, -vipDiscount[vip])
	end
	dxDrawText("Seu carrinho: \n".. tostring(exports["[VDBG]Tools"]:convertMoneyToString(cost)),(315/1024)*sx,(72/768)*sy,(470/1024)*sx,(120/768)*sy,tocolor(255,255,255,255),(sx/1024)*0.5,"bankgothic","left","top",false,true,true)
    dxDrawRectangle((306/1024)*sx,(50/768)*sy,(249/1024)*sx,(79/768)*sy,tocolor(0,0,0,100),false)
    dxDrawText("Carrinho",(355/1024)*sx,(50/768)*sy,(521/1024)*sx,(68/768)*sy,tocolor(255,255,255,255),(sx/1024)*0.7,"bankgothic","left","top",false,false,true)
	local r, g, b = 0, 255, 0
	if getPlayerMoney(localPlayer) < tonumber(getShoppingCosts()) then
		r, g, b = 255, 0, 0
	else
		r, g, b = 0, 255, 0
	end
	dxDrawImage((460/1020)*sx,(55/768)*sy,(90/1024)*sx,(90/1058)*sy,"cart.png",0,0,0,tocolor(5,106,199,255),true)
end

function createModShopGUI(name, itemTable)
	for theName, _ in pairs(GUI) do
		for index, element in pairs(GUI[theName]) do
			if isElement(element) then destroyElement(element) end
		end
	end
	GUI = {}
	GUI["selection"] = {}
	GUI["upgrades"] = {}
	if name and itemTable then
	local y = 0.2350
		for index, item in pairs(itemTable) do
			if (index == 1 or index == 0) then
				y = 0.2350
			else
				y = y + 0.035
			end
			if (name == "selection") then
				GUI[name][item.index] = guiCreateLabel(0.0381,tonumber(y),0.4168,0.339,tostring(item.name),true)
				guiSetFont(GUI[name][item.index], bankGothicFont)
				setElementData(GUI[name][item.index], "upgrades", item.upgs)
				guiLabelSetColor(GUI[name][1], 255, 255, 0)
			else
				GUI[name][index] = guiCreateLabel(0.0381,tonumber(y),0.4168,0.339,tostring(item.name) .." - "..tostring(exports["[VDBG]Tools"]:convertMoneyToString(item.price)),true)
				setElementData(GUI[name][index], "upgradeID", tonumber(item.ID))
				if tostring(item.name) == "Colour 1" then
					setElementData(GUI[name][index], "upgradeID", "Color,1")
				elseif tostring(item.name) == "Colour 2" then
					setElementData(GUI[name][index], "upgradeID", "Color,2")
				elseif tostring(item.name) == "Paintjob 1" then
					setElementData(GUI[name][index], "upgradeID", "Paintjob,0")
				elseif tostring(item.name) == "Paintjob 2" then
					setElementData(GUI[name][index], "upgradeID", "Paintjob,1")
				elseif tostring(item.name) == "Paintjob 3" then
					setElementData(GUI[name][index], "upgradeID", "Paintjob,2")
				end
				setElementData(GUI[name][index], "upgradeCost", tonumber(item.price))
				guiSetFont(GUI[name][index], bankGothicFont)
				guiLabelSetColor(GUI[name][1], 255, 255, 0)
			end
		end
	selected = tostring(name)
	end
end

addEvent("modShop:show",true)
addEventHandler("modShop:show",root,
function (vehicleUpgrades, mkr)
	for index, pickup in pairs(modShopPickups) do
		setElementDimension(pickup, 600)
	end
	marker = mkr
	local vehicle = getPedOccupiedVehicle(localPlayer)
    addEventHandler("onClientRender",root,renderModShop)
	bindKey("arrow_u","down",moveMainItemU)
	bindKey("arrow_d","down",moveMainItemD)
	bindKey("space","down",showSecondMenu)
	bindKey("enter","down",showSecondMenu)
	showCursor(true)
	showChat(false)
	showPlayerHudComponent("radar", false)
	upgrades = {}
	for ID, upg in pairs(vehicleUpgrades) do
		upgrades[tonumber(ID)] = {upg.name, tonumber(upg.price)}
	end
	items = {}
	for index, upg in pairs(getUpgrades()) do
		table.insert(items, {index=index, name=upg.name, upgs=upg.children})
	end
	local children = {{name="Colour 1", price="FREE"}, {name="Colour 2", price="FREE"}}
	table.insert(items, {index=#items+1, name="Colours", upgs=children})
	if isVehicleRacer( vehicle ) or isVehicleLowrider( vehicle ) then
		local children2 = {{name="Paintjob 1", price=1000}, {name="Paintjob 2", price=1000}, {name="Paintjob 3", price=1000}}
		table.insert(items, {index=#items+1, name="Paintjobs", upgs=children2})
	end
	selectedItem = 1
	createModShopGUI("selection", items)
	tempUpgrades = {}
	tempUpgrades.paintJob = getVehiclePaintjob( vehicle )
	tempUpgrades.color = { getVehicleColor( vehicle, true ) }
	tempUpgrades.upgrades = {}
	for index, vehUpgrade in ipairs(getVehicleUpgrades( vehicle )) do
		table.insert(tempUpgrades.upgrades, vehUpgrade)
	end
	setElementFrozen(vehicle, true)
	addEventHandler( "onClientRender", root, rotateCameraAroundPlayer )
end)

function rotateCameraAroundPlayer( )
    local x, y, z = getElementPosition( localPlayer )
    if isPedInVehicle( localPlayer ) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
        x, y, z = getElementPosition( vehicle )
    else
        fixedCamera( false )
        removeEventHandler( "onClientRender", root, rotateCameraAroundPlayer )
    end
    local camX = x + math.cos( facing / math.pi * 180 ) * 5
    local camY = y + math.sin( facing / math.pi * 180 ) * 5
    setCameraMatrix( camX, camY, z+1, x, y, z )
    facing = facing + 0.0002
end

function resetLabelColors()
	for theName, _ in pairs(GUI) do
		for index, element in pairs(GUI[theName]) do
			if isElement(element) then
				guiLabelSetColor(element, 255, 255, 255)
			end
		end
	end
end

function moveMainItemU()
	resetLabelColors()
	selectedItem = selectedItem - 1
	playSoundFrontEnd(1)
	if (selectedItem < 1) then
		selectedItem = #GUI[selected]
	end
	guiLabelSetColor(GUI[selected][selectedItem], 255, 255, 0)
end

function moveMainItemD()
	resetLabelColors()
	selectedItem = selectedItem + 1
	playSoundFrontEnd(1)
	if (selectedItem >= #GUI[selected]+1) then
		selectedItem = 1
	end
	guiLabelSetColor(GUI[selected][selectedItem], 255, 255, 0)
end

function showSecondMenu(key)
	if (key == "space") then
		if (selected == "selection") then
			local tempTable = {}
			for i,v in pairs(getElementData(GUI["selection"][selectedItem], "upgrades")) do
				table.insert(tempTable, v)
			end
			createModShopGUI("upgrades", getElementData(GUI[selected][selectedItem], "upgrades"))
			size2 = #tempTable
			selectedItem = 1
			guiLabelSetColor(GUI[selected][selectedItem], 255, 255, 0)
		elseif (selected == "upgrades") then
			local vehicle = getPedOccupiedVehicle(localPlayer)
			local upgrade = getElementData(GUI[selected][selectedItem], "upgradeID")
			local price = getElementData(GUI[selected][selectedItem], "upgradeCost")
			if upgrade and price then
				if tonumber(upgrade) then
					addVehicleUpgrade(vehicle, upgrade)
				end
			local slotName = getVehicleUpgradeSlotName(upgrade)
			for index, upg in pairs(tempUpgrades.upgrades) do
				if (getVehicleUpgradeSlotName(upgrade) == tostring(slotName) and upg == upgrade) then
					return
				end
			end
				if tonumber(price) then
					if not replaceItemInCart( upgrade, price ) then
						addItemToCart( upgrade, price )
					elseif isItemInCart( upgrade ) then
						removeItemFromCart( upgrade )
						removeVehicleUpgrade( vehicle, upgrade )
					end
                end
			end
            if string.find(tostring(upgrade), "Paintjob") then
				if not paintjobSet then
					paintjobSet = true
                    setVehiclePaintjob( vehicle, tonumber(split(tostring(upgrade),",")[2]) )
                    addItemToCart( "Paintjob", tonumber(split(tostring(upgrade),",")[2]) )
				else
					setVehiclePaintjob( vehicle, 3 )
					removeItemFromCart( "Paintjob" )
					paintjobSet = false
                end
			elseif string.find(tostring(upgrade), "Color") then
				selectedColor = tonumber(split(tostring(upgrade),",")[2])
				colorPicker.openSelect(tonumber(split(tostring(upgrade),",")[2]))
            end
		end
	elseif (key == "enter") then
		if (selected == "upgrades") then
			if colorPicker.isSelectOpen then colorPicker.closeSelect() end
			createModShopGUI("selection", items)
			selectedItem = 1
			guiLabelSetColor(GUI[selected][selectedItem], 255, 255, 0)
		elseif (selected == "selection") then
			if getPlayerMoney(localPlayer) < tonumber(getShoppingCosts()) then
				exports["(SAUR)Info"]:sendClientMessage("Mod Shop: You don't have ".. tostring(exports["[VDBG]Tools"]:convertMoneyToString(getShoppingCosts( ))) .." to pay for the upgrade(s), remove some.",255,0,0)
				return
			else
			local vehicle = getPedOccupiedVehicle(localPlayer)
			removeEventHandler("onClientRender",root,renderModShop)
			unbindKey("arrow_u","down",moveMainItemU)
			unbindKey("arrow_d","down",moveMainItemD)
			unbindKey("space","down",showSecondMenu)
			unbindKey("enter","down",showSecondMenu)
			showCursor(false)
			showChat(true)
			showPlayerHudComponent("radar", true)
			selectedItem = 1
			createModShopGUI(nil, nil)
			local vehicle = getPedOccupiedVehicle(localPlayer)
			setElementFrozen(vehicle, false)
			setCameraTarget(localPlayer)
			removeEventHandler( "onClientRender", root, rotateCameraAroundPlayer )
			selected = "selection"
			local upgrades = getVehicleUpgrades( vehicle )
			if not table.same( upgrades, tempUpgrades.upgrades ) or tempUpgrades.paintjob ~= getVehiclePaintjob( vehicle ) then
				local newColors = { getVehicleColor(vehicle, true) }
				local vip = exports["(SAUR)VIP"]:isPlayerVIP(localPlayer)
				local cost = getShoppingCosts()
				if vip then
					cost = exports["(SAUR)Tools"]:modifyPercent(cost, -tonumber(vipDiscount[vip]))
				end
				triggerServerEvent("modShop:exit", localPlayer, true, leaveNewUpgrades( upgrades, tempUpgrades.upgrades ), newColors, getVehiclePaintjob(vehicle), cost, marker)
				resetUpgrades(vehicle)
			else
				triggerServerEvent("modShop:exit", localPlayer, false)
				resetUpgrades(vehicle)
				end
			end
			for index, pickup in pairs(modShopPickups) do
				setElementDimension(pickup, 0)
			end			
			emptyShoppingCart()
		end
	end
end

function getUpgrades()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if not vehicle then
		return
	end
	local compatibleUpgrades = {}
	local slotName, group
	for i,upgrade in ipairs(getVehicleCompatibleUpgrades(vehicle)) do
		slotName = getVehicleUpgradeSlotName(upgrade)
		group = table.find(compatibleUpgrades, 'name', slotName)
		if not group then
			group = { 'group', name = slotName, children = {} }
			table.insert(compatibleUpgrades, group)
		else
			group = compatibleUpgrades[group]
		end
		if upgrades[tonumber(upgrade)] then
			table.insert(group.children, {name=upgrades[upgrade][1], ID=upgrade, price=upgrades[upgrade][2]})
		end
	end
	--table.sort(compatibleUpgrades, function(a, b) return a.name < b.name end)
	return compatibleUpgrades
end

function resetUpgrades(vehicle)
    for i = 0, 16 do
        local modid = getVehicleUpgradeOnSlot( vehicle, i )
        if modid then
            removeVehicleUpgrade( vehicle, modid )
        end
    end
    for k,v in pairs( tempUpgrades.upgrades ) do
        addVehicleUpgrade( vehicle, v )
    end
    setVehiclePaintjob( vehicle, tempUpgrades.paintJob )
end

function relativeToAbsolute( X, Y )
    local x = X*sx
    local y = Y*sy
    return x, y
end

function table.find(t, ...)
	local args = { ... }
	if #args == 0 then
		for k,v in pairs(t) do
			if v then
				return k
			end
		end
		return false
	end
	
	local value = table.remove(args)
	if value == '[nil]' then
		value = nil
	end
	for k,v in pairs(t) do
		for i,index in ipairs(args) do
			if type(index) == 'function' then
				v = index(v)
			else
				if index == '[last]' then
					index = #v
				end
				v = v[index]
			end
		end
		if v == value then
			return k
		end
	end
	return false
end

function table.same( t1, t2 )
    local size_1 = table.getsize( t1 )
    local size_2 = table.getsize( t2 )
    if (size_1 == size_2) then
        for i = 1, size_1 do
            if t1[ i ] ~= t2[ i ] then return false end
        end
    else 
        return false
    end
    return true
end

function table.getsize( t )
    local tsize = 0
    for k, v in pairs( t ) do
        tsize = tsize + 1
    end
    return tsize
end

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

function isVehicleLowrider( vehicle )
    local id = getElementModel( vehicle )
    return lowriders[ id ]
end

function isVehicleRacer( vehicle )
    local id = getElementModel( vehicle )
    return racers[ id ]
end

function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local r, g, b = colorPicker.updateTempColors()
	if vehicle and isElement(vehicle) then
		local cr, cg, cb, cr2, cg2, cb2 = getVehicleColor(vehicle, true)
		if selectedColor == 1 then
			setVehicleColor(vehicle, r, g, b, cr2, cg2, cb2)
		elseif selectedColor == 2 then
			setVehicleColor(vehicle, cr, cg, cb, r, g, b)
		end
	end
end
addEventHandler("onClientRender", root, updateColor)

function leaveNewUpgrades( newtable, oldtable  )
    local leftUpgrades = { }
    for k, v in ipairs( newtable ) do
        if newtable[ k ] ~= oldtable[ k ] then 
            table.insert( leftUpgrades, newtable[ k ] ) 
        end
    end
    return leftUpgrades
end

function updatePickups()
	local angle = math.fmod((getTickCount() - startTick) * 360 / 2000, 360)
	for i,pickup in pairs(getElementsByType"carPickups") do
		setElementRotation(pickup, 0, 0, angle)
	end
end
addEventHandler('onClientRender', root, updatePickups)