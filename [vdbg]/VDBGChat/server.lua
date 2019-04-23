spammers = { }
possiblyMuted = { }
spamTimers = { }
muteLog = { }
maxMutes = 3
spamTimer = 500


addEventHandler ( "onPlayerChat", root, function  ( msg, tp )
	cancelEvent ( )
	if ( isGuestAccount ( getPlayerAccount ( source ) ) ) then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffPor favor, aguarde até que você esteja #4aabd0 logado#ffffff no servidor para usar o #4aabd0 chat#ffffff.", source, 255, 255, 255, true )
	end
	if ( spammers[source] ) then
		if ( possiblyMuted[source] ) then
			muteLog[source] = muteLog[source] + 1
			if ( muteLog[source] >= maxMutes ) then
				outputChatBox ( "#d9534f[VDBG.ORG] #4aabd0"..getElementData(source, "AccountData:Name").." #fffffffoi chutado por spam #d9534f["..maxMutes.."/"..maxMutes.."]", root, 255, 255, 255, true)
				kickPlayer ( source, "Você foi expulso por ser mutado "..maxMutes.." vezes por spam no chat." )
				exports['VDBGLogs']:outputPunishLog ( getElementData(source, "AccountData:Name").." kicked for spam" )
			else
				exports['admin']:aSetPlayerMuted ( source, true, 60 )
				outputChatBox ( "#d9534f[VDBG.ORG] #4aabd0"..getElementData(source, "AccountData:Name").." #fffffffoi silenciado por spam #4aabd0["..muteLog[source].."/"..maxMutes.."]", root, 255, 255, 255, true)
				exports['VDBGLogs']:outputPunishLog ( getElementData(source, "AccountData:Name").." foi silenciado por spam (1 minuto)" )
			end
		end
		if ( isElement ( source ) ) then
			possiblyMuted[source] = true
			if ( isTimer ( spamTimers[source] ) ) then
				resetTimer ( spamTimers[source] )
			end
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffff[CHAT INFO] Você esta digitando muito rapido. espere: #4aabd01.5 #ffffff segundos para enviar outra mensagem!", source, 255, 255, 255, true)
		end
	end
	
	local tags = getPlayerTags ( source )
	local r, g, b = 255, 255, 255
	if ( getPlayerTeam ( source ) ) then
		r, g, b = getTeamColor ( getPlayerTeam ( source ) )
	end
	local nomecor = rgbToHex(r, g, b)
	local playerName = getElementData(source, "AccountData:Name"):gsub ( '#%x%x%x%x%x%x', '' )
      if ( tp == 0 ) and msg then
		
			exports['VDBGLogs']:outputChatLog ( "Global", tags..playerName..": "..msg  )
			outputChatBox ( "" .. tags..nomecor..playerName..": #ffffff"..msg, root, 255, 255, 255, true )
        end
	if ( tp == 2 ) then
		if ( getPlayerTeam ( source ) ) then
			local tags_ = tags
			local tags = "(TEAM)"..tags_
			exports['VDBGLogs']:outputChatLog ( "Team - "..getTeamName(getPlayerTeam(source)), tags..playerName..": "..msg )
			for i, v in ipairs ( getPlayersInTeam ( getPlayerTeam ( source ) ) ) do
				outputChatBox ( tags..playerName..": #ffffff"..msg, v, r, g, b, true )
			end
		else
			outputChatBox ( "#d9534f[VDBG.ORG]#ffffff Você não está em uma equipe.", source, 255, 255, 255, true )
		end
	end
	
	spammers[source] = true
	spamTimers[source] = setTimer ( function ( p )
		spammers[p] = nil
		possiblyMuted[p] = nil
	end, spamTimer, 1, source )
	
end )

function getLocalAreaPlayers ( plr ) 
	local x, y, z = getElementPosition ( plr )
	local plrs = { }
	for i, v in ipairs ( getElementsByType ( 'player' ) ) do
		local px, py, pz = getElementPosition ( v )
		if ( getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) <= 50 ) then
			table.insert ( plrs, v )
		end
	end
	return plrs
end

