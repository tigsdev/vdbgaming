local sx, sy = guiGetScreenSize()
item_cache = {}
item_cache_player = {}
item_cache_action = {}
local triggered = false
local cSlot = -1
local cItem = nil
local cMovedSlot = -1
local cMovedItem = nil
local cCloneSlot = -1
local cCloneItem = nil
mutat = false
local tickCount = nil
local isMove = false
local showedMove = false
local cursorInBox = false
local cursorInAction = false
local font = dxCreateFont("opensans_semibold.ttf", 12)
invElement = nil
local cActionSlot = -1
for i=1, actionSlot do
	item_cache_action[i] = {-1, -1}
end
local dannied = {
		[1]=true, 
		[71]=true, 
		[72]=true, 
		[73]=true, 
		[78]=true, 
		[79]=true, 
		[80]=true, 
		[90]=true, 
		[91]=true, 
		[92]=true, 
		[93]=true, 
		
		[95]=true, 
		[96]=true, 
		[97]=true, 
		[98]=true, 
		[99]=true, 
		[100]=true, 
		[101]=true, 
		[102]=true, 
		[103]=true, 
		[104]=true, 
		
		
		[106]=true, 
		[107]=true, 
		[108]=true, 
		[109]=true, 
		[110]=true, 
		[111]=true, 
		[112]=true, 
		
		
		[115]=true, 
		[116]=true, 
		[117]=true, 
		
		[120]=true
}


function recivePlayerItems(items)
	triggered = true
	item_cache = items
	if(not invElement or tostring(getElementType(invElement))=="player")then
		item_cache_player = items
	end
end
addEvent("recivePlayerItems", true)
addEventHandler("recivePlayerItems", root, recivePlayerItems)

function sendPlayerDataToServer(player)
	if not player then
		triggerServerEvent("reciveElementData", invElement, invElement, item_cache)
	else
		triggerServerEvent("reciveElementData", invElement, invElement, item_cache_player)
	end
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

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function hasItemPlayer(slot)
	if(item_cache_player[slot] and item_cache_player[slot][2]>-1)then
		return true
	end
	return false
end

function getMaxWeight()
	if(tostring(getElementType(invElement))=="player")then
		return 40
	elseif(tostring(getElementType(invElement))=="vehicle")then
		return 70
	elseif(tostring(getElementType(invElement))=="object")then
		return 100
	end
	return 0
end

function getItemsWeight()
	local all = 0
	if(item_cache)then
		for i=1, row*colum do
			if(not item_cache[i] or item_cache[i][2]>0)then
				all = all + getItemWeight(item_cache[i][2])*item_cache[i][4]
			end
		end
	end
	return all
end

function getFreeSlot()
	if(getItemsWeight()>=getMaxWeight())then
		return false, -1
	end
	for i=1, row*colum do
		if(not item_cache[i] or item_cache[i][2]<0)then
			return true, i
		end
	end
	return false, -1
end

addCommandHandler("asddd", function()
setElementData(localPlayer, "screenmod", true)
end)

