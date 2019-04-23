local xYS = {guiGetScreenSize()}
local didSpeed = 0

addEventHandler("onClientRender",getRootElement(),function()
if not isPedInVehicle(getLocalPlayer()) then return end
		az,wz = xYS[1] - 260 - -20, xYS[2] - 250 - -60
	if getElementData(getLocalPlayer(), "screenmod") then
		return
	end

		dxDrawText(math.floor(didSpeed).." km", az+95,wz+148, 7, 22.5, tocolor(211, 211, 211, 255), 1, "default-bold", "left", "top", false, true, true, true	)
end)

function getVehicleSpeed()
    if isPedInVehicle(getLocalPlayer()) then
		local kocsi = getPedOccupiedVehicle(getLocalPlayer())
		if isElement(kocsi) then
			local vx, vy, vz = getElementVelocity(kocsi)
			return math.sqrt(vx^2 + vy^2 + vz^2) * 161
		end
    end
    return 0
end

function kilometermegtett()
	if getPedOccupiedVehicle(localPlayer) then
		if getVehicleOccupant(getPedOccupiedVehicle(localPlayer), 0) == localPlayer then
			if getVehicleSpeed() > 0 then
				local kmh = getVehicleSpeed()
				local km = (kmh/60)/60
				didSpeed = didSpeed + km
				--outputChatBox(tostring(didSpeed))
			end
		end
	end
end
setTimer(kilometermegtett, 1000, 0)

function saveKilometer(theVehicle, seat)
	if source == localPlayer and seat == 0 then
		triggerServerEvent("saveKilometer", theVehicle, theVehicle, didSpeed)
	end
end
addEventHandler("onClientPlayerVehicleExit",getRootElement(),saveKilometer)


addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
            if getElementData(source,"veh:id") > 0 then
				didSpeed = 0
				triggerServerEvent("loadVehiclesKilometer",thePlayer,thePlayer,getElementData(getPedOccupiedVehicle(thePlayer),"veh:id"))
			end
        end
    end
)

function loadInKilometer(km)
--outputChatBox("out")
	--if vehicle == getPedOccupiedVehicle(localPlayer) then
	--outputChatBox("in")
		didSpeed = km
--	end
end
addEvent("loadInKilometer", true)
addEventHandler("loadInKilometer", getRootElement(), loadInKilometer)


