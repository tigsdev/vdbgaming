local elol = false
local sx, sy = guiGetScreenSize()
local w1PosX, w1PosY = 0, sy/2-300
local currmenuposition = 1
local coreside = "menu"
local kijelolt = 1
local animalva = false
local myfont = dxCreateFont("files/font.ttf", 10)

local current = 1

addEventHandler("onClientKey", root, function(k, v)
	if not v or not elol then return end
		if k == "arrow_r" then	
			if coreside == "menu" then
				if currmenuposition < #menu then
					currmenuposition = currmenuposition +1
				else
					currmenuposition = 1
				end
			
			
			end
		elseif k == "arrow_l" then
			if coreside == "menu" then
				if currmenuposition > 1 then
					currmenuposition = currmenuposition -1
				else
					currmenuposition = 5
				end
		
			
			
			end
		elseif k == "arrow_d" then
			if coreside == "anims" then
				if kijelolt <= 5 then
					kijelolt = kijelolt + 1
				else
					kijelolt = 1
				end
			end
		elseif k == "arrow_u" then
			if coreside == "anims" then
				if kijelolt >= 2 then
					kijelolt = kijelolt - 1
				else
					kijelolt = 6
				end
			end
		elseif k == "enter" then
			if coreside == "menu" then
				coreside = "anims"
			elseif coreside == "anims" then
				animalva = true
				triggerServerEvent("applyanim", localPlayer, localPlayer,
				anims[currmenuposition][kijelolt][2],
				anims[currmenuposition][kijelolt][3],
				anims[currmenuposition][kijelolt][4],
				anims[currmenuposition][kijelolt][5],
				anims[currmenuposition][kijelolt][6],
				anims[currmenuposition][kijelolt][7]	
				
				)
				elol = false
				toggleAllControls(true)
			
			end
		elseif k == "backspace" then
			if coreside == "menu" then
				elol = false	
				toggleAllControls(true)				
			elseif coreside == "anims" then
				coreside = "menu"
				kijelolt = 1
			end
		end

end)

bindKey("space", "down", function() 
	if animalva then
		triggerServerEvent("stopanim", localPlayer, localPlayer)
		animalva = false
	end		
end)

local panelelol = false

local rotates = {-90, -45, 0, 45, 90, 135, 180, 225, 270}


local fastanims = {
{55,"N/A", "", "", -1, false, false, false},
{55,"Pensar", "COP_AMBIENT", "Coplook_think", -1, true, false, false},
{55,"Fumar", "SMOKING", "M_smkstnd_loop", -1, true, false, false},
{55,"Dançar", "DANCING", "dance_loop", -1, true, false, false},
{55,"Saudar", "GANGS", "hndshkba", -1, false, false, false},
{55,"Sentar", "INT_HOUSE", "LOU_In", -1, false, false, false},		
{55,"Conversar", "GANGS", "prtial_gngtlkA", -1, true, false, false},
{55,"Sorrir", "RAPPING", "Laugh_01", -1, false, false, false},	
}

