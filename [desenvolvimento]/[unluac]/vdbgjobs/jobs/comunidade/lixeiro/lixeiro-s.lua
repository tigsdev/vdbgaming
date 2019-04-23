local rootElement = getRootElement()
local sweapers = {[408] = true, [574] = true}
local started = {}
sweaperRoutes = {}

sweaperRoutes["Los Santos"] = {
		[1] = {2260, -2236, 12.54},
		[2] = {2326, -2236, 12.54},
		[3] = {2455, -2150, 12.58},
		[4] = {2455, -2150, 12.58},
		[5] = {2698, -2162, 10.10},
		[6] = {2720, -2091, 10.57},
		[7] = {2732, -2001, 12.54},
		[8] = {2686, -1871, 10.05},
		[9] = {2636, -1714, 9.89},
		[10] = {2636, -1714, 9.89},
		[11] = {2504, -1344, 29.29},
}

sweaperRoutes["Las Venturas"] = {
		[1] = { 2430.5205078125, 1262.431640625, 9.443614006042 },
		[2] = { 2429.6953125, 1460.9482421875, 9.420741081238 },
		[3] = { 2419.92578125, 1664.232421875, 9.566228866577 },
		[4] = { 2118.0400390625, 1776.337890625, 9.419044494629 },
		[5] = { 2149.91015625, 2119.57421875, 9.418784141541 },
		[6] = { 1939.5078125, 2116.16015625, 9.411161422729 },
		[7] = { 2190.0830078125, 1356.025390625, 9.420398712158 },
		[8] = { 1862.5185546875, 1274.9775390625, 9.418623924255 },
		[9] = { 1735.6337890625, 1306.5048828125, 9.488379478455 },
		[10] = { 1662.6455078125, 1715.7353515625, 9.424433708191 },
		[11] = { 1570.5185546875, 1863.1220703125,9.423510551453 },
		[12] = { 1151.1455078125, 1815.681640625, 10.409116744995 },
		[13] = { 921.390625, 1855.4375, 9.420220375061 },
		[14] = { 1009.529296875, 2138.138671875, 9.4192943573 },
		[15] = { 1028.443359375, 2390.4072265625, 9.417165756226 },
	}

function setNewSweaperLocation(thePlayer, city, ID)
	if sweaperRoutes[city] and sweaperRoutes[city][ID] then
		local x, y, z = unpack(sweaperRoutes[city][ID])
		triggerClientEvent(thePlayer,"sweaper_set_location",thePlayer,x,y,z)
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
	if started[thePlayer] then outputChatBox ( "#d9534f[LIXEIRO] #FFFFFFSua rota foi iniciada, finalize-a.", 255,255,255,true) return end
	if not isPedInVehicle(thePlayer) then return end
	if timer[thePlayer] then outputChatBox ( "#d9534f[M:ÔNIBUS] #FFFFFFAguarde 5 minutos para iniciar uma nova rota.", thePlayer, 255, 255, 255, true ) return end 
	if not sweapers[getElementModel(getPedOccupiedVehicle(thePlayer))] then return end
	local job = tostring ( getElementData (thePlayer, "Job" ) or "" )
	if ( job == "Lixeiro" ) then
		started[thePlayer] = true
		timer[thePlayer] = true
		local city = getElementZoneName(thePlayer, true)
		setElementData(thePlayer,"sweaperData",1)
		setNewSweaperLocation(thePlayer, city, 1)
		outputChatBox ( "#d9534f[LIXEIRO] #FFFFFFRota iniciada, mantenha o olho sobre o radar para o icone 'S'.", 255,255,255,true)
	end
end)

addEventHandler("onVehicleEnter",root,
function (thePlayer)
	started[thePlayer] = false
	if not sweapers[getElementModel(source)] then return end
	local job = tostring ( getElementData (thePlayer, "Job" ) or "" )
	if ( job == "Lixeiro" ) then
		outputChatBox ( "#d9534f[LIXEIRO] #FFFFFF/mrota para iniciar a rota de serviços de coleta", thePlayer, 255,255,255,true)
	end
end)

addEvent("sweaper_finish",true)
addEventHandler("sweaper_finish",rootElement,
function (client)
	if not isPedInVehicle(client) then return end
	if not sweapers[getElementModel(getPedOccupiedVehicle(client))] then return end
	local city = getElementZoneName(client, true)	
	local reward = math.random(500,1200)
	if ( reward ) then
		triggerServerEvent ( "VDBGJobs->GivePlayerMoney", client, client, "coletasdelixo", reward, 2 )
		updateJobColumn ( getAccountName ( getPlayerAccount ( client ) ), "coletasdelixo", "AddOne" )
	end
	if #sweaperRoutes[city] == tonumber(getElementData(client,"sweaperData")) then
		setElementData(client,"sweaperData",1)
		started[thePlayer] = false
	else
		setElementData(client,"sweaperData",tonumber(getElementData(client,"sweaperData"))+1)	
	end
	setNewSweaperLocation(client, city, tonumber(getElementData(client,"sweaperData")))
end)