function draw()
if (getElementData(localPlayer,"logado") == false) then return end;
if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
if getElementData ( localPlayer, "opendashboard", true) then return end
	--Action
	
	cActionSlot = -1
	local width = itemSize*actionSlot + margin*(actionSlot+1)
	local height = itemSize + margin*2
	local top = sy - height - 10
	local left = sx/2 - width/2
	if getElementData ( localPlayer, "opendashboard") == false then
	if (getElementData(localPlayer,"logado") == false) then return end;
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
		dxDrawRectangle(left, top, width, height, tocolor(0,0,0,150)) --BG
		for i=1, actionSlot do
			dxDrawRectangle(left + itemSize*(i-1) + margin*i, top + margin, itemSize, itemSize, tocolor(255,255,255,20)) --BG
			
			if((not guiGetInputEnabled() and not isMTAWindowActive() and not isCursorShowing( ) and getKeyState(i)) or isInBox(left + itemSize*(i-1) + margin*i, top + margin, itemSize, itemSize))then
				dxDrawRectangle(left + itemSize*(i-1) + margin*i - 1, top + margin - 1, itemSize + 2, itemSize + 2, tocolor(66,117,164,80)) --BG
				cActionSlot = i
			end
			
			if(item_cache_action[i] and item_cache_action[i][1]>-1 and hasItemPlayer(item_cache_action[i][1]))then
				dxDrawImage(left + itemSize*(i-1) + margin*i, top + margin, itemSize, itemSize, getItemImage(item_cache_action[i][2]), 0, 0, 0, tocolor(255,255,255,255)) --Item
			end
		end
		if(isInBox(left, top, width, height))then
			cursorInAction = true
		else
			cursorInAction = false
		end
	end
	

	if(not mutat or not triggered)then return end
	cItem = nil
	cSlot = -1
	isMove = false
	
	local width = itemSize * colum + margin * (colum+1)
	local height = itemSize * row + margin * (row+1) --[[Pesando Tamanho:]] +35
	local top = sy/1.8 - height/2
	local left = sx/1.205 - width/2
	
	if(isInBox(left, top, width, height))then
		cursorInBox = true
	else
		cursorInBox = false
	end
	
	dxDrawRectangle(left, top - 30, width, 30, tocolor(0, 0, 0,190)) --Top
	local text = "Desconhecido"
	if(tostring(getElementType(invElement))=="vehicle") and getElementData(invElement,"VDBGVehicles:VehicleID") then
		text = "#E6E6E6VDB#5592FFGaming - #F0F0E1 Porta Malas V["..tonumber(getElementData(invElement,"VDBGVehicles:VehicleID")).."]"
		if not getElementData(localPlayer,"notificationVehicleSave") then
	    outputChatBox("#d9534f[VDBG.ORG] #ffffffItens guardados em veículos não são salvos pelo servidor!", 255, 255, 255, true )
		setElementData(localPlayer,"notificationVehicleSave", true) 
		end
	elseif(tostring(getElementType(invElement))=="object")then
		text = "#E6E6E6VDB#5592FFGaming - #F0F0E1 Armário"
	elseif(tostring(getElementType(invElement))=="player")then
		text = "#E6E6E6VDB#5592FFGaming - #F0F0E1 Inventário"
	end
	dxDrawColorText(text, left, top - 30, left + width, top, tocolor(255,255,255,255), 1, font, "center", "center", false, false, false) --Text
	dxDrawRectangle(left, top, width, height, tocolor(0,0,0,200)) --BG
	
	dxDrawRectangle(left + margin, top + height - 35, width - margin*2, 30, tocolor(0,0,0,80)) --PESAGEM BG
	local suly = getItemsWeight()
	if(suly>getMaxWeight())then
		suly = getMaxWeight()
	end
	if(isInBox(left + margin, top + height - 35, width - margin*2, 30))then
		dxDrawText(math.round(suly,2).."/".. getMaxWeight().."kg",left + margin, top + height - 35, left + margin + width - margin*2, top + height - 35 + 30, tocolor(255,255,255,255), 1.2, "clear", "center", "center", false, false, false) --Count		
	else
		dxDrawText(math.ceil(math.round(suly,2)/getMaxWeight()*100) .."%",left + margin, top + height - 35, left + margin + width - margin*2, top + height - 35 + 30, tocolor(255,255,255,255), 1.2, "clear", "center", "center", false, false, false) --Count			
	end
	if math.round(suly,2) == getMaxWeight() then
		dxDrawRectangle(left + margin, top + height - 35, (width - margin*2)*suly/getMaxWeight(), 30, tocolor(217, 83, 79,100)) --PESAGEM ok
	else
		dxDrawRectangle(left + margin, top + height - 35, (width - margin*2)*suly/getMaxWeight(), 30, tocolor(66,117,164,100)) --PESAGEM full
	end
	local sor = 0
	local hely = 0
	showedMove = false
	for i=0, colum*row-1 do
		isMove = tickCount and cMovedItem and cMovedItem==item_cache[i+1] and ( getTickCount( ) - tickCount >= 130 )
		local item = tonumber(item_cache[i+1][2] or -1)
		local value = tonumber(item_cache[i+1][3] or -1)
		local count = tonumber(item_cache[i+1][4] or -1)
		if(hely>colum-1)then
			hely = 0
			sor = sor + 1
		end
		local color = tocolor(255,255,255,20)
		if(isInBox(left + itemSize*hely + margin*(hely+1), top + itemSize*sor + margin*(sor+1), itemSize, itemSize))then
			color = tocolor(66,117,164,80)
			cSlot = i+1
			cItem = item_cache[i+1]
			if(item>-1)then
				tooltip(getItemName(item, value))
			end
		end
		dxDrawRectangle(left + itemSize*hely + margin*(hely+1), top + itemSize*sor + margin*(sor+1), itemSize, itemSize, color) --BG
		if(item>0)then
			if(not isMove)then
				dxDrawImage(left + itemSize*hely + margin*(hely+1), top + itemSize*sor + margin*(sor+1), itemSize, itemSize, getItemImage(item), 0, 0, 0, tocolor(255,255,255,255)) --Item
				dxDrawText(count, left + itemSize*hely + margin*(hely+1) - 1, top + itemSize*sor + margin*(sor+1) - 1, left + itemSize*hely + margin*(hely+1) + itemSize-2, top + itemSize*sor + margin*(sor+1) + itemSize-2, tocolor(0,0,0,255), 0.9, "clear", "right", "bottom", false, false, false) --Count
				dxDrawText(count, left + itemSize*hely + margin*(hely+1), top + itemSize*sor + margin*(sor+1), left + itemSize*hely + margin*(hely+1) + itemSize-2, top + itemSize*sor + margin*(sor+1) + itemSize-2, tocolor(255,255,255,255), 0.9, "clear", "right", "bottom", false, false, false) --Count
			else
				showedMove = true
			end
		end
		hely = hely + 1
	end
	
	if(cMovedItem and showedMove)then
		local cx, cy = getCursorPos()
		dxDrawImage(cx - itemSize/2 - margin, cy - itemSize/2 - margin, itemSize, itemSize, getItemImage(cMovedItem[2]), 0, 0, 0, tocolor(255,255,255,255)) --Item
		dxDrawText(cMovedItem[4] or -1, cx - itemSize/2 - margin - 1, cy - itemSize/2 - margin - 1, cx - itemSize/2 - margin + itemSize - 2, cy - itemSize/2 - margin + itemSize - 2, tocolor(0,0,0,255), 1.2, "clear", "right", "bottom", false, false, false) --Count
		dxDrawText(cMovedItem[4] or -1, cx - itemSize/2 - margin, cy - itemSize/2 - margin, cx - itemSize/2 - margin + itemSize - 2, cy - itemSize/2 - margin + itemSize - 2, tocolor(255,100,100,255), 1.2, "clear", "right", "bottom", false, false, false) --Count
	elseif(cCloneItem)then
		local cx, cy = getCursorPos()
		dxDrawImage(cx - itemSize/2 - margin, cy - itemSize/2 - margin, itemSize, itemSize, getItemImage(cCloneItem[2]), 0, 0, 0, tocolor(255,255,255,255)) --Item
	end
