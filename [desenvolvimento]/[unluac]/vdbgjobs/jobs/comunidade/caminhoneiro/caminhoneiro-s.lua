local truckerPoints = {
	[1]={x=1479.85, y=2839.25, z=10.82}, -- Golf lv 
	[2]={x=2054.44, y=2474.66, z=10.3}, -- The Emerald Isle
	[2]={x=-88.4, y=-1163.5, z=1.8}, --Flint County
	[3]={x=651.2, y=-570.1, z=15.8}, --Dillimore
	[4]={x=2116.2, y=910.8, z=10.3}, --Las Venturas
	[5]={x=1944.4, y=-1767.1, z=13.3}, --Idlewood
	[6]={x=-1327.5, y=2683.2, z=49.6}, --Tierra Robada
	[7]={x=-1666.4, y=409.4, z=7.1}, --Easter Basin
	[9]={x=1380.0, y=456.9, z=19.8}, --Montgomery (Red County)
	[10]={x=1007.7, y=-941.0, z=42.1}, --Temple (Los Santos)
	[11]={x=-1605.7, y=-2715.0, z=48.5}, --Whetsone
	[12]={x=-100.7, y=-1171.0, z=2.5}, --Flint County
	[13]={x=605.6, y=1704.7, z=6.9}, --Bone County
	[14]={x=1595.7, y=2190.9, z=10.8}, --Redsands West(Las Venturas)
	[15]={x=2147.3, y=2756.5, z=10.8}, --Spinybed (Las Venturas)
	[16]={x=2640.8, y=1104.4, z=10.8}, --Las Venturas
	[17]={x=-1477.9, y=1856.6, z=32.6} --Tierra Robada
}

local trucks = {[515]=true, [514]=true, [403]=true}
local trailer = {}
local trailers = {435, 450}

function pickRandomPoint(thePlayer)
	local index = tonumber(getElementData(thePlayer, "truckerID"))
	repeat pick = math.random(#truckerPoints)
	until pick ~= index
	local Xdel, Ydel, Zdel = truckerPoints[pick].x, truckerPoints[pick].y, truckerPoints[pick].z
	setElementData(thePlayer, "truckerID", tonumber(pick))
	triggerClientEvent(thePlayer, "trucker:sendPoint", thePlayer, thePlayer, Xdel, Ydel, Zdel)
end
addEvent("trucker:getPoint", true)
addEventHandler("trucker:getPoint", root, pickRandomPoint)

function truckerGetAssignment(thePlayer, theSeat)
	if (theSeat ~= 0) then return end
	local theVehicle = source
	local vehModel = getElementModel(theVehicle)
	if (not trucks[vehModel]) then return end
	local job = tostring ( getElementData ( thePlayer, "Job" ) or "Desempregado" )
	if ( job == "Caminhoneiro" ) then
	pickRandomPoint(thePlayer)
	local x, y, z = getElementPosition(source)
	trailer[source] = createVehicle ( trailers[ math.random(#trailers) ], x, y, z + 900 )
	attachTrailerToVehicle (source, trailer[source])
	end
	end
addEventHandler("onVehicleEnter", root, truckerGetAssignment)


addEventHandler("onVehicleExit", root,
function()
	if (not trailer[source]) then return end
	destroyElement(trailer[source], source)
end
)

addEvent("trucker:giveMoney", true)
addEventHandler("trucker:giveMoney", root, 
function(theDistance)
local reward = math.random(1000,2000)
if ( reward ) then
		triggerServerEvent ( "VDBGJobs->GivePlayerMoney", source, source, "viagenscamin", reward, 10 )
		updateJobColumn ( getAccountName ( getPlayerAccount ( source ) ), "viagenscamin", "AddOne" )
end
outputChatBox ( "#d9534f[CAMINHONEIRO] #FFFFFFVocê fez a entrega com êxito, e ganhou: #ffa500R$"..reward..".00", source, 255, 255, 255, true )
end)