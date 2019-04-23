function amOpenWindow ( p )
	if ( getPlayerStaffLevel ( p, 'int' ) >= 10 ) then
		local query = exports.VDBGSQL:db_query ( "SELECT * FROM accountdata  ORDER BY Username" )
		local accounts = { 
			valid = { },
			invalid = { }
		}
		for i, v in ipairs ( query ) do
			if ( getAccount ( v.Username ) ) then
				accounts.valid[ tostring ( v.Username ) ] = v
			else
				accounts.invalid[ v.Username] = v
				accounts.invalid[ v.Username].reason = "Esta conta não existe no banco de dados do servidor."
			end
		end
		for i, v in ipairs ( getAccounts ( ) ) do
			local n = getAccountName ( v )
			if ( not accounts.valid [n] and not accounts.invalid[n] ) then
				accounts.invalid[n] = { }
				accounts.invalid[n].Username = n
				accounts.invalid[n].reason = "Esta conta não existe no banco de dados MySQL"
			end
		end
		triggerClientEvent ( p, "VDBGAdministration:AccountManager:onClientOpenWindow", p, accounts )
	end
end
addCommandHandler ( "am", amOpenWindow )

local removeAccount_ = removeAccount
-- remove account 
addEvent ( "VDBGAdmin:amManager:removeAccountFromHistory", true )
addEventHandler ( "VDBGAdmin:amManager:removeAccountFromHistory", root, function ( account )
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		if ( getAccountName ( getPlayerAccount ( v ) ) == account ) then
			return exports.VDBGMessages:sendClientMessage ( "Você foi kickado, "..tostring(getPlayerName(v)).." pois sua conta foi deletada.", source, 255, 255, 0 )
		end
		removeAccount(account,source)
	end
end )


function removeAccount ( account, source )
	local user = ""
	if ( isElement ( source ) ) then
		user = getPlayerName ( source ).." ("..getAccountName(getPlayerAccount(source))..")"
	else
		user = "Dono (Dono)"
	end
	exports.VDBGSQL:db_exec ( "DELETE FROM accountdata WHERE Username=?", account )
	exports.VDBGSQL:db_exec ( "DELETE FROM bank_accounts WHERE Account=?", account )
	exports.VDBGSQL:db_exec ( "DELETE FROM jobdata WHERE Username=?", account )
	exports.VDBGSQL:db_exec ( "DELETE FROM vehicles WHERE Owner=?", account )
	local acc = getAccount ( account )
	if acc then removeAccount_ ( acc ) end
	exports.VDBGLogs:outputActionLog ( user.." deletou a conta "..tostring(account) )
	if(isElement(source))then
		amOpenWindow ( source )
	end
end

-- Execute server data saving
addEvent ( "VDBGAdmin:aManager:ExecuteServerSave", true )
addEventHandler ( "VDBGAdmin:aManager:ExecuteServerSave", root, function ( )
	exports.VDBGSQL:saveAllData ( true )
	exports.VDBGLogs:outputActionLog ( getPlayerName(source).."("..getAccountName(getPlayerAccount(source))..") saved all server data" )
end )

addEvent ( "VDBGAdmin:Module->aManager:OpenPanelFromSource", true )
addEventHandler ( "VDBGAdmin:Module->aManager:OpenPanelFromSource", root, function ( )
	amOpenWindow ( source )
end )




-- Ban accounts
addEvent ( "VDBGAdmin:Modules->Banner:onAdminBanClient", true )
addEventHandler ( "VDBGAdmin:Modules->Banner:onAdminBanClient", root, function ( acc, day, month, year, reason, days )
	local l = getPlayerName(source).." ("..getAccountName(getPlayerAccount(source)).." baniu a conta "..tostring(acc).." for "..tostring(days).." days | reason: "..tostring(reason)
	outputDebugString ( l )
	exports.VDBGLogs:outputServerLog ( l )
	exports.VDBGLogs:outputActionLog ( l )
	exports.VDBGBans:banAccount ( acc, day, month, year, reason, getPlayerName(source) )
end )


-- update account vip
addEvent ( "VDBGAdmin->Modules->aManager->VIPManager->UpdateAccountVIP", true )
addEventHandler ( "VDBGAdmin->Modules->aManager->VIPManager->UpdateAccountVIP", root, function ( account, level, day, month, year )
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		local a = getPlayerAccount ( v )
		if ( not isGuestAccount ( a ) and getAccountName ( a ) == account ) then
			kickPlayer ( v, "SUA CONTA FOI RECONFIGURADA [SISTEMA VIP]" )
			break 
		end
	end 

	setTimer ( function ( account, level, day, month, year, source )
		exports.vdbgsql:db_exec ( "UPDATE accountdata SET vip=?, vipexp=? WHERE Username=?", tostring ( level ), table.concat({year,month,day},"-"), account )
		exports.vdbglogs:outputActionLog ( getAccountName(getPlayerAccount(source)).." updated "..tostring(account).." VIP - Level: "..tostring(level).." | Exp. Date: "..table.concat({year,month,day},"-") )
	end, 250, 1, account, level, day, month, year, source)
end )