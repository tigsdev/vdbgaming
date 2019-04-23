resourceRoot = getResourceRootElement( getThisResource( ) )
localPlayer = getLocalPlayer()
local s = {guiGetScreenSize()}
local screenX,screenY = guiGetScreenSize ()
local font = dxCreateFont("arquivos/font.ttf", 14)
local fontg = guiCreateFont("arquivos/font.ttf", 12)
local font2 = dxCreateFont("arquivos/font.ttf", 18)
local font3 = dxCreateFont("arquivos/font.ttf", 12)
local main, mainAtlatszo, username, password, password2 = nil
local musicElement = false
local mutat = false
local enabled_cam = false
local lastCamTick = 0
local language = "ptbr"
local urlptbr = "portuguese"
local urlenus = "ingles_back"
local lsalpha = 0
local loginalpha = 0
local regalpha = 0
local lastMenu = 1
local cursor_fade = 0
local screenW,screenH = guiGetScreenSize()
local drawUsername = ""
local drawPassword = ""
local drawPassword2 = ""

function getAlpha(aa, a)
	if (aa>a) then
		return a
	end
	return (a-(a-aa))
end

local noti = false

lastCamTick = getTickCount ()
myScreenSource = dxCreateScreenSource( screenX/2, screenY/2 )
blurHShader,tecName = dxCreateShader( "arquivos/blurH.fx" )
blurVShader,tecName = dxCreateShader( "arquivos/blurV.fx" )
blurTick = getTickCount ()

function clearChatBox()
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
	outputChatBox("")
end

local function isInBox( x, y, xmin, xmax, ymin, ymax )
	return x >= xmin and x <= xmax and y >= ymin and y <= ymax
end
local logado = false
local saveuser, savepassword = ""

function showLogin()
	guiSetInputMode("no_binds_when_editing")
	clearChatBox()
	confFile = xmlLoadFile("expert_login.xml")
	if (confFile) then
		saveuser = xmlNodeGetAttribute(confFile,"username")
		savepassword = xmlNodeGetAttribute(confFile,"pass")
	else
		confFile = xmlCreateFile("expert_login.xml","user")
		xmlNodeSetAttribute(confFile,"username","")
		xmlNodeSetAttribute(confFile,"pass","")
		
		saveuser = getPlayerName(localPlayer)
		savepassword = "Senha"
	end
	xmlSaveFile(confFile)
	confFile = xmlLoadFile("expert_login.xml")
	if (confFile) then
		xmlNodeSetAttribute(confFile,"username","")
		xmlNodeSetAttribute(confFile,"pass","")
	end
	
	if (saveuser=="") then
		saveuser = "Usuário"
	end
	if (savepassword=="") then
		savepassword = "Senha"
	end
	
	setWeather(7)
	setTime(22,0)
	musicElement = playSound ("arquivos/musica.mp3")
	setSoundVolume (musicElement,1)
	setElementData(getLocalPlayer(), "logado", false)
	if(isElement(nil_gui))then
		destroyElement(nil_gui)
	end
	nil_gui = guiCreateEdit(-1000,-1000,1,1,"", false)
	if(isElement(username))then
		destroyElement(username)
	end
	username = guiCreateEdit(-1000,-1000,280,30,saveuser,false)
	guiSetAlpha(username, 0)
	guiSetFont(username, fontg)
	guiEditSetMasked ( username, true )
	guiEditSetMaxLength ( username, 15 )
	if(isElement(password))then
		destroyElement(password)
	end
	password = guiCreateEdit(-1000,-1000,280,30,savepassword,false)
	guiSetAlpha(password, 0)
	guiSetFont(password, fontg)
	guiEditSetMasked ( password, true )
	guiEditSetMaxLength ( password, 15 )
	if(isElement(password2))then
		destroyElement(password2)
	end
	password2 = guiCreateEdit(-1000,-1000,280,30,savepassword,false)
	guiSetAlpha(password2, 0)
	guiSetFont(password2, fontg)
	guiEditSetMasked ( password2, true )
	guiEditSetMaxLength ( password2, 15 )
	mutat = true
	showChat(false)
	showCursor ( true )
end
addEventHandler("onClientResourceStart", resourceRoot, showLogin)

