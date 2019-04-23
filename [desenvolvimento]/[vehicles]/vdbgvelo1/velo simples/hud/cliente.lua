
local theTimer2 = nil
local myfont4 = dxCreateFont( "hud/logo.ttf", 15 )
local myfont3 = dxCreateFont( "hud/font2.ttf", 15 )
local myfont2 = dxCreateFont( "hud/font2.ttf", 15 )
local myfont = dxCreateFont( "hud/font.ttf", 15 )
local screenX, screenY = guiGetScreenSize()
local color1 = tocolor( 0, 106, 255, 255 )
local color2 = tocolor( 86, 152, 226, 255)
local color3 = tocolor( 63, 145, 213, 255 )
local color4 = tocolor( 247, 148, 29 )
local color5 = tocolor( 239, 239, 239, 255 )


sWidth, sHeight = guiGetScreenSize() -- Getting the screen size

local pegasetalogado = false
setTimer ( function ( )
	pegasetalogado = exports.VDBGLogin:isClientLoggedin ( )
end, 1000, 1 )

addEvent ( "onClientPlayerLogin", true )
addEventHandler ( "onClientPlayerLogin", root, function ( )
	pegasetalogado = true
end )

    function VDBGHUD ()
		if ( pegasetalogado ) then
		

			local scx, scy = guiGetScreenSize()
			local x, y = scx-193 - 47, 10
							
			
			
			local xy = scx -250
			local xx = scx - 373
			dxDrawImage(xx, 30, 361, 145, "hud/hud.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
			---icons---
			local xc = scx -270
			local xp = scx -270
			dxDrawImage(xc, 55, 74, 36, "hud/health.png", 0, 0, 0, tocolor(86, 152, 226, 255), false)
			dxDrawImage(xp, 73,74,36, "hud/armour.png", 0, 0, 0, tocolor(247, 148, 29, 255), false)
			dxDrawImage(xp, 95,67,30, "hud/h2o.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			
			local hours = getRealTime().hour
			local minutes = getRealTime().minute
			local seconds = getRealTime().second
	
			dxDrawText(hours..":"..minutes..":"..seconds, xx + 275,39.60, 500, 500, tocolor(255,255,255,255),0.7,myfont)
			
			local exps = (getElementData(localPlayer, "XP") or "0") 
			local nive = (getElementData(localPlayer, "LVL") or "0") 
			local upar = (getElementData(localPlayer, "LVLUP") or "0")
			local limite = 0.485
			
			
			
			
			dxDrawImage(xx, 170, 361, 44, "hud/level.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
			dxDrawImage(xx + 21, 194.5, (exps/upar)*xx*limite, 10, "hud/progresso.png",0,0,0,tocolor(92,184,92,255))
			dxDrawColorText( "" ..  nive.."  |  "..exps.."/" ..upar, xx + 20, 175, 400, 400, tocolor(255,255,255,255), 1, "default","left","top",false,false,false) 
			local xx = scx - 300
			local weapon = getPedWeapon(getLocalPlayer())
			
			if weapon > 0 then
				local xx = scx - 335
				 playerAmmo = getPedTotalAmmo ( getLocalPlayer() )
				 playerAmmo2 = getPedTotalAmmo( getLocalPlayer() ) - getPedAmmoInClip( getLocalPlayer() )
				 playerAmmoc = getPedAmmoInClip ( getLocalPlayer() )
                dxDrawText( playerAmmo2 .. " | " .. playerAmmoc,xx,98.5, xx, 60, tocolor(255,255,255,255),1.0 ,"")
			    
			end
			
			local playerHealth = getElementHealth ( getLocalPlayer() )
			playerHealth = playerHealth * 1.70
			if playerHealth > 170 then
				playerHealth = 170
			end	
			
			dxDrawRectangle(x+24.6,y+58,playerHealth,9,color2,false)	

			local xx, yy = scx-193 - 47, 29
			
			local armor = getPedArmor ( getLocalPlayer() )
			if armor > 0 then
			local xx, yy = scx-210 - 47,62 + 19
				armor = armor * 1.70
				if armor > 170 then
					armor = 170
				end
				dxDrawRectangle(xx+41.6,yy+3.8,armor,9,color4,false)
			end
			
			local h0 = math.floor( getPedOxygenLevel( localPlayer ))
			h0 = h0 / 10
		
	if h0 < 100 then
		
			local xx, yy = scx-210 - 47,62 + 19
			local yo = 70
			dxDrawRectangle(xx+41.6,yy+21,h0*1.7,9,color5,false)	
			end 
		
		
		local playerMoney = string.format("%09d", (getPlayerMoney(LOCAL_PLAYER)))      
    

	dxDrawText ("VDBGaming", screenX - 355.5, 38, screenWidth, screenHeight, tocolor (255, 255, 255, 255), 1.0, myfont4,"left","top",false,false,false)
	
	dxDrawText ("R$", screenX - 178.5, 133, screenWidth, screenHeight, tocolor (255,255,255, 255), 1.5, "default-bold","left","top",false,false,false)
	dxDrawColorText (convertMoneyToString(playerMoney), screenX - 150,133, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1.5, "default","left","top",false,false,false)
	
	
	
	
	local wanted = getPlayerWantedLevel (getLocalPlayer())
	local xx, yy = scx-310 - 47, 130 
	dxDrawImage(xx, yy, 25, 25, "hud/img/wanted.png", 0, 0, 0, tocolor(100, 100, 100, 255), false)
	dxDrawImage(xx + 29, yy, 25, 25, "hud/img/wanted.png", 0, 0, 0, tocolor(100, 100, 100, 255), false)
	dxDrawImage(xx + 54, yy, 25, 25, "hud/img/wanted.png", 0, 0, 0, tocolor(100, 100, 100, 255), false)
	dxDrawImage(xx + 79, yy, 25, 25, "hud/img/wanted.png", 0, 0, 0, tocolor(100, 100, 100, 255), false)
	dxDrawImage(xx + 104, yy, 25, 25, "hud/img/wanted.png", 0, 0, 0, tocolor(100, 100, 100, 255), false)
	dxDrawImage(xx + 129, yy, 25, 25, "hud/img/wanted.png", 0, 0, 0, tocolor(100, 100, 100, 255), false)
	
	if wanted == 1 then
	
	dxDrawImage(xx, yy, 25, 25, "hud/img/wanted_a.png") -- star 01	
	
	elseif wanted == 2 then
	dxDrawImage(xx, yy, 25, 25, "hud/img/wanted_a.png") -- star 01
	dxDrawImage(xx + 29, yy, 25, 25, "hud/img/wanted_a.png") -- star 02

	elseif wanted == 3 then
	dxDrawImage(xx, yy, 25, 25, "hud/img/wanted_a.png") -- star 01
	dxDrawImage(xx + 29, yy, 25, 25, "hud/img/wanted_a.png") -- star 02
	dxDrawImage(xx + 54, yy, 25, 25, "hud/img/wanted_a.png") -- star 03
		
	elseif wanted == 4 then
	dxDrawImage(xx, yy, 25, 25, "hud/img/wanted_a.png") -- star 01
	dxDrawImage(xx + 29, yy, 25, 25, "hud/img/wanted_a.png") -- star 02
	dxDrawImage(xx + 54, yy, 25, 25, "hud/img/wanted_a.png") -- star 03 
	dxDrawImage(xx + 79, yy, 25, 25, "hud/img/wanted_a.png") -- star 04
	
	elseif wanted == 5 then
	dxDrawImage(xx, yy, 25, 25, "hud/img/wanted_a.png") -- star 01
	dxDrawImage(xx + 29, yy, 25, 25, "hud/img/wanted_a.png") -- star 02
	dxDrawImage(xx + 54, yy, 25, 25, "hud/img/wanted_a.png") -- star 03 
	dxDrawImage(xx + 79, yy, 25, 25, "hud/img/wanted_a.png") -- star 04
	dxDrawImage(xx + 104, yy, 25, 25, "hud/img/wanted_a.png") -- star 05
	
	elseif wanted == 6 then 
	dxDrawImage(xx, yy, 25, 25, "hud/img/wanted_a.png") -- star 01
	dxDrawImage(xx + 29, yy, 25, 25, "hud/img/wanted_a.png") -- star 02
	dxDrawImage(xx + 54, yy, 25, 25, "hud/img/wanted_a.png") -- star 03 
	dxDrawImage(xx + 79, yy, 25, 25, "hud/img/wanted_a.png") -- star 04
	dxDrawImage(xx + 104, yy, 25, 25, "hud/img/wanted_a.png") -- star 05
	dxDrawImage(xx + 129, yy, 25, 25, "hud/img/wanted_a.png") -- star 06

	end

	
		elseif isMainMenuActive() then
			screenWidth, screenHeight = guiGetScreenSize()
			windowWidth, windowHeight = 64, 64
			left = (screenWidth/2) - (windowWidth/2)
			top = (screenHeight/2) - (windowHeight/2) + 40
			dxDrawRectangle (0, 0, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), true )
		else
			screenWidth, screenHeight = guiGetScreenSize()
			x = screenWidth / 2
			y = screenHeight / 2
			windowWidth, windowHeight = 64, 64
			left = (screenWidth/2) - (windowWidth/2)
			top = (screenHeight/2) - (windowHeight/2) + 40
		end
	end
addEventHandler("onClientRender", getRootElement(), VDBGHUD)


function toggleRadar()
	if isVisible then
		addEventHandler("onClientRender", root, VDBGHUD)
		addEventHandler("onClientRender", root, HudGtaV)
	else
		removeEventHandler("onClientRender", root, VDBGHUD)
		removeEventHandler("onClientRender", root, HudGtaV)
	end
	isVisible = not isVisible
end
bindKey ("F4", "down", toggleRadar)
bindKey ("F11", "down", toggleRadar)
addCommandHandler ( "hud", toggleRadar )

-----------
local screenW,screenH = guiGetScreenSize()
local resW, resH = 1280, 720
local x, y =  (screenW/resW), (screenH/resH)

function HudGtaV ( )
if ( pegasetalogado ) then
local sca, scy = guiGetScreenSize()
local xa = sca - 515
dxDrawImage(xa,64, 253, 128, "hud/img/"..getPedWeapon(getLocalPlayer())..".png")
end


end

function toggleRadar()
	if isVisible then
		addEventHandler("onClientRender", root, HudGtaV)
	else
		removeEventHandler("onClientRender", root, HudGtaV)
	end
	isVisible = not isVisible
end



local hudTable = {

"ammo",
"armour",
"clock",
"health",
"weapon",
"wanted",
"money",
"area_name",
"vehicle_name",
"breath",
"clock"
}



addEventHandler("onClientRender", root, HudGtaV)
addEventHandler("onClientResourceStart", resourceRoot,
    function()
	for id, hudComponents in ipairs(hudTable) do
		showPlayerHudComponent(hudComponents, false)
	end
    end
)

addEventHandler("onClientResourceStop", resourceRoot,
    function()
	for id, hudComponents in ipairs(hudTable) do
		showPlayerHudComponent(hudComponents, true)
	end
    end
)
function convertMoneyToString(money)
	local formatted = money
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
		if k==0 then break end
	end
	formatted = ""..tostring(formatted)
	return formatted
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