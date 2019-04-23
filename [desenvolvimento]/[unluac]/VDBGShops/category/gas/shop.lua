local d = {0,57,114,171,228,285,292}
local s = {guiGetScreenSize()}
local maximo = 1
local count = 1
local panel = {}
local visibilidade = false	
panel.x, panel.y = (s[1] - 770)/2 - 125, (s[2] - 453)/2
local loja1 = { -- id, value, รกr, db, count
		{30, 1, 189, 1, 1},
}

local loja = loja1

local opensans = dxCreateFont("files/opensans.ttf", 16)
local opensans2 = dxCreateFont("files/opensans.ttf", 11)
local opensans3 = dxCreateFont("files/opensans.ttf", 13)

addEventHandler( "onClientRender", getRootElement(),
	function( )	
		
	 if visibilidade then
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
		-- <ESTRUTURA>
		--dxDrawText("#428bcaVDB#FFFFFF Gaming - Postos VDBGaming", panel.x + 340, panel.y + 154, 760, 220, tocolor(255, 255, 255, 255), 1, opensans, "center", "top", true, true, true, true, true)
		dxDrawText("#428bcaVDB#FFFFFF Gaming - Postos VDBGaming", panel.x + 220, panel.y + 154, 605, 456, tocolor(255, 255, 255, 255), 1, opensans, "left", "top", true, true, true, true, true)
		--[[dxDrawRectangle(206, 154, 605, 456, tocolor(0, 0, 0, 200), false)
		dxDrawRectangle(203, 154, 3, 456, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(203, 151, 608, 3, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(811, 151, 3, 459, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(203, 610, 611, 3, tocolor(0, 0, 0, 255), false)
        dxDrawLine(210, 187, 795, 188, tocolor(100, 100, 100, 100), 1.5, false)]]
		
		dxDrawRectangle(panel.x + 206, panel.y + 154, 605, 106, tocolor(0, 0, 0, 200), false)
		dxDrawRectangle(panel.x + 203, panel.y + 154, 3, 106, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 203, panel.y + 151, 608, 3, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 811, panel.y + 151, 3, 109, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 203, panel.y + 260, 611, 3, tocolor(0, 0, 0, 255), false)

		
		-- </ESTRUTURA>
		-- <CONTEUDO>
		for i=0, maximo-1 do
			dxDrawRectangle(panel.x + 220, panel.y + 197+d[i+1], 40, 40, tocolor(0, 0, 0, 96), false) 
			dxDrawImage(panel.x + 220, panel.y + 197+d[i+1], 40, 40, ":VDBGItem/"..exports.VDBGItem:getItemImage(loja[i+1][1]),0,0,0,tocolor(255,255,255,255),false)
			dxDrawColorText("#FFA500Item: #FFFFFF"..exports.VDBGItem:getItemName(loja[i+1][1]), panel.x + 275, panel.y + 197+d[i+1], 760, 220, tocolor(254, 254, 254, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
			dxDrawColorText("#acd373Preço: #FFFFFFR$ "..loja[i+1][3]..",00", panel.x + 275, panel.y + 220+d[i+1], 760, 220, tocolor(254, 254, 254, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
			
			
		if(isCursorShowing()) then
		XY = {guiGetScreenSize()} 
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 682, panel.y + 197+d[i+1], 108, 33, cursorX, cursorY)) then
				--- mostra o botao comprar colorido
				dxDrawRectangle(panel.x + 682, panel.y + 197+d[i+1], 108, 33, tocolor(0, 0, 0, 96), false)
				
				
				item = loja[i+1][1]
				value = loja[i+1][2]			
				price = loja[i+1][3]
				db = loja[i+1][4]
				--count = loja[i+1][5] é definido pelo usuario
				activeitem = loja[i+1][6]
				name = exports.VDBGItem:getItemName(loja[i+1][1])
				buy = true
				
				
				dxDrawText("Comprar", panel.x + 709, panel.y + 204+d[i+1], 108, 33, tocolor(66, 139, 202, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
				
			else
			setTimer ( function() buy = nil end, 200, 1) --- se nao tiver em cima nao mostra colorido
			dxDrawText("Comprar", panel.x + 709, panel.y + 204+d[i+1], 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
			dxDrawRectangle(panel.x + 682, panel.y + 197+d[i+1], 108, 33, tocolor(0, 0, 0, 96), false)
				
			end
		end	
		--[[ SE NAO TIVER COM O MOUSE ]]
		if( not isCursorShowing()) then
		dxDrawText("Comprar", panel.x + 709, panel.y + 204+d[i+1], 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		dxDrawRectangle(panel.x + 682, panel.y + 197+d[i+1], 108, 33, tocolor(0, 0, 0, 96), false)
		end 
		--[[/SE NAO TIVER COM O MOUSE]]
	
		end
		
		
		
		if loja ~= loja1 then
		if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 682, panel.y + 557, 108, 33, cursorX, cursorY)) then
				dxDrawRectangle(panel.x + 682, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
				dxDrawText("Próximo", panel.x + 711, panel.y + 563, 108, 33, tocolor(66, 139, 202, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)		
			else
				dxDrawRectangle(panel.x + 682, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
				dxDrawText("Próximo", panel.x + 711, panel.y + 563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		
			end
		end	
		end	
		if( not isCursorShowing()) then
		dxDrawRectangle(panel.x + 682, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
		dxDrawText("Próximo", panel.x + 711, panel.y + 563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		
		end
		
		
		
		
		
		if loja ~= loja1 then
		if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 226, panel.y + 557, 108, 33, cursorX, cursorY)) then
				dxDrawRectangle(panel.x + 226, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
				dxDrawText("Anterior", panel.x + 254, panel.y + 563, 108, 33, tocolor(66, 139, 202, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)		
			else
				dxDrawRectangle(panel.x + 226, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
				dxDrawText("Anterior", panel.x + 254, panel.y + 563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		
			end
		end	
		
		if( not isCursorShowing()) then
		dxDrawRectangle(panel.x + 226, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
		dxDrawText("Anterior", panel.x + 254, panel.y + 563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		end
		end
		
		
		if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 741, panel.y + 160, 50, 17, cursorX, cursorY)) then
				dxDrawText("Fechar", panel.x + 741, panel.y + 160, 50, 17, tocolor(66, 139, 202, 255), 1.00, opensans3, "left", "top", false, false, false, false, false)		
			else
				dxDrawText("Fechar", panel.x + 741, panel.y + 160, 50, 17, tocolor(255, 255, 255, 255), 1.00, opensans3, "left", "top", false, false, false, false, false)
		
			end
		end	
		if( not isCursorShowing()) then
		
		dxDrawText("Fechar",panel.x +  741, panel.y + 160, 50, 17, tocolor(255, 255, 255, 255), 1.00, opensans3, "left", "top", false, false, false, false, false)
		
		end
		
	end
	end
)



function MenuButton(botao,status,x,y)
	if botao == "left" and status == "down" then
	
	if visibilidade then 
			if buy then
			triggerServerEvent("addItem", localPlayer, item, value, price, db, count, activeitem, name)
			end
	
		
		if(locMouse(panel.x + 741, panel.y + 160, 50, 17,x,y)) then
			visibilidade = false
			showCursor(false)
			toggleControl("all",false)
		end	
		
		if(locMouse(panel.x + 682, panel.y + 557, 108, 33,x,y)) then		
			if loja == loja1 then
			loja = loja2
			elseif loja == loja2 then
			loja = loja3
			maximo = 5
			end
		end		
		if loja ~= loja1 then
		if(locMouse(panel.x + 226, panel.y + 557, 108, 33,x,y)) then
			if loja == loja3 then 
			loja = loja2
			maximo = 6
			elseif loja == loja2 then
			loja = loja1
			end
		end	
		end	
	end	
end	
end
addEventHandler("onClientClick",getRootElement(),MenuButton)


function locMouse(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
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



function openWindowGas (p)
		if ( p == localPlayer and not isPedInVehicle ( localPlayer ) ) then
			visibilidade = true
			showCursor(true)
			toggleControl("all",true)
		end 		
end 