end
addEventHandler("onClientRender", root, draw)


function openInventory(element)
	mutat = not mutat
	if(not mutat)then
		triggered = false
		playSound(":VDBGPanelSound/fecha.mp3")
	else		
		playSound(":VDBGPanelSound/abre.mp3")
		triggerServerEvent("sendPlayerItemsToClient", getLocalPlayer(), element, getLocalPlayer())
	end
	invElement = element
end
function hideInventory(element)
end
	
bindKey("i", "down", function()
if (getElementData(localPlayer,"logado") == false) then return end
if getElementData ( localPlayer, "opendashboard", true) then return end
	tickCount = 0
	openInventory(getLocalPlayer())
end)

addCommandHandler("vdbginvadm1212", function(cmd, name)
	openInventory(getPlayerFromName(name or "") or getLocalPlayer())
end)

bindKey("delete", "down", function()
	if(not mutat)then return end
	if(cSlot>-1 and item_cache[cSlot][2]>-1)then
		triggerServerEvent("deleteItem", invElement, invElement, item_cache[cSlot][1], true)
		item_cache[cSlot] = {-1,-1,-1,-1}
		sendPlayerDataToServer()
	end
end)

for i=1, actionSlot do
	bindKey(i, "down", function()
		if(item_cache_action[i] and item_cache_action[i][1]>-1 and hasItemPlayer(item_cache_action[i][1]) and tonumber(item_cache[item_cache_action[i][1]][4] or -1) > 0 )then
			useItem(item_cache[item_cache_action[i][1]][1], item_cache_action[i][1], item_cache[item_cache_action[i][1]][2], item_cache[item_cache_action[i][1]][3], item_cache[item_cache_action[i][1]][4])
			if (not dannied[item_cache[item_cache_action[i][1]][2]]) then 
				item_cache[item_cache_action[i][1]][4] = tonumber(item_cache[item_cache_action[i][1]][4] or -1)-1
				sendPlayerDataToServer(true)
				if item_cache[item_cache_action[i][1]][4] < 0 then
					item_cache[item_cache_action[i][1]][4] = 0
					sendPlayerDataToServer(true)		
				end
			end
			
			
			
		end
	end)
end

