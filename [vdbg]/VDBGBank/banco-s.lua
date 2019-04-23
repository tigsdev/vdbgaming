local bankLocations = {
	-- { x, y, z, int, dim, { out x, out y, out z } },
	{ 362.3, 173.67, 1008.38, 3, 1, { 595.37, -1250.33, 19.28 } },
	{ 362.3, 173.67, 1008.38, 3, 2, { 2474.86, 1021.09, 10.82 } },
	{ 362.3, 173.67, 1008.38, 3, 3, { -1705.67, 785.32, 24.89 } },
	--{ 2478.19, 1013.93, 10.68, 0, 0, { 899.88, -984.7, 37.35 } }, -- for testing
}


local startingCash = 1000 
local accounts = { }

function doesBankAccountExist ( account )
	if ( accounts[account] ) then
		return true
	else
		return false
	end
end 

function createBankAccount ( name )
	if ( not doesBankAccountExist ( name ) ) then
		exports['VDBGSQL']:db_exec ( "INSERT INTO bank_accounts ( Account, Balance ) VALUES ( ?, ? )", tostring ( name ), tostring ( startingCash ) )
		accounts[tostring(name)] = tonumber ( startingCash )
		return true
	end
	return false
end 

function getBankAccounts ( )
	return acounts;
end 

function withdraw ( player, amount )
	local acc = getPlayerAccount ( player )
	if ( isGuestAccount ( acc ) ) then return false end
	local acc = getAccountName ( acc )
	if ( not doesBankAccountExist ( acc ) ) then
		createBankAccount ( acc )
	end
	accounts[acc] = accounts[acc] - amount
	givePlayerMoney ( player, amount )
	
	local today = exports.VDBGPlayerFunctions:getToday ( )
	local lg = getElementData(player, "AccountData:Name").." sacou R$"..amount
	local serial = getPlayerSerial ( player )
	local ip = getPlayerIP ( player )
	exports.VDBGSQL:db_exec ( "INSERT INTO bank_transactions ( account, log, serial, ip, thetime ) VALUES ( ?, ?, ?, ?, ? )",
		acc, lg, serial, ip, today )
	
	return true
end 

function deposit ( player, ammount )
	local acc = getPlayerAccount ( player )
	if ( isGuestAccount ( acc ) ) then return false end
	local acc = getAccountName ( acc )
	if ( not doesBankAccountExist ( acc ) ) then
		createBankAccount ( acc )
	end
	takePlayerMoney ( player, amount )
	accounts[acc] = accounts[acc] + amount
	return true
end 

function getPlayerBank ( plr )
	local acc = getPlayerAccount ( plr )
	if ( isGuestAccount ( acc ) ) then return false end
	local acc = getAccountName ( acc )
	if ( not doesBankAccountExist ( acc ) ) then
		createBankAccount ( acc )
	end
	return accounts[acc]
end 

function onBankMarkerHit ( p )
	if ( p and getElementType ( p ) == 'player' and not isPedInVehicle ( p ) ) then
		if ( getElementInterior ( p ) == getElementInterior ( source ) and getElementDimension ( p ) == getElementDimension ( source )  ) then
			local acc = getPlayerAccount ( p )
			if ( isGuestAccount ( acc ) ) then return false end
			local acc = getAccountName ( acc )
			
			if ( not doesBankAccountExist ( acc ) ) then
				createBankAccount ( acc )
			end
			triggerClientEvent ( p, 'VDBGBank:onClientEnterBank', p, accounts[acc], acc, source )
		end
	end
end 

