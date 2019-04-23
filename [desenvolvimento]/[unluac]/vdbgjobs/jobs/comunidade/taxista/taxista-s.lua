local timers = {}
local extra = 500
local taxis = {[438] = true, [420] = true}

addEvent("requestTaxiAccept",true)
addEventHandler("requestTaxiAccept",root,
function (client, bool, theDriver)
if bool then
	outputChatBox ( "#d9534f[TAXI] #FFFFFFDiga ao motorista onde você quer ir.", client, 255, 255, 255, true )
	timers[client] = setTimer(passengerFee, 15000, 0, client, theDriver)
else
	setControlState(client, "enter_exit", true)
	end
end)

function passengerEnters(thePlayer, theSeat, theJacked)
		if (theSeat == 0) then return end
		local theDriver = getVehicleController(source)
		if (not theDriver) then return end
		local job = tostring ( getElementData (theDriver, "Job" ) or "" )
		if ( job ~= "Taxista" ) then return end
		if (taxis[getElementModel(source)]) then
		triggerClientEvent(thePlayer,"sendTaxiRequest",thePlayer,theDriver)
		addEventHandler("onVehicleExit", source, function (player) if player == thePlayer then triggerClientEvent(player,"removeTaxiRequest",player) end end)
		outputChatBox ( "#d9534f[TAXI]#428bca "..getElementData(thePlayer, "AccountData:Name").."#FFFFFF acabou de entrar em seu táxi.", theDriver, 255, 100, 0 )
	end
end  
addEventHandler("onVehicleEnter", root, passengerEnters)

function passengerFee(thePassenger, theDriver)
	if (thePassenger and theDriver and isElement(thePassenger) and isElement(theDriver) and getElementType(theDriver) == "player" and getElementType(thePassenger) == "player") then
		if (isPedInVehicle(thePassenger) and isPedInVehicle(theDriver)) then
			local theVehicle = getPedOccupiedVehicle(thePassenger)
			local theController = getVehicleController(theVehicle)
			if (theController == theDriver) then
				local passengerCash = getPlayerMoney(thePassenger)
				local reward = 12
				if (passengerCash >= 9) then
					takePlayerMoney(thePassenger, 12)
					reward = 12 + extra
				else
					reward = passengerCash
					takePlayerMoney(thePassenger, passengerCash)
					destroyTimer(thePassenger)
					removePedFromVehicle(thePassenger)
				end
				if ( reward ) then
					triggerServerEvent ( "VDBGJobs->GivePlayerMoney", theDriver, theDriver, "pontostaxista", reward, 10 )
					updateJobColumn ( getAccountName ( getPlayerAccount ( theDriver ) ), "pontostaxista", "AddOne" )
					outputChatBox ( "#d9534f[TAXISTA] #FFFFFFVocê levou o passageiro até o local e ganhou: #acd373R$"..reward..".00 .", theDriver, 255, 255, 255, true )
				end
			else
				destroyTimer(thePassenger)
			end
		else
			destroyTimer(thePassenger)
		end
	else
		destroyTimer(thePassenger)
	end
end

function destroyTimer(thePassenger)
	if (thePassenger) then
		if (isTimer(timers[thePassenger])) then
			killTimer(timers[thePassenger])
		end
		timers[thePassenger] = nil
	end
end