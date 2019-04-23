local rootElement = getRootElement()
local busses = {[431] = true, [437] = true}
local busRoutes = {}
local started = {}

busRoutes["Los Santos"] = {
		-- { x, y, z, isStop, stop number}
		[1]={1825.5222,-1819.0747,13.4037,true,1},
		[2]={1847.2609,-1754.3463,13.3751,false,0},
		[3]={1922.6714,-1755.9180,13.3752,true,2},
		[4]={2144.0254,-1754.4574,13.3857,false,0},
		[5]={2220.9336,-1712.7439,13.3701,false,0},
		[6]={2291.5940,-1662.8654,14.7959,true,3},
		[7]={2340.1425,-1689.7734,13.3593,false,0},
		[8]={2398.7548,-1735.1572,13.3828,false,0},
		[9]={2481.8867,-1735.1953,13.3828,true,4},
		[10]={2622.7998,-1734.9023,11.3093,false,0},
		[11]={2685.3623,-1660.2822,11.3453,false,0},
		[12]={2740.8818,-1552.9648,24.0011,false,0},
		[13]={2740.9121,-1436.5507,30.2812,true, 5},
		[14]={2735.4316,-1335.8515,47.3734,false,0},
		[15]={2621.0566,-1253.6796,48.9659,false,0},
		[16]={2424.6201,-1252.7261,23.6982,true,6},
		[17]={2374.0664,-1225.7890,27.1437,false,0},
		[18]={2339.6667,-1151.8619,26.9376,false,0},
		[19]={2154.5393,-1113.0920,25.3323,true,7},
		[20]={2065.9500,-1155.1235,23.6985,false,0},
		[21]={2065.6633,-1254.4645,23.8122,false,0},
		[22]={1997.7284,-1257.4001,23.8125,true,8},
		[23]={1846.0527,-1279.8642,12.9596,false,0},
		[24]={1821.1875,-1574.8125,13.3536,true,9},
		[25]={1766.5739,-1602.9021,13.3683,false,0},
		[26]={1491.5818,-1588.4076,13.3745,true,10},
		[27]={1360.0137,-1578.5935,13.3768,false,0},
		[28]={1351.8754,-1474.9437,13.3749,false,0},
		[29]={1361.4806,-1288.0685,13.3491,true,11},
		[30]={1364.6495,-1094.6451,24.1111,false,0},
		[31]={1333.6823,-924.2286,36.0750,false,0},
		[32]={1112.4703,-942.3127,42.6810,true,12},
		[33]={1047.8228,-1036.9039,31.8199,false,0},
		[34]={959.0685,-1119.5323,23.6708,true,13},
		[35]={873.3333,-1139.9399,23.7442,false,0},
		[36]={759.7260,-1049.3702,23.8522,false,0},
		[37]={573.0375,-1221.7246,17.5006,true,14},
		[38]={430.7755,-1324.5621,14.8815,false,0},
		[39]={198.4696,-1476.8871,12.7383,false,0},
		[40]={110.9657,-1638.4880,10.0730,false,0},
		[41]={167.6030,-1740.0616,4.4372,true,15},
		[42]={317.3379,-1741.2506,4.3995,false,0},
		[43]={419.5071,-1774.9253,5.2732,false,0}, 
		[44]={530.0619,-1733.6987,12.1128,false,0},
		[45]={787.5512,-1785.6987,13.1211,false,0},
		[46]={813.1080,-1717.0001,13.3753,false,0},
		[47]={854.2473,-1602.5085,13.3834,true,16},
		[48]={920.4056,-1507.9554,13.3641,false,0},
		[49]={959.7448,-1408.3657,13.1925,false,0},
		[50]={1165.9882,-1409.5631,13.3811,true,17},
		[51]={1290.8201,-1408.6349,13.0440,false,0},
		[52]={1297.5280,-1540.7646,13.2577,false,0},
		[53]={1293.6631,-1814.7549,13.2578,true,18},
		[54]={1352.7914,-1867.4207,13.2579,false,0},
		[55]={1391.5159,-1755.3124,13.2578,false,0},
		[56]={1459.4001,-1736.0459,13.3752,true,19},
		[57]={1667.8722,-1735.0980,13.3747,false,0},
		[58]={1767.8871,-1829.3638,13.2578,true,20},
	}

