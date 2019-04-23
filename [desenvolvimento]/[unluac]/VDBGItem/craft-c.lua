--[[
//////////////////////////////////////////////
//Code by Mark and all rights reserved! 2015//
//////////////////////////////////////////////
--]]

local sx, sy = guiGetScreenSize()
mutatCraft = false
item_cache_craft = {}
for i=1, craftSlot*craftSlot do
	item_cache_craft[i] = {-1, -1}
end
cursorInCraft = false
cCraftSlot = -1
local cMovedCraftSlot = -1
local craftButton = false

function isCraftSlotOK(slot)
	for i, v in pairs(item_cache_craft) do
		if(tonumber(v[1])==tonumber(slot))then
			return false
		end
	end
	return true
end

function checkCursor()
	if not guiGetInputEnabled() and not isMTAWindowActive() and isCursorShowing( ) then
		return true
	else
		return false
	end
end

function getCursorPos()
	if checkCursor() then
		cx,cy = getCursorPosition ()
		cx,cy = cx*sx,cy*sy
	else
		cx,cy = -500,-500
	end
	return cx,cy
end

local function isInBox( xmin, ymin, xmax, ymax )
	if checkCursor() then
		x,y = getCursorPos()
		xmin = tonumber(xmin) or 0
		xmax = (tonumber(xmax) or 0)+xmin
		ymin = tonumber(ymin) or 0
		ymax = (tonumber(ymax) or 0)+ymin
		return x >= xmin and x <= xmax and y >= ymin and y <= ymax
	else
		return false
	end
end

local function tooltip( text, text2 )
	if checkCursor() then
		local x,y = getCursorPosition( )
		local x,y = x * sx, y * sy
		text = tostring( text )
		if text2 then
			text2 = tostring( text2 )
		end
		
		if text == text2 then
			text2 = nil
		end
		
		local width = dxGetTextWidth( text, 1, "clear" ) + 20
		if text2 then
			width = math.max( width, dxGetTextWidth( text2, 1, "clear" ) + 20 )
			text = text .. "\n" .. text2
		end
		local height = 10 * ( text2 and 5 or 3 )
		x = math.max( 10, math.min( x, sx - width - 10 ) )
		y = math.max( 10, math.min( y, sy - height - 10 ) )
		
		dxDrawRectangle( x, y, width, height, tocolor( 0, 0, 0, 190 ), true )
		dxDrawText( text, x, y, x + width, y + height, tocolor( 255, 255, 255, 230 ), 1, "clear", "center", "center", false, false, true )
	end
end

function hasItemPlayer(slot)
	if(item_cache_player[slot][2]>-1)then
		return true
	end
	return false
end

function getCrafedItem()
	local crafted = {-1, -1, -1}
	local kell = 0
	local plus = 0
	for ki,c in ipairs(craftList) do
		plus = 0
		for i, v in pairs(c) do
			if(i=="item")then
				crafted = v
				kell = #v-1
			else
				if(tonumber(item_cache_craft[i][2])==tonumber(v[1]) and tonumber(item_cache_player[item_cache_craft[i][1]][3])==tonumber(v[2]))then
					plus = plus + 1
				end
			end
			if(kell>0 and kell==plus)then
				return crafted
			end
		end
	end
	return {-1, -1, -1}
end

