fuellessVehicle = { [510]=true, [481]=true, [509]=true, [441]=true, [464]=true, [501]=true, [465]=true, [564]=true, [594]=true }

enginelessVehicle = { [510]=true, [509]=true, [481]=true }
local active = true
local fuel = 12

local x, y = guiGetScreenSize()
local smothedRotation = 0
local isSpeedoEnabled = true

text = nil

g_screenWidth, g_screenHeight = guiGetScreenSize()

g_ImageW = 512
g_ImageH = 256

font = dxCreateFont( "velocimetro1/acens.ttf",18)
font2 = dxCreateFont( "velocimetro1/DS-DIGI.ttf",15)

blink = false
elinditva = false

function getVehicleSpeed(veh)
	if veh then
		local x, y, z = getElementVelocity (veh)
		return math.sqrt( x^2 + y^2 + z^2 ) * 187.5
	end
end


local velocity = 0
local vehicleDistanceTraveled = 0
local vehicleDistanceTraveledargm = 0
local velocityarg = 0
function drawSpeedo() 
	
	if getElementData ( localPlayer, "velo1") == false then return end
	if getElementData ( localPlayer, "opendashboard") == true then return end
	if getElementData ( localPlayer, "velocimetrostate") == true then return end
	if (getElementData(localPlayer,"logado") == false) then return end
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	if active and  not isPlayerMapVisible() then
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		if (vehicle and getVehicleEngineState(vehicle) == true) then 
			speed = getVehicleVelocity(vehicle)
			local x, y = guiGetScreenSize()
			local light = 1
			if getElementData(vehicle, "lights") then
				light = getElementData(vehicle, "lights") + 1
			end
			local speedoX, speedoY = x-440,y-395

			disc = dxDrawImage(speedoX, speedoY, 512, 512, "velocimetro1/velocimetrobg.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)

			dxDrawText ( getFormatGear(), speedoX+210, speedoY+189, x, y, tocolor ( 150, 150, 150, 255 ), 1, font )
			
			velocity = getFormatSpeed(getElementSpeed(vehicle,"kmh"))*1.3
		
			if velocity <= 9 then
			velocityarg = string.sub(velocity, 1,1)
			elseif velocity <= 99 then
			velocityarg = string.sub(velocity, 1, 2)
			else
			velocityarg = string.sub(velocity, 1, 3)
			end
			vehicleDistanceTraveled = getElementData(vehicle, "travelmeter-vehicleDistanceTraveled")
			
			if vehicleDistanceTraveled <= 0.9 then
			vehicleDistanceTraveledargm = "00000"..string.sub(vehicleDistanceTraveled, 1,1)
			elseif vehicleDistanceTraveled <= 9.9 then
			vehicleDistanceTraveledargm = "00000"..string.sub(vehicleDistanceTraveled, 1,1)
			elseif vehicleDistanceTraveled <= 99.9 then
			vehicleDistanceTraveledargm = "0000"..string.sub(vehicleDistanceTraveled, 1, 2)
			elseif vehicleDistanceTraveled <= 999.9 then
			vehicleDistanceTraveledargm = "0000"..string.sub(vehicleDistanceTraveled, 1, 3)
			elseif vehicleDistanceTraveled <= 9999.9 then
			vehicleDistanceTraveledargm = "000"..string.sub(vehicleDistanceTraveled, 1, 4)
			elseif vehicleDistanceTraveled <= 99999.9 then
			vehicleDistanceTraveledargm = "00"..string.sub(vehicleDistanceTraveled, 1, 5)
			elseif vehicleDistanceTraveled <= 999999.9 then
			vehicleDistanceTraveledargm = "0"..string.sub(vehicleDistanceTraveled, 1, 6)
			elseif vehicleDistanceTraveled >= 999999.9 then
			vehicleDistanceTraveledargm = string.sub(vehicleDistanceTraveled, 1, 6).."+"
			end
			
			dxDrawText ( velocityarg , speedoX+240, speedoY+189, x, y, tocolor ( 150, 150, 150, 255 ), 1, font )
			dxDrawText ( vehicleDistanceTraveledargm.." km" , speedoX+197, speedoY+340, x, y, tocolor ( 150, 150, 150, 255 ), 1, font2 )
			
			local speed = getVehicleSpeed (vehicle)
			local percentOfAngle = speed/300
			local guageAngle = percentOfAngle * 220
			if speed > 300 then
				guageAngle = 220
			end
			
			gasolina = (getElementData(vehicle,"fuel" ) or 100)/100 + 0.15
			if gasolina < 0.40 then
			if getTickCount() % 1000 < 500 then
				dxDrawImageSection(x-380, y-350, 387, 387*gasolina, 0, 0, 470, 470*gasolina, 'velocimetro1/gasolina_full.png', -0.5)
			end
			else
			dxDrawImageSection(x-380, y-350, 387, 387*gasolina, 0, 0, 470, 470*gasolina, 'velocimetro1/gasolina_full.png', -0.5)
			end
			
			dxDrawImage(x-378, y-350, 420, 420, "velocimetro1/gasolina_vazio.png",0.0,0.0,0.0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(x-375, y-350, 420, 420, "velocimetro1/gasolina.png",0.0,0.0,0.0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(x-428, y-350, 420, 420, "velocimetro1/hp_vazio.png",0.0,0.0,0.0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(x-430, y-350, 420, 420, "velocimetro1/hp.png",0.0,0.0,0.0, tocolor(255, 255, 255, 255), false)
			vida = getElementHealth ( vehicle ) /1000 + 0.15
			if vida < 0.40 then
			if getTickCount() % 1000 < 500 then
				dxDrawImageSection(x-428, y-348, 340, 340*vida, 0, 0, 420, 420*vida, 'velocimetro1/hp_full.png', -0.5)
			end
			else
			dxDrawImageSection(x-428, y-348, 340, 340*vida, 0, 0, 420, 420*vida, 'velocimetro1/hp_full.png', -0.5)
			end

			dxDrawImage(x-435, speedoY + 240, 480,480,"velocimetro1/setaesquerdaOff.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			if(getElementData(vehicle, "i:left") and getElementData(vehicle, "i:left") == true) then
				if getTickCount() % 1000 < 500 then
					dxDrawImage(x-435, speedoY + 240,480,480,"velocimetro1/setaesquerdaOn.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
				end
			end
			--170
			handbrake = getElementData(vehicle, "freiodemao")
			dxDrawImage(x-540, y-442,480,480,"velocimetro1/FreiodemaoOff.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			if handbrake == true then
			dxDrawImage(x-540, y-442,480,480,"velocimetro1/FreiodemaoOn.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			end
			--x=190
			dxDrawImage(x-465 + 32, speedoY  + 240,480,480,"velocimetro1/setadireitaOff.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			if(getElementData(vehicle, "i:right") and getElementData(vehicle, "i:right") == true) then
				if getTickCount() % 1000 < 500 then
					dxDrawImage(x-465 + 32, speedoY  + 240,480,480,"velocimetro1/setadireitaOn.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
				end
			end
			--x=225
			dxDrawImage(x-355, y-442,480,480,"velocimetro1/LuzOff.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
			if ( getVehicleOverrideLights ( vehicle ) == 2 ) then
				dxDrawImage(x-355, y-442,480,480,"velocimetro1/LuzOn.png",0.0,0.0,0.0,tocolor(255,255,255,255),false)
		
			end
			
		dxDrawImage(x-570, y-495,480,480,"velocimetro1/trancaroff.png",0.0,0.0,0.0,tocolor(255,255,255,255),false, alap)
		if(isVehicleLocked(vehicle)) then
			dxDrawImage(x-570, y-495,480,480,"velocimetro1/trancaron.png",0.0,0.0,0.0,tocolor(255,255,255,255),false, alap)
		end
		

		if(getElementData(vehicle, "enginebroke") and getElementData(vehicle, "enginebroke") == 1) then
			if getTickCount() % 1000 < 500 then
			end
		end
		if isPedInVehicle(getLocalPlayer()) and isSpeedoEnabled == true then 
        local speed = getElementSpeed(getPedOccupiedVehicle(getLocalPlayer()), "kmh")
		if not speed then return end
        local rot = math.floor(((90/9800)* getVehicleRPM(getPedOccupiedVehicle(getLocalPlayer()))) - 0.3)
	    if (smothedRotation < rot) then
            smothedRotation = smothedRotation + 1
        end
        if (smothedRotation > rot) then
            smothedRotation = smothedRotation - 2
        end
        local speedoX, speedoY = x-392,y-337
		dxDrawImage(speedoX, speedoY, 400, 400, "velocimetro1/velocimetro.png", smothedRotation, 0, 0, tocolor(255,255,255,225), true)
		end
		end
	end
end
function round(num, idp)
  return math.floor(num * 10 ^ (idp or 0) + 0.5) / 10 ^ (idp or 0)
end
	


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
function getFormatGear()
    local gear = getVehicleCurrentGear(getPedOccupiedVehicle(getLocalPlayer()))
    local rear = "R"
	local neutral = "N"
    if (gear > 0) then 
        return gear
    else
        return rear
    end
end
function getElementSpeed(element,unit)
    if (unit == nil) then unit = 0 end
    if (isElement(element)) then
        local x,y,z = getElementVelocity(element)
        if (unit=="kmh" or unit==1 or unit =='1') then
            return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100)
        else
            return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100 * 1.609344)
        end
    else
        return false
    end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function syncFuel(ifuel)
	if not (ifuel) then
		fuel = 100
	else
		fuel = ifuel
	end
end
addEvent("syncFuel", true)
addEventHandler("syncFuel", getRootElement(), syncFuel)

function drawFuel()
	if active and not isPlayerMapVisible() then
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		if (vehicle) then
			
			local width, height = guiGetScreenSize()
			local x = width
			local fx = width
			local fy = height
			local y = height

			
			if fuel < 10 then
				local ax, ay = x - 150, y - 170
				if (getElementData(vehicle, "vehicle:windowstat") == 1) then
					ay = ay - 32
				end
				
				
				if getTickCount() % 1000 < 500 then

					
				end
			end
		end
	end
end

           function drawWindow()
	      if active and not isPlayerMapVisible() then
		local vehicle = getPedOccupiedVehicle(getLocalPlayer())
		if (vehicle) then
			local width, height = guiGetScreenSize()
			local x = width
			local y = height
   
            if (getElementData(vehicle, "vehicle:windowstat") == 1) then
    local ax, ay = x - 45, y - 55
    dxDrawImage(ax,ay,32,37,"velocimetro1/porta.png")
      else
   end

  end
 end
end

function onVehicleEnter(thePlayer, seat)
	if (thePlayer==getLocalPlayer()) then
		if (seat<2) then
			local id = getElementModel(source)
			if seat == 0 and not (fuellessVehicle[id]) then
				addEventHandler("onClientRender", getRootElement(), drawFuel)
			end
			if not (enginelessVehicle[id]) then
				addEventHandler("onClientRender", getRootElement(), drawSpeedo)
				addEventHandler("onClientRender", getRootElement(), drawWindow)
			end
		end
	end
end
addEventHandler("onClientVehicleEnter", getRootElement(), onVehicleEnter)

function onVehicleExit(thePlayer, seat)
	if (thePlayer==getLocalPlayer()) then
		if (seat<2) then
			local id = getElementModel(source)
			if seat == 0 and not (fuellessVehicle[id]) then
				removeEventHandler("onClientRender", getRootElement(), drawFuel)
			end
			if not(enginelessVehicle[id]) then
				removeEventHandler("onClientRender", getRootElement(), drawSpeedo)
				removeEventHandler("onClientRender", getRootElement(), drawWindow)
			end
		end
	end
end
addEventHandler("onClientVehicleExit", getRootElement(), onVehicleExit)

function hideSpeedo()
	removeEventHandler("onClientRender", getRootElement(), drawSpeedo)
	removeEventHandler("onClientRender", getRootElement(), drawFuel)
	removeEventHandler("onClientRender", getRootElement(), drawWindow)
end

function showSpeedo()
	source = getPedOccupiedVehicle(getLocalPlayer())
	if source then
		if getVehicleOccupant( source ) == getLocalPlayer() then
			onVehicleEnter(getLocalPlayer(), 0)
		elseif getVehicleOccupant( source, 1 ) == getLocalPlayer() then
			onVehicleEnter(getLocalPlayer(), 1)
		end
	end
end

function removeSpeedo()
	if not (isPedInVehicle(getLocalPlayer())) then
		hideSpeedo()
	end
end
setTimer(removeSpeedo, 1000, 0)

addEventHandler( "onClientResourceStart", getResourceRootElement(), showSpeedo )


function getVehicleRPM(vehicle)
local vehicleRPM = 0
    if (vehicle) then  
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then             
                vehicleRPM = math.floor(((getElementSpeed(vehicle, "kmh")/getVehicleCurrentGear(vehicle))*180) + 0.5) 
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9800) then
                    vehicleRPM = math.random(9800, 9900)
                end
            else
                vehicleRPM = math.floor((getElementSpeed(vehicle, "kmh")*180) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9800) then
                    vehicleRPM = math.random(9800, 9900)
                end
            end
        else
            vehicleRPM = 0
        end
        return tonumber(vehicleRPM)
    else
        return 0
    end
end

local factor = 1.5

function relateVelocity(speed)
	return factor * speed
end

function getVehicleVelocity(vehicle)
	speedx, speedy, speedz = getElementVelocity (vehicle)
	return relateVelocity((speedx^2 + speedy^2 + speedz^2)^(0.5)*100)
end