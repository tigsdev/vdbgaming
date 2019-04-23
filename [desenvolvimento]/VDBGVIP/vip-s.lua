print_ = print
print = outputChatBox

--exports.scoreboard:scoreboardAddColumn ( "VIP", root, 50, "VIP", 10 )
for i, v in pairs ( getElementsByType ( "player" ) ) do
	if ( not getElementData ( v, "VIP" ) ) then
		setElementData ( v, "VIP", "SemVIP" )
	end
end

addEventHandler ( "onPlayerJoin", root, function ( )
	setElementData ( source, "VIP", "SemVIP" )
end )

-- VIP Chat --
addCommandHandler ( "vip", function ( p, cmd, ... )
	if ( not isPlayerVIP ( p ) ) then
		return exports.VDBGMessages:sendClientMessage ( "Este comando é somente para VIP (www.vdbg.org)", p, 255, 0, 0 )
	end
	
	if ( isPlayerMuted ( p ) ) then
		return exports.VDBGMessages:sendClientMessage ( "Este comando está desativado, você está mutado.", p, 255, 255, 0 )
	end
	
	if ( not getElementData ( p, "userSettings" )['usersetting_display_vipchat'] ) then
		return exports.VDBGMessages:sendClientMessage ( "Por favor ative o chat vip no F3.", 0, 255, 255 )
	end
	
	local msg = table.concat ( { ... }, " " )
	if ( msg:gsub ( " ", "" ) == "" ) then
		return exports.VDBGMessages:sendClientMessage ( "use: /"..tostring(cmd).." [mensagem]", p, 255, 255, 0 )
	end
	
	local tags = "(VIP)"..tostring(exports.VDBGChat:getPlayerTags ( p ))
	local msg = tags..getPlayerName ( p )..": #ffffff"..msg
	for i,v in pairs ( getElementsByType ( 'player' ) ) do
		if ( ( isPlayerVIP ( v ) or exports.VDBGAdministration:isPlayerStaff ( p ) ) and getElementData ( v, "userSettings" )['usersetting_display_vipchat'] ) then
			outputChatBox ( msg, v, 200, 200, 0, true )
		end
	end
end )





function checkPlayerVipTime ( p )
	local vip = getElementData ( p, "VIP" )
	if ( vip == "SemVIP" ) then return end
	local expDate = getElementData ( p, "VDBGVIP.expDate" )  or "0000-00-00"  -- Format: YYYY-MM-DD
	if ( isDatePassed ( expDate ) ) then
		setElementData ( p, "VIP", "SemVIP" )
		setElementData ( p, "VDBGVIP.expDate", "0000-00-00" )
		exports.VDBGMessages:sendClientMessage ( "Seu VIP expirou.", p, 255, 0, 0 )
	end
end

function checkAllPlayerVIP ( )
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		checkPlayerVipTime ( v )
	end
end

function isPlayerVIP ( p )
	checkPlayerVipTime ( p )
	return tostring ( getElementData ( p, "VIP" ) ):lower ( ) ~= "semvip"
end 


function getVipLevelFromName ( l )
	local levels = { ['semvip'] = 0, ['bronze'] = 1, ['prata'] = 2, ['ouro'] = 3, ['platina'] = 4 }
	return levels[l:lower()] or 0;
end




------------------------------------------
-- Give VIP players free cash			--
------------------------------------------
local payments = { [1] = 1000, [2] = 3000, [3] = 5000, [4] = 10000 }

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
			exports.VDBGMessages:sendClientMessage ( "Olá, você ganhou R$"..money..",00 por ser um usuário VIP!", v, 0, 255, 0 )
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


addEventHandler("onVehicleStartEnter",getRootElement(),
function(player)
    local account = getPlayerAccount(player)
    local accountName = getAccountName(account)
    if not isObjectInACLGroup ( "user." .. accountName, aclGetGroup ( "Level 10" ) ) then
        toggleControl ( player, "vehicle_secondary_fire", false ) -- disable their fire key
        toggleControl (player, "vehicle_fire", false )
    else
        toggleControl (player, "vehicle_secondary_fire", true ) -- enable their fire key
        toggleControl (player, "vehicle_fire", true)
    end
end)

function disableFireForHydra ( theVehicle, seat, jacked )
    if ( getElementModel ( theVehicle ) == 520 ) then -- if they entered a hydra
        toggleControl ( source, "vehicle_secondary_fire", false ) -- disable their fire key
    else -- if they entered another vehicle
        toggleControl ( source, "vehicle_secondary_fire", true ) -- enable their fire key
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), disableFireForHydra )

