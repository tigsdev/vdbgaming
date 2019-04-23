local fuelPrice = math.random ( 1, 7 )
outputChatBox ( "#d9534f[VDBG.ORG] #FFFFFFCombustíveis #acd373R$ "..tostring(fuelPrice)..".00 #FFFFFFa cada 1 litro!", root, 255, 255, 255, true )
--setTimer ( triggerClientEvent, 500, 1, root, "VDBGVehicles:Fuel:OnFuelPriceChange", root, fuelPrice )

addEvent ( "VDBGVehicles:Fuel:OnClientRequestFuelPrice", true )
addEventHandler ( "VDBGVehicles:Fuel:OnClientRequestFuelPrice", root, function ( )
	triggerClientEvent ( source, "VDBGVehicles:Fuel:OnFuelPriceChange", source, fuelPrice )
end )

setTimer ( function ( )
	local _fuelPrice = math.random ( 1, 7 )
	while ( fuelPrice == _fulePrice ) do
		_fuelPrice = math.random ( 1, 7 )
	end
	fuelPrice = _fuelPrice
	outputChatBox ( "#d9534f[VDBG.ORG] #FFFFFFCombustíveis #acd373R$ "..tostring(fuelPrice)..".00 #FFFFFFa cada 1 litro!", root, 255, 255, 255, true )
	triggerClientEvent ( root, "VDBGVehicles:Fuel:OnFuelPriceChange", root, fuelPrice )
end, 700000, 0 )

local warnings = {
	[20]=true,
	[15]=true,
	[10]=true,
	[7]=true,
	[5]=true,
	[2]=true,
}

setTimer ( function ( ) 
	for i, v in ipairs ( getElementsByType ( 'vehicle' ) ) do 
		local fuel = getElementData ( v, "fuel" )
		if not fuel then
			setElementData ( v, "fuel", 75 )
			fuel = 75
		end
		
		local speed = getVehicleSpeed ( v, "kph" )
		if ( fuel >= 1 and speed > 0 and getVehicleOccupant ( v ) ) then
			setElementData ( v, "fuel", fuel - 1 )
			local fuel = fuel - 1
			if ( warnings[fuel] ) then
				outputChatBox ( "#d9534f[VDBG.ORG] #FFFFFAtenção, o seu combustível está a baixo de: #d9534f"..tostring(fuel).."%", getVehicleOccupant ( v ), 255,255,255,true )
			end
		end
		
	end
end, 15000, 0 )


function getVehicleSpeed ( tp, md )
	local md = md or "kph"
	local sx, sy, sz = getElementVelocity ( tp )
	local speed = math.ceil( ( ( sx^2 + sy^2 + sz^2 ) ^ ( 0.5 ) ) * 161 )
	local speed1 = math.ceil( ( ( ( sx^2 + sy^2 + sz^2 ) ^ ( 0.5 ) ) * 161 ) / 1.61 )
	if ( md == "kph" ) then
		return speed;
	else
		return speed1;
	end
end


addEvent ( "VDBGFuel:takeMoney", true )
addEventHandler ( "VDBGFuel:takeMoney", root, function ( p )
	takePlayerMoney ( source, p )
end )