fuellessVehicle = { [510]=true, [481]=true, [509]=true, [441]=true, [464]=true, [501]=true, [465]=true, [564]=true, [594]=true }
enginelessVehicle = { [510]=true, [509]=true, [481]=true }
local kepernyom = {guiGetScreenSize()}
local Meretek = {260,260}
local speedoStatusz = true


addCommandHandler("fuel", function()
	for k, v in ipairs (getElementsByType("vehicle")) do
		setElementData(v, "veh:fuel", 60)
		if getVehicleUpgradeOnSlot(v, 8) then 
			--outputChatBox(getVehicleNitroLevel(v))
		end
	end

end)
function SpeedoFelrajzol ()
    if not getElementData(localPlayer, "screenmod") then
		if not isPedInVehicle(getLocalPlayer()) then
			hideSpeedo()
		end
	--	if getElementData(getLocalPlayer(), "loggedin") == 0 then
			
		if not isPedInVehicle ( localPlayer ) then
			return
		end	
		local vehSpeed = getVehicleSpeed()
		fuel = tonumber(getElementData(getPedOccupiedVehicle(localPlayer),"veh:fuel")) or 0

		if getVehicleUpgradeOnSlot(getPedOccupiedVehicle(localPlayer), 8) then 
			nitro = getVehicleNitroLevel(getPedOccupiedVehicle(localPlayer))
		else
			nitro = 0
		end
		if (tonumber(vehSpeed) < 40) then
			rotat = 1
		else
			rotat = 0.86
		end

		Sg_hatter = dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2], "files/speedo_alap.png", 0, 0, 0, white, false)
		cucc = dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2], "files/speedo_needle.png",vehSpeed*rotat, 0, 0, white, false)
		dxDrawText ( getFormatSpeed(getVehicleSpeed()), kepernyom[1]-Meretek[1]+95, kepernyom[2]-Meretek[2]+100, Meretek[1], Meretek[2], tocolor ( 150, 150, 150, 255 ), 3, "default-bold", "left", "top", false, false, Sg_hatter )
		dxDrawText ( "mph", kepernyom[1]-Meretek[1]+160, kepernyom[2]-Meretek[2]+127, Meretek[1], Meretek[2], tocolor ( 150, 150, 150, 255 ), 0.9, "default-bold", "left", "top", false, false, Sg_hatter )
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_right.png",0.0,0.0,0.0,tocolor(255,255,255,255),false, Sg_hatter)
		if(getElementData(vehicle, "i:right") and getElementData(vehicle, "i:right") == true) then
			if getTickCount() % 1000 < 500 then
				dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_right_on.png",0.0,0.0,0.0,tocolor(255,255,255,255),false, Sg_hatter)
			end
		end	
		dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_left.png",0.0,0.0,0.0,tocolor(255,255,255,255),true, Sg_hatter)
		if(getElementData(vehicle, "i:left") and getElementData(vehicle, "i:left") == true) then
			if getTickCount() % 1000 < 500 then
				dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_left_on.png",0.0,0.0,0.0,tocolor(255,255,255,255),true, Sg_hatter)
			end
		end

		if(getElementData(vehicle, "i:left") and getElementData(vehicle, "i:left") == true) then
			if getTickCount() % 1000 < 500 then
				dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_left_on.png",0.0,0.0,0.0,tocolor(255,255,255,255),true, Sg_hatter)
			end
		end

		dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_gas.png",0.0,0.0,0.0,tocolor(255,255,255,255),true, Sg_hatter)
		if(fuel < 30) then
			if getTickCount() % 1000 < 500 then
				dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_gas_low.png",0.0,0.0,0.0,tocolor(255,255,255,255),true, Sg_hatter)
			end
		end

		dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_lock.png",0.0,0.0,0.0,tocolor(255,255,255,255),true, Sg_hatter)
		if(isVehicleLocked(vehicle)) then
			dxDrawImage(kepernyom[1]-Meretek[1], kepernyom[2]-Meretek[2]-7, Meretek[1], Meretek[2],"files/speedo_lock_on.png",0.0,0.0,0.0,tocolor(255,255,255,255),true, Sg_hatter)

		end


		if (fuel > 0) then	
				dxDrawImageSection(kepernyom[1]-Meretek[1], kepernyom[2]-7-Meretek[2] + Meretek[1], Meretek[2], Meretek[1]*-(fuel/100),0,0, Meretek[2], Meretek[1]*-(fuel/100), "files/speedo_oil.png", 0, 0, 0, tocolor(255, 255, 255), true, Sg_hatter)
		end

		if nitro then
			dxDrawImageSection(kepernyom[1]-Meretek[1], kepernyom[2]-7-Meretek[2] + Meretek[1], Meretek[1], Meretek[1]*-(nitro),0,0, Meretek[1], Meretek[1]*-(nitro), "files/speedo_nitro.png", 0, 0, 0, tocolor(255, 255, 255), true, Sg_hatter)				
		end
	end
end
addEventHandler("onClientRender", getRootElement(), SpeedoFelrajzol)
function getFormatSpeed(unit)
    unit = math.round(unit)
	if unit < 10 then
        unit = "00" .. unit
    elseif unit < 100 then
        unit = "0" .. unit
    elseif unit >= 1000 then
        unit = "999"
    end
    return unit
end


function getVehicleSpeed()
    if isPedInVehicle(getLocalPlayer()) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(getLocalPlayer()))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 187.5
    end
    return 0
end
function hideSpeedo()
	if not speedoStatusz then
		return
	end
	speedoStatusz = false
	removeEventHandler("onClientRender", getRootElement(), SpeedoFelrajzol)
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function onVehicleEnter(thePlayer, seat)
	if (thePlayer==getLocalPlayer()) then
		if (seat<2) then
			local id = getElementModel(source)
			if seat == 0 and not (fuellessVehicle[id]) then
				--addEventHandler("onClientRender", getRootElement(), drawFuel)
			end
			if not (enginelessVehicle[id]) then
				addEventHandler("onClientRender", getRootElement(), SpeedoFelrajzol)
				--addEventHandler("onClientRender", getRootElement(), drawWindow)
			end
		end
	end
end
addEventHandler("onClientVehicleEnter", getRootElement(), onVehicleEnter)