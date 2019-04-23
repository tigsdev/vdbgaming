------------------------------------------
-- 		 	  DX INFO DE NASCER			--
------------------------------------------
-- Script by: Tiago Santos  (Galego)	--
-- Arquivo: nascer-c.lua	  		    --
-- Copyright 2015 (C) Tiago Santos		--
-- Todos os direitos reservados.		--
------------------------------------------

local data = nil
local dead = false
local sx, sy = guiGetScreenSize ( )
local hospitals = { }
local enabled_cam = false
local lastCamTick = 0
local img, oldFilmShader = false
lastCamTick = getTickCount ()
local a = 255

addEvent ( 'VDBGHospitals:onClientWasted', true )
addEventHandler ( 'VDBGHospitals:onClientWasted', root, function ( d )
	dead = true
	data = d
	l_tick = getTickCount ( )
	ind = 0
	rec_y = sy
	moveMode = true
	drawRec = false
	addEventHandler ( 'onClientRender', root, dxDrawRespawnMenu )
	showChat ( false )
	setElementInterior ( localPlayer, 0 )
	setElementDimension ( localPlayer, 0 )
end )

function dxDrawRespawnMenu ( )
	if ( ind == 0 and getTickCount ( ) - l_tick >= 2000 ) then
		fadeCamera ( false )
		ind = ind + 1
	elseif ( ind == 1 and getTickCount ( ) - l_tick >= 5500 ) then
		ind = ind + 1
		fadeCamera ( true )
		setCameraMatrix ( data[5], data[6], data[7], data[2], data[3], data[4] )
		drawRec = true
	elseif ( ind == 2 and getTickCount ( ) - l_tick >= 10000 ) then
		ind = ind + 1
		moveMode = false
		fadeCamera ( false )
	elseif ( ind == 3 and getTickCount ( ) - l_tick >= 11500 ) then
		triggerServerEvent ( "VDBGHospitals:triggerPlayerSpawn", localPlayer, data )
		fadeCamera ( true )
		setCameraTarget ( localPlayer )
		removeEventHandler ( "onClientRender", root, dxDrawRespawnMenu )
		lastCamTick = getTickCount ()
		enabled_cam = true
		drawRec=false
		moveMode=true
		rec_y = sy
		ind = 0
		
		dead = false
	end
	
	if ( drawRec ) then
		dxDrawRectangle ( 0, rec_y, sx, ( sy / 8 ), tocolor ( 0, 0, 0, 255 )  )
		dxDrawText ( data[1], 0, rec_y, sx, rec_y + ( sy / 8 ), tocolor ( 255, 255, 255, 255 ), 3, 'default-bold', 'center', 'center' )
		
		if ( moveMode ) then
			if ( rec_y > sy - ( sy / 8 ) ) then
				rec_y = rec_y - 3
			else
				rec_y = sy - ( sy / 8 )
			end
		else
			if ( rec_y < sy ) then
				rec_y = rec_y + 3
			end
		end
	end
end

local x,y,z = 0,0,0
function upCam ()
	if enabled_cam then
		local cTick = getTickCount ()
		local delay = cTick - lastCamTick
		local duration = 2000
		local easing = "Linear"
		if duration and easing then
			local progress = delay/duration
			if progress < 1 then
				x,y,z = getElementPosition( localPlayer )
				local cx,cy,cz = interpolateBetween (
					x,y,342.13180541992,
					x,y,z,
					progress,easing
				)
				local tx,ty,tz = interpolateBetween (
					x,y,341.13180541992,
					x,y,z-1.0,
					progress,easing
				)
				setCameraMatrix (cx,cy,cz,tx,ty,tz)
			else
				lastCamTick = getTickCount ()
				enabled_cam = false
				setCameraTarget (getLocalPlayer(), getLocalPlayer())
				fadeCamera(false, 0.01)
				setTimer(fadeCamera, 500, 1, true, 1)
				showChat ( true )
			end
			if(a>0)then
				a = a-1
			end
		end
	end
end
addEventHandler ("onClientRender",getRootElement(),upCam)


function isClientDead ( )
	return dead
end

addEvent ( "VDBGHospitals:onServerSendClientLocRequest", true )
addEventHandler ( "VDBGHospitals:onServerSendClientLocRequest", root, function ( hos )
	hospitals = hos
end )

addEvent ( "onClientPlayerLogin", true )
addEventHandler ( "onClientPlayerLogin", root, function ( )
	local mBlips = exports.VDBGPhone:getSetting ( "usersetting_display_hospitalblips" )
	if ( mBlips ) then
		blips = { }
		for i, v in pairs ( hospitals ) do
			local x, y, z = v[4], v[5], v[6]
			blips[i] = createBlip ( x, y, z, 22, 2, 255, 255, 255, 255, 0, 450 )
		end
	end
end )

addEvent ( "onClientUserSettingChange", true )
addEventHandler ( "onClientUserSettingChange", root, function ( set, to ) 
	if ( set == "usersetting_display_hospitalblips" ) then
		if ( to and not blips ) then
			blips =  { }
			for i, v in pairs ( hospitals ) do
				local x, y, z = v[4], v[5], v[6]
				blips[i] = createBlip ( x, y, z, 22, 2, 255, 255, 255, 255, 0, 450 )
			end
		elseif ( not to and blips ) then
			for i, v in pairs ( blips ) do
				destroyElement ( v )
			end
			blips = nil
		end
	end
end )


triggerServerEvent ( "VDBGHospitals:onClientRequestLocations", localPlayer )