busRoutes["San Fierro"] = {
	-- { x, y, z, isStop, stop number}
	[1]={-2004.5703125,-53.552734375,34.298252105713,false},
	[2]={-2148.7099609375,-67.7998046875,34.30525970459,true},
	[3]={-2351.9873046875,-68.44140625,34.297409057617,false},
	[4]={-2274.587890625,47.4296875,34.29740524292,true},
	[5]={-2248.7548828125,174.4375,34.305137634277,false},
	[6]={-2224.361328125,489.9091796875,34.148761749268,true},
	[7]={-2024.376953125,501.5791015625,34.147701263428,true},
	[8]={-1896.7646484375,622.1181640625,34.145721435547,false},
	[9]={-1895.0107421875,815.767578125,34.606506347656,true},
	[10]={-1814.103515625,914.4287109375,23.928504943848,false},
	[11]={-1789.6689453125,1083.7099609375,44.188053131104,true},
	[12]={-1880.125,1155.15625,44.430370330811,false},
	[13]={-2046.7041015625,1182.302734375,44.430198669434,true},
	[14]={-2236.517578125,1181.255859375,54.711437225342,false},
	[15]={-2270.861328125,880.955078125,65.631683349609,true},
	[16]={-2270.185546875,686.83984375,48.430233001709,false},
	[17]={-2269.6669921875,588.8408203125,36.482364654541,true},
	[18]={-2507.59375,569.5859375,13.610645294189,false},
	[19]={-2588.3076171875,470.2373046875,13.593816757202,true}	,
	[20]={-2608.41796875,344.0419921875,3.3191819190979,false},
	[21]={-2708.0908203125,303.75,3.3126063346863,true},
	[22]={-2707.470703125,98.7509765625,3.3089895248413,false},
	[23]={-2708.1435546875,-192.6484375,3.3130583763123,true},
	[24]={-2419.296875,-87.4541015625,34.306995391846,false},
	[25]={-2277.71875,-72.5234375,34.297630310059,true},
	[26]={-2164.3369140625,15.0380859375,34.304836273193,true},
	[27]={-2027.4130859375,26.73046875,33.169208526611,false},
	[28]={-1990.47265625,148.20703125,26.672004699707,true},
}
--[[
local locations = {}

addCommandHandler("addloc",
function (player, cmd, stop)
	local index = #locations +1
	local x, y, z = getElementPosition(player)
	locations[index] = {x, y, z-1, stop}
end)

addCommandHandler("getlocs",
function (player)
	for index, location in pairs(locations) do
		local position = tostring(location[1])..","..tostring(location[2])..","..tostring(location[3])..","..tostring(location[4])
		outputChatBox("["..tostring(index).."]={"..position.."},",player)
	end
end)]]

function setNewBusLocation(thePlayer, city, ID)
	if busRoutes[city] and busRoutes[city][ID] then
		local x, y, z = unpack(busRoutes[city][ID])
		triggerClientEvent(thePlayer,"bus_set_location",thePlayer,x,y,z)
	end
end

local timer = {}
setTimer( function()
	for _, thePlayer in pairs(getElementsByType("player")) do
		if timer[thePlayer] == true then
			timer[thePlayer] = false
		end
	end
end, 300000, 0)

addCommandHandler("mrota",
function (thePlayer)
	if not isPedInVehicle(thePlayer) then return end
	if timer[thePlayer] then outputChatBox ( "#d9534f[M:ÔNIBUS] #FFFFFFAguarde 5 minutos para iniciar uma nova rota.", thePlayer, 255, 255, 255, true ) return end 
	if started[thePlayer] then outputChatBox ( "#d9534f[M:ÔNIBUS] #FFFFFFSua rota já foi iniciada, finalize-a.", thePlayer, 255, 255, 255, true ) return end
	if not busses[getElementModel(getPedOccupiedVehicle(thePlayer))] then return end
		local job = tostring ( getElementData ( thePlayer, "Job" ) or "" )
		if ( job == "Motorista" ) then
		local city = getElementZoneName(thePlayer, true)
		setElementData(thePlayer,"busData",1)
		setNewBusLocation(thePlayer, city, 1)
		started[thePlayer] = true
		timer[thePlayer] = true
		outputChatBox ( "#d9534f[M:ÔNIBUS] #FFFFFFSua rota começou, fique de olho no seu radar.", thePlayer, 255, 255, 255, true )
	end
end)

addEventHandler("onVehicleEnter",root,
function (thePlayer)
	if not busses[getElementModel(source)] then return end
	started[thePlayer] = false
	local job = tostring ( getElementData ( thePlayer, "Job" ) or "" )
	if ( job == "Motorista" ) then
		outputChatBox ( "#d9534f[M:ÔNIBUS]#FFFFFF Use #ffa500/mrota#FFFFFF para iniciar uma rota.", thePlayer, 255, 255, 255, true )
	end
end)


addEvent("bus_finish",true)
addEventHandler("bus_finish",rootElement,
function (client)
	if not isPedInVehicle(client) then return end
	if not busses[getElementModel(getPedOccupiedVehicle(client))] then return end
	local city = getElementZoneName(client, true)	
	if busRoutes[city][tonumber(getElementData(client,"busData"))][4] then
	local reward = math.random(50, 250)
	
	if ( reward ) then
		triggerEvent ( "VDBGJobs->GivePlayerMoney", source, source, "paradasbus", reward, 1 )
		triggerEvent ( "VDBGJobs->SQL->UpdateColumn", source, source, "paradasbus", "AddOne" )
	end
	
	outputChatBox ( "#d9534f[M:ÔNIBUS]#FFFFFF Você fez uma parada, e ganhou: #acd373R$:"..reward..".00", source, 255, 255, 255, true )
	end
	if #busRoutes[city] == tonumber(getElementData(client,"busData")) then
		outputChatBox ( "#d9534f[M:ÔNIBUS]#FFFFFF Você terminou sua rota, volte para a estação para bater o cartão.", thePlayer, 255, 255, 255, true )
		started[thePlayer] = false
	else
		setElementData(client,"busData",tonumber(getElementData(client,"busData"))+1)
		setNewBusLocation(client, city, tonumber(getElementData(client,"busData")))
	end
end)