function draw()
	if(not mutatCraft)then return end
	if(tostring(getElementType(invElement))~="player")then
		mutatCraft = false
		return
	end
	
	local width = craftSlot*itemSize + margin*(craftSlot+1)
	local height = craftSlot*itemSize + margin*(craftSlot+1)
	local top = sy/2 - height/2
	local left = 100
	
	cCraftSlot = -1
	craftButton = false
	if(isInBox(left, top, width, height))then
		cursorInCraft = true
	else
		cursorInCraft = false
	end
	
	dxDrawRectangle(left, top - 30, width, 30, tocolor(0,0,0, 150))
	dxDrawText("Barkácsolás", left, top - 30, left + width, top, tocolor(255,255,255,255), 1.4, "clear", "center", "center", false, false, false) --Text
	dxDrawRectangle(left, top, width, height, tocolor(0,0,0,150))
	
	dxDrawRectangle(left, top + height, width, itemSize + margin*2, tocolor(0,0,0,170)) --Craft BT BG
	
	dxDrawRectangle(left + width - itemSize - margin, top + height + margin, itemSize, itemSize, tocolor(255,255,255,20)) --Craftolt IT BG
	local craftedItem = getCrafedItem()
	if(craftedItem[1]>-1)then
		dxDrawImage(left + width - itemSize - margin, top + height + margin, itemSize, itemSize, getItemImage(craftedItem[1])) --Craft IT BG
	end
	dxDrawRectangle(left + margin, top + height + (itemSize-30)/2 + margin, 100, 30, tocolor(169,139,101,150)) --Craft BT
	dxDrawText("Elkészít", left + margin, top + height + (itemSize-30)/2 + margin, left + margin + 100, top + height + (itemSize-30)/2 + margin + 30, tocolor(255,255,255,255), 1.4, "clear", "center", "center", false, false, false) --Text
	if(isInBox(left + margin, top + height + (itemSize-30)/2 + margin, 100, 30))then
		craftButton = true
	end
	
	local hely = 0
	local sor = 0
	for i=1, craftSlot*craftSlot do
		if(hely>craftSlot-1)then
			hely = 0
			sor = sor + 1
		end
		local color = tocolor(255,255,255,20)
		if(isInBox(left + itemSize*hely + margin*(hely+1), top + itemSize*sor + margin*(sor+1), itemSize, itemSize))then
			color = tocolor(169,139,101,80)
			cCraftSlot = i
		end
		dxDrawRectangle(left + itemSize*hely + margin*(hely+1), top + itemSize*sor + margin*(sor+1), itemSize, itemSize, color) --BG
		
		if(item_cache_craft[i] and hasItemPlayer(item_cache_craft[i][1]) and cMovedCraftSlot~=i)then
			dxDrawImage(left + itemSize*hely + margin*(hely+1), top + itemSize*sor + margin*(sor+1), itemSize, itemSize, getItemImage(item_cache_craft[i][2]), 0, 0, 0, tocolor(255,255,255,255)) --Item		
		end
		
		hely = hely + 1
	end
	if(cMovedCraftSlot>-1)then
		local cx, cy = getCursorPos()
		dxDrawImage(cx - itemSize/2 - margin, cy - itemSize/2 - margin, itemSize, itemSize, getItemImage(item_cache_craft[cMovedCraftSlot][2]), 0, 0, 0, tocolor(255,255,255,255)) --Item
	end	
end
addEventHandler("onClientRender", root, draw)

bindKey("o", "down", function()
	if(invElement and tostring(getElementType(invElement))=="player" and not mutatCraft)then
		mutatCraft = true
	else
		mutatCraft = false
	end
	item_cache_craft = {}
	for i=1, craftSlot*craftSlot do
		item_cache_craft[i] = {-1, -1}
	end
end)

addEventHandler("onClientClick", root, function(button, state, cx, cy, wx, wy, wz, element)
	if(mutatCraft and craftButton and button=="left" and state=="down")then
		local craftedItem = getCrafedItem()
		if(craftedItem[1]>-1)then
			if(not getFreeSlot())then
				outputChatBox("Nincs elég hely a hátizsákodban!", 255, 30, 30)
			else
				triggerServerEvent("giveItem", getLocalPlayer(), getLocalPlayer(), craftedItem[1], craftedItem[2], craftedItem[3])
				for i, v in ipairs(item_cache_craft) do
					if(tonumber(item_cache_craft[i][2])>-1)then
						triggerServerEvent("deleteItem", getLocalPlayer(), getLocalPlayer(), item_cache_craft[i][1])
					--	item_cache[item_cache_craft[i][1]] = {-1,-1,-1,-1}
					--	sendPlayerDataToServer()
					end
				end
			end
		end
	end
	if(mutatCraft and button=="left" and state=="down")then
		if(item_cache_craft[cCraftSlot] and item_cache_craft[cCraftSlot][2]>-1)then
			cMovedCraftSlot = cCraftSlot
		end
	elseif(mutatCraft and button=="left" and state=="up")then
		if(cursorInCraft and cMovedCraftSlot>-1 and cCraftSlot>-1 and item_cache_craft[cCraftSlot] and item_cache_craft[cCraftSlot][2]<1)then
			item_cache_craft[cCraftSlot] = item_cache_craft[cMovedCraftSlot]
			item_cache_craft[cMovedCraftSlot] = {-1, -1}
		elseif(not cursorInCraft and cMovedCraftSlot>-1 and cCraftSlot<1)then
			item_cache_craft[cMovedCraftSlot] = {-1, -1}
		end
		cMovedCraftSlot = -1
	end
end)