addEventHandler("onClientClick", root, function(button, state, cx, cy, wx, wy, wz, element)
	if(not mutat and button=="left" and state=="down" and element and (tostring(getElementType(element))=="vehicle" or (tostring(getElementType(element))=="object" and getElementModel(element)==1372)))then
		openInventory(element)
	end
	if(mutat and button=="left" and state=="down")then
		tickCount = getTickCount()
		cMovedItem = cItem
		cMovedSlot = cSlot
		if(cursorInAction and cActionSlot>-1)then
			item_cache_action[cActionSlot] = {-1, -1}
		end
	elseif(mutat and button=="left" and state=="up")then
		if(showedMove and cMovedItem and cSlot>-1 and tonumber(cItem[2])<0 and cSlot~=cMovedSlot and cursorInBox)then
			item_cache[cMovedSlot] = {-1,-1,-1,-1}
			item_cache[cSlot] = cMovedItem
			sendPlayerDataToServer()
		elseif(showedMove and cMovedItem and cSlot>-1 and tonumber(item_cache[cSlot][2])==tonumber(cMovedItem[2]) and tonumber(cItem[3])==tonumber(cMovedItem[3]) and cSlot~=cMovedSlot and cursorInBox and items[tonumber(cItem[2])][4])then
			cItem[4] = cItem[4] + item_cache[cMovedSlot][4]
			triggerServerEvent("deleteItem", invElement, invElement, cMovedItem[1], true)
			item_cache[cMovedSlot] = {-1,-1,-1,-1}
			item_cache[cSlot] = cItem
			sendPlayerDataToServer()
		elseif(not showedMove and cSlot>-1 and cItem[2]>-1 and cursorInBox)then
			if(invElement==getLocalPlayer())then
				useItem(cItem[1], cSlot, cItem[2], cItem[3], cItem[4])
				if (not dannied[cItem[2]]) then 
				cItem[4] = tonumber(cItem[4] or -1)-1
				sendPlayerDataToServer(true)				
				if cItem[4] < 0 then
					cItem[4] = 0
					sendPlayerDataToServer(true)		
				end
			end
			else			
				triggerServerEvent("transferItem", invElement, invElement, getLocalPlayer(), cMovedSlot, getLocalPlayer())
			end
		elseif(not cursorInBox and cursorInAction and cMovedItem and cMovedSlot>-1)then
			item_cache_action[cActionSlot] = {cMovedSlot, cMovedItem[2]}
		elseif(not cursorInBox and cursorInCraft and cMovedItem and cMovedSlot>-1 and isCraftSlotOK(cMovedSlot))then
			item_cache_craft[cCraftSlot] = {cMovedSlot, cMovedItem[2]}
		elseif(not cursorInBox and element and cMovedItem and cMovedSlot>-1 and element~=getLocalPlayer())then		
				if ((getElementType(element))=="vehicle") and tonumber(getElementData(element, "accountID") or -1)>-1 then
					triggerServerEvent("transferItem", invElement, invElement, element, cMovedSlot)
				elseif ((getElementType(element))=="object") and getElementModel(element)==1372 then
					triggerServerEvent("transferItem", invElement, invElement, element, cMovedSlot)
				elseif ((getElementType(element))=="player") and tonumber(getElementData(element, "accountID") or -1)>-1 then
					triggerServerEvent("transferItem", invElement, invElement, element, cMovedSlot)
				end	
		end
		isMove = false
		cMovedItem = nil
		cMovedSlot = -1
	elseif(mutat and button=="right" and state=="down")then
		if(cItem and tonumber(cItem[4] or -1)>1)then
			cCloneItem = cItem
			cCloneSlot = cSlot
		end
	elseif(mutat and button=="right" and state=="up")then
		if(cCloneItem and cItem and cSlot>-1 and tonumber(cItem[2])<0 and tonumber(cCloneItem[4])>1 and cSlot~=cCloneSlot and items[tonumber(cCloneItem[2])] and items[tonumber(cCloneItem[2])][4])then
			cCloneItem[4] = tonumber(cCloneItem[4]) - 1
			item_cache[cCloneSlot] = cCloneItem
			item_cache[cSlot] = {-1, cCloneItem[2], cCloneItem[3], 1}
			sendPlayerDataToServer()
		elseif(cCloneItem and cItem and cSlot>-1 and tonumber(cCloneItem[4])>1 and tonumber(cItem[2])==tonumber(cCloneItem[2]) and tonumber(cItem[3])==tonumber(cCloneItem[3]) and cSlot~=cCloneSlot and items[tonumber(cCloneItem[2])][4])then
			cCloneItem[4] = tonumber(cCloneItem[4]) - 1
			item_cache[cCloneSlot] = cCloneItem
			item_cache[cSlot][4] = tonumber(item_cache[cSlot][4]) + 1
			sendPlayerDataToServer()
		end
		cCloneItem = nil
		cCloneSlot = -1		
	end	
end)


