local deliveryVehicles = {[459]=true, [413]=true, [440]=true, [499]=true, [609]=true, [498]=true, [414]=true, [456]=true, [482]=true}
local client = getLocalPlayer()
local delEls = {}

function createAssignments(tb)
	local totDis = 0
	local px, py = getElementPosition(client)
	for ind, ent in ipairs(tb) do
		totDis = totDis + getDistanceBetweenPoints2D(ent[1], ent[2], px, py)
		local mkr = createMarker(ent[1], ent[2], ent[3], "cylinder", 3.5, math.random(255), math.random(255), math.random(255))
		local blp = createBlip(ent[1], ent[2], ent[3], 51)
		delEls[ind] = {mkr, blp}
		addEventHandler("onClientMarkerHit", mkr, deliveryDone)
	end
	gTotDis = totDis
	outputChatBox ( "#d9534f[ENTREGADOR] #FFFFFFVocê deve entregar 4 caixas para o pagamento",255,255,255, true )
end
addEvent("deliveryMan:gotJob", true)
addEventHandler("deliveryMan:gotJob", client, createAssignments)

function deliveryDone(player, matching)
	if (player == client and matching) then
		if (getPedOccupiedVehicle(player) and deliveryVehicles[getElementModel(getPedOccupiedVehicle(player))]) then
			for ind, ent in pairs(delEls) do
				if (ent[1] == source) then
					destroyElement(ent[1])
					destroyElement(ent[2])
					delEls[ind] = nil
				end
			end
			if (#delEls == 0) then
				triggerServerEvent("delivery:doneJob", client, gTotDis)
			end
		end
	end
end