function renderfastaim()
	if not panelelol then return end
	local sx, sy = guiGetScreenSize()

	--createBlur()

	local w, h = 100, 100
	local left, top = sx/2 - w/2, sy/2 - h/2
		--dxDrawRectangle(sx/2 - 165/2, sy/2 + 195/2, 176, 3,tocolor(0, 0, 0, 210))
		--dxDrawRectangle(sx/2 - 165/2, sy/2 + 138/2, 176, 3,tocolor(0, 0, 0, 210))
		---dxDrawRectangle(sx/2 + 181/2, sy/2 + 145/2, 3, 25,tocolor(0, 0, 0, 210))
		--dxDrawRectangle(sx/2 - 166/2, sy/2 + 145/2, 3, 25,tocolor(0, 0, 0, 210))
		dxDrawRectangle(sx/2 - 160/2, sy/2 + 145/2, 170, 25,tocolor(0, 0, 0, 190))
		dxDrawText (fastanims[current][2] .. "",sx-150, sy/2 - 150/2 + 150, 150, 150, tocolor(255, 255, 255,255 ), 1.0, myfont, "center", "top", false, false, false, true)
	
	progress = (getTickCount() - asdtick) / 500

	panelTopa = interpolateBetween (
			top,0,0,
			top +220, 0, 0,
			progress,"InOutQuad"
		)
	panelTopa1 = interpolateBetween (
			top ,0,0,
			top-220, 0, 0,
			progress,"InOutQuad"
		)
	panelTopa2 = interpolateBetween (
			left,0,0,
			left - 220, 0, 0,
			progress,"InOutQuad"
		)
	panelTopa3 = interpolateBetween (
			left,0,0,
			left + 220, 0, 0,
			progress,"InOutQuad"
		)
	panelTopa4 = interpolateBetween (
			top,0,0,
			top + 165, 0, 0,
			progress,"InOutQuad"
		)
	panelTopa5 = interpolateBetween (
			left,0,0,
			left + 165, 0, 0,
			progress,"InOutQuad"
		)
	panelTopa6 = interpolateBetween (
			top,0,0,
			top - 165, 0, 0,
			progress,"InOutQuad"
		)
	panelTopa7 = interpolateBetween (
			left,0,0,
			left - 165, 0, 0,
			progress,"InOutQuad"
		)
	

	dxDrawImage(sx/2 - 150/2, sy/2 - 150/2, 150, 150,"seta.png",rotates[current],0,0,tocolor(255,255,255,255),true)
   
   
	
	--dxDrawRectangle(left, panelTopa, w, h, tocolor(0, 0, 0, 200))
	--dxDrawRectangle(panelTopa5, panelTopa4, w, h, tocolor(0, 0, 0, 200))
	--dxDrawRectangle(panelTopa5, panelTopa6, w, h, tocolor(0, 0, 0, 200))
	--dxDrawRectangle(panelTopa7, panelTopa6, w, h, tocolor(0, 0, 0, 200))
	--dxDrawRectangle(panelTopa7, panelTopa4, w, h, tocolor(0, 0, 0, 200))
	--dxDrawRectangle(panelTopa2, top, w, h, tocolor(0, 0, 0, 200))
	
	--dxDrawRectangle(left, panelTopa1 , w, h, tocolor(0, 0, 0, 200))
	--dxDrawRectangle(panelTopa3, top , w, h, tocolor(0, 0, 0, 200))
	
	
	dxDrawImage(sx/2 - 98/2, sy/2 - 534/2, 98, 98,"images/Icon_Stop.png",0,0,tocolor(255,255,255,200))
	dxDrawImage(sx/2 + 234/2, sy/2 - 426/2, 98, 98,"images/Icon_pensar.png",0,0,tocolor(255,255,255,200))
	dxDrawImage(sx/2 + 344/2, sy/2 - 96/2, 98, 98,"images/Icon_fumar.png",0,0,tocolor(255,255,255,200))
	dxDrawImage(sx/2 + 234/2, sy/2 + 236/2, 98, 98,"images/Icon_dance.png",0,0,tocolor(255,255,255,200))
	dxDrawImage(sx/2 - 100/2, sy/2 + 350/2, 98, 98,"images/Icon_cumprimentar.png",0,0,tocolor(255,255,255,200))
	dxDrawImage(sx/2 - 422/2, sy/2 + 240/2, 98, 98,"images/Icon_sentar.png",0,0,tocolor(255,255,255,200))
	dxDrawImage(sx/2 - 534/2, sy/2 - 98/2, 98, 98,"images/Icon_conversar.png",0,0,tocolor(255,255,255,200))
	dxDrawImage(sx/2 - 428/2, sy/2 - 432/2, 98, 98,"images/Icon_rir.png",0,0,tocolor(255,255,255,200))
	
	
	if current == 1 then
	dxDrawImage(sx/2 - 98/2, sy/2 - 534/2, 98, 98,"images/Icon_Stop_1.png",0,0,tocolor(255,255,255,200))	
	elseif current == 2 then
	dxDrawImage(sx/2 + 234/2, sy/2 - 426/2, 98, 98,"images/Icon_pensar_1.png",0,0,tocolor(255,255,255,200))		
	elseif current == 3 then
	dxDrawImage(sx/2 + 344/2, sy/2 - 96/2, 98, 98,"images/Icon_fumar_1.png",0,0,tocolor(255,255,255,200))	
	elseif current == 4 then
	dxDrawImage(sx/2 + 234/2, sy/2 + 236/2, 98, 98,"images/Icon_dance_1.png",0,0,tocolor(255,255,255,200))	
	elseif current == 5  then
	dxDrawImage(sx/2 - 100/2, sy/2 + 350/2, 98, 98,"images/Icon_cumprimentar_1.png",0,0,tocolor(255,255,255,200))
	elseif current == 6  then
	dxDrawImage(sx/2 - 422/2, sy/2 + 240/2, 98, 98,"images/Icon_sentar_1.png",0,0,tocolor(255,255,255,200))	
	elseif current == 7  then
	dxDrawImage(sx/2 - 534/2, sy/2 - 98/2, 98, 98,"images/Icon_conversar_1.png",0,0,tocolor(255,255,255,200))
	elseif current == 8  then
	dxDrawImage(sx/2 - 428/2, sy/2 - 432/2, 98, 98,"images/Icon_rir_1.png",0,0,tocolor(255,255,255,200))			
	end
	
end
addEventHandler("onClientRender", root, renderfastaim)
local animba = false
bindKey("f2", "up", function()
showChat(true)
				triggerServerEvent("applyfastanim", localPlayer, localPlayer,

				fastanims[current][3],
				fastanims[current][4],
				fastanims[current][5],
				fastanims[current][6],
				fastanims[current][7],
				fastanims[current][8],	
				fastanims[current][9]				
				)
	animba = true
	setElementData(localPlayer, "opendashboard", false)
	panelelol = false
	current = 1

end)

bindKey("f2", "down", function()
if ( getElementData(localPlayer,"logado") ) then
local theVehicle = getPedOccupiedVehicle ( localPlayer )
if ( theVehicle ) then return end
setElementData(localPlayer, "opendashboard", true)
asdtick = getTickCount()
panelelol = true
showChat(false)
end
end)

bindKey("mouse_wheel_down", "down", function()
if not panelelol then return end
cancelEvent()
	if current <= 7 then
		current = current + 1
	else
		current = 1
	end
	playSound("files/som.mp3")

end)

bindKey("mouse_wheel_up", "down", function()
if not panelelol then return end
	cancelEvent()
	if current >= 2 then
		current = current - 1
	else
		current = 8
	end
	playSound("song.mp3")

end)

bindKey("space", "down", function()
triggerServerEvent("removeanim", localPlayer, localPlayer)
end)