function outputLocalMessage ( plr, _, ... )
	if ( ... ) then
		if ( isPlayerMuted ( plr ) ) then
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê não pode usar o #428bcabate-papo,#ffffff enquanto você estiver #d9534fmutado.", plr, 255, 255, 255, true )
		end
		
		if ( spammers[plr] ) then
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffPor favor, controle-se e não faça spam no chat. Duas mensagens a cada dois segundos no máximo.", plr, 255, 255, 255, true )
		end
		
		local msg = table.concat ( { ... }, " " )
		local players = getLocalAreaPlayers ( plr )
		local count = #players-1
		local tags="[LOCAL]["..count.."]"..getPlayerTags ( plr )
		local r, g, b = 255, 255, 255
		if ( getPlayerTeam ( plr ) ) then
			r, g, b = getTeamColor ( getPlayerTeam ( plr ) )
		end
		local playerName = getPlayerName ( plr ):gsub ( '#%x%x%x%x%x%x', '' )
		exports['VDBGLogs']:outputChatLog ( "Local", tags..playerName..": ".. msg )
		for i, v in ipairs ( players ) do
			outputChatBox ( tags..playerName..": #ffffff".. msg, v, r, g, b, true )
		end
		spammers[plr] = true
		setTimer ( function ( p )
			spammers[p] = nil
		end, spamTimer, 1, plr )
	end
end
addCommandHandler ( 'LocalChat', outputLocalMessage )

for i, v in ipairs ( getElementsByType ( 'player' ) ) do
	if ( not isGuestAccount ( getPlayerAccount ( v ) ) ) then
		bindKey ( v, "o", "down", "chatbox", "LocalChat" )
	end
end


setTimer ( function()
for i, v in ipairs ( getElementsByType ( 'player' ) ) do
	if ( isPlayerMuted ( v ) ) then
			setElementData(v,"mutado.admin",true)
		else
			setElementData(v,"mutado.admin",false)
	end
end
end, 5000, 0 )

addCommandHandler ( 'r', function ( source, command, ... ) 
	if ( isGuestAccount ( getPlayerAccount ( source ) ) ) then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffPor favor, aguarde até que você esteja logado no servidor para usar o bate-papo.", source, 255, 255, 255, true)
	end

	local team = "" 
	if ( getPlayerTeam ( source ) ) then
		team = getTeamName ( getPlayerTeam ( source ) )
	end
	if ( not exports['VDBGPlayerFunctions']:isTeamLaw ( team ) and getTeamName(getPlayerTeam(source))~="Administração" ) then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê não faz parte da equipe de policia.", source, 255, 255, 255, true)
	end
	
	if ( isPlayerMuted ( source ) ) then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffEste comando está desativado enquanto você estiver mutado.", source, 255, 255, 255, true)
	end
	
	if not ... then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffComando: /"..command.." [mensagem]", source, 255, 255, 255, true)
	end
	
	local msg = table.concat ( { ... }, " " )
	
	if ( spammers[source] ) then
		if ( possiblyMuted[source] ) then
			muteLog[source] = muteLog[source] + 1
			if ( muteLog[source] >= maxMutes ) then
				outputChatBox ( "#d9534f[VDBG.ORG] #ffffff"..getElementData(source, "AccountData:Name").." foi kickado por spam ["..maxMutes.."/"..maxMutes.."]", root, 255, 255, 255, true)
				kickPlayer ( source, "Você foi expulso por ser mutado "..maxMutes.." por spam no chat." )
				exports['VDBGLogs']:outputPunishLog ( getElementData(source, "AccountData:Name").." kicked por spam" )
			else
				exports['admin']:aSetPlayerMuted ( source, true, 60 )
				outputChatBox ( "#d9534f[VDBG.ORG] #ffffff"..getElementData(source, "AccountData:Name").." foi silenciado para spam ["..muteLog[source].."/"..maxMutes.."]", root, 255, 255, 255, true)
				exports['VDBGLogs']:outputPunishLog ( getElementData(source, "AccountData:Name").." foi silenciado por spam (1 minuto)" )
			end
		end
		if ( isElement ( source ) ) then
			possiblyMuted[source] = true
			if ( isTimer ( spamTimers[source] ) ) then
				resetTimer ( spamTimers[source] )
			end
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffPor favor, controle-se e não faça spam no chat. Duas mensagens a cada dois segundos no máximo.", source, 255, 255, 255, true)
		end
	end
	
	local tags = getPlayerTags ( source )
	local playerName = getElementData(source, "AccountData:Name"):gsub ( '#%x%x%x%x%x%x', '' )
	exports['VDBGLogs']:outputChatLog ( "Policial", tags..playerName..": "..msg  )
	outputLawMessage ( tags..playerName..": #ffffff"..msg, 0, 140, 255, true )
	
	local r, g, b = getTeamColor ( getPlayerTeam ( source ) )
	triggerClientEvent ( root, "VDBGPolice:Modules->Panel:OnClientPoliceRadioChat", root, tags..playerName, msg, r, g, b )
	spammers[source] = true
	spamTimers[source] = setTimer ( function ( p )
		spammers[p] = nil
		possiblyMuted[p] = nil
	end, spamTimer, 1, source )
end )

