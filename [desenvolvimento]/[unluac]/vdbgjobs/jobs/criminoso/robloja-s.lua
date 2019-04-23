ped = { }
peds = {
	--x, y, z, dimension, interior, rotation, skinID
	[1]={ 161, -81, 1001.8046875, 3, 18, 180, 93 },
	[2]={ 161, -81, 1001.8046875, 2, 18, 180, 93 },
	[3]={ 161, -81, 1001.8046875, 1, 18, 180, 93 },
	[4]={ 161, -81, 1001.8046875, 0, 18, 180, 93 },
	
	[5]={ 204.7978515625, -7.896484375, 1001.2109375, 2, 5, 270, 93 },
	[6]={ 204.7978515625, -7.896484375, 1001.2109375, 1, 5, 270, 93 },
	[7]={ 204.7978515625, -7.896484375, 1001.2109375, 0, 5, 270, 93 },
	
	[8]={ 203.4, -41.7, 1001.8046875, 2, 1, 180, 93 },
	[9]={ 203.4, -41.7, 1001.8046875, 1, 1, 180, 93 },
	[10]={ 203.4, -41.7, 1001.8046875, 0, 1, 180, 93 },
	
	[11]={ 204.2080078125, -157.8193359375, 1000.5234375, 0, 14, 180, 93 },
	
	[12]={ 206.3759765625, -127.5380859375, 1003.5078125, 1, 3, 180, 93 },
	[13]={ 206.3759765625, -127.5380859375, 1003.5078125, 0, 3, 180, 93 },
	
	[14]={ 206.3349609375, -98.703125, 1005.2578125, 3, 15, 180, 93 },
	[15]={ 206.3349609375, -98.703125, 1005.2578125, 2, 15, 180, 93 },
	[16]={ 206.3349609375, -98.703125, 1005.2578125, 1, 15, 180, 93 },
	[17]={ 206.3349609375, -98.703125, 1005.2578125, 0, 15, 180, 93 },
	
	-- lojas que faltava
	
	-- ammunations
	[18]={ 296.59, -40.6, 1001.52, 0, 1, 0, 179 },
	[19]={ 296.59, -40.6, 1001.52, 1, 1, 0, 179 },
	[20]={ 296.59, -40.6, 1001.52, 2, 1, 0, 179 },
	[21]={ 296.59, -40.6, 1001.52, 3, 1, 0, 179 },
	[22]={ 296.59, -40.6, 1001.52, 4, 0, 0, 179 },
	[23]={ 296.59, -40.6, 1001.52, 5, 1, 0, 179 },
	[24]={ 296.59, -40.6, 1001.52, 6, 1, 0, 179 },
	[25]={ 296.59, -40.6, 1001.52, 7, 1, 0, 179 },
	[26]={ 296.59, -40.6, 1001.52, 8, 1, 0, 179 },
	[27]={ 296.59, -40.6, 1001.52, 9, 1, 0, 179 },
	[28]={ 296.59, -40.6, 1001.52, 10, 1, 0, 179 },
	[29]={ 296.59, -40.6, 1001.52, 11, 1, 0, 179 },
	[30]={ -23.79, -57.57, 1003.55, 1, 6, 0, 93 },
	[31]={ -30.74, -30.71, 1003.56, 3, 4, 0, 93 },
}

cancelTimers = {}
function loadPeds()
	for k=1, #peds do
		-- Create the ped
		--exports.VDBG3DTEXT:create3DText ( 'ASSALTO', { peds[k][1], peds[k][2], peds[k][3] }, { 255, 0, 0 }, { nil, true },  { }, "Criminoso", "PEAK")
    	ped[k] = createPed ( peds[k][7], peds[k][1], peds[k][2], peds[k][3] )
		setElementDimension( ped[k], peds[k][4] )
		setElementInterior( ped[k], peds[k][5] )
		setPedRotation ( ped[k], peds[k][6] )
		if isElement( ped[k] )then
		setTimer( setElementHealth, 100, 0, ped[k], 100 )
		end
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadPeds)

-- Robbery time
function CounterTime( crim )
	if isElement( crim ) then
		local time = getTickCount( )
		setElementData( crim, "robTime2", time )
	end
end


lawTeams = {
	[getTeamFromName("Policial")] = true, 
	[getTeamFromName("Administração")] = true 
}

robTimer = { }


function robStore( target )
	if getElementType( target ) == "ped" and not isTimer(robTimer[target]) then
	
		setElementData( client, "rob", true )
		local money = math.random( 500, 10000 )
		local robtime = math.random(120000, 240000)
		
		
		setElementData( client, "robTime", robtime+getTickCount( ))
		setElementData( client, "robTime2", getTickCount( ))
		setTimer( CounterTime, 1000, (math.floor(robtime)/1000), client )
		
		
	    setTimer( payForRob, robtime, 1, client, money )
	    setTimer( robStatus, robtime, 1, client, target )
	    cancelTimers[client] = setTimer( cancelRob, (math.floor(robtime)/100), 100, client, target )
		giveWantedPoints ( client, 130 )
        setPedAnimation( target, "shop", "shp_rob_givecash", -1, false )
		
		
		local cops = getElementsByType( "player" ) 
		for theKey,cop in ipairs(cops) do 
			if lawTeams[getPlayerTeam(cop)] then
				local cx,cy,cz = getElementPosition( client )
				local nome = getElementData(p, "AccountData:Name")
				outputChatBox ( "#d9534f[CRIMINOSO][A157]: "..nome.."#FFFFFF está assaltando uma loja em: #ffa500"..getZoneName( cx, cy, cz ), cop, 255, 255, 255, true )
			end
		end		
		
	robTimer[target] = setTimer(function() end, 1000, 1 )
	elseif isTimer(robTimer[target]) then
	outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFCaia fora daqui, esta loja foi roubada recentemente!", client, 255, 255, 255, true)
	end
end
addEvent( "onRob", true )
addEventHandler( "onRob", root, robStore )

function payForRob( crim, amount )
	if isElement( crim ) then
		if getElementData( crim, "rob" ) then 
			if ( amount ) then
				triggerServerEvent ( "VDBGJobs->GivePlayerMoney", crim, crim, "CriminosoActions", cash, 15 )
				updateJobColumn ( getAccountName ( getPlayerAccount ( crim ) ), "CriminosoActions", "AddOne" )
			end	
			outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFAssalto bem sucedido, você ganhou:#acd373 "..tostring(amount)..".00", crim, 255, 255, 255, true)
		end 
	end
end

function robStatus( crim, target, money ) 
	if isElement( crim ) then
		if getElementData( crim, "rob" ) then 
			outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFNunca faça isso na vida real!", crim, 255, 255, 255, true)	
	    end
		setPedAnimation( target, nil, nil )
		setElementData( crim, "rob", false )
	end	
end

-- Check if the rob should be interrupted
function cancelRob( crim, target )
	if isElement( crim ) then
		if getElementData( crim, "VDBGJobs:ArrestingOfficer" ) or getElementData( crim, "onPlayerStartArrested" ) then
			setElementData( crim, "rob", false )
			outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFAssalto falhou!", crim, 255, 255, 255, true)
			setPedAnimation( target, nil, nil )
			if isTimer( cancelTimers[crim] ) then
				killTimer( cancelTimers[crim] )
			end
		end
	end
end

-- Round float values
function round(number, digits)
  	local mult = 10^(digits or 0)
  	return math.floor(number * mult + 0.5) / mult
end