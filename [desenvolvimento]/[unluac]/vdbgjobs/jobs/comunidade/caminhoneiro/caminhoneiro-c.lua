local client = getLocalPlayer()
local trucks = {[515]=true, [514]=true, [403]=true}
local assignmentSet = false

function enterTruck(thePlayer, Xdel, Ydel, Zdel)
	if (assignmentSet) then return end
	if (Xdel and Ydel and Zdel) then
		truckerMarker = createMarker(Xdel, Ydel, Zdel, "cylinder", 5, 200, 200, 100, 150)
		truckerBlip = createBlip(Xdel, Ydel, Zdel, 51)
		local zone = getZoneName(Xdel, Ydel, Zdel)
		outputChatBox("#d9534f[CAMINHONEIRO] #FFFFFFLeve a carga até o comprador, no local indicado no seu mini-mapa: "..zone..".",255, 255, 255, true )
		addEventHandler("onClientMarkerHit", truckerMarker, truckerHitsMarker)
		local Xp, Yp, Zp = getElementPosition(client)
		assignmentSet = true
	else
		triggerServerEvent("trucker:getPoint", client, client)
	end
end
addEvent("trucker:sendPoint", true)
addEventHandler("trucker:sendPoint", client, enterTruck)

function newTruckerAssignment()
	local theVehicle = getPedOccupiedVehicle(client)
	if (not theVehicle) then return end
	local model = getElementModel(theVehicle)
	if (not trucks[model]) then outputChatBox("#d9534f[CAMINHONEIRO] #FFFFFFVocê precisa estar usando o caminhão da empresa para concluir o trampo.",255, 255, 255, true ) return end
	local theDriver = getVehicleController(theVehicle)
	if (theDriver ~= client) then return end
	enterTruck()
end

function truckerHitsMarker(hitPlayer,source)
	if (hitPlayer ~= client) then return end
	local theVehicle = getPedOccupiedVehicle(hitPlayer)
	local model = getElementModel(theVehicle)
	if (not theVehicle) then return end
	if (not trucks[model]) then outputChatBox("#d9534f[CAMINHONEIRO] #FFFFFFVocê precisa estar usando o caminhão da empresa para receber o pagamento.",255, 255, 255, true ) return end
	if (getVehicleController(theVehicle) ~= client) then return end
	triggerServerEvent("trucker:giveMoney", client)
	endJob()
	setTimer(fadeOut, 2000, 1)
	setTimer(newTruckerAssignment, 5000, 1)
	fadeCamera(false, 1)
end

function onExitTruckDestroyMarker(thePlayer)
if (thePlayer ~= client) then return end
local model = getElementModel(source)
	if (trucks[model] and assignmentSet) then
		if isElement(truckerMarker) then destroyElement(truckerMarker) end
		if isElement(truckerBlip) then destroyElement(truckerBlip) end
		assignmentSet = false
	end
end
addEventHandler("onClientVehicleExit",getRootElement(),onExitTruckDestroyMarker)

function fadeOut()
	fadeCamera(true, 1)
end

function endJob()
	if (assignmentSet == false) then return end
	assignmentSet = false
	if (isElement(truckerMarker)) then
		removeEventHandler("onClientMarkerHit", truckerMarker, truckerHitsMarker)
		destroyElement(truckerMarker)
	end
	if (isElement(truckerBlip)) then
		destroyElement(truckerBlip)
	end
end
addEvent("endJob",true)
addEventHandler("endJob",getRootElement(),endJob)