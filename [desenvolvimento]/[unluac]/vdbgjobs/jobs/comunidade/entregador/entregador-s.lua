local DEL_DIV = 3
local busyDeliverers = {}
local deliveryVehicles = {[459]=true, [482]=true}
local deliveryBaseLS = createMarker(2291.87, -2332.15, 12.55, "cylinder", 3.5, 255, 255, 255)
local deliveryBaseSF = createMarker(-1823.96, -172.7, 8.4, "cylinder", 3.5, 255, 255, 255)

deliverySpotsDel = {
	{2398.414, -1509.642, 22}, -- Mount Chilliad, Whestone
	{2519.627, -1468.868, 22}, -- East Los Santos, Los Santos
	{2121.356, -1144.714, 23}, -- Jefferson, Los Santos
	{1216.301, -907.729, 42}, -- Mulholland, Los Santos
	{1003.75, -940.706, 41}, -- Temple, Los Santos
	{965.842, -1382.407, 12}, -- Market, Los Santos
	{801.447, -1629.5, 12}, -- Marina, Los Santos
	{-267.641, -2161.526, 27}, -- Los Santos Inlet, Flint County
	{-88.802, -1164.147, 1}, -- Flint County
	{20.415, -2637.626, 39}, -- Flint County
	{-1609.196, -2718.643, 47}, -- Whetstone
	{-2157.958, -2467.311, 29}, -- Angel Pine
	{-1891.792, -1693.129, 20}, -- Whetstone
	{-521.399, -543.341, 24}, -- Fallen Tree, Red County
	{649.97, -559.393, 15}, -- Dillimore, Red County
	{-1038.423, -640.605, 31}, -- Easter Bay Chemicals, Red County
	{884.171, -1195.644, 16}, -- Vinewood, Los Santos
	{2281.561, 63.721, 25}, -- Palomino Creek, Red County
	{790.28, -606.829, 15}, -- Dillimore, Red County
	{169.851, -183.735, 2}, -- Blueberry, Red County
	{-116.368, -225.582, 2}, -- Red County
	{89.099, -282.075, 2}, -- Blueberry, Red County
	{1198.643, 256.693, 18}, -- Montgomery, Red County
	{1357.177, 233.117, 17}, -- Montgomery, Red County
	{1385.123, 461.334, 18}, -- Red County
	{1646.942, 752.759, 10}, -- Randpolph Industrial Estate, Las Venturas
	{1634.034, 961.359, 10}, -- LVA Freight Depot, Las Venturas
	{1423.46, 1044.671, 10}, -- LVA Freight Depot, Las Venturas
	{1684.162, 1790.947, 10}, -- Las Venturas Airport, Las Venturas
	{1684.997, 2244.157, 10}, -- Redsands West, Las Venturas
	{1682.781, 2359.221, 10},
	{1537.424, 2346.401, 10},
	{1409.475, 2340.485, 10},
	{1086.356, 2365.737, 10},
	{1055.549, 2263.586, 10},
	{990.643, 2114.707, 10},
	{1101.76, 2132.301, 10},
	{1168.243, 2084.811, 10},
	{1076.526, 1916.716, 10},
	{2706.45, 832.429, 8.6},
	{2822.234, 965.827, 10},
	{2789.438, 2004.152, 10},
	{2794.552, 2576.938, 10},
	{2400.218, 2755.336, 10},
	{2150.116, 2748.542, 10},
	{2151.506, 2801.273, 10},
	{1477.667, 2367.26, 10},
	{605.248, 1704.666, 6},
	{243.932, 1421.17, 9},
	{-300.593, 1775.217, 41},
	{291.775, 2535.944, 15},
	{-538.446, 2552.856, 52},
	{-285.13, 2601.654, 62},
	{-904.84, 2690.567, 41},
	{-1330.084, 2682.939, 49},
	{-1531.32, 2570.573, 56},
	{-1209.76, 1840.629, 41},
	{-1468.701, 1863.919, 31},
	{-1954.8, 2375.42, 48}, -- Tierra Robada
	{-2506.713, 2343.903, 3},
	{-2287.555, 2283.305, 3},
	{-2695.894, 1423.804, 6},
	{-2786.969, 765.864, 49},
	{-2404.569, 979.483, 44},
	{-2029.872, 157.689, 28},
	{-2353.149, -142.375, 34},
	{-2535.744, -19.888, 15}, -- Hashburry, San Fierro
	{-2462.797, 781.17, 34},
	{-2144.886, -103.685, 35}
}

function getDeliveryAssignment(source, matching)
	if (not matching or getElementType(source) ~= "vehicle") then return end
	if (not deliveryVehicles[getElementModel(source)]) then return end
	local player = getVehicleController(source)
	if (not player) then return end
	local job = tostring ( getElementData ( player, "Job" ) or "" )
	if ( job ~= "Entregador" ) then return end
	if (busyDeliverers[player]) then return end
	busyDeliverers[player] = true
	local fourRandSpots = {}
	local delivLocs = {}
	for i=1, 4 do
		local rand = math.random(#deliverySpotsDel)
		while fourRandSpots[rand] do
			rand = math.random(#deliverySpotsDel)
		end
		if (not fourRandSpots[rand]) then
			fourRandSpots[rand] = true
			delivLocs[i] = deliverySpotsDel[rand]
		end
	end
	triggerClientEvent(player, "deliveryMan:gotJob", player, delivLocs)
end
addEventHandler("onMarkerHit", deliveryBaseLS, getDeliveryAssignment)
addEventHandler("onMarkerHit", deliveryBaseSF, getDeliveryAssignment)

function deliveryDoneJob(distance)
	local reward = math.floor(distance / DEL_DIV)
	if ( reward ) then
		triggerServerEvent ( "VDBGJobs->GivePlayerMoney", source, source, "caixas", reward, 15 )
		updateJobColumn ( getAccountName ( getPlayerAccount ( source ) ), "caixas", "AddOne" )
	end
	busyDeliverers[source] = nil
	outputChatBox ( "#d9534f[ENTREGADOR] #FFFFFFVocê recebeu: #acd373R$ "..reward".00 #FFFFFFpor entregar todas as caixas", source, 255, 255, 255, true )
	outputChatBox ( "#d9534f[ENTREGADOR] #FFFFFFVoltar para o armazém para mais trabalho.", source, 255, 255, 255, true )
end
addEvent("delivery:doneJob", true)
addEventHandler("delivery:doneJob", root, deliveryDoneJob)