--WEAPON
toggleControl("next_weapon", false)
toggleControl("previous_weapon", false)

function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	if((getElementData(getLocalPlayer(), "char:weaponInHand") or {-1, -1, -1})[1]>-1)then
		local weaponData = getElementData(getLocalPlayer(), "char:weaponInHand") or {-1, -1, -1}
		local witem = tonumber(weaponData[1] or -1)
		local wslot = tonumber(weaponData[2] or -1)
		local weapon = tonumber(weaponData[3] or -1)
		if(not items[witem][6])then return end
		local slot = 0
		local allammo = 0
		for i, v in ipairs(item_cache_player) do
			if(tonumber(v[2])==tonumber(items[witem][6]) and tonumber(v[4])>0)then
				slot = i
				allammo = allammo + tonumber(v[4])
			end
		end
		
		if(allammo<=0)then
			triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), wslot, witem)
		else
			item_cache_player[slot][4] = tonumber(item_cache_player[slot][4] or -1)-1
			sendPlayerDataToServer(true)
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )

function getElementItemID(client, itemrequerid)
	if client and itemrequerid then 
		triggerEvent ( "onServerRequestItem", client, itemrequerid ) 
	end
	if getElementData(client, "hasItem" ) == true and getElementData(client, "hasItemID" ) == itemrequerid then
		setElementData(client, "hasItem", nil )
		setElementData(client, "hasItemID", nil )
		return true	
	else
		setElementData(client, "hasItem", nil )
		setElementData(client, "hasItemID", nil )
		return false
	end
end


addEvent( "onServerRequestItem", true )
addEventHandler( "onServerRequestItem", getRootElement(),
    function(item) 
		hasItem(tonumber(item)) 
    end)
	
function hasItem(item)
	for i, v in ipairs(item_cache_player) do
		if(tonumber(v[2])==tonumber(item) and tonumber(v[4])>0)then
			setElementData(getLocalPlayer(), "hasItem", true )
			setElementData(getLocalPlayer(), "hasItemID", tonumber(item) )
			--outputDebugString(item)
		end
	end
end

function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY)
  bx, by, color, scale, font = bx or ax, by or ay, color or tocolor(255,255,255,255), scale or 1, font or "default"
  if alignX then
    if alignX == "center" then
      ax = ax + (bx - ax - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font))/2
    elseif alignX == "right" then
      ax = bx - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
    end
  end
  if alignY then
    if alignY == "center" then
      ay = ay + (by - ay - dxGetFontHeight(scale, font))/2
    elseif alignY == "bottom" then
      ay = by - dxGetFontHeight(scale, font)
    end
  end
   local clip = false
   if dxGetTextWidth(str:gsub("#%x%x%x%x%x%x","")) > bx then clip = true end
  local alpha = string.format("%08X", color):sub(1,2)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  local text = ""
  local broke = false
  while s do
    if cap == "" and col then color = tocolor(getColorFromString("#"..col..alpha)) end
    if s ~= 1 or cap ~= "" then
      local w = dxGetTextWidth(cap, scale, font)
           if clip then
                local text_ = ""
                 for i = 1,string.len(cap) do
                  if dxGetTextWidth(text,scale,font) < bx then
                  text = text..""..string.sub(cap,i,i)
                  text_ = text_..""..string.sub(cap,i,i)
                  else
                  broke = true
                   break
                  end
                 end
                 cap = text_
                end
      dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
      ax = ax + w
      color = tocolor(getColorFromString("#"..col..alpha))
    end
    last = e + 1
    s, e, cap, col = str:find(pat, last)
  end
  if last <= #str and not broke then
    cap = str:sub(last)
                   if clip then
                local text_ = ""
                 for i = 1,string.len(cap) do
                  if dxGetTextWidth(text,scale,font) < bx then
                  text = text..""..string.sub(cap,i,i)
                  text_ = text_..""..string.sub(cap,i,i)
                  else
                  broke = true
                   break
                  end
                 end
                 cap = text_
                end
    dxDrawText(cap, ax, ay, ax + dxGetTextWidth(cap, scale, font), by, color, scale, font)
  end
end