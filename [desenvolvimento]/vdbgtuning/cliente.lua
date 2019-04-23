local x,y = guiGetScreenSize()
local font = dxCreateFont("arquivos/font.ttf", 11)
local menucount = 0
local lastmenuitem = -1
local upgradecount = 0
local lastupgradeitem = -1
local lastupgradetext = ""
local vehicle = nil
local upgrade_names = {"Hood","Vent","Spoiler","Sideskirt","Front Bullbars","Rear Bullbars","Headlights","Roof","Nitro","Hydraulics","Stereo","Unknown","Wheels","Exhaust","Front Bumper","Rear Bumper","Misc"}
local lastupgradeid = -1
local lastmenutext = ""
local lastclickedtext = ""
local mutat = true
local sell = true
local sell_cursor = true
local lastupgradedindexonslot = -1
local lastupgradeprice = 0
local sx, sy = guiGetScreenSize()
VehicleUpgrades = {
   {itemid="1000",name="Pro",price="400"},
   {itemid="1001",name="Win",price="550"},
   {itemid="1002",name="Drag",price="200"},
   {itemid="1003",name="Alpha",price="250"},
   {itemid="1004",name="Champ Scoop",price="100"},
   {itemid="1005",name="Fury Scoop",price="150"},
   {itemid="1006",name="Roof Scoop",price="80"},
   {itemid="1007",name="R Sideskirt",price="500"},

   {itemid="1008",name="5x Nitro",price="500"},
   {itemid="1009",name="2x Nitro",price="200"},
   {itemid="1010",name="10x Nitro",price="1000"},
   {itemid="1011",name="Race Scoop",price="220"},
   {itemid="1012",name="Worx Scoop",price="250"},
   {itemid="1013",name="Round Fog Lamp",price="100"},
   {itemid="1014",name="Champ Spoiler",price="400"},
   {itemid="1015",name="Race Spoiler",price="500"},
   {itemid="1016",name="Worx Spoiler",price="200"},

   {itemid="1017",name="L Sideskirt",price="500"},
   {itemid="1018",name="Upsweptc Exhaust",price="350"},
   {itemid="1019",name="Twin Cylinder Exhaust",price="300"},
   {itemid="1020",name="Large Exhaust",price="250"},
   {itemid="1021",name="Medium Exhaust",price="200"},
   {itemid="1022",name="Small Exhaust",price="150"},
   {itemid="1023",name="Fury Spoiler",price="350"},
   {itemid="1024",name="Square Fog Lamp",price="50"},
   {itemid="1025",name="Off Road",price="1000"},

   {itemid="1026",name="R Alien Sideskirt",price="480"},
   {itemid="1027",name="L Alien Sideskirt",price="480"},
   {itemid="1028",name="Alien Exhaust",price="770"},
   {itemid="1029",name="X-Flow Exhaust",price="680"},
   {itemid="1030",name="L X-Flow Sideskirt",price="370"},
   {itemid="1031",name="R X-Flow Sideskirt",price="370"},
   {itemid="1032",name="Alien Roof Scoop",price="170"},
   {itemid="1033",name="X-Flow Roof Scoop type 2",price="120"},
   {itemid="1034",name="Alien Exhaust",price="790"},

   {itemid="1035",name="X-Flow Exhaust",price="150"},
   {itemid="1036",name="R Alien Sideskirt",price="500"},
   {itemid="1037",name="X-Flow Exhaust",price="690"},
   {itemid="1038",name="Alien Roof Scoop",price="190"},
   {itemid="1039",name="L X-Flow Sideskirt",price="390"},
   {itemid="1040",name="L Alien Sideskirt",price="500"},
   {itemid="1041",name="R X-Flow Sideskirt",price="390"},
   {itemid="1042",name="R Chrome Sideskirt",price="1000"},
   {itemid="1043",name="Slamin Exhaust",price="500"},

   {itemid="1044",name="Chrome Exhaust",price="500"},
   {itemid="1045",name="X-Flow Exhaust",price="510"},
   {itemid="1046",name="Alien Exhaust",price="710"},
   {itemid="1047",name="R Alien Sideskirt",price="670"},
   {itemid="1048",name="R X-Flow Sideskirt",price="530"},
   {itemid="1049",name="Alien Spoiler 1",price="810"},
   {itemid="1050",name="X-Flow Spoiler 1",price="620"},
   {itemid="1051",name="L Alien Sideskirt",price="670"},
   {itemid="1052",name="L X-Flow Sideskirt",price="530"},

   {itemid="1053",name="X-Flow Roof Scoop",price="130"},
   {itemid="1054",name="Alien Roof Scoop",price="210"},
   {itemid="1055",name="Alien Roof Scoop",price="230"},
   {itemid="1056",name="R Alien Sideskirt",price="520"},
   {itemid="1057",name="R X-Flow Sideskirt",price="430"},
   {itemid="1058",name="Alien Spoiler 2",price="620"},
   {itemid="1059",name="X-Flow Exhaust",price="720"},
   {itemid="1060",name="X-Flow Spoiler 2",price="530"},
   {itemid="1061",name="X-Flow Roof Scoop",price="180"},

   {itemid="1062",name="L Alien Sideskirt",price="520"},
   {itemid="1063",name="L X-Flow Sideskirt",price="430"},
   {itemid="1064",name="Alien Exhaust",price="830"},
   {itemid="1065",name="Alien Exhaust",price="850"},
   {itemid="1066",name="X-Flow Exhaust",price="750"},
   {itemid="1067",name="Alien Roof Scoop",price="250"},
   {itemid="1068",name="X-Flow Roof Scoop",price="200"},
   {itemid="1069",name="R Alien Sideskirt",price="550"},
   {itemid="1070",name="R X-Flow Sideskirt",price="450"},

   {itemid="1071",name="L Alien Sideskirt",price="550"},
   {itemid="1072",name="L X-Flow SIdeskirt",price="450"},
   {itemid="1073",name="Shadow",price="1100"},
   {itemid="1074",name="Mega",price="1030"},
   {itemid="1075",name="Rimshine",price="980"},
   {itemid="1076",name="Wires",price="1560"},
   {itemid="1077",name="Classic",price="1620"},
   {itemid="1078",name="Twist",price="1200"},
   {itemid="1079",name="Cutter",price="1030"},

   {itemid="1080",name="Switch",price="900"},
   {itemid="1081",name="Grove",price="1230"},
   {itemid="1082",name="Import",price="820"},
   {itemid="1083",name="Dollar",price="1560"},
   {itemid="1084",name="Trance",price="1350"},
   {itemid="1085",name="Atomic",price="770"},
   {itemid="1086",name="Stereo",price="100"},
   {itemid="1087",name="Hydraulics",price="1500"},
   {itemid="1088",name="Alien Roof Scoop",price="150"},

   {itemid="1089",name="X-Flow Exhaust",price="650"},
   {itemid="1090",name="R Alien Sideskirt",price="450"},
   {itemid="1091",name="X-Flow Exhaust",price="100"},
   {itemid="1092",name="Alien Exhaust",price="750"},
   {itemid="1093",name="R X-Flow Sideskirt",price="350"},
   {itemid="1094",name="L Alien Sideskirt",price="450"},
   {itemid="1095",name="R X-Flow Sideskirt",price="350"},
   {itemid="1096",name="Ahab",price="1000"},
   {itemid="1097",name="Virtual",price="620"},

   {itemid="1098",name="Access",price="1140"},
   {itemid="1099",name="L Chrome Sideskirt",price="1000"},
   {itemid="1100",name="Chrome Grill",price="940"},
   {itemid="1101",name="L Chrome Flames",price="780"},
   {itemid="1102",name="L Chrome Strip",price="830"},
   {itemid="1103",name="Convertible Roof",price="3250"},
   {itemid="1104",name="Chrome Exhaust",price="1610"},
   {itemid="1105",name="Slamin Exhaust",price="1540"},
   {itemid="1106",name="R Chrome Arches",price="780"},

   {itemid="1107",name="L Chrome Strip",price="780"},
   {itemid="1108",name="R Chrome Strip",price="780"},
   {itemid="1109",name="Chrome R Bullbars",price="1610"},
   {itemid="1110",name="Slamin R Bullbars",price="1540"},
   {itemid="1111",name="Front Sign",price="100"},
   {itemid="1112",name="Front Sign",price="100"},
   {itemid="1113",name="Chrome Exhaust",price="1650"},
   {itemid="1114",name="Slamin Exhaust",price="1590"},
   {itemid="1115",name="Chrome Bullbars",price="2130"},

   {itemid="1116",name="Slamin Bullbars",price="2050"},
   {itemid="1117",name="Chrome F Bumper",price="2040"},
   {itemid="1118",name="R Chrome Trim",price="720"},
   {itemid="1119",name="R WHeelcovers",price="940"},
   {itemid="1120",name="L Chrome Trim",price="940"},
   {itemid="1121",name="L Wheelcovers",price="940"},
   {itemid="1122",name="R Chrome Flames",price="780"},
   {itemid="1123",name="Chrome Bars",price="860"},
   {itemid="1124",name="L Chrome Arches",price="780"},

   {itemid="1125",name="Chrome Lights",price="1120"},
   {itemid="1126",name="Chrome Exhaust",price="3340"},
   {itemid="1127",name="Slamin Exhaust",price="3250"},
   {itemid="1128",name="Vinyl Hardtop",price="3340"},
   {itemid="1129",name="Chrome Exhaust",price="1650"},
   {itemid="1130",name="Hardtop",price="3380"},
   {itemid="1131",name="Softtop",price="3290"},
   {itemid="1132",name="Slamin Exhaust",price="1590"},
   {itemid="1133",name="R Chrome Strip",price="830"},

   {itemid="1134",name="R Chrome Strip",price="800"},
   {itemid="1135",name="Slamin Exhaust",price="1500"},
   {itemid="1136",name="Chrome Exhaust",price="1000"},
   {itemid="1137",name="L Chrome Strip",price="800"},
   {itemid="1138",name="Alien Spoiler 3",price="580"},
   {itemid="1139",name="X-Flow Spoiler 3",price="470"},
   {itemid="1140",name="X-Flow R Bumper",price="870"},
   {itemid="1141",name="ALien R Bumper",price="980"},
   {itemid="1142",name="Left Oval Vents",price="500"},

   {itemid="1143",name="R Oval Vents",price="500"},
   {itemid="1144",name="L Square Vents",price="500"},
   {itemid="1145",name="R Square Vents",price="500"},
   {itemid="1146",name="X-Flow Spoiler 4",price="490"},
   {itemid="1147",name="Alien Spoiler 4",price="500"},
   {itemid="1148",name="X-Flow R Bumper",price="500"},
   {itemid="1149",name="EAlien R Bumper",price="1000"},
   {itemid="1150",name="Alien R Bumper",price="1090"},
   {itemid="1151",name="X-Flow R Bumper",price="840"},

   {itemid="1152",name="X-Flow F Bumper",price="910"},
   {itemid="1153",name="Alien F Bumper",price="1200"},
   {itemid="1154",name="Alien R Bumper",price="1030"},
   {itemid="1155",name="Alien F Bumper",price="1030"},
   {itemid="1156",name="X-Flow R Bumper",price="920"},
   {itemid="1157",name="X-Flow F Bumper",price="930"},
   {itemid="1158",name="X-Flow Spoiler 5",price="550"},
   {itemid="1159",name="Alien R Bumper",price="1050"},
   {itemid="1160",name="Alien F Bumper",price="1050"},

   {itemid="1161",name="X-Flow R Bumper",price="950"},
   {itemid="1162",name="Alien Spoiler 5",price="650"},
   {itemid="1163",name="X-Flow Spoiler 6",price="450"},
   {itemid="1164",name="Alien Spoiler 6",price="550"},
   {itemid="1165",name="X-Flow F Bumper",price="850"},
   {itemid="1166",name="Alien F Bumper",price="950"},
   {itemid="1167",name="X-Flow R Bumper",price="850"},
   {itemid="1168",name="Alien R Bumper",price="950"},
   {itemid="1169",name="Alien F Bumper",price="970"},

   {itemid="1170",name="X-Flow F Bumper",price="880"},
   {itemid="1171",name="Alien F Bumper",price="990"},
   {itemid="1172",name="X-Flow F Bumper",price="900"},
   {itemid="1173",name="X-Flow F Bumper",price="950"},
   {itemid="1174",name="Chrome F Bumper",price="1000"},
   {itemid="1175",name="Slamin R Bumper",price="900"},
   {itemid="1176",name="Chrome F Bumper",price="1000"},
   {itemid="1177",name="Slamin R Bumper",price="900"},
   {itemid="1178",name="Slamin R Bumper",price="2050"},

   {itemid="1179",name="Chrome F Bumper",price="2150"},
   {itemid="1180",name="Chrome R Bumper",price="2130"},
   {itemid="1181",name="Slamin F Bumper",price="2040"},
   {itemid="1182",name="Chrome F Bumper",price="2150"},
   {itemid="1183",name="Slamin R Bumper",price="2050"},
   {itemid="1184",name="Chrome R Bumper",price="2150"},
   {itemid="1185",name="Slamin F Bumper",price="2040"},
   {itemid="1186",name="Slamin R Bumper",price="2095"},
   {itemid="1187",name="Chrome R Bumper",price="2175"},

   {itemid="1188",name="Slamin F Bumper",price="2080"},
   {itemid="1189",name="Chrome F Bumper",price="2200"},
   {itemid="1190",name="Slamin F Bumper",price="1200"},
   {itemid="1191",name="Chrome F Bumper",price="1040"},
   {itemid="1192",name="Chrome R Bumper",price="940"},
   {itemid="1193",name="Slamin R Bumper",price="1100"},
}

