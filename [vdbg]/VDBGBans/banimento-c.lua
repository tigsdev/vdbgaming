------------------------------------------
-- 		 Contas Banidas					--
------------------------------------------
-- Script by: Tiago Santos  (Galego)	--
-- Arquivo: banimento-c.lua	 		    --
-- Copyright 2015 (C) Tiago Santos		--
-- Todos os direitos reservados.		--
------------------------------------------
local ban = nil

local sx, sy = guiGetScreenSize ( )
local rsx, rsy = sx, sy
local sx, sy = sx/1280, sy/960
local open = false
local banY = -(rsy/1.2)

local font_size =(sx+sy)

function drawBanScreen ( )
	if not startTime then
		startTime = getTickCount ( )
	end if not endTime then 
		endTime = getTickCount ( ) + 3500
	end
	local now = getTickCount()
	local elapsedTime = now - startTime
	local duration = endTime - startTime
	local progress = elapsedTime / duration
	local _, y, _ = interpolateBetween ( 0, -(rsy/1.3), 0, 0, 0, 0,  progress, "OutBack" )
	banY = y
	
	
	dxDrawRectangle(sx*250, banY+sy*189, sx*750, sy*470, tocolor(0, 0, 0, 138), false)
	--bordatopo
	dxDrawRectangle(sx*250, banY+sy*185, sx*750, 5, tocolor(0, 0, 0, 255), true)
	--esquerda
	dxDrawRectangle(sx*245, banY+sy*185, 5, sy*475, tocolor(0, 0, 0, 255), true)
	--bordadireita
	dxDrawRectangle(sx*1000, banY+sy*185, 5, sy*475, tocolor(0, 0, 0, 255), true)
	--bordarodape
	dxDrawRectangle(sx*245, banY+sy*660, sx*761, 5, tocolor(0, 0, 0, 255), true)
	
	dxDrawColorText ( "#2F7CCCVDB#ffffffGaming", 0, banY+sy*320, sx*1280, banY+sy*98, tocolor(255, 0, 0, 255), 2, "default-bold", "center", "center", true, true, true, true, true)
	dxDrawColorText ( "#d9534fOops! #ffffffNosso sistema detectou que você foi banido recentemente!", 0, banY+sy*380, sx*1280, banY+sy*98, tocolor(255, 0, 0, 255), 1.3, "default", "center", "center", true, true, true, true, true)
	
	dxDrawRectangle(sx*260, banY+sy*260, sx*730, 2, tocolor(255, 255, 255, 138), false)
	
	--[[SEPARACAO                   ]]
	dxDrawRectangle(sx*250, banY+sy*280, sx*750, sy*40, tocolor(0, 0, 0, 210), false)
	
	dxDrawColorText("#2F7CCCBanido por: #ffffff"..ban.banner, sx*440, banY+sy*370, sx*812, banY+sy*229, tocolor(255, 255, 255, 255), font_size, "default", "center", "center", true, true, true, true, true)
	
	--[[SEPARACAO                   ]]
	dxDrawRectangle(sx*250, banY+sy*330, sx*750, sy*40, tocolor(0, 0, 0, 210), false)
	
	dxDrawColorText("#2F7CCCRasão: #ffffff"..ban.reason, sx*440, banY+sy*470, sx*812, banY+sy*229, tocolor(255, 255, 255, 255), font_size, "default", "center", "center", true, true, true, true, true)
	
	--[[SEPARACAO                   ]]
	dxDrawRectangle(sx*250, banY+sy*380, sx*750, sy*40, tocolor(0, 0, 0, 210), false)
	
	dxDrawColorText("#2F7CCCData do ban: #ffffff"..ban.banned_on, sx*440, banY+sy*570, sx*812, banY+sy*229, tocolor(255, 255, 255, 255), font_size, "default", "center", "center", true, true, true, true, true)
	
	--[[SEPARACAO                   ]]
	dxDrawRectangle(sx*250, banY+sy*430, sx*750, sy*40, tocolor(0, 0, 0, 210), false)
	
	dxDrawColorText("#2F7CCCData de expiração: #ffffff"..ban.unban, sx*440, banY+sy*670, sx*812, banY+sy*229, tocolor(255, 255, 255, 255), font_size, "default", "center", "center", true, true, true, true, true)
	
	--[[SEPARACAO                   ]]
	dxDrawRectangle(sx*250, banY+sy*480, sx*750, sy*40, tocolor(0, 0, 0, 210), false)
	
	dxDrawColorText("#2F7CCCSerial: #ffffff"..ban.serial, sx*440, banY+sy*770, sx*812, banY+sy*229, tocolor(255, 255, 255, 255), font_size, "default", "center", "center", true, true, true, true, true)
	
	--[[SEPARACAO                   ]]
	dxDrawRectangle(sx*250, banY+sy*530, sx*750, sy*40, tocolor(0, 0, 0, 210), false)
	
	dxDrawColorText("#2F7CCCLogin do Jogador: #ffffff"..ban.account, sx*440, banY+sy*870, sx*812, banY+sy*229, tocolor(255, 255, 255, 255), font_size, "default", "center", "center", true, true, true, true, true)
	
	dxDrawRectangle(sx*250, banY+sy*600, sx*750, sy*60, tocolor(0, 0, 0, 210), false)

	dxDrawColorText ( "#ffffffSite @ www.vdbg.org", 0, banY+sy*1160, sx*1280, banY+sy*98, tocolor(255, 0, 0, 255), 2.5, "default", "center", "center", true, true, true, true, true)
	
	
	--[[
	dxDrawRectangle(sx*87, banY+sy*189, sx*152, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText("Serial", sx*103, banY+sy*189, sx*239, banY+sy*229, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	dxDrawRectangle(sx*249, banY+sy*189, sx*563, sy*40, tocolor(0, 0, 0, 138), true)
	
	
	dxDrawRectangle(sx*87, banY+sy*249, sx*152, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText("IP", sx*103, banY+sy*249, sx*239, banY+sy*289, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	dxDrawRectangle(sx*249, banY+sy*249, sx*563, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText(ban.ip, sx*259, banY+sy*249, sx*812, banY+sy*289, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	
	dxDrawRectangle(sx*87, banY+sy*309, sx*152, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText("Conta", sx*103, banY+sy*309, sx*239, banY+sy*349, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	dxDrawRectangle(sx*249, banY+sy*309, sx*563, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText(ban.account, sx*259, banY+sy*309, sx*812, banY+sy*349, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	
	dxDrawRectangle(sx*87, banY+sy*369, sx*152, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText("Até", sx*103, banY+sy*369, sx*239, banY+sy*409, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	dxDrawRectangle(sx*249, banY+sy*369, sx*563, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText(ban.unban, sx*259, banY+sy*369, sx*812, banY+sy*409, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	
	dxDrawRectangle(sx*87, banY+sy*429, sx*152, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText("Banido em", sx*103, banY+sy*429, sx*239, banY+sy*469, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	dxDrawRectangle(sx*249, banY+sy*429, sx*563, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText(ban.banned_on, sx*259, banY+sy*429, sx*812, banY+sy*469, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	
	dxDrawRectangle(sx*87, banY+sy*489, sx*152, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText("Banido por", sx*103, banY+sy*489, sx*239, banY+sy*529, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	dxDrawRectangle(sx*249, banY+sy*489, sx*563, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText(ban.banner, sx*259, banY+sy*489, sx*812, banY+sy*529, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	
	dxDrawRectangle(sx*87, banY+sy*549, sx*152, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText("Razão", sx*103, banY+sy*549, sx*239, banY+sy*589, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	dxDrawRectangle(sx*249, banY+sy*549, sx*563, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText(ban.reason, sx*259, banY+sy*549, sx*812, banY+sy*589, tocolor(255, 255, 255, 255), font_size, "default", "left", "center", true, false, true, false, false)
	
	
	dxDrawRectangle(sx*87, banY+sy*609, sx*725, sy*40, tocolor(0, 0, 0, 138), true)
	dxDrawText("Peça um desbanimento em nosso fórum: www.vdbg.org", sx*87, banY+sy*609, sx*812, banY+sy*649, tocolor(255, 255, 255, 255), 1, "default", "center", "center", true, false, true, false, false)
]]
end

addEvent ( "VDBGBans:OpenClientBanScreen", true )
addEventHandler ( "VDBGBans:OpenClientBanScreen", root, function ( d )
	ban = d
	if ( tonumber ( ban.unban_month ) and tonumber ( ban.unban_month ) < 10 )  then
		ban.unban_month = "0"..ban.unban_month
	end if ( tonumber ( ban.unban_day ) and tonumber ( ban.unban_day ) < 10 )  then
		ban.unban_day = "0"..ban.unban_day
	end

	ban.unban = table.concat ({ tostring(ban.unban_year), tostring(ban.unban_month), tostring(ban.unban_day) }, "-" )
	if ( tostring ( ban.unban ):upper() == "NIL" ) then
		ban.unban = "Forever"
	end
	
	if open then return end
	open = true
	addEventHandler ( "onClientPreRender", root, drawBanScreen )
end )




function dxDrawBoarderedText ( text, x, y, endX, endY, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	local text = tostring ( text )
	local x = tonumber(x) or 0
	local y = tonumber(y) or 0
	local endX = tonumber(endX) or x
	local endY = tonumber(endY) or y
	local color = color or tocolor ( 255, 255, 255, 255 )
	local size = tonumber(size) or 1
	local font = font or "default"
	local alignX = alignX or "left"
	local alignY = alignY or "top"
	local clip = clip or false
	local wordBreak = wordBreak or false
	local postGUI = postGUI or false
	local colorCode = colorCode or false
	local subPixelPos = subPixelPos or false
	local fRot = tonumber(fRot) or 0
	local fRotCX = tonumber(fRotCX) or 0
	local fRotCY = tonumber(fRotCy) or 0
	local offSet = tonumber(offSet) or 1
	local t_g = text:gsub ( "#%x%x%x%x%x%x", "" )
	dxDrawText ( t_g, x-offSet, y-offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x-offSet, y, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x, y-offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x+offSet, y+offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x+offSet, y, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x, y+offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	return dxDrawText ( text, x, y, endX, endY, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
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