--------------
--by MazzMan
--------------

local distance = 75 --distance from where you can hear the shot
local explostionDistance = 150

local cSoundsEnabled = true
local reloadSoundEnabled = true
local explosionEnabled = true

--shoot sounds
function playSounds(weapon, ammo, ammoInClip)
	if(cSoundsEnabled)then
		local x,y,z = getElementPosition(source)
		if weapon == 31 then --m4
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/m4.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/m4.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 22 then --pistol
			if(ammoInClip == 0 and reloadSoundEnabled)then
				pistolReload("sounds/weapon/pistole.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/pistole.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 24 then --deagle
			if(ammoInClip == 0 and reloadSoundEnabled)then
				pistolReload("sounds/weapon/deagle.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/deagle.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 25 or weapon == 26 or weapon == 27 then --shotguns
			if(weapon == 25)then
				local sound = playSound3D("sounds/weapon/shotgun.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
				shotgunReload(x,y,z)
			else
				local sound = playSound3D("sounds/weapon/shotgun.wav", x,y,z)
				local shellSound = playSound3D("sounds/reload/shotgun_shell.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 28 then --uzi
			if(ammoInClip == 0)then						
				mgReload("sounds/weapon/uzi.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/uzi.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 29 then --mp5
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/mp5.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/mp5.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 32 then --tec-9
			if(ammoInClip == 0)then						
				tec9Reload(x,y,z)
			else
				local sound = playSound3D("sounds/weapon/tec-9.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 30 then --ak
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/ak.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/ak.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 33 or weapon == 34 then --snipers
			local sound = playSound3D("sounds/weapon/sniper.wav", x,y,z)
			setSoundMaxDistance(sound, distance)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", getRootElement(), playSounds)

--reload sounds
function mgReload(soundPath, x,y,z)
	local sound = playSound3D(soundPath, x,y,z)
	setSoundMaxDistance(sound, distance)
				
	local clipinSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	end, 1250, 1)
end

function tec9Reload(x,y,z)
	local sound = playSound3D("sounds/weapon/tec-9.wav", x,y,z)
	setSoundMaxDistance(sound, distance)
				
	local clipinSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	end, 1000, 1)
end

function pistolReload(soundPath, x,y,z)
	local sound = playSound3D(soundPath, x,y,z)
	setSoundMaxDistance(sound, distance)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/pistol_reload.wav", x,y,z)
	end, 500, 1)
end

function shotgunReload(x,y,z)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/shotgun_reload.wav", x,y,z)
		local shellSound = playSound3D("sounds/reload/shotgun_shell.wav", x,y,z)
	end, 500, 1)
end

--explosion sounds
addEventHandler("onClientExplosion", getRootElement(), function(x,y,z, theType)
	if(explosionEnabled)then
		if(theType == 0)then--Grenade
			local explSound = playSound3D("sounds/explosion/explosion1.wav", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		elseif(theType == 4 or theType == 5 or theType == 6 or theType == 7)then --car, car quick, boat, heli
			local explSound = playSound3D("sounds/explosion/explosion3.wav", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		end
	end
end)


--window etc.
local screenX, screenY = guiGetScreenSize()
function optionsWindow()
	--outputChatBox("Custom sounds by MazzMan", 255, 196, 0)
	--outputChatBox("Type in /csound to open the options window", 255, 196, 0)
		
	cSoundsWindow = guiCreateWindow(screenX-220, screenY-200, 200, 150, "Custom sounds - Options", false)
	checkBoxEnableCSounds = guiCreateCheckBox(10, 20, 200, 20, "Enable shoot sounds", cSoundsEnabled, false, cSoundsWindow)
	checkBoxEnableRelSounds = guiCreateCheckBox(10, 50, 200, 20, "Enable reload sounds", reloadSoundEnabled, false, cSoundsWindow)
	checkBoxEnableExplSounds = guiCreateCheckBox(10, 80, 200, 20, "Enable explosion sounds", explosionEnabled, false, cSoundsWindow)
	btnCloseCSoundsWindow = guiCreateButton(10, 110, 280, 30, "Close", false, cSoundsWindow)
	
	addEventHandler("onClientGUIClick", checkBoxEnableCSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableCSounds))then
				cSoundsEnabled = true
			else
				cSoundsEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", checkBoxEnableRelSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableRelSounds))then
				reloadSoundEnabled = true
			else
				reloadSoundEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", checkBoxEnableExplSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableExplSounds))then
				explosionEnabled = true
			else
				explosionEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", btnCloseCSoundsWindow, closeCSoundsWindow, false)
	
	guiSetVisible(cSoundsWindow, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), optionsWindow)

function closeCSoundsWindow()
	if(guiGetVisible(cSoundsWindow))then
		guiSetVisible(cSoundsWindow, false)
		showCursor(false)
	else
		guiSetVisible(cSoundsWindow, true)
		showCursor(true)
	end	
end
--addCommandHandler("csound", closeCSoundsWindow)





