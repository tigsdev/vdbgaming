exports.vdbgsql:db_exec ( "CREATE TABLE IF NOT EXISTS log_punish ( _time VARCHAR(35), account VARCHAR(40), serial VARCHAR(50), admin VARCHAR(40), log TEXT )" )


local forwardLogsToConsole = false
local paths = { action = "logs/action", punish = "logs/punish", chat = "logs/chat", server="logs/server", sql="logs/sql" }
function outputActionLog ( log )
	local path = paths.action .. "/"..exports.VDBGPlayerFunctions:getToday ( )..".txt"
	if ( not fileExists ( path ) ) then
		local f = fileCreate ( path )
		fileWrite ( f, "Este arquivo foi gerado pelo Console em "..tostring ( getToday ( ) ).."\n\n\n" )
		fileFlush ( f )
		fileClose ( f )
	end
	local f = fileOpen ( path )
	fileSetPos ( f, fileGetSize ( f ) )

	local log = "["..getToday().."] "..tostring ( log )
	fileWrite ( f, "\n"..log )
	fileFlush ( f )
	fileClose ( f )

	if ( forwardLogsToConsole ) then print ( "[LOG DE AÇÕES] "..tostring( log ) ) end
end

function outputPunishLog ( player, admin, log )
	local account = getPlayerAccount ( player )
	if ( isGuestAccount ( account ) ) then
		account = "Guest"
	else
		account = getAccountName ( account )
	end

	local from = "Server"
	if ( type ( admin ) ~= "string" and isElement ( admin ) and getElementType ( admin ) == "player" ) then
		from = getPlayerName ( admin )
	end

	local serial = getPlayerSerial ( player )
	exports.vdbgsql:db_exec ( "INSERT INTO log_punish ( _time, account, serial, admin, log ) VALUES ( ?, ?, ?, ?, ? )", getToday(), account, serial, from, log )

end

function outputChatLog ( chat, log )
	local path = paths.chat .. "/"..exports.VDBGPlayerFunctions:getToday ( )..".txt"
	if ( not fileExists ( path ) ) then
		local f = fileCreate ( path )
		fileWrite ( f, "Este arquivo foi gerado pelo Console em"..tostring ( getToday ( ) ).."\n\n\n" )
		fileFlush ( f )
		fileClose ( f )
	end
	local f = fileOpen ( path )
	fileSetPos ( f, fileGetSize ( f ) )

	local log = "["..getToday().."]  ("..tostring ( chat )..") -> "..tostring ( log )
	fileWrite ( f, "\n"..log )
	fileFlush ( f )
	fileClose ( f )

	if ( forwardLogsToConsole ) then print ( "[LOG DO CHAT] "..tostring( log ) ) end
end

function outputServerLog ( log )
	local path = paths.server .. "/"..exports.VDBGPlayerFunctions:getToday ( )..".txt"
	if ( not fileExists ( path ) ) then
		local f = fileCreate ( path )
		fileWrite ( f, "Este arquivo foi gerado pelo Console em "..tostring ( getToday ( ) ).."\n\n\n" )
		fileFlush ( f )
		fileClose ( f )
	end
	local f = fileOpen ( path )
	fileSetPos ( f, fileGetSize ( f ) )
	local log = "["..getToday().."] "..tostring ( log )
	fileWrite ( f, "\n".. tostring ( log ) )
	fileFlush ( f )
	fileClose ( f )

	if ( forwardLogsToConsole ) then print ( "[LOG DO SERVIDOR] "..tostring( log ) ) end
end

function outputSQLLog ( log )
	local path = paths.sql .. "/"..exports.VDBGPlayerFunctions:getToday ( )..".txt"
	if ( not fileExists ( path ) ) then
		local f = fileCreate ( path )
		fileWrite ( f, "Este arquivo foi gerado pelo Console em "..tostring ( getToday ( ) ).."\n\n\n" )
		fileFlush ( f )
		fileClose ( f )
	end
	local f = fileOpen ( path )
	fileSetPos ( f, fileGetSize ( f ) )

	local log = "["..getToday().."] "..tostring ( log )
	fileWrite ( f, "\n\n\n"..log )
	fileFlush ( f )
	fileClose ( f )

	if ( forwardLogsToConsole ) then print ( "[LOG DO BANCO DE DADOS] "..tostring( log ) ) end
end

function getToday ( ) 
	local time = getRealTime ( )
	local year = time.year+1900
	local month = time.month+1
	local day = time.monthday
	local hour = time.hour
	local min = time.minute
	local sec = time.second
	if ( month < 10 ) then month = 0 .. month end
	if ( day < 10 ) then day = 0 .. day end
	if ( hour < 10 ) then hour = 0 .. hour end
	if ( min < 10 ) then min = 0 .. min end
	if ( sec < 10 ) then sec = 0 .. sec end
	return table.concat({year,month,day},":").."-"..table.concat({hour,min,sec},":")
end

-- Log de ações ( liga desliga resources )
setTimer ( function ( ) 
	addEventHandler ( "onResourceStart", root, function ( source )
		outputServerLog ( getResourceName ( source ).. " foi ligado..." )
	end ) 
	
	addEventHandler ( "onResourceStop", root, function ( source )
		outputServerLog ( getResourceName ( source ).." foi desligado..." )
	end ) 
	
	
	---------------------------------
	-- Nick dos administradores 
	---------------------------------
	addEventHandler ( "onPlayerChangeNick", root, function ( o, n )
		if ( string.sub ( n, 0, 4 ):upper ( ) == "*VDBG*" and not exports.VDBGAdministration:isPlayerStaff ( source ) ) then
			exports.VDBGMessages:sendClientMessage ( "Você não pode ter o *VDBG* tag, por que você não é um membro da administração", source, 255, 0, 0 )
			cancelEvent ( )
			return
		end
		outputActionLog ( o.." Mudou seu nick para ".. n )
	end )
	
	addEventHandler ( "onPlayerLogin", root, function ( )
		if ( string.sub ( getPlayerName ( source ), 0, 4 ):upper() == "*VDBG*" and not exports.VDBGAdministration:isPlayerStaff ( source ) ) then
			local n = string.sub ( getPlayerName ( source ), 5, string.len ( getPlayerName ( source ) ) )
			setPlayerName ( source, n )
			exports.VDBGMessages:sendClientMessage ( "O seu nome foi alterado para "..tostring(n).." porque você tinha o *VDBG* tag e você não é staff", source, 255, 255, 0 )
		end
	end )
	
	for _, source in pairs ( getElementsByType ( "player" ) ) do
		local n = getPlayerName ( source )
		if ( string.sub ( n, 0, 4 ) == "*VDBG*" and not exports.VDBGAdministration:isPlayerStaff ( source ) ) then
			local n = string.sub ( getPlayerName ( source ), 5, string.len ( getPlayerName ( source ) ) )
			setPlayerName ( source, n )
			exports.VDBGMessages:sendClientMessage ( "O seu nome foi alterado para "..tostring(n).." porque você tinha o *VDBG* tag e você não é staff", source, 255, 255, 0 )
		end
	end
	
	
end, 2000, 1 )