local function isInBox( x, y, xmin, xmax, ymin, ymax )
	return x >= xmin and x <= xmax and y >= ymin and y <= ymax
end

function addMenuItem(name, cursor, font, size)
	if not font then
		font = "normal"
	end
	if not size then
		size = 1
	end
	if size>1.6 then
		size = 1.6
	end
	if size<0.5 then
		size = 0.5
	end
	w = 20 * menucount
	local r = 0
	local g = 0
	local b = 0
	local a = 150
	if isCursorShowing () and cursor then
		local cx,cy = getCursorPosition()
		cx,cy = cx*x,cy*y
		if (isInBox(cx, cy, 20, 320, 50 + w, 50+ w + 20)) then
			r = 150
			g = 150
			b = 150
			a = 170
			lastmenuitem = menucount
			lastmenutext = name
			if (lastclickedid==-1)then
			lastupgradeid = getUpgradeIdFromName(lastmenutext)
			lastupgradedindexonslot = getVehicleUpgradeOnSlot ( vehicle, lastupgradeid-1 ) or -1
			end
			if(name=="Motor")then
				lastmenuitem = 100
			end
			--outputChatBox(name..": "..lastupgradedindexonslot)
		end
	end
	if(lastclickedtext==name)then
	    r = 200
		g = 200
		b = 200
		a = 200
		lastclickedid = getUpgradeIdFromName(name)
		lastupgradedindexonslot = getVehicleUpgradeOnSlot ( vehicle, lastclickedid-1 ) or -1
		if(lastmenutext=="Motor")then
			lastclickedid = 100
		end
	end

	--dxDrawImage(sx/2 - 1004/2, sy/2 - 756/2, 318, 52,"arquivos/bg.png",0,0,tocolor(255,255,255,255))
	dxDrawImage( 10, 6 , 318, 52, "arquivos/bg.png",0,0,tocolor (255,255,255,255) )
	dxDrawRectangle ( 17, 480 , 306, 3, tocolor ( 0,0,0,255 ) )
	dxDrawRectangle ( 320, 50  , 3, 430, tocolor ( 0,0,0,255 ) )
	dxDrawRectangle ( 17, 50  , 3, 430, tocolor ( 0,0,0,255 ) )
	dxDrawRectangle ( 20, 50 + w, 300, 20, tocolor ( r, g, b, a ) )
	dxDrawRectangle ( 20, 70 + w, 302, -20, tocolor ( 0, 0, 0, 122 ) )
	dxDrawText ( name, 20, 70 + w, 320, 50 + w, tocolor ( 255, 255, 255, 255 ), size, font, "center", "center" )
	
	menucount=menucount+1

