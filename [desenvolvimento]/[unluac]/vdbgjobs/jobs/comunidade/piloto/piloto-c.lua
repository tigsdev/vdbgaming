local pilot = { }

local paths = {
	main = { 
		{ 1848.36, -2416.57, 13.55 },
		{ 1603.27, 1604.38, 10.82 },
		{ 369.06, 2538.43, 16.62 },
		{ -1274.43, -157.23, 14.15 },
		{ 3409.47, 2083.54, 19.72 },
	},
	
	extra = { 
		{ -729.39, -170.51, 65.82 },
		{ 3408.02, 1996.04, 19.72 },
		{ -1532.31, 1030.19, 25.32 },
		{ -870.73, 1765.54, 87.98 },
		{ -780.03, 2435.35, 157.1 },
		{ 2068.11, 1603.76, 10.68 },
		{ 1927.86, 703.53, 16.05 }
	}
}



local flightPath = nil
function pilot.createFlightPath ( )
	pilot.destroyFlightPath ( )
	flightPath = { }
	flightPath.elements = { }
	
	local x, y, z = unpack ( paths.main [ math.random ( #paths.main ) ] )
	local px, py, pz = getElementPosition ( localPlayer )
	while ( getZoneName ( x, y, z, true ) == getZoneName ( px, py, pz, true ) ) do
		x, y, z = unpack ( paths.main [ math.random ( #paths.main ) ] )
	end
	flightPath.elements.FlightMarker = createMarker ( x, y, z - 1, "cylinder", 7, 255, 200, 0, 120 )
	flightPath.elements.FlightBlip = createBlip ( x, y, z, 5 )
	outputChatBox ( "#d9534f[PILOTO] #FFFFFFVocê foi designado um vôo de #428bca"..getZoneName(px,py,pz,true).." #FFFFFFpara #4aabd0"..getZoneName(x,y,z).."("..getZoneName(x,y,z,true)..") #ffa500("..math.floor(getDistanceBetweenPoints2D(px,py,x,y)).." metros)", 255, 255, 255, true )
	addEventHandler ( "onClientMarkerHit", flightPath.elements.FlightMarker, function ( p )
		if ( p == localPlayer and isPedInVehicle ( p ) ) then
			local c = getPedOccupiedVehicle ( p )
			if ( getVehicleType ( c ) ~= "Plane" ) then return end
			if ( getElementData ( c, "VDBGAntiRestart:VehicleJobRestriction" ) == nil ) then return end
			if ( getVehicleController ( c ) ~= p ) then return end
			pilot.destroyFlightPath ( )
			local m = math.random ( 1000, 2000 )
			
			if ( m ) then
				triggerServerEvent ( "VDBGJobs->GivePlayerMoney", localPlayer, localPlayer, "completeflights", m, 7 )
				updateJobColumn ( getAccountName ( getPlayerAccount ( localPlayer ) ), "completeflights", "AddOne" )
				outputChatBox ( "#d9534f[JOB] #FFFFFFVocê foi pago R$"..tostring(m).."para completar o trajeto de vôo!", 255, 255, 255, true )
			end
			
		end
	end )
	
	if ( pilot.ShouldiGetaGoodPoint ( ) ) then
		outputChatBox ( "#d9534f[PILOTO] #FFFFFFExiste agora um blip piscando em seu radar (F11).Ao levar o passageiro até o local indicado você receberá R$4500!", 255, 255, 255, true )
		local x, y, z = unpack ( paths.extra [ math.random ( #paths.extra ) ] )
		flightPath.elements.FlightMarkerExtra = createMarker ( x, y, z - 1, "cylinder", 4, 0, 0, 200, 150 )
		flightPath.elements.FlightBlipExtra = createBlip ( x, y, z, 5 )
		BlipBlinkTimer = setTimer ( function ( )
			if ( not isElement ( flightPath.elements.FlightMarkerExtra ) ) then
				killTimer ( BlipBlinkTimer )
				if ( isElement ( flightPath.elements.FlightBlipExtra ) ) then
					destroyElement ( lightPath.elements.FlightBlipExtra )
					flightPath.elements.FlightBlipExtra = nil
				end
			end
			
			if ( isElement( flightPath.elements.FlightBlipExtra ) ) then
				destroyElement ( flightPath.elements.FlightBlipExtra )
				flightPath.elements.FlightBlipExtra = nil
			else
				local x, y, z = getElementPosition ( flightPath.elements.FlightMarkerExtra )
				flightPath.elements.FlightBlipExtra = createBlip ( x, y, z, 5 )
			end
		end, 700, 0 )
		
		
		addEventHandler ( "onClientMarkerHit", flightPath.elements.FlightMarkerExtra, function ( p )
			if ( p == localPlayer and isPedInVehicle ( p ) ) then
				local c = getPedOccupiedVehicle ( p )
				if ( getVehicleType ( c ) ~= "Plane" ) then return end
				if ( getElementData ( c, "VDBGAntiRestart:VehicleJobRestriction" ) == nil ) then return end
				if ( getVehicleController ( c ) ~= p ) then return end
				if ( pilot.VehicleSpeed ( c ) > 10 ) then return outputChatBox("#d9534f[PILOTO] #FFFFFFPasse no marcador em uma velocidade mais lenta.",255, 255, 255, true ) end
				pilot.destroyFlightPath ( )
				local m = 4500
				
				if ( m ) then
					triggerServerEvent ( "VDBGJobs->GivePlayerMoney", localPlayer, localPlayer, "completeflights", m, 25 )
					updateJobColumn ( getAccountName ( getPlayerAccount ( localPlayer ) ), "completeflights", "AddOne" )
					outputChatBox ( "#d9534f[PILOTO] #FFFFFFVocê foi pago R$"..tostring(m).."para completar o trajeto de vôo!", 255, 255, 255, true )
				end
			end
		end )
	end
end 

function pilot.destroyFlightPath ( )
	if ( flightPath ) then
		for i, v in pairs ( flightPath.elements ) do
			if ( isElement ( v ) ) then
				destroyElement ( v )
			end
		end
	end
	if (  isTimer ( BlipBlinkTimer ) ) then 
		killTimer ( BlipBlinkTimer )
	end
	flightPath = nil
end

setTimer ( function ( )
	if ( getElementData ( localPlayer, "Job" ) == "Piloto" and not isPedInVehicle ( localPlayer ) ) then
		pilot.destroyFlightPath ( )
	elseif ( getElementData ( localPlayer, "Job" ) == "Piloto" and isPedInVehicle ( localPlayer ) ) then
		if ( not flightPath ) then
			local c = getPedOccupiedVehicle ( localPlayer ) 
			if ( getVehicleType ( c ) == "Plane" and getElementData ( c, "VDBGAntiRestart:VehicleJobRestriction" ) ~= nil ) then
				pilot.createFlightPath ( )
			end
		end
	end
end, 5000, 0 )

function getZoneShortName ( zone )	-- Incomplete function
	local zone = tostring ( zone ):lower ( )
	if ( zone == "Las Venturas" or zone == "Bone County" or zone == "Tierra Robada" ) then
		return "LV"
	elseif ( zone == "San Fierro" ) then
		return "SF"
	end
end

function pilot.ShouldiGetaGoodPoint ( )
	local n = math.random ( 0, 100 )
	return n >= 95
end