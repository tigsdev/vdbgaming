local isRender = false
local renderData = nil
local removeIfNotText = 0
local alpha = 5
local pos = -600
local alphaative = true
local posative = true
local roundintro = false
local active1 = true
local enabled_cam_desce = false
local enabled_cam = false
local lastCamTick = 0
local img, oldFilmShader = false
lastCamTick = getTickCount ()
local a = 255
local turfstatus = true
local fonte = dxCreateFont("files/opensans.ttf",15)
local fonteintro = dxCreateFont("files/font_namclans.ttf",25)
local s = {guiGetScreenSize()}
local panel = {}
panel.x, panel.y = (s[1] / 2) - 640, (s[2] /2 ) - 360

addEvent ( "VDBGTurfs:onClientEnterTurfArea", true )
addEventHandler ( "VDBGTurfs:onClientEnterTurfArea", root, function ( info ) 
	renderData = info
	if ( not render ) then
		addEventHandler ( "onClientRender", root, onClientRender )
		render = true	
		alpha = 5
		pos = -600
		alphaative = true
		posative = true
		roundintro = false
		active1 = true
		enabled_cam_desce = false
		enabled_cam = false
		lastCamTick = 0
		img, oldFilmShader = false
		lastCamTick = getTickCount ()
		a = 255
		turfstatus = true
	end
end )

addEvent ( "VDBGTurfs:onClientStartIntro", true )
addEventHandler ( "VDBGTurfs:onClientStartIntro", root, function ( )
	if active1 then
	roundintro = true
	lastCamTick = getTickCount ()
	enabled_cam = true
	active1 = false
	exports.VDBGPDU:toggleElmosas()
	end
end )

addEvent ( "VDBGTurfs:onClientExitTurfArea", true )
addEventHandler ( "VDBGTurfs:onClientExitTurfArea", root, function ( ) 
	isRender = false 
	renderData = nil
	if roundintro then
		exports.VDBGPDU:toggleElmosas()
		alpha = 5
		pos = -600
		alphaative = true
		posative = true
		roundintro = false
		active1 = true
		enabled_cam_desce = false
		enabled_cam = false
		lastCamTick = 0
		img, oldFilmShader = false
		lastCamTick = getTickCount ()
		a = 255
		turfstatus = true
	end
end )

addEvent ( "VDBGTurfs:upadateClientInfo", true )
addEventHandler ( "VDBGTurfs:upadateClientInfo", root, function ( data ) 
	renderData = data
	if ( not render ) then
		addEventHandler ( "onClientRender", root, onClientRender )
		render = true 
		playSound("files/joinprep.mp3")
	end
end )

local _sx, _sy = guiGetScreenSize ( )
local sx, sy = _sx/1280, _sy/720

