--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Taser' - resource for MTA: San Andreas                     ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Falke
]]

local cFunc = {}
local cSetting = {}

cSetting["shots"] = {}
cSetting["shot_calcs"] = {}
local last_shot = 1
-- FUNCTIONS --

--[[
cFunc["render_shots"] = function()
	for index, tbl in pairs(cSetting["shots"]) do
		dxDrawFuckedLine3D(tbl[1], tbl[2], tbl[3], tbl[4], tbl[5], tbl[6], tocolor(0, 255, 0))
	end
end]]

cFunc["draw_shot"] = function(x1, y1, z1, x2, y2, z2)
	table.insert(cSetting["shots"], last_shot, {x1, y1, z1, x2, y2, z2})
	-- SHOT CALCULATING 
	local lastx, lasty, lastz = x1, y1, z1
	local dis = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
	cSetting["shot_calcs"][last_shot] = {}
	
	for i = 1, dis, 0.5 do
	--	cSetting["shot_calcs"][i] = nx, ny, nz
	--	cSetting["shot_calcs"][last_shot][i] =
	end
	last_shot = last_shot+1
end

cFunc["shot_weapon"] = function(hitX, hitY, hitZ, x, y, z)
	playSound3D("data/Fire.wav", x, y, z)
	local s = playSound3D("data/Fire.wav", hitX, hitY, hitZ)
	setSoundMaxDistance(s, 50)
	for i = 1, 5, 1 do
		fxAddPunchImpact(hitX, hitY, hitZ, 0, 0, 0)
		fxAddSparks(hitX, hitY, hitZ, 0, 0, 0, 8, 1, 0, 0, 0, true, 3, 1)
	end
	cFunc["draw_shot"](x, y, z, hitX, hitY, hitZ)
	fxAddPunchImpact(x, y, z, 0, 0, -3)
end

cFunc["wait_shot"] = function()
	toggleControl("fire", false)
	setTimer(function()
		toggleControl("fire", true)
	end, 350, 1)
end

cFunc["shot_check"] = function(wp, _, _, hitX, hitY, hitZ, element, startX, startY, startZ)
	if(wp == 23) then
		cFunc["shot_weapon"](hitX, hitY, hitZ, startX, startY, startZ)  
		if(source == localPlayer) then
			cFunc["wait_shot"]()
		end
	end
end

dxDrawFuckedLine3D = function(x1, y1, z1, x2, y2, z2, color)
	local dis = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
	local lastx, lasty, lastz = x1, y1, z1
	for i = 1, dis, 3 do
		dxDrawLine3D(x1, y1, z1, x2, y2, z2)
	end
end

cFunc["anim_check"] = function(_, wep, bodypart)
	if(wep == 23)  and (bodypart == 9) then
		setPedAnimation(source, "ped", "KO_shot_face", 10000, false, true, false)
	elseif(wep == 23)  and (bodypart == 8) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 23)  and (bodypart == 7) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 23)  and (bodypart == 6) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 23)  and (bodypart == 5) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 23)  and (bodypart == 4) then
		setPedAnimation(source, "CRACK", "crckdeth3", 10000, false, true, false)
	elseif(wep == 23)  and (bodypart == 3) then
		setPedAnimation(source, "ped", "KO_shot_stom", 10000, false, true, false)
	elseif(wep == 23)  and (bodypart == 2) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)
	elseif(wep == 23)  and (bodypart == 1) then
		setPedAnimation(source, "CRACK", "crckdeth2", 10000, false, true, false)

	end
end

-- EVENT HANDLER --

addEventHandler("onClientPlayerWeaponFire", getRootElement(), cFunc["shot_check"])
addEventHandler("onClientRender", getRootElement(), cFunc["render_shots"])
addEventHandler("onClientPedDamage", getRootElement(),cFunc["anim_check"])
addEventHandler("onClientPlayerDamage", getRootElement(),cFunc["anim_check"])