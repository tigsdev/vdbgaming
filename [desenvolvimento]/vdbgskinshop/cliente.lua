-- változók
local currskin = 1
local panelState = false
local sx, sy = guiGetScreenSize()
local oldal = 1
local max_oldal = 4
local Csoport = ""
local Slot = 1
local markers = { }
local warpin = {}
local warpout = {}
local sw = {guiGetScreenSize()}
local radarPos = {sw[1]*20/1440, sw[2]-(200+50), ((318-10)),(185)}



local SkinLocs = { 
	[1] = { 
		namewarp = "VDBG Roupas & Skins #d9534f#1",
		outPos = { 1456.77, -1138.02, 23.2872 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 301
	},
	
	[2] = {
		namewarp = "VDBG Roupas & Skins #d9534f#2",
		outPos = { -1883.2, 865.473, 34.2601 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 302
	},
	[3] = {
		namewarp = "VDBG Roupas & Skins #d9534f#3",
		outPos = { 2572.07, 1904.83, 10.0231 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[4] = {
		namewarp = "VDBG Roupas & Skins #d9534f#4",
		outPos = { 1456.77, -1138.02, 23.2872 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 304
	},
	[5] = {
		namewarp = "VDBG Roupas & Skins #d9534f#5",
		outPos = { 2244.47, -1665.36, 14.4839 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 305
	},
	[6] = {
		namewarp = "VDBG Roupas & Skins #d9534f#6",
		outPos = { -2375.32, 910.293, 44.4578 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 306
	},
	[7] = {
		namewarp = "VDBG Roupas & Skins #d9534f#7",
		outPos = { 1657.01, 1733.33, 10.0209 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 307
	},
	[8] = {
		namewarp = "VDBG Roupas & Skins #d9534f#8",
		outPos = { 2102.69, 2257.49, 10.0579 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 308
	},
	[9] = {
		namewarp = "VDBG Roupas & Skins #d9534f#9",
		outPos = { 461.158, -1499.98, 30.1742 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 309
	},
	[10] = {
		namewarp = "VDBG Roupas & Skins #d9534f#10",
		outPos = { -1694.76, 951.599, 24.2706 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 310
	},
	[11] = {
		namewarp = "VDBG Roupas & Skins #d9534f#11",
		outPos = { 2802.34, 2430.6, 10.061 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 311
	},
	[12] = {
		namewarp = "VDBG Roupas & Skins #d9534f#12",
		outPos = { 453.868, -1478.07, 29.9609 },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 312
	}
	--[[[13] = {
		namewarp = "VDBG Roupas & Skins #d9534f#13",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[14] = {
		namewarp = "VDBG Roupas & Skins #d9534f#14",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[15] = {
		namewarp = "VDBG Roupas & Skins #d9534f#15",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[16] = {
		namewarp = "VDBG Roupas & Skins #d9534f#16",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[17] = {
		namewarp = "VDBG Roupas & Skins #d9534f#17",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[18] = {
		namewarp = "VDBG Roupas & Skins #d9534f#18",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[19] = {
		namewarp = "VDBG Roupas & Skins #d9534f#19",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[20] = {
		namewarp = "VDBG Roupas & Skins #d9534f#20",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[21] = {
		namewarp = "VDBG Roupas & Skins #d9534f#21",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[22] = {
		namewarp = "VDBG Roupas & Skins #d9534f#22",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[23] = {
		namewarp = "VDBG Roupas & Skins #d9534f#23",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[24] = {
		namewarp = "VDBG Roupas & Skins #d9534f#24",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},
	[25] = {
		namewarp = "VDBG Roupas & Skins #d9534f#25",
		outPos = {  },
		inPos = { 161.2, -96.25, 1001.8 },
		markerPos = { 161.37, -83.81, 1001.8 },
		int = 18,
		dim = 303
	},]]
}


local menu = 1
local Rotatcio = 419



local skinek_1 = {
    {1, 30, "SKIN"},
    {29, 30, "SKIN"},
    {34, 30, "SKIN"},
    {29, 30, "SKIN"},
    {30, 30, "SKIN"},
    {29, 30, "SKIN"},
    {130, 30, "SKIN"},
    {45, 30, "SKIN"},
    {9, 30, "SKIN"},
    {10, 30, "SKIN"},
    {11, 30, "SKIN"},
}
local skinek_2 = {
    {1, 30, "Personagem 12"},
    {29, 30, "Personagem 13"},
    {34, 30, "Personagem 14"},
    {29, 30, "Personagem 15"},
    {30, 30, "Personagem 16"},
    {29, 30, "Personagem 17"},
    {130, 30, "Personagem 18"},
    {45, 30, "Personagem 19"},
    {9, 30, "Personagem 20"},
    {10, 30, "Personagem 21"},
    {11, 30, "Personagem 22"},
}
 local skinek_3 = {
    {1, 30, "SKIN"},
    {29, 30, "SKIN"},
    {34, 30, "SKIN"},
    {29, 30, "SKIN"},
    {30, 30, "SKIN"},
    {29, 30, "SKIN"},
    {130, 30, "SKIN"},
    {45, 30, "SKIN"},
    {9, 30, "SKIN"},
    {10, 30, "SKIN"},
    {11, 30, "SKIN"},
}
local skinek_4 = {
    {1, 30, "SKIN"},
    {29, 30, "SKIN"},
    {34, 30, "SKIN"},
    {29, 30, "SKIN"},
    {30, 30, "SKIN"},
    {29, 30, "SKIN"},
    {130, 30, "SKIN"},
    {45, 30, "SKIN"},
    {9, 30, "SKIN"},
    {10, 30, "SKIN"},
    {11, 30, "SKIN"},
}

local CsoportNeve = {"Casuais","Esportivas","Marca","Luxo"}

local Colors = {
	tocolor(0,0,0,180), -- Ez átilla
	tocolor(0,0,0,220), -- Ez szűke
	tocolor(0,0,0,235), -- Ez feka
	tocolor(66, 139, 202,100), --Ez ződ
	tocolor(100,100,100,200), --Ez világos feka
    tocolor(66, 139, 202,140), --Ez ződ
    tocolor(66, 139, 202,200)
}
local s = {guiGetScreenSize()}
local skinK = {320,30}
local skinP = {(s[1]/2-skinK[1]/2),(s[2]/2-skinK[2]/2)}
local RotateK = {100,100}
local RotateP = {(s[1]/2-RotateK[1]/2),(s[2]/2-RotateK[2]/2)}
local max_s = 11


function markerHit(p,int,dim)
local veh = getPedOccupiedVehicle(p)
if p == getLocalPlayer() then
	if veh then return end
		if not panelState then
			setElementData(localPlayer,"skinshop",true)
			panelState = true 
			Matrix = setCameraMatrix(179.65, -88.14, 1002.02,1946.6188964844,-326.7591552734,950.030006408691)	
			skinped = createPed(skinek_1[currskin][1],182.29, -89.35, 1002.02)
			setElementDimension(skinped,getElementDimension(localPlayer) or 9999)
			setElementInterior(skinped, getElementInterior(localPlayer) or 9999)
			setPedRotation(skinped,Rotatcio)
			addEventHandler("onClientRender", getRootElement(), RenderDX)
			addEventHandler("onClientClick", getRootElement(), menuPont)
			showCursor(true)
			showChat(false)
			setElementFrozen(localPlayer,true)
		end
	end
end

local expertfont = dxCreateFont("arquivos/vdbgfonte.ttf", 12)


function RenderDX()
	Null = 1

	if(getElementData(getLocalPlayer(), "opendashboard") == true) then return end
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	

	
	dxDrawRectangle(50 + skinK[1] + 2, sy/2-300 + skinK[2], skinK[1]/3, skinK[2]*2, Colors[3])
	--dxDrawRectangle(50 + skinK[1] + 2, sy/2-300 + skinK[2] + skinK[2]*2 - 2, skinK[1]/3, 2, Colors[4])
	
	

	dxDrawText("Páginação", 0 + skinK[1] + 2, sy/2-300 + skinK[2] + 5, 100 + skinK[1] + 2 + skinK[1]/3, sy/2-300 + skinK[2] + skinK[2]*2, tocolor(200,200,200,255), 1, expertfont, "center", "top", false, false, false, false, true )
	dxDrawText(oldal.."/"..max_oldal, 0 + skinK[1] + 2, sy/2-300 + skinK[2] + 20, 100 + skinK[1] + 2 + skinK[1]/3, sy/2-300 + skinK[2] + skinK[2]*2, tocolor(200,200,200,255), 1, expertfont, "center", "center", false, false, false, false, true )
	--dxDrawText(skinek_1[currskin][1] or "Hiba!", 100 + skinK[1] + 2, sy/2-300 + skinK[2] + 10, 100 + skinK[1] + 2 + skinK[1]/3, sy/2-300 + skinK[2] + skinK[2]*2, tocolor(200,200,200,255), 1, expertfont, "center", "center", false, false, false, false, true )
	
	for i=0, max_s-1 do
		dxDrawRectangle(50,sy/2-300 + (skinK[2]*(i+1)),skinK[1],skinK[2],Colors[(i%2)+1])
		if oldal == 1 then
			Csoport = CsoportNeve[1]
			dxDrawText(skinek_1[i+1][3], 60,sy/2-300 + (skinK[2]*(i+1)),100 + skinK[1],sy/2-300 + (skinK[2]*(i+1)) + skinK[2], tocolor(255,255,255,255), 1, expertfont, "left", "center", false, false, false, false, true )
		elseif oldal == 2 then	
			Csoport = CsoportNeve[2]
			dxDrawText(skinek_2[i+1][3], 60,sy/2-300 + (skinK[2]*(i+1)),100 + skinK[1],sy/2-300 + (skinK[2]*(i+1)) + skinK[2], tocolor(255,255,255,255), 1, expertfont, "left", "center", false, false, false, false, true )
		elseif oldal == 3 then	
			Csoport = CsoportNeve[3]
			dxDrawText(skinek_3[i+1][3], 60,sy/2-300 + (skinK[2]*(i+1)),100 + skinK[1],sy/2-300 + (skinK[2]*(i+1)) + skinK[2], tocolor(255,255,255,255), 1, expertfont, "left", "center", false, false, false, false, true )
		elseif oldal == 4 then	
			Csoport = CsoportNeve[4]
			dxDrawText(skinek_4[i+1][3], 60,sy/2-300 + (skinK[2]*(i+1)),100 + skinK[1],sy/2-300 + (skinK[2]*(i+1)) + skinK[2], tocolor(255,255,255,255), 1, expertfont, "left", "center", false, false, false, false, true )
		end
		if(i==currskin-1)then
			
			dxDrawRectangle(50,sy/2-300 + (skinK[2]*(i+1)),skinK[1],30,Colors[4])
			dxDrawRectangle(50,sy/2-300 + (skinK[2]*(i+1)),skinK[1],2,Colors[6])
			dxDrawRectangle(50,sy/2-300 + (skinK[2]*(i+1)) + skinK[2] - 2,skinK[1],2,Colors[6])
		end
	end

	dxDrawRectangle(50,sy/2-678 + (skinK[2]*(max_s+1)),skinK[1]+109,skinK[2]*1.5,Colors[3])-- Felso
	dxDrawRectangle(50,sy/2-300 + (skinK[2]*(max_s+1)),skinK[1],skinK[2]*2,Colors[3])
	--dxDrawRectangle(50,sy/2-300 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 2,skinK[1],2,Colors[7])
	
    dxDrawImage(381 - skinK[1] - 1,sy/2-305 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,293,53,"arquivos/legenda.png",0,0,0,tocolor(255,255,255,255))-- Rotate
	dxDrawImage(120 + skinK[1] - 1,sy/2-555 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,16,28,"arquivos/cima.png",90,0,0,tocolor(255,255,255,255),true)-- Rotate
	dxDrawImage(75 + skinK[1] - 1,sy/2-555 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,16,28,"arquivos/baixo.png",90,0,0,tocolor(255,255,255,255),true)-- Rotate
	

	
	
	dxDrawRectangle(50 + skinK[1] + 2,sy/2-220 + skinK[2],skinK[1]/3,skinK[2]*1.2,Colors[3])
	--dxDrawRectangle(50 + skinK[1] + 2,sy/2-185 + skinK[2],skinK[1]/3,2,Colors[4])-- Alsó Jobb oldali

	
	dxDrawText (Csoport,60,sy/2-665 + (skinK[2]*(max_s+1)),skinK[1]+109,skinK[2]*1.5, tocolor(255,255,255,255 ), 1, expertfont, "left", "top", false, false, false, true) 
	
	
	dxDrawText ("#9D9D9DR$ 10.000",370,sy/2-665 + (skinK[2]*(max_s+1)),skinK[1]+109,skinK[2]*1.5, tocolor(255,255,255,255 ), 1, expertfont, "left", "top", false, false, false, true)

	--	Rotate Hover
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
		if(dobozbaVan(120 + skinK[1] - 1,sy/2-555 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,16,28, cursorX, cursorY)) then
			dxDrawImage(120 + skinK[1] - 1,sy/2-555 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,16,28,"arquivos/cima-c.png",90,0,0,tocolor(255,255,255,255),true)-- Rotate
		end
	end		
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
		if(dobozbaVan(75 + skinK[1] - 1,sy/2-555 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,16,28, cursorX, cursorY)) then
			dxDrawImage(75 + skinK[1] - 1,sy/2-555 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,16,28,"arquivos/baixo-c.png",90,0,0,tocolor(255,255,255,255),true)-- Rotate
		end
	end	
end

function menuPont(gomb,stat,x,y)
	if gomb == "left" and stat == "down" then
		if (dobozbaVan(120 + skinK[1] - 1,sy/2-555 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,16,28,x,y)) then
			outputDebugString("Rotate +")
			Rotatcio = Rotatcio + 20
			setPedRotation(skinped,Rotatcio)
		end		
		if (dobozbaVan(75 + skinK[1] - 1,sy/2-555 + (skinK[2]*(max_s+1)) + skinK[2]*2 - 52,16,28,x,y)) then
			outputDebugString("Rotate -")
			Rotatcio = Rotatcio - 20
			setPedRotation(skinped,Rotatcio)
			outputDebugString("Rotate -")
		end				
			
	end
end




addEventHandler("onClientClick", getRootElement(), function(button, state)
	if(button=="left" and state=="down" and clickedLegend)then
		renderLegend = true
	end
end)
		
local Valasztott = 0

addEventHandler("onClientKey", root, function(g, v)
	if not panelState or not v then return end
	if g == "backspace" then
		setElementData(localPlayer,"skinshop",false)
		executeCommandHandler("togradar")
		panelState = false
		removeEventHandler("onClientRender", getRootElement(), RenderDX)
		removeEventHandler("onClientClick", getRootElement(), menuPont)
		destroyElement(skinped)
		setCameraTarget(localPlayer)
		currskin = 1
		showCursor(false)
		showChat(true)
		showPlayerHudComponent("radar",false)
		oldal = 1
		--setElementDimension(localPlayer,0)
		setElementFrozen(localPlayer,false)
		Slot = 1
	elseif g == "arrow_u" then
		currskin = currskin -1
		if(currskin<1)then
			currskin = #skinek_1
		end
		if oldal == 1 then
			setElementModel(skinped, skinek_1[currskin][1])
		elseif oldal == 2 then
			setElementModel(skinped, skinek_2[currskin][1])
		elseif oldal == 3 then
			setElementModel(skinped, skinek_3[currskin][1])
		elseif oldal == 4 then
			setElementModel(skinped, skinek_4[currskin][1])
		end	
	elseif g == "arrow_r" then
		currskin = 1
		if oldal == 1 then
			oldal = 2
		elseif oldal == 2 then
			oldal = 3
		elseif oldal == 3 then
			oldal = 4
		end	
	elseif g == "arrow_l" then
		currskin = 1
		if oldal == 4 then
			oldal = 3
		elseif oldal == 3 then
			oldal = 2
		elseif oldal == 2 then
			oldal = 1
		end	
	elseif g == "arrow_d" then
		currskin = currskin + 1
		if(currskin>#skinek_1)then
			currskin = 1
		end
		if oldal == 1 then
			setElementModel(skinped, skinek_1[currskin][1])
		elseif oldal == 2 then
			setElementModel(skinped, skinek_2[currskin][1])
		elseif oldal == 3 then
			setElementModel(skinped, skinek_3[currskin][1])
		elseif oldal == 4 then
			setElementModel(skinped, skinek_4[currskin][1])
		end	
	elseif g == "enter" then
	if getPlayerMoney(localPlayer) >= 30 then
		if oldal == 1 then
			Valasztott = skinek_1[currskin][1]
		elseif oldal == 2 then
			Valasztott = skinek_2[currskin][1]
		elseif oldal == 3 then
			Valasztott = skinek_3[currskin][1]
		elseif oldal == 4 then
			Valasztott = skinek_4[currskin][1]
		end	
		triggerServerEvent("eg_skinsetS",resourceRoot,localPlayer,Valasztott )
		
		-- ##
		setElementData(localPlayer,"skinshop",false)
		executeCommandHandler("togradar")
		panelState = false
		removeEventHandler("onClientRender", getRootElement(), RenderDX)
		removeEventHandler("onClientClick", getRootElement(), menuPont)
		destroyElement(skinped)
		setCameraTarget(localPlayer)
		currskin = 1
		showCursor(false)
		showChat(true)
		showPlayerHudComponent("radar",false)
		oldal = 1
		--setElementDimension(localPlayer,0)
		setElementFrozen(localPlayer,false)
		Slot = 1
	else
		outputChatBox("#ffffff[#77b64cexpertGaming#ffffff] Nincs elég pénzed!")
	end
	end
end)

for i, s in pairs ( SkinLocs ) do
	local xm, ym, zm = unpack ( s.markerPos )
	local xo, yo, zo = unpack ( s.outPos )
	local xi, yi, zi = unpack ( s.inPos )
	markers[i] = createMarker ( xm, ym, zm - 1, "cylinder", 2.5, 255, 50, 50, 200 )
	setElementInterior ( markers[i], s.int )
	setElementDimension ( markers[i], s.dim )
	
	warpin[i] = exports.VDBGWarpManager:makeWarp ( { namewarp = s.namewarp, pos = {  xo, yo, zo+2 }, toPos = { xi, yi, zi+2 }, cInt = 0, cDim = 0, tInt = s.int, tDim = s.dim } )
	warpout[i] = exports.VDBGWarpManager:makeWarp ( { namewarp = s.namewarp, pos = { xi, yi, zi+1 }, toPos = { xo, yo, zo+2 }, cInt = s.int, cDim = s.dim, tInt = 0, tDim = 0 } )
	blips = createBlip ( xo, yo, zo, 45, 2, 255, 255, 255, 255, 0, 450 )
	local d = {
		int = s.int,
		dim = s.dim
	}
	setElementData ( markers[i], "VDBGShops:Skins->MarkerInfo", d )
	addEventHandler ( "onClientMarkerHit", markers[i], markerHit )
end

-------------------------a
function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end