local bankMarkers = { }
addEventHandler ( "onResourceStart", resourceRoot, function ( )
	exports['VDBGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS bank_accounts ( Account TEXT, Balance INT )" )
	exports['VDBGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS bank_transactions ( account TEXT, log TEXT, serial TEXT, ip TEXT, thetime DATE )" )

	local q = exports['VDBGSQL']:db_query ( "SELECT * FROM bank_accounts" )
	for i, v in ipairs ( q ) do 
		accounts[v['Account']] = tonumber ( v['Balance'] )
	end
	
	for i, v in pairs ( bankLocations ) do
		local x, y, z, int, dim, out = unpack ( v )
		bankMarkers[i] = createPickup ( x, y, z, 3, 1274, 200, 0 )
		local bx, by, bz = unpack ( out )
		--createBlip ( bx, by, bz, 52 )
		setElementInterior ( bankMarkers[i], int )
		setElementDimension ( bankMarkers[i], dim )
		addEventHandler ( "onPickupHit", bankMarkers[i], onBankMarkerHit )
	end
	
	for i, v in ipairs ( getElementsByType ( 'player' ) ) do 
		local acc = getAccountName ( getPlayerAccount ( v ) )
		setElementData ( v, "VDBGBank:BankBalance", accounts[acc] or 0 )
	end
end ) function saveBankAccounts ( )
	if ( getResourceState ( getResourceFromName ( "VDBGSQL" ) ) ~= "running" ) then return end
	for i, v in pairs ( accounts ) do 
		exports['VDBGSQL']:db_exec ( "UPDATE bank_accounts SET Balance=? WHERE Account=?", tostring ( v ), tostring ( i ) )
	end
end 
addEventHandler ( "onResourceStop", resourceRoot, saveBankAccounts )

addEvent ( "VDBGBank:ModifyAccount", true )
addEventHandler ( "VDBGBank:ModifyAccount", root, function ( action, amount )
	local acc = getPlayerAccount ( source )
	if ( isGuestAccount ( acc ) ) then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffPor favor, faça o login para usar o sistema de banco.", source, 255, 255, 255, true )
	end
	
	local acc = getAccountName ( acc )
	local bankBalance = accounts[acc]
	if ( action == 'withdraw' ) then
		if ( bankBalance < amount ) then
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê não tem muito dinheiro suficiente em sua conta bancária.", source, 255, 255, 255, true )
		end
		accounts[acc] = accounts[acc] - amount
		givePlayerMoney ( source, amount )
		outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê sacou R$"..tostring ( amount )..",00 da sua conta bancária.", source, 255, 255, 255, true )
		exports['VDBGLogs']:outputActionLog ( getPlayerName ( source ).." depositou R$"..tostring(amount)..",00 em seu banco. (Total: R$"..accounts[acc]..",00)" )
		lg = getPlayerName ( source ).." sacou R$"..amount
	elseif ( action == 'deposit' ) then
		if ( amount > getPlayerMoney ( source ) ) then
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê não tem dinheiro suficiente dinheiro.", source, 255, 255, 255, true )
		end
		accounts[acc] = bankBalance + amount
		takePlayerMoney ( source, amount ) 
		outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê depositou R$"..tostring ( amount )..",00 em sua conta bancária.", source, 255, 255, 255, true )
		exports['VDBGLogs']:outputActionLog ( getPlayerName ( source ).." depositou $"..tostring(amount)..",00 em sua conta bancaria. (Total: R$"..accounts[acc]..",00)" )
		lg = getPlayerName ( source ).." depositou $"..amount
	end
	setElementData ( source, "VDBGBank:BankBalance", accounts[acc] ) 
	triggerClientEvent ( source, "VDBGBanks:resfreshBankData", source, accounts[acc] )
	
	
	-- log it
	local today = exports.VDBGPlayerFunctions:getToday ( )
	local serial = getPlayerSerial ( source )
	local ip = getPlayerIP ( source )
	exports.VDBGSQL:db_exec ( "INSERT INTO bank_transactions ( account, log, serial, ip, thetime ) VALUES ( ?, ?, ?, ?, ? )",
		acc, lg, serial, ip, today )
end ) 

addEventHandler ( "onPlayerJoin", root, function ( )
	setElementData ( source, "VDBGBank:BankBalance", 0 )
end ) 

addEventHandler ( "onPlayerLogin", root, function ( _, acc )
	local acc = getAccountName ( acc )
	setElementData ( source, "VDBGBank:BankBalance", accounts[acc] or 0 )
end )

function getAccountBalance ( account )
	return accounts [ account ] 
end




addEvent ( "VDBGBank->OnClientHitBankMarker", true )
addEventHandler ( "VDBGBank->OnClientHitBankMarker", root, function ( player, mark )
	outputChatBox (  "#d9534f[VDBG.ORG] #ffffffOlá, "..getElementData(player, "AccountData:Name"), source, 255, 255, 255, true )
	onBankMarkerHit ( player, mark )
end )
