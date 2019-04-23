local screenW,screenH = guiGetScreenSize()
local hudTable = {"ammo","armour","clock","health","money","weapon","wanted","area_name","vehicle_name","breath","clock","radar"}
local font = dxCreateFont("arquivos/font.ttf", 8)
local font2 = dxCreateFont("arquivos/font2.ttf", 11)
local diamantecor = 0

local rectangleData = {
    x = screenW - 333 - 10 + 10,
    y =  77 + 40,
    width =  162,
    height = 40
}
local pdudata = {
    x = screenW -72 - 10,
	y =  13,
	width =   15,
	height = 15
}

addEventHandler("onClientRender", root, function()

	if(getElementData(getLocalPlayer(), "opendashboard") == true) then return end
	if(getElementData(getLocalPlayer(), "hudstate") == true) then return end
	if(getElementData(getLocalPlayer(), "logado") == false ) then return end
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	local health = getElementHealth(getLocalPlayer())
	local food = getElementData(getLocalPlayer(), "AccountData.Fome") or 0
	local drink = getElementData(getLocalPlayer(), "AccountData.Sede") or 0
	local armor = getPedArmor(getLocalPlayer()) or 0
    
	--iconsback--
	
	dxDrawRectangle(screenW - 145 - 10, 36, 133, 2,tocolor(0,0,0,140),false) -- borda exp
	dxDrawRectangle(screenW - 145 - 10, 54, 133, 2,tocolor(0,0,0,140),false) -- borda exp
	dxDrawRectangle(screenW - 147 - 10, 36, 2, 20,tocolor(0,0,0,140),false) -- borda esquerda
	dxDrawRectangle(screenW - 12 - 10, 36, 2, 20,tocolor(0,0,0,140),false) -- borda direita
	
	
	dxDrawRectangle(screenW - 145 - 10, 38, 133, 16,tocolor(0,0,0,140),false) -- fundo exp
	
	local exp = exports.VDBGLevel:checkExp(getLocalPlayer()) or 0
	local up = exports.VDBGLevel:checkUP(getLocalPlayer()) or 0
	local exps = 133*(up-exp)/100
	local exp2 = 133 - exps
	
	dxDrawRectangle(screenW - 145 - 10, 38, exp2, 16,tocolor(23,201,236,255),false) -- fundo ceilnter
	dxDrawText( exp.." / "..up, screenW+screenW - 195, 39.19,20, 20, tocolor ( 255, 255, 255, 255 ), 1, font , "center", "top" , false)
	

	
	dxDrawRectangle(screenW - 328 - 10, 10, 328, 154,tocolor(0,0,0,140),false) -- fundo
	dxDrawRectangle(screenW - 328 - 10, 10, 328, 22,tocolor(0,0,0,140),false) -- fundo topo
	dxDrawRectangle(screenW - 147 - 10, 59, 137, 53,tocolor(0,0,0,120),false) -- fundo weapon
	
	dxDrawRectangle(screenW - 328 - 10, 10, 328, 2,tocolor(0,0,0,140),false) -- borda topo
	dxDrawRectangle(screenW - 328 - 10, 10, 2, 152,tocolor(0,0,0,140),false) -- borda esquerda
	dxDrawRectangle(screenW - 328 + 316, 10, 2, 152,tocolor(0,0,0,140),false) -- borda direita
	dxDrawRectangle(screenW - 328 - 10, 162, 328, 2,tocolor(0,0,0,140),false) -- borda rodape
	
	dxDrawRectangle(screenW - 328 - 5, 36, 40, 40,tocolor(0,0,0,140),false) 
	dxDrawRectangle(screenW - 327 - 5, 77, 152, 1.5,tocolor(150, 150, 150,255),false) 
	
	dxDrawImage(screenW - 271 - 10, 85, 26, 21, "arquivos/fome_back.png", 0, 0, 0, tocolor(255,255,255,250))
    dxDrawImage(screenW - 231 - 10, 85, 27, 25, "arquivos/sede_back.png", 0, 0, 0, tocolor(255,255,255,250))
	dxDrawImage(screenW - 192 - 10, 85, 22, 24, "arquivos/colete_back.png", 0, 0, 0, tocolor(255,255,255,250))
	dxDrawImage(screenW - 318 - 10, 86, 32, 23, "arquivos/health_back.png", 0, 0, 0, tocolor(255,255,255,250))
	local avatarID = tonumber(getElementData(localPlayer,"avatar") or 0)	
	dxDrawImage(screenW - 328 - 5, 36, 40, 40, ":VDBGPDU/avatares/"..avatarID..".png", 0, 0, 0, tocolor(255,255,255,255))

	dxDrawImageSection(screenW - 328 - 10 + 10, 10 + 76 + 23, 32, -(23*(health/100)), 0, 0, 32, -(23*(health/100)), "arquivos/health.png", 0, 0, 0, tocolor(255,255,255,250))
	dxDrawImageSection(screenW - 328 - 10 + 57, 10 + 75 + 21, 26, -(21*(food/100)), 0, 0, 26, -(21*(food/100)), "arquivos/fome.png", 0, 0, 0, tocolor(255,255,255,250))
	dxDrawImageSection(screenW - 328 - 10 + 97, 10 + 75 + 25, 27, -(25*(drink/100)), 0, 0, 27, -(25*(drink/100)), "arquivos/sede.png", 0, 0, 0, tocolor(255,255,255,250))
	dxDrawImageSection(screenW - 328 - 10 + 136, 10 + 75 + 24, 22, -(24*(armor/100)), 0, 0, 22, -(24*(armor/100)), "arquivos/colete.png", 0, 0, 0, tocolor(255,255,255,250))

	dxDrawImage(screenW - 328 - 10 + 183, 10 + 60, 128, 64, "arquivos/armas/"..getPedWeapon(getLocalPlayer())..".png", 0, 0, 0, tocolor(255,255,255,250))
	
    dxDrawText ( "Vdb", screenW - 310 - 10 - 10, 10 + 5, 20, 20, tocolor ( 255, 255, 255, 255 ), 1, font )
    dxDrawText ( "Gaming", screenW - 289 - 10 - 10, 10 + 5, 20, 20, tocolor ( 66, 139, 202,255 ), 1, font )
	
	dxDrawImage(screenW - 328 - 10 + 183, 10 + 105, 9, 11, "arquivos/ammo.png", 0, 0, 0, tocolor(255,255,255,250))
	
	if(isCursorShowing()) then
	XY = {guiGetScreenSize()}
	local cursorX, cursorY = getCursorPosition()
	cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
	if(dobozbaVan(rectangleData.x, rectangleData.y, rectangleData.width, rectangleData.height, cursorX, cursorY)) then
		dxDrawImage(screenW - 333 - 10 + 10, 77 + 40, 162, 40, "arquivos/loja_diamantes.png", 0, 0, 0, tocolor(255,255,255,250))
		
	else
		dxDrawImage(screenW - 333 - 10 + 10, 77 + 40, 162, 40, "arquivos/loja_diamantes_back.png", 0, 0, 0, tocolor(255,255,255,255))
	end
	else
	dxDrawImage(screenW - 333 - 10 + 10, 77 + 40, 162, 40, "arquivos/loja_diamantes_back.png", 0, 0, 0, tocolor(255,255,255,255))
	end
	
	if(isCursorShowing()) then
	XY = {guiGetScreenSize()}
	local cursorX, cursorY = getCursorPosition()
	cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
	if(dobozbaVan(pdudata.x, pdudata.y, pdudata.width, pdudata.height, cursorX, cursorY)) then
		dxDrawImage(screenW -72 - 10, 13, 15, 15, "arquivos/panel1.png", 0, 0, 0, tocolor(255,255,255,250))
		
	else
		dxDrawImage(screenW -72 - 10, 13, 15, 15, "arquivos/panel0.png", 0, 0, 0, tocolor(255,255,255,250))
	end
	else
	dxDrawImage(screenW -72 - 10, 13, 15, 15, "arquivos/panel0.png", 0, 0, 0, tocolor(255,255,255,250))
	end
	
	
	
	
		
	local t = getRealTime()
	local nome = getElementData(getLocalPlayer(), "AccountData:Name") or "Desconhecido"
	local level = exports.VDBGLevel:checkLevel(getLocalPlayer()) or 0
	dxDrawText ( (t.hour<10 and "0"..t.hour or t.hour)..":"..(t.minute<10 and "0"..t.minute or t.minute)..":"..(t.second<10 and "0"..t.second or t.second), screenW - 328 - 10 + 278, 10 + 4, 20, 20, tocolor ( 255, 255, 255, 255 ), 1, font )
	dxDrawText ( nome.."\nDiamantes: "..(getElementData(getLocalPlayer(), "VDBG.Diamantes") or 0).."\nLevel: "..level, screenW - 328 - 10 + 50, 10 + 25, 20, 20, tocolor ( 255, 255, 255, 255 ), 1, font )
	if(getPedWeapon(getLocalPlayer())==0 or getPedWeapon(getLocalPlayer())==1 or getPedWeapon(getLocalPlayer())==2 or getPedWeapon(getLocalPlayer())==3 or getPedWeapon(getLocalPlayer())==4 or getPedWeapon(getLocalPlayer())==5 or getPedWeapon(getLocalPlayer())==6 or getPedWeapon(getLocalPlayer())==7 or getPedWeapon(getLocalPlayer())==8)then
		dxDrawText ( "Sem armas", screenW - 328 - 10 + 196, 10 + 103, 20, 20, tocolor ( 255, 255, 255, 255 ), 1, font )
	else
		local maxclip = tonumber(getWeaponProperty(getPedWeapon(getLocalPlayer()), "poor", "maximum_clip_ammo") or 1)
		local tolteny = math.ceil((getPedTotalAmmo(getLocalPlayer())-getPedAmmoInClip(getLocalPlayer()))/maxclip)
		local tolteny2 = getPedAmmoInClip(getLocalPlayer())
		dxDrawText ( tolteny2.."/"..tolteny, screenW - 328 - 10 + 196, 10 + 103, 20, 20, tocolor ( 255, 255, 255, 255 ), 1, font )
	end
	local money = getPlayerMoney(getLocalPlayer())
	local money2 = tostring(money)
	local money_text = ""
	
	if(money<-10000000)then
		money_text = "- R$#d9534f"..money2:gsub("%-","")
	elseif(money<-1000000)then
		money_text = "- R$0#d9534f"..money2:gsub("%-","")
	elseif(money<-100000)then
		money_text = "- R$00#d9534f"..money2:gsub("%-","")
	elseif(money<-10000)then
		money_text = "- R$000#d9534f"..money2:gsub("%-","")
	elseif(money<-1000)then
		money_text = "- R$0000#d9534f"..money2:gsub("%-","")
	elseif(money<-100)then
		money_text = "- R$00000#d9534f"..money2:gsub("%-","")
	elseif(money<-10)then
		money_text = "- R$000000#d9534f"..money2:gsub("%-","")
	elseif(money<-0)then
		money_text = "- R$0000000#d9534f"..money2:gsub("%-","")
	elseif(money==0)then
		money_text = "R$0000000"..money2:gsub("%-","")
		

	elseif(money<10)then
		money_text = "R$0000000#44CC44"..money2:gsub("%-","")
	elseif(money<100)then
		money_text = "R$000000#44CC44"..money2:gsub("%-","")
	elseif(money<1000)then
		money_text = "R$00000#44CC44"..money2:gsub("%-","")
	elseif(money<10000)then
		money_text = "R$0000#44CC44"..money2:gsub("%-","")
	elseif(money<100000)then
		money_text = "R$000#44CC44"..money2:gsub("%-","")
	elseif(money<1000000)then
		money_text = "R$00#44CC44"..money2:gsub("%-","")
	elseif(money<10000000)then
		money_text = "R$0#44CC44"..money2:gsub("%-","")
	elseif(money<100000000)then
		money_text = "R$#44CC44"..money2:gsub("%-","")
	end


	dxDrawText ( money_text, screenW - 328 - 10, 10 + 128, screenW - 328 - 10 + 315, 20, tocolor ( 255, 255, 255, 255 ), 1.5, "Arial", "right", "top", false, false, false, true )
	
	wanted = getPlayerWantedLevel (getLocalPlayer())
	if wanted > 0 then
	if wanted == wanted then
	dxDrawImage(screenW - 538 - 10 + 300, 10 + 160, 291,28, "arquivos/"..wanted..".png", 0, 0, 0, tocolor(255,255,255,250))
	end
	end
	
end)
addEventHandler("onClientResourceStart", resourceRoot, function()
	for id, hudComponents in ipairs(hudTable) do
		showPlayerHudComponent(hudComponents, false)
	end
end)


 
addEventHandler ( "onClientClick", root, function ( _, _, x, y )
	if(getElementData(getLocalPlayer(), "opendashboard") or false) then return end
	if(getElementData(getLocalPlayer(), "hudstate") or false) then return end
	if(getElementData(getLocalPlayer(), "logado") == false ) then return end
	if (not exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
    if ( x >= rectangleData.x and x <= rectangleData.x + rectangleData.width and y >= rectangleData.y and y <= rectangleData.y + rectangleData.height ) then
       clicandonomenu()
    end
end )


addEventHandler ( "onClientClick", root, function ( _, _, x, y )
	if(getElementData(getLocalPlayer(), "opendashboard") or false) then return end
	if(getElementData(getLocalPlayer(), "hudstate") or false) then return end
	if(getElementData(getLocalPlayer(), "logado") == false ) then return end
	if (not exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
    if ( x >= pdudata.x and x <= pdudata.x + pdudata.width and y >= pdudata.y and y <= rectangleData.y + pdudata.height ) then
       exports.VDBGPDU:clicandonomenu()
    end
end )




function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end