end

function addMenuItemDouble(name, price, data, cursor, font, size)
	if not font then
		font = "normal"
	end
	if not size then
		size = 1
	end
	if size>1.6 then
		size = 1.6
	end
	if size<0.5 then
		size = 0.5
	end
	w = 20 * menucount
	local r = 0
	local g = 0
	local b = 0
	local a = 150
	if isCursorShowing () and cursor then
		local cx,cy = getCursorPosition()
		cx,cy = cx*x,cy*y
		if (isInBox(cx, cy, 20, 320, 50 + w, 50+ w + 20)) then
			r = 150
			g = 150
			b = 150
			a = 170
			
			lastmenuitem = menucount
			lastmenutext = name
			if (lastclickedid==-1)then
			lastupgradeid = getUpgradeIdFromName(lastmenutext)
			lastupgradedindexonslot = getVehicleUpgradeOnSlot ( vehicle, lastupgradeid-1 ) or -1
			end
			if(data~=nil and getElementData(vehicle, data) or false)then
				sell_cursor = true
			end
			--outputChatBox(name..": "..lastupgradedindexonslot)
		end
	end
	if(data~=nil and getElementData(vehicle, data) or false)then
		
		r = 66
		g = 139
		b = 202
		a = 200
		sell = true
		price = "Comprado"
	end
	dxDrawRectangle ( 20, 50 + w, 300, 20, tocolor ( r, g, b, a ) )
	dxDrawText ( name, 20, 70 + w, 320, 50 + w, tocolor ( 255, 255, 255, 255 ), size, font, "left", "center" )
	dxDrawText ( price, 20, 70 + w, 320, 50 + w, tocolor ( 255, 255, 255, 255 ), size, font, "right", "center" )
	menucount=menucount+1
