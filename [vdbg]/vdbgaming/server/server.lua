function updateTime()
	local offset = -1
	local realtime = getRealTime()
	hour = realtime.hour + offset
	hour = hour + 5
	if hour >= 24 then
		hour = hour - 24
	elseif hour < 0 then
		hour = hour + 24
	end
	minute = realtime.minute
	setTime(hour, minute)
	nextupdate = (60-realtime.second) * 100
	setMinuteDuration( nextupdate )
	setTimer( setMinuteDuration, nextupdate + 5, 1, 30000 )
end
addEventHandler("onResourceStart", getResourceRootElement(), updateTime )
setTimer( updateTime, 1800000, 0 )

setFarClipDistance(250)


local weatherNameToGTA = {
	["Haze"] = math.random(12,12),
	["Mostly Cloudy"] = math.random(12,12),
	["Clear"] = 12,
	["Cloudy"] = math.random(0,7),
	["Flurries"] = 32,
	["Fog"] = 9,
	["Mostly Sunny"] = math.random(0,7),
	["Partly Cloudy"] = math.random(0,7),
	["Partly Sunny"] = math.random(0,7),
	["Rain"] = 16,
	["Sleet"] = 16,
	["Snow"] = 31,
	["Sunny"] = 12,
	["Thunderstorms"] = 8,
	["Thunderstorm"] = 8,
	["Unknown"] = 13,
	["Overcast"] = 13,
	["Scattered Clouds"] = 12,
}

local json = nil
local currentCelsius = createElement( "vdbg", "temp" )
function fetchWeather(thePlayer)
	fetchRemote( "http://api.wunderground.com/api/04652b27df3ce7ae/conditions/q/IA/Newyork.json", function(data)
		local new = fromJSON(data)
		local wind = tonumber(new["current_observation"]["wind_mph"])
		local temp = tonumber(new["current_observation"]["temp_c"])
		local weather = tostring(new["current_observation"]["weather"])
		local observation_time_rfc822 = tostring(new["current_observation"]["observation_time_rfc822"])
		setElementData(currentCelsius, "temp", temp)
		setWaveHeight(math.floor(wind/4))
		if weatherNameToGTA[weather] then
			setWeather(weatherNameToGTA[weather])
		else
			setWeather(12)
		end
	end, nil, true )
end
setTimer( fetchWeather, 60000*10, 0 )
addEventHandler("onResourceStart", getResourceRootElement(), fetchWeather )

addEventHandler("onResourceStart", getRootElement(),
	function()
		setMapName("San Andreas")
		setGameType("VDBG:RPG 3.0.2") 
	end
)


function reloadACL ( source, command )
	if ( isObjectInACLGroup ( "user." .. getAccountName ( getPlayerAccount ( source )), aclGetGroup ( "Dono" ) ) ) then
		local reload = aclReload()
			if ( reload ) then 
				outputChatBox ( "ACL foi recarregada.", source, 255, 0, 0 ) -- If so, output it
			else 
				outputChatBox ( "Falha ao recarregar a NOVA ACL", source, 255, 0, 0 )
			end
	else
		outputChatBox ( "Você não tem permissão para fazer isso!", source, 255, 0, 0 )
	end
end
addCommandHandler ( "reacl", reloadACL )

-------------

function deixasemblur()
    setPlayerBlurLevel ( source, 0 )
end
addEventHandler ( "onPlayerJoin", getRootElement(), deixasemblur )
function scriptStart()
    setPlayerBlurLevel ( getRootElement(), 0)
end
addEventHandler ("onResourceStart",getResourceRootElement(getThisResource()),scriptStart)

function scriptRestart()
	setTimer ( scriptStart, 4000, 1 )
end
addEventHandler("onResourceStart",getRootElement(),scriptRestart)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        setCloudsEnabled(false)
        setHeatHaze(0)
        setWeather(0)
	setFogDistance(0)
    end
)

-----

addEvent("onPlayerGarageEnter", true)

addEventHandler("onResourceStart", getResourceRootElement(),
function (resource)
	for i=0,49 do
		--outputChatBox("opening garage " .. i)
		if (not isGarageOpen(i)) then
			setGarageOpen(i, true)
		end
	end
end
)

addEventHandler("onPlayerGarageEnter", root,
function (vehicle)
	--outputChatBox("SERVER: SOMEONE ENTERED GARAGE WITH CAR")
	fixVehicle(vehicle)
	setVehicleColor(vehicle, math.random(0,126), math.random(0,126), math.random(0,126), math.random(0,126))
	notifyOfVehicleHealthIncrease(vehicle)
end
)
-----------


vehiclesList = { 437, 431, 537, 449 }

function in_array(e, t)
	for _,v in pairs(t) do
		if (v==e) then return true end
	end
	return false
end

function getFreeSeat(veh)
	local max = getVehicleMaxPassengers(veh)
	for i=2,max,1 do
		local occ = getVehicleOccupant(veh, i)
		if (occ==false) then return i end
	end
	return false
end


addEventHandler("onVehicleEnter", getRootElement(), function(player,seat,jacked)
	local model = getElementModel(source)
	
	-- debug thing
	-- local max = getVehicleMaxPassengers(source)
	-- outputChatBox(tostring(max)..'--'..tostring(seat))
		
	if (in_array(model, vehiclesList)) then
		if (seat==1) then
			local seatID = getFreeSeat(source)
			if (seatID~=false) then
				outputChatBox(tostring(seatID))
				warpPedIntoVehicle(player, source, seatID)
				--outputChatBox(getPlayerName(getVehicleOccupant(source, seatID)))
			end
		end
	end
end)


cmdList = {
    ["register"]=true,
    ["login"]=false,
    ["me"]=true,
}
 
addEventHandler("onPlayerCommand", root,
function(cmdName)
     if cmdList[cmdName] then
          cancelEvent()
     end
end)
