local d = {0,57,114,171,228,285,292}
local s = {guiGetScreenSize()}
local maximo = 6
local count = 1
local visibilidade = false	
local panel = {}
panel.x, panel.y = (s[1] / 2) - 512, (s[2] /2 ) - 384

local loja1 = { -- id, value, preço, db, count, ativado=1desativado=0, level requerido
		{118, 1, 1500, 1, 1, 1, 1},
		{117, 1, 10000, 1, 1, 1, 1},
		{120, 1, 10000, 1, 1, 1, 1},
		{102, 1, 100, 1, 1, 1, 1},
		{100, 1, 12000, 1, 1, 1, 5},
		{101, 1, 12000, 1, 1, 1, 5},
}

local loja2 = { -- id, value, preço, db, count, ativado=1desativado=0
		{105, 1, 500, 1, 1, 1, 5},
		{99, 1, 21000, 1, 1, 1, 7},
		{106, 1, 38000, 1, 1, 1, 7},
		{103, 1, 48000, 1, 1, 1, 8},
		{95, 1, 42000, 1, 1, 1, 8},
		{104, 1, 53000, 1, 1, 1, 9},
}

local loja3 = { -- id, value, preço, db, count, ativado=1desativado=0
		{96, 1, 43000, 1, 1, 1, 10},
		{110, 1, 41000, 1, 1, 1, 10},
		{99, 1, 46000, 1, 1, 1, 11},
		{97, 1, 43000, 1, 1, 1, 12},
		{109, 1, 70000, 1, 1, 1, 13},
		{108, 1, 50000, 1, 1, 1, 14},
}
local loja4 = { -- id, value, preço, db, count, ativado=1desativado=0
		{112, 1, 98000, 1, 1, 1, 14},
		{107, 1, 250000, 1, 1, 1, 21},
		{94, 1, 700, 1, 1, 1, 55},
		{98, 1, 500000, 1, 1, 1, 50},
		{93, 1, 90000, 1, 1, 1, 55},
		{115, 1, 490000, 1, 1, 1, 60},
}
local loja5 = { -- id, value, preço, db, count, ativado=1desativado=0
		{90, 1, 15, 1, 1, 0, 100},
		{113, 1, 1200000, 1, 1, 1, 100},
		{91, 1, 15, 1, 1, 0, 105},
		{92, 1, 15, 1, 1, 0, 110},
		{116, 1, 50, 1, 1, 1, 250},
}


local loja = loja1

local opensans = dxCreateFont("files/opensans.ttf", 16)
local opensans2 = dxCreateFont("files/opensans.ttf", 11)
local opensans3 = dxCreateFont("files/opensans.ttf", 13)