end

function addUpgradeItem(name, cursor, font, size, onprice)
	if not font then
		font = "normal"
	end
	if not size then
		size = 1
	end
	if size>1.6 then
		size = 1.6
	end
	if size<0.5 then
		size = 0.5
	end
	sell = false
	w = 20 * upgradecount
	local r = 0
	local g = 0
	local b = 0
	local a = 150
	local _,price,_ = getUpgradeName(getUpgradeID(name))
	if isCursorShowing () and cursor then
		local cx,cy = getCursorPosition()
		cx,cy = cx*x,cy*y
		if (isInBox(cx, cy, 330, 630, 50 + w, 50+ w + 20)) then
			r = 150
			g = 150
			b = 150
			a = 200
			lastupgradeitem = upgradecount
			lastupgradetext = name
			lastupgradeprice = price
			if(tonumber(lastupgradedindexonslot)==tonumber(getUpgradeID(name)))then
				sell_cursor = true
				_,price,_ = getUpgradeName(getUpgradeID(name))
			end
		end
	end
	if(onprice)then
		price = onprice
	end
	if(tonumber(lastupgradedindexonslot)==tonumber(getUpgradeID(name)))then
	
		r = 66
		g = 139
		b = 202
		a = 200
		sell = true
	end
	dxDrawRectangle ( 330, 50 + w, 300, 20, tocolor ( r, g, b, a ) )
	dxDrawText ( name, 330, 70 + w, 630, 50 + w, tocolor ( 255, 255, 255, 255 ), size, font, "left", "center" )
	if (sell) then
		dxDrawText ( "Comprado", 330, 70 + w, 630, 50 + w, tocolor ( 255, 255, 255, 255 ), size, font, "right", "center" )
	else
		dxDrawText ( "R$"..price, 330, 70 + w, 630, 50 + w, tocolor ( 255, 255, 255, 255 ), size, font, "right", "center" )
	end
	upgradecount=upgradecount+1