function outputLawMessage ( message, r, g, b, hex )
	local r = r or 255
	local g = g or 255
	local b = b or 255
	local hex = hex or false
	local message = "[POLICIAL] "..message
	for i, v in ipairs ( getElementsByType ( 'team' ) ) do 
		if ( exports['VDBGPlayerFunctions']:isTeamLaw ( getTeamName ( v ) ) ) then
			for i, v in ipairs ( getPlayersInTeam ( v ) ) do
				outputChatBox ( message, v, r, g, b, hex )
			end
		end
	end
	exports['VDBGLogs']:outputChatLog ( "Policial", message )
end






function getChatLine ( player, message )
	local playername = getPlayerName ( player ):gsub ( "#%x%x%x%x%x%x", "" )
	local playername = getPlayerTags ( player )..playername
	return playername..": #ffffff"..message
end

function getPlayerTags ( p )
	local id = getElementData ( p, "id" )
	local tags = "#2F7CCC["..id.."] #FFFFFF"
	if ( exports['VDBGAdministration']:getPlayerStaffLevel ( p, 'int' ) >= 9 ) then
	tags = tags.."VDBG:Owner * "
	elseif ( exports['VDBGAdministration']:getPlayerStaffLevel ( p, 'int' ) >= 8 ) then
	tags = tags.."VDBG:Console * "
	elseif ( exports['VDBGAdministration']:getPlayerStaffLevel ( p, 'int' ) >= 7 ) then
	tags = tags.."VDBG:Staff's * "
	elseif ( exports['VDBGAdministration']:getPlayerStaffLevel ( p, 'int' ) >= 5 ) then
	tags = tags.."VDBG:Admin * "
	elseif ( exports['VDBGAdministration']:getPlayerStaffLevel ( p, 'int' ) >= 1 ) then
	tags = tags.."VDBG:Suporte * " 
	
	elseif ( getResourceState ( getResourceFromName ( "VDBGGroups" ) ) == 'running' and exports['VDBGGroups']:getPlayerGroup(p) ~= nil ) then
	local grupo = exports['VDBGGroups']:getPlayerGroup(p)
	local rg, gg, bg = exports['VDBGGroups']:getGroupColor(grupo)
	local corh = rgbToHex(rg, gg, bg)
	tags = tags..corh.."<"..exports['VDBGGroups']:getGroupType(grupo)..":"..exports['VDBGGroups']:getGroupTag(grupo).."> * "
	elseif ( exports['VDBGVIP']:isPlayerVIP(p) ) then
	tags = tags.."VDBG:VIP * " 
	end
	return tags
end

addEventHandler ( 'onPlayerLogin', root, function ( )
	bindKey ( source, "o", "down", "chatbox", "LocalChat" )
	muteLog[source] = 0
end ) addEventHandler ( "onPlayerLogout", root, function ( )
	if ( muteLog[source] ) then
		muteLog[source] = nil
	end
end ) addEventHandler ( "onResourceStart", root, function ( )
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		muteLog[v] = 0
	end
end )

function rgbToHex ( nR, nG, nB )
    local sColor = "#"
    nR = string.format ( "%X", nR )
    sColor = sColor .. ( ( string.len ( nR ) == 1 ) and ( "0" .. nR ) or nR )
    nG = string.format ( "%X", nG )
    sColor = sColor .. ( ( string.len ( nG ) == 1 ) and ( "0" .. nG ) or nG )
    nB = string.format ( "%X", nB )
    sColor = sColor .. ( ( string.len ( nB ) == 1 ) and ( "0" .. nB ) or nB )
    return sColor
end

-- Cancel out private messages --
addEventHandler ( "onPlayerPrivateMessage", root, function ( ) 
	cancelEvent ( )
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffffAs mensagens privadas são desativados. Por favor, use o aplicativo SMS (F2) para mensagens.", source, 255, 255, 255, true)
end )


