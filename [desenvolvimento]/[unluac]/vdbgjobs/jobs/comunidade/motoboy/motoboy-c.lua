addEvent("pizza:sendLocation", true)
addEventHandler("pizza:sendLocation", localPlayer,
function (X, Y, Z)
	if isElement(marker) then destroyElement(marker) end
	if isElement(blip) then destroyElement(blip) end
	marker = createMarker(X, Y, Z, "cylinder", 2, 255, 188, 0)
	blip = createBlip(X, Y, Z, 24, 1)
	outputChatBox ( "#d9534f[PizzaBOY] #FFFFFFEntregue as caixas de pizzas em: #ffa500".. getZoneName(X, Y, Z) .." ("..getZoneName(X, Y, Z, true) ..")#FFFFFF ; (icone #4aabd0'D' #FFFFFFno mapa).",255,255,255,true )
	addEventHandler("onClientMarkerHit", marker, onPizzaMarkerHit)
end)

function onPizzaMarkerHit(hitPlayer, dim)
	if (hitPlayer == localPlayer and dim and isPedInVehicle(localPlayer) == false) then
	local job = tostring ( getElementData ( localPlayer, "Job" ) or "" )
	if ( job == "PizzaBOY" ) then
		fadeCamera(false)
		if isElement(marker) then destroyElement(marker) end
		if isElement(blip) then destroyElement(blip) end
		setTimer(fadeCamera, 3000, 1, true)
		triggerServerEvent("pizza:finishDelivery", localPlayer, localPlayer, elements)
	else
		endDelivery()
		end
	end
end

function endDelivery()
	if isElement(marker) then destroyElement(marker) end
	if isElement(blip) then destroyElement(blip) end
end
addEvent("pizza:endDelivery",true)
addEventHandler("pizza:endDelivery", localPlayer, endDelivery)