end

function addUpgradeTitle(name)
	dxDrawRectangle ( 330, 20, 300, 30, tocolor ( 0, 0, 0, 200 ) )
	dxDrawText ( name, 330, 40, 630, 30, tocolor ( 255, 255, 255, 255 ), 1.0, font, "center", "center" )
end

function addMenuTitle(name)
	dxDrawRectangle ( 20, 20, 300, 30, tocolor ( 0, 0, 0, 200 ) )
	dxDrawText ( name, 20, 40, 320, 30, tocolor ( 255, 255, 255, 255 ), 1.0, font, "center", "center" )
end

function addMenuBack(name)
	menucount = menucount+1
	local r = 0
	local g = 0
	local b = 0
	local a = 200
	if isCursorShowing () then
		local cx,cy = getCursorPosition()
		cx,cy = cx*x,cy*y
		if (isInBox(cx, cy, 20, 320, 30 + (20*menucount), 30 + (20*menucount) + 30)) then
			r = 50
			g = 50
			b = 50
			a = 200
			lastmenuitem = -2
		end
	end
	dxDrawRectangle ( 20, 30 + (20*menucount), 300, 30, tocolor ( r, g, b, a ) )
	dxDrawText ( name, 20, 60 + (20*menucount), 320, 30 + (20*menucount), tocolor ( 255, 255, 255, 255 ), 1.0, font, "center", "center" )