addEventHandler( "onClientRender", getRootElement(),
	function( )	
	 if visibilidade then
	if (not exports.VDBGaming:isServerVDBG("adminverif","02102015") == true) then return end
		-- <ESTRUTURA>
		dxDrawText("#428bcaVDB#FFFFFF Gaming - Ammunation", panel.x + 220, panel.y + 154, 605, 456, tocolor(255, 255, 255, 255), 1, opensans, "left", "top", true, true, true, true, true)
		dxDrawRectangle(panel.x + 206, panel.y + 154, 605, 456, tocolor(0, 0, 0, 200), false)
		dxDrawRectangle(panel.x + 203, panel.y + 154, 3, 456, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 203, panel.y + 151, 608, 3, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 811, panel.y + 151, 3, 459, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 203, panel.y + 610, 611, 3, tocolor(0, 0, 0, 255), false)
        dxDrawLine(panel.x + 210, panel.y + 187, panel.x + 795, panel.y + 188, tocolor(100, 100, 100, 100), 1.5, false)
		-- </ESTRUTURA>
		-- <CONTEUDO>
		for i=0, maximo-1 do		
			dxDrawLine(panel.x + 211, panel.y + 244+d[i+1], panel.x + 794, panel.y + 244+d[i+1], tocolor(100, 100, 100, 100), 1.5, false)
			dxDrawRectangle(panel.x + 220, panel.y + 197+d[i+1], 40, 40, tocolor(0, 0, 0, 96), false) 
			dxDrawImage(panel.x + 220, panel.y + 197+d[i+1], 40, 40, ":VDBGItem/"..exports.VDBGItem:getItemImage(loja[i+1][1]),0,0,0,tocolor(255,255,255,255),false)
			dxDrawColorText("#FFA500Item: #FFFFFF"..exports.VDBGItem:getItemName(loja[i+1][1]), panel.x + 275, panel.y + 197+d[i+1], 760, 220, tocolor(254, 254, 254, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
			dxDrawColorText("#acd373Preço: #FFFFFFR$ "..loja[i+1][3]..",00", panel.x + 275, panel.y + 220+d[i+1], 760, 220, tocolor(254, 254, 254, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
			if loja[i+1][7] < exports.VDBGLevel:checkLevel(getLocalPlayer()) or loja[i+1][7] == exports.VDBGLevel:checkLevel(getLocalPlayer()) then
				dxDrawColorText("#acd373Necessário level: "..loja[i+1][7], panel.x + 480, panel.y + 220+d[i+1], 760, 220, tocolor(254, 254, 254, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
			else
				dxDrawColorText("#d9534fNecessário level: "..loja[i+1][7], panel.x + 480, panel.y + 220+d[i+1], 760, 220, tocolor(254, 254, 254, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
			end
			
		if loja[i+1][7] < exports.VDBGLevel:checkLevel(getLocalPlayer()) or loja[i+1][7] == exports.VDBGLevel:checkLevel(getLocalPlayer()) then
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
				
				dxDrawText("Comprar", panel.x + 709,panel.y +  204+d[i+1], 108, 33, tocolor(66, 139, 202, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
				
			else
			setTimer ( function() buy = nil end, 200, 1) --- se nao tiver em cima nao mostra colorido
			dxDrawText("Comprar", panel.x + 709, panel.y + 204+d[i+1], 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
			dxDrawRectangle(panel.x + 682, panel.y + 197+d[i+1], 108, 33, tocolor(0, 0, 0, 96), false)
				
			end
		end	
		end
		--[[ SE NAO TIVER COM O MOUSE ]]
		if( not isCursorShowing()) then
		dxDrawText("Comprar", panel.x + 709, panel.y + 204+d[i+1], 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		dxDrawRectangle(panel.x + 682, panel.y + 197+d[i+1], 108, 33, tocolor(0, 0, 0, 96), false)
		end
		--[[/SE NAO TIVER COM O MOUSE]]
	
		end
		
		dxDrawText("+"..count, panel.x + 510, panel.y + 570, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		
		if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 488, panel.y + 563, 10, 10, cursorX, cursorY)) then
				dxDrawImage(panel.x + 488, panel.y + 563, 10, 10, "files/-.png",0,0,0,tocolor(66, 139, 202,255),false)
			
			else
				dxDrawImage(panel.x + 488,  panel.y +563, 10, 10, "files/-.png",0,0,0,tocolor(255,255,255,255),false)
			end
		end	
		if( not isCursorShowing()) then
			dxDrawImage(panel.x + 488, panel.y + 563, 10, 10, "files/-.png",0,0,0,tocolor(255,255,255,255),false)
		end
		
		if count > 100 then
			count = 100
		end								
		if count == 0 then
			count = 1
		end	
		
		if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 488, panel.y + 583, 10, 10, cursorX, cursorY)) then
				dxDrawImage(panel.x + 488, panel.y + 583, 10, 10, "files/+.png",90,0,0,tocolor(66, 139, 202,255),false)
			
			else
				dxDrawImage(panel.x + 488, panel.y + 583, 10, 10, "files/+.png",90,0,0,tocolor(255,255,255,255),false)
			end
		end	
		if( not isCursorShowing()) then
			dxDrawImage(panel.x + 488, panel.y + 583, 10, 10, "files/+.png",90,0,0,tocolor(255,255,255,255),false)
		end
		
		if loja ~= loja5 then
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
		dxDrawText("Próximo", panel.x + panel.y + 711, 563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		
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
		dxDrawRectangle(panel.x + 226, panel.y +557, 108, 33, tocolor(0, 0, 0, 96), false)
		dxDrawText("Anterior", panel.x + 254, panel.y +563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		end
		end
		
		
		if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 741, panel.y +160, 50, 17, cursorX, cursorY)) then
				dxDrawText("Fechar", panel.x + 741, panel.y +160, 50, 17, tocolor(66, 139, 202, 255), 1.00, opensans3, "left", "top", false, false, false, false, false)		
			else
				dxDrawText("Fechar", panel.x + 741, panel.y +160, 50, 17, tocolor(255, 255, 255, 255), 1.00, opensans3, "left", "top", false, false, false, false, false)
		
			end
		end	
		if( not isCursorShowing()) then
		
		dxDrawText("Fechar", panel.x + 741, panel.y +160, 50, 17, tocolor(255, 255, 255, 255), 1.00, opensans3, "left", "top", false, false, false, false, false)
		
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
		if(locMouse(panel.x + 488, panel.y +563, 10, 10,x,y)) then
			count = count - 1
		end		
		if(locMouse(panel.x + 488, panel.y +583, 10, 10,x,y)) then
			count = count + 1			
		end	
		
		if(locMouse(panel.x + 741, panel.y +160, 50, 17,x,y)) then
			visibilidade = false
			showCursor(false)
			toggleControl("all",false)
			setElementFrozen ( getLocalPlayer(), false )
		end	
		
		if(locMouse(panel.x + 682, panel.y +557, 108, 33,x,y)) then		
			if loja == loja1 then
			loja = loja2
			elseif loja == loja2 then
			loja = loja3
			elseif loja == loja3 then
			loja = loja4
			elseif loja == loja4 then
			loja = loja5
			maximo = 5
			end
		end		
		if loja ~= loja1 then
		if(locMouse(panel.x + 226, panel.y +557, 108, 33,x,y)) then
			if loja == loja5 then
			loja = loja4		
			maximo = 6
			elseif loja == loja4 then 
			loja = loja3
			elseif loja == loja3 then 
			loja = loja2
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


local lojasitem = { }
function criarLoja ( x, y, z, int, dim )

	local i = 0
	while ( lojasitem [ i ] ) do
		i = i + 1
	end

	lojasitem [ i ] = createMarker ( x, y, z - 1, "cylinder", 1.5, 172, 211, 115, 170 )
	setElementInterior( lojasitem [ i ], int )
	setElementDimension( lojasitem [ i ], dim )


	addEventHandler ( "onClientMarkerHit", lojasitem[i], function ( p )
		if ( p == localPlayer and not isPedInVehicle ( localPlayer ) ) then
			visibilidade = true
			showCursor(true)
			toggleControl("all",true)
			setElementFrozen ( getLocalPlayer(), true )
		end 
	end )
end 

-- X,Y,Z,INT,DIM

criarLoja (296.32, -37.92, 1001.52, 1, 96)
criarLoja (296.32, -37.92, 1001.52, 1, 97)
criarLoja (296.32, -37.92, 1001.52, 1, 98)
criarLoja (296.32, -37.92, 1001.52, 1, 99)
criarLoja (296.32, -37.92, 1001.52, 1, 100)
criarLoja (296.32, -37.92, 1001.52, 1, 101)
criarLoja (296.32, -37.92, 1001.52, 1, 102)
criarLoja (296.32, -37.92, 1001.52, 1, 103)
criarLoja (296.32, -37.92, 1001.52, 1, 104)
criarLoja (296.32, -37.92, 1001.52, 1, 105)


