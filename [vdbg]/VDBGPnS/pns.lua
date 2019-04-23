function startup()
	local file = xmlLoadFile("pns.xml")
	for k, v in ipairs(xmlNodeGetChildren(file)) do
		local pos = split(xmlNodeGetAttribute(v,"pos"),string.byte(","))
		local marker = createMarker(pos[1],pos[2],pos[3],"cylinder")
		 exports.VDBG3DTEXT:create3DText ( 'Entre para Reparar seu Veículo', { pos[1],pos[2],pos[3] }, { 0, 127, 255 }, { nil, true },  { }, "PnS", "PNS:VDBG")
		createBlipAttachedTo(marker,63,2,255,0,0,255,0,250)
		setElementData(marker,"pnsMarker",true)
		setGarageOpen(tonumber(xmlNodeGetAttribute(v,"garage")),true)
	end
	xmlUnloadFile(file)
end
addEventHandler("onResourceStart",getResourceRootElement(),startup)

function payNSpray(hitElement)
	if (getElementData(source,"pnsMarker") == true) then
		if (getElementType(hitElement) == "vehicle") then
			if (getElementHealth(hitElement) < 3000) then
				if (getVehicleOccupant(hitElement)) then
					local driver = getVehicleOccupant(hitElement)
					local charge = math.floor(3000-getElementHealth(hitElement))
					if (getPlayerMoney(driver) >= charge) then
						fixVehicle(hitElement)
						outputChatBox("#d9534f[VDBG.ORG] #ffffffO custo da manutenção foi de R$ "..charge..".00",driver,255,255,0)
						takePlayerMoney(driver,charge)
						for k, v in ipairs({"accelerate","enter_exit","handbrake"}) do
							toggleControl(driver,v,false)
						end
						setControlState(driver,"handbrake",true)
						fadeCamera(driver,false,1)
						setTimer(restoreControl,3000,1,driver)
					else
						local extraCost = math.floor(charge-getPlayerMoney(driver))
						outputChatBox("#d9534f[VDBG.ORG] #ffffffVocê precisa de mais R$ ".. extracost ..".00 para reparar seu veículo",driver,255,0,0)
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),payNSpray)

function restoreControl(driver)
	for k, v in ipairs({"accelerate","enter_exit","handbrake"}) do
		toggleControl(driver,v,true)
	end
	setControlState(driver,"handbrake",false)
	fadeCamera(driver,true)
end