end

function addUpgradeBack(name)
	upgradecount = upgradecount+1
	local r = 0
	local g = 0
	local b = 0
	local a = 200
	if isCursorShowing () then
		local cx,cy = getCursorPosition()
		cx,cy = cx*x,cy*y
		if (isInBox(cx, cy, 330, 630, 30 + (20*upgradecount), 30 + (20*upgradecount) + 30)) then
			r = 50
			g = 50
			b = 50
			a = 200
			lastupgradeitem = -2
		end
	end
	dxDrawRectangle ( 330, 30 + (20*upgradecount), 300, 30, tocolor ( r, g, b, a ) )
	dxDrawText ( name, 330, 60 + (20*upgradecount), 630, 30 + (20*upgradecount), tocolor ( 255, 255, 255, 255 ), 1.0, font, "center", "center" )
end

addEventHandler("onClientRender", getRootElement(), function()
	if(not mutat)then
		return
	end
	lastupgradeprice = 0
	menucount = 0
	lastmenuitem = -1
	upgradecount = 0
	lastupgradeitem = -1
	lastmenutext = ""
	lastupgradetext = ""
	lastclickedid = -1
	lastupgradeid = -1
	sell = false
	sell_cursor = false
	vehicle = getPedOccupiedVehicle ( getLocalPlayer() )
	if not vehicle then
		return
	end
	addMenuTitle("TUNING")
	addMenuItem("Motor", true, font,1)
	addMenuItemDouble("Motor Turbo G.50", "R$36.780,00", "turbo", true, font,1)
	addMenuItemDouble("Motor na ECU nível 1", "R$12.568,30", "enginev1", true, font,1)
	addMenuItemDouble("Motor na ECU nível 2", "R$59.987,14", "enginev2", true, font,1)
	addMenuItemDouble("Motor na ECU nível 3", "Diamantes *900", "enginev3", true, font,1)
	addMenuItem("Transmissão", true, font,1)
	addMenuItemDouble("Caixa de câmbio nível 1", "R$13.000,00", "turn", true, font,1)
	addMenuItemDouble("Caixa de câmbio nível 2", "R$17.000,00", "turn2", true, font,1)
	addMenuItemDouble("Caixa de câmbio nível 3", "Diamantes *700", "turn2", true, font,1)
	addMenuItem("Freios", true, font,1)
	addMenuItemDouble("Freios de rua", "R$10.000,00", "break", true, font,1)
	addMenuItemDouble("Freios esportivos", "R$13.500,00", "break2", true, font,1)
	addMenuItemDouble("Freios de corrida", "Diamantes *100", "break3", true, font,1)
	addMenuItemDouble("Freio com ABS", "Diamantes *400", "abs", true, font,1)
	addMenuItem("Especiais", true, font,1)
	addMenuItemDouble("Blindagem", "Diamantes *100", "break3", true, font,1)
	addMenuItemDouble("Pneus Nano", "R$ 59.000,00", "abs", true, font,1)
	addMenuItemDouble("Vidros blindado", "Diamantes *500", "abs", true, font,1)
	addMenuItemDouble("2X Refil para nitro", "R$29000", "abs", true, font,1)
	addMenuItemDouble("4X Refil para nitro", "Diamantes * 600", "abs", true, font,1)
	addMenuItem("Suspensão", true, font,1)
	addMenuItemDouble("Original", "Diamantes *100", "break3", true, font,1)
	addMenuItemDouble("Rebaixada", "R$ 59.000,00", "abs", true, font,1)
	addMenuItemDouble("De rua", "Diamantes *500", "abs", true, font,1)
	addMenuItemDouble("Competição", "R$29000", "abs", true, font,1)
	addMenuItemDouble("Corrida", "Diamantes * 600", "abs", true, font,1)
	
	addMenuBack("SAIR")

	if(lastclickedid>=0 and lastclickedid<100)then
		addUpgradeTitle(upgrade_names[lastclickedid])
		for _, upgrade in ipairs ( getUpgradesForCar(getElementModel(vehicle), upgrade_names[lastclickedid]) ) do
			addUpgradeItem(upgrade[2], true, font, 1)
		end
		addUpgradeBack("VOLTAR")
	elseif(lastupgradeid>=0)then
		addUpgradeTitle(upgrade_names[lastupgradeid])
		for _, upgrade in ipairs ( getUpgradesForCar(getElementModel(vehicle), upgrade_names[lastupgradeid]) ) do
			addUpgradeItem(upgrade[2], true, font, 1)
		end
		addUpgradeBack("VOLTAR")
	end
end)