local attackersProgWidth = 0
local defenderProgWidth = 100
function onClientRender ( )
	if ( not render or not renderData  ) then 
		render = false 
		renderData = nil
		return removeEventHandler ( "onClientRender", root, onClientRender )
	end
	local textturf = "s"
	local data = renderData
	if ( not data.attackers ) then 
		if ( removeIfNotText and removeIfNotText > 20 ) then 
			render = false 
			removeIfNotText = 0
			return 
		end 
		removeIfNotText = removeIfNotText + 1
		return 
	end

	local mode = "prep"
	if ( data.prepProg == 0 and data.attackProg > 0 ) then
		mode = "attack"
		textturf = "  ATACANDO ZONA"
		if active1 then
		triggerEvent ( "VDBGTurfs:onClientStartIntro", localPlayer )
		end
	end 
	
	
	if roundintro then 
	if pos == 0 then
	pos = 0
	posative = false
	end
	
	if posative == true then 
	pos = pos + 5
	end
	
	
	if alpha == 255 then
	alpha = 255
	alphaative = false
	end
	if alphaative == true then 
	alpha = alpha + 5
	end
	
	dxDrawImage( panel.x+470, panel.y+10, 346, 152, "files/logo_clanwar.png",0,0,0,tocolor(255,255,255,alpha),true)
	dxDrawImage( panel.x+330, panel.y+150, 622, 90, "files/menu_clanwar.png",0,0,0,tocolor(255,255,255,alpha),true)
	
	
	dxDrawImage( panel.x+285, panel.y+200, 236, 256, ":VDBGGroups/clanlogos/"..tostring(data.logoclanowner)..".png",0,0,0,tocolor(255,255,255,alpha),true)
	dxDrawText ( tostring ( data.owner ), panel.x+330, panel.y+240+pos, 1230, 650, tocolor ( 255, 255, 255, alpha ), 1, fonteintro, "left", "center" )
	
	dxDrawImage( panel.x+750, panel.y+200, 256, 256, ":VDBGGroups/clanlogos/"..tostring(data.logoclanattackers)..".png",0,0,0,tocolor(255,255,255,alpha),true)
	dxDrawText ( tostring ( data.attackers ), panel.x+790, panel.y+240+pos, 1230, 650, tocolor ( 255, 255, 255, alpha ), 1, fonteintro, "left", "center" )
	
	
	if enabled_cam then
		setElementData(localPlayer,"opendashboard", true)
		turfstatus = false
		setElementFrozen ( getLocalPlayer(), true )
		toggleAllControls ( false )
		local cTick = getTickCount ()
		local delay = cTick - lastCamTick
		local duration = 4000
		local easing = "Linear"
		if duration and easing then
			local progress = delay/duration
			if progress < 1 then
				local x,y,z = getElementPosition( getLocalPlayer() )
				local cx,cy,cz = interpolateBetween (
					x,y,z,
					x,y,342.13180541992,
					progress,easing
				)
				local tx,ty,tz = interpolateBetween (
					x,y,z-1.0,
					x,y,341.13180541992,
					progress,easing
				)
				setCameraMatrix (cx,cy,cz,tx,ty,tz)
			else
				lastCamTick = getTickCount ()
				enabled_cam = false
				enabled_cam_desce = true
				setElementData ( localPlayer, "opendashboard", true )
			end
			if(a>0)then
				a = a-1
			end
		end
	end
	if enabled_cam_desce then
		local cTick = getTickCount ()
		local delay = cTick - lastCamTick
		local duration = 4000
		local easing = "Linear"
		if duration and easing then
			local progress = delay/duration
			if progress < 1 then
				local x,y,z = getElementPosition( getLocalPlayer() )
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
				setCameraTarget (getLocalPlayer(), getLocalPlayer())
				fadeCamera(false, 0.01)
				setTimer(fadeCamera, 500, 1, true, 1)
				showChat ( true )
				setElementData(localPlayer,"opendashboard", false)
				exports.VDBGPDU:toggleElmosas()
				setElementFrozen ( getLocalPlayer(), false )
				toggleAllControls ( true )  
				playSound("files/roundstart.mp3")
				turfstatus = true
				enabled_cam_desce = false
				setElementData ( localPlayer, "opendashboard", false)
				roundintro = false
			end
			if(a>0)then
				a = a-1
			end
		end
	end
	end
	
	if ( mode == "prep" ) then 
		ownerProg = 100 - data.prepProg
		attackProg = data.prepProg 
		textturf = "PREPARANDO ZONA"
	else 
		ownerProg = 100 - data.attackProg
		attackProg = data.attackProg
		textturf = "ATACANDO ZONA"
	end

	local progWidth = 190
	if turfstatus then
	
	dxDrawImage( panel.x+874, panel.y+382.5, 295, 337, "files/bgturf.png",0,0,0,tocolor(255,255,255,255))
	
	
	
	-- loogo dos atacantes
	dxDrawImage( panel.x+919, panel.y+442.5, 67, 67, ":VDBGGroups/clanlogos/"..tostring(data.logoclanowner)..".png",0,0,0,tocolor(255,255,255,255),true)
	
	
	
	
	dxDrawImage( panel.x+990, panel.y+442.5, 80, 74, "files/iconpvp.png",0,0,0,tocolor(255,255,255,255),true)
	
	-- logo dos donos 
	dxDrawImage( panel.x+1074, panel.y+442.5, 67, 67, ":VDBGGroups/clanlogos/"..tostring(data.logoclanattackers)..".png",0,0,0,tocolor(255,255,255,255),true)
	
	
	dxDrawText ( textturf, panel.x+940, panel.y+643, 1250, 720, tocolor ( 255, 255, 255, 255 ), 1, fonte, "left", "top" )
	
	dxDrawRectangle ( panel.x+930, panel.y+550, 200, 30, tocolor ( 0, 0, 0, 120 ) )
	dxDrawRectangle ( panel.x+935, panel.y+555, ((ownerProg*0.01)*progWidth), 20, tocolor ( 62,126,212, 255 ) )
	dxDrawText ( tostring ( data.owner ).." -   "..ownerProg.."%", panel.x+930, panel.y+533, 1230, 650, tocolor ( 255, 255, 255, 255 ), 1, "default-bold", "left", "top" )
	dxDrawRectangle ( panel.x+930, panel.y+605, 200, 30, tocolor ( 0, 0, 0, 120 ) )
	dxDrawRectangle ( panel.x+935, panel.y+610,  ((attackProg*0.01)*progWidth), 20, tocolor ( 244, 28, 28, 255 ) )
	dxDrawText ( tostring ( data.attackers ).." - "..attackProg.."%", panel.x+930, panel.y+585, 1230, 650, tocolor ( 255, 255, 255, 255 ), 1, "default-bold", "left", "top" )
	end
end

