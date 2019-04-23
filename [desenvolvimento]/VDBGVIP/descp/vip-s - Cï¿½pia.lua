print_ = print
print = outputChatBox


exports.scoreboard:scoreboardAddColumn ( "VIP", root, 50, "VIP", 10 )
for i, v in pairs ( getElementsByType ( "player" ) ) do
	if ( not getElementData ( v, "VIP" ) ) then
		setElementData ( v, "VIP", "SemVIP" )
	end
end

addEventHandler ( "onPlayerJoin", root, function ( )
	setElementData ( source, "VIP", "SemVIP" )
end )

 --
addCommandHandler ( "vip", function ( thePlayer, cmd, ... )
	if ( not isPlayerVIP ( thePlayer ) ) then
		return exports.VDBGMessages:sendClientMessage ( "Este comando é só apra VIP ( Loja: www.mtaserverbrasil.com )", thePlayer, 255, 0, 0 )
	end
	
	if ( isPlayerMuted ( thePlayer ) ) then
		return exports.VDBGMessages:sendClientMessage ( "Este comando está desativado, você está mutado.", thePlayer, 255, 255, 0 )
	end
	
	if ( not getElementData ( thePlayer, "userSettings" )['usersetting_display_vipchat'] ) then
		return exports.VDBGMessages:sendClientMessage ( "Por favor ative o chat vip no F3.", 0, 255, 255 )
	end
	
	local msg = table.concat ( { ... }, " " )
	if ( msg:gsub ( " ", "" ) == "" ) then
		return exports.VDBGMessages:sendClientMessage ( "use: /"..tostring(cmd).." [mensagem]", thePlayer, 255, 255, 0 )
	end
	
	local tags = "(VIP)"..tostring(exports.VDBGChat:getPlayerTags ( thePlayer ))
	local msg = tags..getPlayerName ( thePlayer )..": #ffffff"..msg
	for i,v in pairs ( getElementsByType ( 'player' ) ) do
		if ( ( isPlayerVIP ( v ) or exports.VDBGAdministration:isPlayerStaff ( thePlayer ) ) and getElementData ( v, "userSettings" )['usersetting_display_vipchat'] ) then
			outputChatBox ( msg, v, 200, 200, 0, true )
		end
	end
end )


function checkPlayerVipTime ( thePlayer )
	local vip = getElementData ( thePlayer, "VIP" )
	if ( vip == "SemVIP" ) then return end
	local expDate = getElementData ( thePlayer, "VDBGVIP.expDate" )  or "0000-00-00"  -- Format: YYYY-MM-DD
	if ( isDatePassed ( expDate ) ) then
		setElementData ( thePlayer, "VIP", "SemVIP" )
		setElementData ( thePlayer, "VDBGVIP.expDate", "0000-00-00" )
		exports.VDBGMessages:sendClientMessage ( "Seu VIP expirou.", thePlayer, 255, 0, 0 )
	end
end

function checkAllPlayerVIP ( )
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		checkPlayerVipTime ( v )
	end
end

function isPlayerVIP ( thePlayer )
	checkPlayerVipTime ( thePlayer )
	return tostring ( getElementData ( thePlayer, "VIP" ) ):lower ( ) ~= "SemVIP"
end 

function getVipLevelFromName ( l )
	local levels = { ['SemVIP'] = 0, ['Bronze'] = 1, ['Prata'] = 2, ['Ouro'] = 3, ['Platina'] = 4 }
	return levels[l:lower()] or 0;
end

------------------------------------------
-- Give VIP players free cash			--
------------------------------------------
local payments = { [1] = 500, [2] = 700, [3] = 1000, [4] = 1500 }

VipPayoutTimer = setTimer ( function ( )
	exports.VDBGLogs:outputServerLog ( "Depositando dinheiro vip...." )
	print_ ( "Depositando dinheiro vip...." )
	outputDebugString ( "Depositando dinheiro vip" )
	
	local sentAccounts = { }
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		local acc = getPlayerAccount ( v )
		if ( isPlayerVIP ( v ) ) then
			local l = getVipLevelFromName ( getElementData ( v, "VIP" ) )
			local money = payments [ l ]
			givePlayerMoney ( v, money )
			exports.VDBGMessages:sendClientMessage ( "Aqui é um R$ livre"..money.." por ser um usuário VIP!", v, 0, 255, 0 )
			sentAccounts[getAccountName(getPlayerAccount(v))] = true
		end
	end
	
	
	local query = exports.VDBGSQL:db_query ( "SELECT * FROM accountdata" );
	for i, v in pairs( query ) do
		if ( v['vip'] ~= "SemVIP" and not sentAccounts [ v['Username'] ] ) then
			local expTime = v['vipexp'] or "0000-00-00";
			if ( isDatePassed ( expTime ) ) then
				exports.VDBGSQL:db_exec ( "UPDATE accountdata SET vip=?, vipexp=? WHERE Username=?", "SemVIP", "0000-00-00", v['Username'] )
			else
				local m = tonumber ( v['Money'] )
				local level = v['vip'];
				local money = payments [ getVipLevelFromName ( level ) ]
				local m = m + money
				exports.VDBGSQL:db_exec ( "UPDATE accountdata SET Money=? WHERE Username=?", tostring ( m ), v['Username'] )
			end
		end
	end
end, (60*60)*1000, 0 ) 


function getVipPayoutTimerDetails ( ) 
	return getTimerDetails ( VipPayoutTimer )
end

function isDatePassed ( date )
	-- date format: YYYY-MM-DD
	local this = { }
	local time = getRealTime ( );
	this.year = time.year + 1900
	this.month = time.month + 1
	this.day = time.monthday 
	local old = { }
	local data = split ( date, "-" )
	old.year = data[1];
	old.month = data[2];
	old.day = data[3];
	for i, v in pairs ( this ) do
		this [ i ] = tonumber ( v )
	end for i, v in pairs ( old ) do
		old [ i ] = tonumber ( v )
	end
	if ( this.year > old.year ) then
		return true
	elseif ( this.year == old.year and this.month > old.month ) then
		return true
	elseif ( this.year == old.year and this.month == old.month and this.day > old.day ) then
		return true
	end
	return false
end


addEventHandler( "onResourceStart", resourceRoot, function ( )
	checkAllPlayerVIP ( )
	setTimer ( checkAllPlayerVIP, 120000, 0 )
end )