addEventHandler("onClientClick", getRootElement(), function(button, state, cursorX, cursorY, worldX, worldY, worldZ, element)
	if(lastmenuitem>=0 and state == "down" and button == "left" and lastmenutext~="Fix Vehicle" and lastmenutext~="Turbo")then
		if(lastmenutext=="Motor")then
			lastclickedid = 100
			lastclickedtext = "Motor"
			return
		end
		lastclickedid = getUpgradeIdFromName(lastmenutext)
		lastclickedtext = lastmenutext
		playSoundFrontEnd(40)
	end
	if(lastmenuitem==-2 and state == "down" and button == "left")then
		mutat = false
		showCursor(false)
		showChat(true)
	end
	if(lastupgradeitem==-2 and state == "down" and button == "left")then
		lastupgradeid = -1
		lastclickedid = -1
		lastclickedtext = ""
	end
end)

addEventHandler("onClientDoubleClick", getRootElement(), function (button, absoluteX, absoluteY, worldX, worldY,  worldZ, clickedWorld)
	if(lastupgradeitem>=0 and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("sellCarUpgrade", getLocalPlayer(), getLocalPlayer(), vehicle, getUpgradeID(lastupgradetext), lastupgradetext)
		else
			triggerServerEvent("buyCarUpgrade", getLocalPlayer(), getLocalPlayer(), vehicle, getUpgradeID(lastupgradetext), lastupgradetext, lastupgradeprice)
		end
	end
	if(lastmenutext=="Reparar Veiculo" and button == "left")then
		triggerServerEvent("fixVehicle", getLocalPlayer(), getLocalPlayer(), vehicle, math.ceil(((100/(getElementHealth(vehicle)/10))-1)*1500))
	end
	if(lastmenutext=="Muda cor" and button == "left")then
		if (getPlayerMoney(getLocalPlayer())<1000) then
			exports.ig_radar:showNot("Não há dinheiro suficiente! \ A compra deve ser de RR$1.000!")
			return
		end
		openColorPicker()
	end
	if(lastmenutext=="Motor Turbo G.50" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "turbo")
		else
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "turbo", 2000)
		end
	end
	if(lastmenutext=="Motor na ECU nível 1" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "enginev1")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev1") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev2") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev3") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "enginev1", 1500)
		end
	end
	if(lastmenutext=="Motor na ECU nível 2" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "enginev2")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev1") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev2") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev3") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "enginev2", 4000)
		end
	end
	if(lastmenutext=="Motor na ECU nível 3" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "enginev3")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev1") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev2") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "enginev3") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "enginev3", 10000)
		end
	end
	if(lastmenutext=="Freio com ABS" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "abs")
		else
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "abs", 5000)
		end
	end
	if(lastmenutext=="Caixa de câmbio nível 1" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "turn")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "turn") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "turn2") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "turn", 3000)
		end
	end
	if(lastmenutext=="Caixa de câmbio nível 2" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "turn2")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "turn") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "turn2") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "turn2", 7000)
		end
	end
	if(lastmenutext=="Caixa de câmbio nível 3" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "turn2")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "turn") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "turn2") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "turn2", 7000)
		end
	end
	if(lastmenutext=="Freio V1" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "break")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break2") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break3") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "break", 2500)
		end
	end
	if(lastmenutext=="Freio V2" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "break2")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break2") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break3") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "break2", 6000)
		end
	end
	if(lastmenutext=="Freio V3" and button == "left")then
		if(sell_cursor)then
			triggerServerEvent("delVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "break3")
		else
			if (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break2") or false) or (getElementData(getPedOccupiedVehicle(getLocalPlayer()), "break3") or false) then
				exports.ig_radar:showNot("Már van ilyen fajta tuning a kocsiban!\nElőbb szereld ki!")
				return
			end
			triggerServerEvent("addVehHandling", getLocalPlayer(), getLocalPlayer(), vehicle, "break3", 9000)
		end
	end
end)

function getUpgradeIdFromName(name)
	for k,v in ipairs ( upgrade_names ) do
		if(v==name)then
			return k
		end
	end
	return -1
end

function getUpgradesForCar(id, type)
	local u = {}
	local element = createVehicle(id, 0,0,0)
	for k,v in ipairs ( VehicleUpgrades ) do
		local i,n,p = v.itemid,v.name,v.price
		if i and n and type == getVehicleUpgradeSlotName(i) then
			if addVehicleUpgrade ( element, i ) then
				u[#u+1] = {i,n,p}
			end
		end
	end
	destroyElement(element)
	return u
end

function idAddedUpgradesForCar(id, type)
	local u = {}
	local element = createVehicle(id, 0,0,0)
	for k,v in ipairs ( VehicleUpgrades ) do
		local i,n,p = v.itemid,v.name,v.price
		if i and n and type == getVehicleUpgradeSlotName(i) then
			if addVehicleUpgrade ( element, i ) then
				destroyElement(element)
				return true
			end
		end
	end
	destroyElement(element)
	return false
end

function isUpgradeAvailabe(daname)
		av = false
		if type(daname) == "string" then
			if daname == 'Paintjob' then
				return CheckPaintjobs()
			else
				local upgrades = getVehicleCompatibleUpgrades ( vehicle )
				if upgrades then
					if #upgrades ~= 0 then
						for upgradeKey, upgradeValue in ipairs ( upgrades ) do
							if upgradeValue then
								if tonumber(upgradeValue) then
									local slotname = getVehicleUpgradeSlotName ( tonumber(upgradeValue) )
									if slotname then
										if string.lower(slotname) == string.lower(daname) then
											av = true
										end
									end
								end
							end
						end
					end
					
				end
			end
			upgrades = nil
		end
		return av
end

function getAvaiableUpgrade(name)
	if name then
		local t = {}
		local upgrades = getVehicleCompatibleUpgrades ( vehicle )
		for upgradeKey, upgradeValue in ipairs ( upgrades ) do
			local slotname = getVehicleUpgradeSlotName ( tonumber(upgradeValue) )
			if slotname then
				if string.lower(slotname) == string.lower(name) then
					table.insert(t,upgradeValue)
				end
			end
		end
		return t
	end
end

function isUpgrade(what)
	if what then
		local id = getUpgradeID(what)
		if id then
			return true
		else
			return false
		end
	end
end

function getUpgradeName(id)
	name = false
	for k,v in ipairs ( VehicleUpgrades ) do
		local i,n,p = v.itemid,v.name,v.price
		if i and n then
			if tonumber(i) == tonumber(id) then
				name = n
				price = p
			end
		end
	end
	return name,price,id
end

function getUpgradeID(name)
	id = false
	if name then
		for k,v in ipairs ( VehicleUpgrades ) do
			local i,n,p = v.itemid,v.name,v.price
			if i and n then
				if string.lower(n) == string.lower(name) then
					id = i
				end
			end
		end
	end
	return id
end

--BIND
bindKey("j", "down", function()
	menucount = 0
	lastmenuitem = -1
	upgradecount = 0
	lastupgradeitem = -1
	vehicle = nil
	lastupgradeid = -1
	lastmenutext = ""
	lastclickedtext = ""
	mutat = not mutat
	showCursor(mutat)
	showChat(not mutat)
end)

function turbo()
	timer = setTimer(function()
		if (getPedOccupiedVehicle(getLocalPlayer())) then
			if not(getElementData(getPedOccupiedVehicle(getLocalPlayer()), "turbo") or false) then
				if isTimer(timer) then
					killTimer(timer)
				end
			end
			local cur = getVehicleCurrentGear(getPedOccupiedVehicle(getLocalPlayer()))
			if ((getElementData(getLocalPlayer(), "tuning.gear") or 0)<cur) and (cur==2 or cur>=4) then
				setElementData(getLocalPlayer(), "tuning.gear", cur)
				playSound("arquivos/turbo.wav")
			else
				setElementData(getLocalPlayer(), "tuning.gear", cur)
			end
		else
			if isTimer(timer) then
				killTimer(timer)
			end
		end
	end,50,0)
end
addEvent("playTurboSound", true)
addEventHandler("playTurboSound", getRootElement(), turbo)