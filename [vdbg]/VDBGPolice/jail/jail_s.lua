local jailedPlayers = { }

function isPlayerJailed ( p )
	if ( p and getElementType ( p ) == 'player' ) then
		if ( jailedPlayers[p] ) then
			return tonumber ( getElementData ( p, 'VDBGPolice:JailTime' ) )
		else
			return false
		end
	end
	return nil
end

function jailPlayer ( p, dur, announce, element, reason ) 
	if( p and dur ) then
		if  isPedInVehicle(p) then
			destroyElement( getPedOccupiedVehicle(p) )
		end
		local announce = announce or false
		jailedPlayers[p] = dur
		setElementInterior ( p, 0 )
		setElementDimension ( p, 0 )
		setElementPosition ( p, -2383.97, 1826.57, 23.42 )		
		toggleControl (p, "fire", false)
		toggleControl (p, "next_weapon", false)
		toggleControl (p, "previous_weapon", false)
		toggleControl (p, "aim_weapon", false)
		toggleControl (p, "vehicle_fire", false)
		setElementData ( p, 'VDBGPolice:JailTime', tonumber ( dur ) )
		setElementData ( p, "isGodmodeEnabled", true )
		exports['VDBGJobs']:updateJobColumn ( getAccountName ( getPlayerAccount ( p ) ), 'TimesArrested', "AddOne" )
		if ( announce ) then
			local reason = reason or "Ter estrela."
			local msg = ""
			if ( element and reason ) then
				msg = "#d9534f[D.P] #ffffff"..getElementData(p, "AccountData:Name").." Foi preso pelo(a) #428bca"..getElementData(element, "AccountData:Name").." #ffffffpor #d9534f"..tostring ( dur ).." #ffffffsegundos ["..reason.."]"
			elseif ( element ) then
				msg =  "#d9534f[D.P] #ffffff"..getElementData(p, "AccountData:Name").." Foi Preso pelo(a) #428bca"..getElementData(element, "AccountData:Name").." #ffffffpor #d9534f"..tostring ( dur ).." #ffffffsegundos"
			end
			outputChatBox ( msg, root, 255, 255, 255, true )
			exports['VDBGLogs']:outputPunishLog ( tostring ( msg ) )
		end
		triggerEvent ( "onPlayerArrested", p, dur, element, reason )
		triggerClientEvent ( p, "onPlayerArrested", p, dur, element, reason )
		return true
	end
	return false
end
 
function unjailPlayer ( p, triggerClient )
	local p = p or source
	setElementDimension ( p, 10 )
	setElementInterior ( p, 3 )
	setElementPosition ( p, 239.01, 176.81, 1003.03 )
    toggleControl (p, "fire", true)
    toggleControl (p, "next_weapon", true)
    toggleControl (p, "previous_weapon", true)
    toggleControl (p, "aim_weapon", true)
    toggleControl (p, "vehicle_fire", true)
	local wl = tonumber ( getElementData ( p, "VDBGJobs:WantedPoints" ) )
	setElementData ( p, "WantedPoints", tonumber ( wl ) ) 
	outputChatBox ( "#d9534f[D.P] #ffffffVocê foi libertado da prisão! Comporte-se na próxima vez.", p, 255, 255, 255, true )
	jailedPlayers[p] = nil
	setElementData ( p, "VDBGPolice:JailTime", nil )
	setElementData ( p, "isGodmodeEnabled", nil )
	exports['VDBGLogs']:outputActionLog ( getElementData(p, "AccountData:Name").." Foi Solto!" )
	if ( triggerClient ) then
		triggerClientEvent ( p, 'VDBGJail:StopJailClientTimer', p ) 
	end
end
addEvent ( "VDBGJail:UnjailPlayer", true )
addEventHandler ( "VDBGJail:UnjailPlayer", root, unjailPlayer )

function getJailedPlayers ( )
	return jailedPlayers
end
addCommandHandler ( "prender", function ( p, _, p2, time, ... )
	if ( exports['VDBGAdministration']:isPlayerStaff ( p ) ) then
		if ( p2 and time ) then
			local toJ = getPlayerFromName ( p2 ) or exports['VDBGPlayerFunctions']:getPlayerFromNamePart ( p2 )
			if toJ then
				jailPlayer ( toJ, time, true, p, table.concat ( { ... }, " " ) )
			else
				outputChatBox ( "#d9534f[D.P] #ffffffNenhum Jogador Encontrado com \""..p2.."\" em seu nome.", p, 255, 255, 255, true )
			end
		else
			outputChatBox ( "#d9534f[D.P] #ffffff Use: /prender [NOME/PARTE DO NOME (MAIÚSCULO)] [SEGUNDOS] [RASÃO]", p, 255, 255, 255, true )
		end
	end
end )

addCommandHandler ( "soltar", function ( p, _, p2 ) 
	if ( not exports['VDBGAdministration']:isPlayerStaff ( ) ) then
		return
	end if ( not p2 ) then
		return outputChatBox ( "Digite: /soltar [Nome do jogador]", p, 255, 255, 255, true )
	end if ( not getPlayerFromName ( p2 ) ) then
		p2 = exports['VDBGPlayerFunctions']:getPlayerFromNamePart ( p2 )
		if not p2 then
			return outputChatBox ( "#d9534f[D.P] #ffffffEste jogador não existe no servidor.", p, 255, 255, 255, true )
		end
	end
	
	if ( jailedPlayers[p2] ) then
		outputChatBox ( "#d9534f[D.P] #ffffffVocê foi solto "..getElementData(p2, "AccountData:Name").."!", p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[D.P] #ffffffVocê foi solto por "..getElementData(p, "AccountData:Name").."!", p2, 255, 255, 255, true )
		unjailPlayer ( p2, true )
	else
		outputChatBox ( "#d9534f[D.P] #ffffffEste Jogador não está preso.", p, 255, 0, 0 )
	end
	
end )


addEventHandler ( "onResourceStop", resourceRoot, function ( )
	exports['VDBGSQL']:saveAllData ( false )
end )  addEventHandler ( "onResourceStart", resourceRoot, function ( )
	setTimer ( function ( )
		local q = exports['VDBGSQL']:db_query ( "SELECT * FROM accountdata" )
		local data = { }
		for i, v in ipairs ( q ) do
			data[v['Username']] = v['JailTime']
		end
		
		
		for i, v in pairs ( data ) do 
			local p = exports['VDBGPlayerFunctions']:getPlayerFromAcocunt ( i )
			if p then
				local t = tonumber ( getElementData ( p, 'VDBGPolice:JailTime' ) ) or i
				jailPlayer ( p, tonumber ( t ), false )
			end
		end
	end, 500, 1 )
end )
addEvent ( "onPlayerArrested", true )