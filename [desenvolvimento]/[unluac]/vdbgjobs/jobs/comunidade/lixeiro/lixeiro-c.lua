local client = getLocalPlayer()
local rootElement = getRootElement()
local marker = nil
local blip = nil

addEvent("sweaper_set_location",true)
addEventHandler("sweaper_set_location",rootElement,
function (x, y, z)
	if isElement(blip) then destroyElement(blip) end
		if isElement(marker) then
		removeEventHandler("onClientMarkerHit",marker,onSweaperStopHit)
		destroyElement(marker)
	end
	marker = createMarker(tostring(x), tostring(y), tostring(z)-1, "cylinder", 3.5, 255, 255, 0, 170)
	blip = createBlipAttachedTo( marker, 38, 2, 255, 255, 0, 255 )
	addEventHandler("onClientMarkerHit",marker,onSweaperStopHit)
end)

function onSweaperStopHit(hitPlayer)
	if hitPlayer ~= client then return end
	if not getPedOccupiedVehicle(client) then return end
	local speed = ( function( x, y, z ) return math.floor( math.sqrt( x*x + y*y + z*z ) * 155 ) end )( getElementVelocity( getPedOccupiedVehicle(client) ) )
	if speed >= 60 then outputChatBox ( "#d9534f[LIXEIRO] #FFFFFFVocê deve ficar no limite de 60KM/h ou menos",255, 255, 255, true) return end
		triggerServerEvent("sweaper_finish",client,client)
		if isElement(blip) then destroyElement(blip) end
			if isElement(marker) then
			removeEventHandler("onClientMarkerHit",marker,onSweaperStopHit)
			destroyElement(marker)
		end
end

addEventHandler("onClientVehicleExit",rootElement,
function (thePlayer, seat)
    if thePlayer == client then
	if isElement(marker) then
		removeEventHandler("onClientMarkerHit",marker,onSweaperStopHit)
		destroyElement(marker) 
	end
		if isElement(blip) then destroyElement(blip) end
	end
end)