function draw()
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	if not mutat then return end
	if mutat then
	updateCamPosition()
	renderBlur()
	enabled_cam = true
	lastClicked=0
	lastMenuClicked=0
	cursor_fade = cursor_fade + 1
	if(cursor_fade>60)then
		cursor_fade = 0
	end
	
	local onebuttonsize=screenX/4.3
	local onebuttonsize2=screenX/7.3
	local logincolor = tocolor ( 255,255,255, 175 )
	local regcolor = tocolor ( 255,255,255, 175 )
	
	drawUsername = guiGetText(username)
	drawPassword = string.rep ( "x", utfLen ( guiGetText ( password ) ) )
	drawPassword2 = string.rep ( "x", utfLen ( guiGetText ( password2 ) ) )
	--GUI
	if(clicked==0)then
		guiBringToFront( nil_gui )
		if(guiGetText(username)=="")then
			guiSetText(username, "Login")
		end
		if(guiGetText(password)=="")then
			guiSetText(password, "Senha")
		end
	elseif(clicked==1)then
		guiBringToFront( username )
		guiEditSetCaretIndex ( username, string.len ( guiGetText(username) ) )
		if(guiGetText(username)=="Usuário")then
			guiSetText(username, "")
		end
		if(cursor_fade>30)then
			drawUsername = guiGetText(username).."|"
		end
	elseif(clicked==2)then
		guiBringToFront( password )
		guiEditSetCaretIndex ( password, string.len ( guiGetText(password) ) )
		if(guiGetText(password)=="Senha")then
			guiSetText(password, "")
		end
		if(cursor_fade>30)then
			drawPassword = drawPassword.."|"
		end
	elseif(clicked==3 and lastMenu==2)then
		guiBringToFront( password2 )
		guiEditSetCaretIndex ( password2, string.len ( guiGetText(password2) ) )
		if(guiGetText(password2)=="Repita senha")then
			guiSetText(password2, "")
		end
		if(cursor_fade>30)then
			drawPassword2 = drawPassword2.."|"
		end
	end
	--CURSOR
	
	
	
	
	
	if isCursorShowing ( ) then
		cx,cy = getCursorPosition ()
		cx,cy = cx*screenX,cy*screenY
		if(isInBox(cx,cy,onebuttonsize*1, onebuttonsize*1 + onebuttonsize, 0, 70))then
			logincolor = tocolor ( 47, 124, 204, 175 )
			lastMenuClicked=1
		end
		
		if(lastMenu==1)then
			if(isInBox(cx,cy,screenX/2-onebuttonsize/2, screenX/2-onebuttonsize/2 + onebuttonsize, screenY/2-100/2, screenY/2-100/2 + 40))then
				lastClicked = 1
			elseif(isInBox(cx,cy,screenX/2-onebuttonsize/2, screenX/2-onebuttonsize/2 + onebuttonsize, screenY/2-100/2 + 50, screenY/2-100/2 + 50 + 40))then
				lastClicked = 2
			elseif(isInBox(cx,cy,screenX/2-(onebuttonsize*0.8)/2,screenX/2-(onebuttonsize*0.8)/2+(onebuttonsize*0.8), screenY/2-100/2 + 100, screenY/2-100/2 + 100 + 40))then
				lastClicked = 3
			end
		elseif(lastMenu==2)then
			if(isInBox(cx,cy,screenX/2-onebuttonsize/2, screenX/2-onebuttonsize/2 + onebuttonsize, screenY/2-200/2, screenY/2-200/2 + 40 ))then
				lastClicked = 1
			elseif(isInBox(cx,cy,screenX/2-onebuttonsize/2, screenX/2-onebuttonsize/2 + onebuttonsize, screenY/2-200/2 + 50, screenY/2-200/2 + 50 + 40))then
				lastClicked = 2
			elseif(isInBox(cx,cy,screenX/2-onebuttonsize/2, screenX/2-onebuttonsize/2 + onebuttonsize, screenY/2-200/2 + 50 + 50, screenY/2-200/2 + 50 + 50 + 40))then
				lastClicked = 3
			elseif(isInBox(cx,cy,screenX/2-(onebuttonsize*0.8)/2, screenX/2-(onebuttonsize*0.8)/2 + (onebuttonsize*0.8), screenY/2-200/2 + 150, screenY/2-200/2 + 150 + 40))then
				lastClicked = 4
			end
		end
	end


	
	if (lastMenu==0) then
		if(lsalpha<255)then
			lsalpha = lsalpha+(255/150)
		end
		local w, h = (1920/screenX)*345, (1920/screenX)*199
		dxDrawImage(screenX/2-w/2, screenY/2-h/2, w, h, "imagens/ls.png",0,0,0,tocolor(255,255,255,getAlpha(lsalpha, 255)))
	elseif (lastMenu==1) then
		if(lsalpha>0)then
			lsalpha = lsalpha-(lsalpha/150)
		end
		if(loginalpha<255)then
			loginalpha = loginalpha+(255/30)
		end
		if(regalpha>0)then
			regalpha = regalpha-(regalpha/15)
		end
	elseif (lastMenu==2) then
		if(lsalpha>0)then
			lsalpha = lsalpha-(lsalpha/150)
		end
		if(regalpha<255)then
			regalpha = regalpha+(255/30)
		end
		if(loginalpha>0)then
			loginalpha = loginalpha-(loginalpha/15)
		end
	end
	
	dxDrawImage(screenX/2-296/2, screenY/2+200/2+110, 121, 40, "imagens/bglanguage.png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255))) -- BG LANGUAGE
	
	function logoAnimacio(x, y)
	local valosID = logoAnimacioLepes
	if (string.len(logoAnimacioLepes)==2) then
		valosID = "000" .. logoAnimacioLepes
	elseif (string.len(logoAnimacioLepes)==1) then
		valosID = "0000" .. logoAnimacioLepes
	end
	local nx, ny = logoP[1], logoP[2]
	if(x and y) then
		nx, ny = x, y
	end
	dxDrawImage ( nx, ny, logoS[1], logoS[2], 'kepek/logo/'..valosID..'.png', 0, 0, 0 )
	
	-- Csak minden 3. tickbe dobjuk át az új képre
	if(getTickCount() % 3 == 0) then
		logoAnimacioLepes = logoAnimacioLepes + 1
		-- Ha véletlen túllépjük a képek számátű
		if(logoAnimacioLepes > 60) then
			logoAnimacioLepes = 0
		end
	end
end
	
	--
	
	--Ingles
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(screenX/2-298/2, screenY/2+200/2+110, 59, 40, cursorX, cursorY)) then
				--- mostra o botao com efeito ( mouse em cima )
				dxDrawImage(screenX/2-298/2, screenY/2+200/2+110, 59, 40, "imagens/"..urlenus..".png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 150)))
			else
				--- se nao tiver em cima nao mostra colorido
			dxDrawImage(screenX/2-298/2, screenY/2+200/2+110, 59, 40, "imagens/"..urlenus..".png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255)))
			dxDrawImage(screenX/2-298/2, screenY/2+200/2+110, 59, 40, "imagens/"..urlenus..".png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255))) -- EFEITOAQUIGALEGO
			
			end
		end	

	dxDrawRectangle ( screenX/2-(onebuttonsize*0.8)/2, screenY/2-100/2 + 100, (onebuttonsize*0.8),40, tocolor ( 0, 0, 0, getAlpha(loginalpha, 180) ) ) -- Button
	--Portugues
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(screenX/2-170/2, screenY/2+200/2+110, 59, 40, cursorX, cursorY)) then
				--- mostra o botao com efeito ( mouse em cima )
				dxDrawImage(screenX/2-170/2, screenY/2+200/2+110, 59, 40, "imagens/"..urlptbr..".png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 150))) 
			else
			
				--- se nao tiver em cima nao mostra colorido
				dxDrawImage(screenX/2-170/2, screenY/2+200/2+110, 59, 40, "imagens/"..urlptbr..".png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255))) 
				dxDrawImage(screenX/2-170/2, screenY/2+200/2+110, 59, 40, "imagens/"..urlptbr..".png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255))) -- EFEITOAQUIGALEGO
			end
		end	
	
	if not getElementData(localPlayer,"AccountData.Language") then
		--- conteudo padrao
		dxDrawImage(screenX/2-366/2, screenY/2-100/2-241, 353, 653, "imagens/bgp.png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255)))
	dxDrawText ( "Logar-se", screenX/2-(onebuttonsize*0.8)/2, screenY/2-100/2 + 100, screenX/2-(onebuttonsize*0.8)/2 + (onebuttonsize*0.8), screenY/2-100/2 + 100 + 40, tocolor(255,255,255,getAlpha(loginalpha, 175)), 1, font, "center", "center")
	 	
	end
	
	--dxDrawRectangle ( screenX/2-96/2, screenY/2-100/2-110 + 96, 96, 2, tocolor ( 47, 124, 204, getAlpha(loginalpha, 200) ) ) -- LineDown
	if getElementData(localPlayer,"AccountData.Language") == "ptbr" then
		--- conteudo portugues
		
		dxDrawImage(screenX/2-366/2, screenY/2-100/2-241, 353, 653, "imagens/bgp.png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255)))
	dxDrawText ( "Logar-se", screenX/2-(onebuttonsize*0.8)/2, screenY/2-100/2 + 100, screenX/2-(onebuttonsize*0.8)/2 + (onebuttonsize*0.8), screenY/2-100/2 + 100 + 40, tocolor(255,255,255,getAlpha(loginalpha, 175)), 1, font, "center", "center")
	
	end
	if getElementData(localPlayer,"AccountData.Language")== "enus" then
		--- conteudo ingles
		dxDrawImage(screenX/2-366/2, screenY/2-100/2-241, 353, 653, "imagens/bgi.png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255)))
	dxDrawText ( "Log-in", screenX/2-(onebuttonsize*0.8)/2, screenY/2-100/2 + 100, screenX/2-(onebuttonsize*0.8)/2 + (onebuttonsize*0.8), screenY/2-100/2 + 100 + 40, tocolor(255,255,255,getAlpha(loginalpha, 175)), 1, font, "center", "center")
	
	end
	--dxDrawRectangle ( screenX/2-96/2, screenY/2-100/2-110 + 96, 96, 2, tocolor ( 47, 124, 204, getAlpha(loginalpha, 200) ) ) -- LineDown
	
	--dxDrawRectangle ( screenX/2-onebuttonsize/2, screenY/2-100/2, onebuttonsize,40, tocolor ( 0, 0, 0, getAlpha(loginalpha, 200) ) ) -- User
	--dxDrawRectangle ( screenX/2-onebuttonsize/2 + 40, screenY/2-100/2, 1,40, tocolor ( 50, 50, 50, getAlpha(loginalpha, 200) ) ) -- Line
	--dxDrawRectangle ( screenX/2-onebuttonsize/2, screenY/2-100/2 + 38, onebuttonsize,2, tocolor ( 47, 124, 204, getAlpha(loginalpha, 200) ) ) -- LineDown
	--dxDrawImage(screenX/1.98-onebuttonsize/2 + 5, screenY/2-92/2 + 3, 26, 33, "imagens/usuario.png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255)))
	--dxDrawImage(screenX/2-296/2, screenY/2-300/2+110, 26, 33, "imagens/usuario.png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255))) 
	dxDrawText ( drawUsername, screenX/2-85 ,screenY/2-87/2 - 2, screenX/2-onebuttonsize/2 + onebuttonsize, screenY/2-100/2 + 40, tocolor(255,255,255,getAlpha(loginalpha, 175)), 1, font, "left", "center" )
	
	--dxDrawRectangle ( screenX/2-onebuttonsize/2, screenY/2-100/2 + 50, onebuttonsize,40, tocolor ( 0, 0, 0, getAlpha(loginalpha, 200) ) ) -- Pass
	--dxDrawRectangle ( screenX/2-onebuttonsize/2 + 40, screenY/2-100/2 + 50, 1,40, tocolor ( 50, 50, 50, getAlpha(loginalpha, 200) ) ) -- Line
	--dxDrawRectangle ( screenX/2-onebuttonsize/2, screenY/2-100/2 + 50 + 38, onebuttonsize,2, tocolor ( 47, 124, 204, getAlpha(loginalpha, 200) ) ) -- LineDown
	--dxDrawImage(screenX/1.98-onebuttonsize/2 + 5, screenY/2-98/2 + 50 + 2, 26, 33, "imagens/senha.png",0,0,0,tocolor(255,255,255,getAlpha(loginalpha, 255)))
	--dxDrawText (drawPassword, screenW/2.0-onebuttonsize/2 + 36, screenH/2-96/2 + 50 - 6 screenH/2-onebuttonsize/2 + onebuttonsize, screenH/2-100/2 + 50 + 40, tocolor(255,255,255,getAlpha(loginalpha, 175)), 1, font, "left", "center" )
	dxDrawText ( drawPassword, screenX/2-85, screenY/2-96/2 + 50 - 6, screenX/2-onebuttonsize/2 + onebuttonsize, screenY/2-100/2 + 50 + 40, tocolor(255,255,255,getAlpha(loginalpha, 175)), 1, font, "left", "center" )
	
	
	--dxDrawRectangle ( screenX/2-(onebuttonsize*0.8)/2, screenY/2-100/2 + 100 - 2, (onebuttonsize*0.8),2, tocolor ( 47, 124, 204, getAlpha(loginalpha, 200) ) ) -- LineUp
   
	
    
	
	
	--REG
	
	--dxDrawImage(screenX/2-onebuttonsize/2 + 7, screenY/2-100/2 + 50 + 2, 26, 33, "imagens/senha.png",0,0,0,tocolor(255,255,255,getAlpha(regalpha, 255)))

end
end
addEventHandler("onClientRender", getRootElement(), draw)

setTimer(function()
	if(lastMenu==0)then
		lastMenu=1
	end
end, 10000, 1)


function MenuButton(botao,status,x,y)
	if botao == "left" and status == "down" then
		cx,cy = getCursorPosition ()
		cx,cy = cx*screenX,cy*screenY
		-- ingles
		if(locMouse(screenX/2-298/2, screenY/2+200/2+110, 59, 40,x,y)) then
			urlptbr = "portuguese_back"
			urlenus = "ingles"
			playSound ("arquivos/click.mp3")
			setElementData(localPlayer,"AccountData.Language", "enus")
		end		
		--- ptbr
		if(locMouse(screenX/2-170/2, screenY/2+200/2+110, 59, 40,x,y)) then
			urlptbr = "portuguese"
			urlenus = "ingles_back"
			playSound ("arquivos/click.mp3")
			setElementData(localPlayer,"AccountData.Language", "ptbr")
		end			
	end	
end
addEventHandler("onClientClick",getRootElement(),MenuButton)



addEventHandler("onClientClick", getRootElement(), function(button, state)
	if(button~="left" or state~="down")then return end
	if (lastMenuClicked>0)then
		lastMenu = lastMenuClicked
	end
	if(lastClicked==3 and lastMenu==1)then
		playSound ("arquivos/logar.mp3")
		triggerServerEvent("Login:onClientAttemptLogin", getLocalPlayer(), getLocalPlayer(), guiGetText(username), guiGetText(password))
		toggleSavePassword(guiGetText(username), guiGetText(password))	
	else
		clicked = lastClicked
	end
end)

function toggleSavePassword(name, pass)
	confFile = xmlLoadFile("expert_login.xml")
	xmlNodeSetAttribute(confFile, "username", name)
	xmlNodeSetAttribute(confFile, "pass", pass)
	xmlSaveFile(confFile)
end

---------VIEW----------
local last_cam_pos = 1
local cam_pos = {
	{1359.8466796875, -964.04107666016, 41.700199127197, 1359.7414550781, -964.99334716797, 41.413646697998, 1338.6286621094, -1411.3120117188, 41.900001525879, 1338.6075439453, -1412.2508544922, 41.556369781494, 60000},
	{1491.2071533203, 161.71119689941, 38.791400909424, 1490.3010253906, 161.97152709961, 38.458061218262, 1221.2795410156, 279.30139160156, 41.609298706055, 1220.3957519531, 279.67514038086, 41.327991485596, 30000},
	{1649.6226806641, -995.65289306641, 71.386901855469, 1649.4932861328, -996.62030029297, 71.169128417969, 1576.1292724609, -1605.2222900391, 65.682502746582, 1576.0288085938, -1606.1701660156, 65.380271911621, 60000}
}



setTimer ( triggerServerEvent, 200, 1, "VDBGLogin:RequestClientLoginConfirmation", localPlayer )


	
function destroyGui()
	removeEventHandler("onClientRender", getRootElement(), draw)
	setCameraTarget(localPlayer)
	enabled_cam = false
	mutat = false	
	clicked=-1
	lastClicked=-1
	logado = true
	local volume = 1
	setTimer(function()
		volume = volume - 0.1
		setSoundVolume (musicElement,volume)
		if (volume<=0)then
			destroyElement(musicElement)
		end
			fadeCamera(true,2)
			showCursor(false)
	end,500,11)
end
addEvent("destroyGui", true)
addEventHandler("destroyGui", getRootElement(), destroyGui)
camFading = 0

function isClientLoggedin ( )
	return logado
end


function updateCamPosition ()
	if cam_pos[last_cam_pos] and enabled_cam then
		local cTick = getTickCount ()
		local delay = cTick - lastCamTick
		local duration = cam_pos[last_cam_pos][13]
		local easing = "Linear"
		if duration and easing then
			local progress = delay/duration
			if progress < 1 then
				local cx,cy,cz = interpolateBetween (
					cam_pos[last_cam_pos][1],cam_pos[last_cam_pos][2],cam_pos[last_cam_pos][3],
					cam_pos[last_cam_pos][7],cam_pos[last_cam_pos][8],cam_pos[last_cam_pos][9],
					progress,easing
				)
				local tx,ty,tz = interpolateBetween (
					cam_pos[last_cam_pos][4],cam_pos[last_cam_pos][5],cam_pos[last_cam_pos][6],
					cam_pos[last_cam_pos][10],cam_pos[last_cam_pos][11],cam_pos[last_cam_pos][12],
					progress,easing
				)
				setCameraMatrix (cx,cy,cz,tx,ty,tz)
				if camFading == 0 then
					local left = duration-delay
					if left <= 3000 then
						camFading = 1
						fadeCamera (false,3,0,0,0)
					end
				elseif camFading == 2 then
					local left = duration-delay
					if left >= 2000 then
						camFading = 0
					end
				end
			else
				local nextID = false
				if #cam_pos>1 then
					while nextID == false do
						local id = math.random(1,#cam_pos)
						if id ~= last_cam_pos then
							nextID = id
						end
					end
				else
					nextID = 1
				end
				camFading = 2
				fadeCamera (true,2)
				lastCamTick = getTickCount ()
				last_cam_pos = nextID
				
				setCameraMatrix (cam_pos[last_cam_pos][1],cam_pos[last_cam_pos][2],cam_pos[last_cam_pos][3],cam_pos[last_cam_pos][4],cam_pos[last_cam_pos][5],cam_pos[last_cam_pos][6])
			end
		end
	end
end
------------------
-------blur-------
------------------

function renderBlur ()
	local alpha = 255
	local cTick = getTickCount ()
	local delay = cTick - 0
	if delay <= 2000 then
		local progress = delay / 2000
		alpha = interpolateBetween (
			0,0,0,
			200,200,200,
			progress,"Linear"
		)
	end
	RTPool.frameStart()
	dxUpdateScreenSource( myScreenSource )
	local current = myScreenSource
	
	current = applyDownsample( current )
	current = applyGBlurH( current, Settings.var.bloom )
	current = applyGBlurV( current, Settings.var.bloom )
	dxSetRenderTarget()
	dxDrawImage( 0, 0, screenX, screenY, current, 0,0,0, tocolor(255,255,255,alpha) )
end

Settings = {}
Settings.var = {}
Settings.var.cutoff = 0
Settings.var.power = 1.88
Settings.var.bloom = 1

function applyDownsample( Src, amount )
	amount = amount or 2
	local mx,my = dxGetMaterialSize( Src )
	mx = mx / amount
	my = my / amount
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, Src, 0, 0, 0, tocolor(230,230,230, alpha) )
	return newRT
end

function applyGBlurH( Src, bloom )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurHShader, "tex0", Src )
	dxSetShaderValue( blurHShader, "tex0size", mx,my )
	dxSetShaderValue( blurHShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx, my, blurHShader, 0, 0, 0, tocolor(230,230,230, alpha) )
	return newRT
end

function applyGBlurV( Src, bloom )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurVShader, "tex0", Src )
	dxSetShaderValue( blurVShader, "tex0size", mx,my )
	dxSetShaderValue( blurVShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx,my, blurVShader, 0, 0, 0, tocolor(230,230,230, alpha) )
	return newRT
end

RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
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

function locMouse(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end