local fuelPrice = nil
local createBlips = true
local BuyCan = { }
local sx, sy = guiGetScreenSize ( )

setTimer ( function ( )

createBlips = true

addEvent ( "VDBGVehicles:Fuel:OnFuelPriceChange", true )
addEventHandler ( "VDBGVehicles:Fuel:OnFuelPriceChange", root, function ( p )
	fuelPrice = p
end )

local isRendering = false
local fuelingMarker = nil
function onFuelMarkerHit ( p )
	if ( p == localPlayer ) then
		local x, y, z = getElementPosition ( source )
		local px, py, pz = getElementPosition ( p )
		if ( getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) < 5) then
			if ( eventName == 'onClientMarkerHit' ) then
				if ( isPedInVehicle ( p ) ) then
					isRendering = true
					fuelingMarker = source
					addEventHandler ( "onClientRender", root, onFuelTextRender )
				else 
					exports.VDBGShops:openWindowGas()
				end
			elseif ( eventName == 'onClientMarkerLeave' ) then
				if ( isRendering ) then
					isRendering = false
					fuelingMarker = nil
					removeEventHandler ( "onClietnRender", root, onFuelTextRender )
				end
			end
		end
	end
end

local tick = getTickCount ( )
function onFuelTextRender ( )
	if ( isRendering and isPedInVehicle ( localPlayer ) and getVehicleController ( getPedOccupiedVehicle ( localPlayer ) ) == localPlayer and isElementWithinMarker ( localPlayer, fuelingMarker ) ) then
		local car = getPedOccupiedVehicle ( localPlayer )
		local fuel = tonumber ( getElementData ( car, "fuel" ) )
		if ( fuel < 100 ) then
			text = "Pressione \""..refuelKey:upper().."\" Para reabastecer (R$"..tostring(fuelPrice).."/a cada 5 litros)\nTotal de: R$"..(100-fuel)*fuelPrice
			color = tocolor ( 255, 140, 0, 255 )
			if ( getKeyState ( refuelKey ) ) then
				if ( getPlayerMoney ( localPlayer ) >= fuelPrice ) then
					if ( getTickCount ( ) - tick >= fuelDelay ) then
						setElementData ( car, "fuel", fuel + 1 )
						triggerServerEvent ( "VDBGFuel:takeMoney", localPlayer, fuelPrice )
						tick = getTickCount ( )
					end
				else
					text = "Você não tem dinheiro suficiente"
					color = tocolor ( 255, 0, 0, 255 )
				end
			end
		else
			text = "Tanque cheio!"
			color = tocolor ( 0, 255, 0, 255 )
		end
		dxDrawText ( text, 2, 2, sx, sy / 1.2, tocolor ( 0, 0, 0, 255 ), 2, "default-bold", "center", "bottom" )
		dxDrawText ( text, 0, 0, sx, sy / 1.2, color, 2, "default-bold", "center", "bottom" )
	else
		isRendering = false
		fuelingMarker = nil
		removeEventHandler ( 'onClientRender', root, onFuelTextRender )
	end
end

local fuelBlips = { }
for i, v in pairs ( fuelLocations ) do 
	local x, y, z, blip = unpack ( v )
	local marker = createMarker ( x, y, z - 1, "cylinder", 3, 255, 140, 0, 140 )
	addEventHandler ( "onClientMarkerHit", marker, onFuelMarkerHit )
	addEventHandler ( "onClientMarkerLeave", marker, onFuelMarkerHit )
	if ( blip and createBlips ) then
		fuelBlips[i] = createBlip ( x, y, z, 48, 2, 255, 255, 255, 255, 0, 370 )
	end
end
setTimer ( triggerServerEvent, 500, 1, "VDBGVehicles:Fuel:OnClientRequestFuelPrice", localPlayer )


addEvent ( "onClientUserSettingChange", true )
addEventHandler ( "onClientUserSettingChange", root, function ( g, v )
	if ( g == "usersetting_display_createfuelblips" ) then
		for i, v in pairs ( fuelBlips ) do
			destroyElement ( fuelBlips[i] )
			fuelBlips[i] = nil
		end
		
		fuleBlips = { }
		if v == true then
			for i, v in pairs ( fuelLocations ) do 
				if ( v [ 4 ] ) then
					fuelBlips[i] = createBlip ( v[1], v[2], v[3], 48, 2, 255, 255, 255, 255, 0, 370 )
				end
			end
		end
	end
end )

end, 500, 1 )

