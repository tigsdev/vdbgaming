------------------------------------------
-- 		 Contas Banidas					--
------------------------------------------
-- Script by: Tiago Santos  (Galego)	--
-- Arquivo: banimento-s.lua			    --
-- Copyright 2015 (C) Tiago Santos		--
-- Todos os direitos reservados.		--
------------------------------------------

local bans = { }		-- Todos os bans salvos, mesmo os que foram salvos depois da resource estar desligada

--[[ Formato da tabela de banimentos:
	bans[serial] = {
		serial 		= user serial,
		ip 			= user ip,
		account 	= user account,
		unban_day 	= unban day,
		unban_month = unban month,
		unban_year 	= unban year,
		reason 		= reason,
		banner 		= the person who banned,
		banned_on 	= when the user was banned
	}
]]


addEventHandler ( "onResourceStart", resourceRoot, function ( )
	exports.VDBGSQL:db_exec ( "CREATE TABLE IF NOT EXISTS ban_system ( serial TEXT, ip TEXT, account TEXT, unban_day INT, unban_month INT, unban_year INT, banner TEXT, reason TEXT, banned_on DATE, banned_ont TIME )" );
	-- Load the bans
	local q = exports.VDBGSQL:db_query ( "SELECT * FROM ban_system" );
	if ( q and type ( q ) == "table" ) then
		for i, v in pairs ( q ) do
			local data = { }
			for ind, var in pairs ( v ) do
				data[ind] = var
				if ( ind == "unban_day" or ind == "unban_month" or ind == "unban_year" ) then
					data[ind] = tonumber ( var )
				end
			end
			bans[v.serial] = data
			isSerialBanned ( v.serial )
		end
	end
	
	setTimer ( function ( )
		local playerSerials = { }
		for i, v in pairs ( getElementsByType ( "player" ) ) do
			playerSerials[getPlayerSerial(v)] = v
		end
		
		for i, v in pairs ( bans ) do
			if ( playerSerials [ v.serial ] ) then
				loadBanScreenForPlayer ( playerSerials [ v.serial ] )
			end
		end
		playerSerials = nil
	end, 500, 1 )
end )

function banAccount ( acc, ban_day, unban_month, ban_year, reason, banner )
	local reason = reason or "Não definida, ou seja: Administrador sujeito a punição !"
	local banner = banner or "Banido pelo Servidor"
	local d = exports.VDBGSQL:db_query ( "SELECT * FROM accountdata WHERE Username=?", acc );
	if ( d and type ( d ) == "table" and table.len ( d ) == 1 ) then
		local d = d [ 1 ]
		local ser = d['LastSerial']
		local ip = d['LastIP']
		local ban_day = tonumber ( ban_day ) or 1
		local unban_month = tonumber ( unban_month )  or 1
		local ban_year = tonumber ( ban_year ) or 2015
		bans[ser] = {
			serial = ser, 
			ip = ip,
			account = acc,
			unban_day = ban_day, 
			unban_month = unban_month,
			unban_year = ban_year,
			reason = reason,
			banner = banner,
			banned_on = getToday(),
			banned_ont = getTime()
		}

		for i, v in pairs ( getElementsByType ( "player" ) ) do
			local a = getPlayerAccount ( v )
			if ( not isGuestAccount ( a ) and getAccountName ( a ) == acc ) then
				kickPlayer ( v, "Volte a logar, você estava errado. ( reconnect )" )
				break
			end
		end
		
	end
end


function getToday ( )
	local t = getRealTime ( )
	local year = t.year + 1900
	local month = t.month + 1
	local day  =t.monthday
	if ( month < 10 ) then month = 0 .. month end
	if ( day < 10 ) then day = 0 .. day end
	local date = table.concat ( { year, month, day }, "-" )
	return date
end

function getTime ()
	local t = getRealTime ( )
	local hours = t.hour
	local minutes = t.minute
	local segundos = t.second
	local time = table.concat ( { hours, minutes, segundos }, ":" )
	return time
end


function isSerialBanned ( serial )
	if ( bans [ serial ] ) then
		local isBanContinuted = false
		local today = today ( )
		local d = bans [ serial ]
		
		if ( tostring(d.unban_year):upper() == "NIL" or tostring(d.unban_month):upper() == "NIL" or tostring(d.unban_day):upper() == "NIL" ) then
			return true
		end
		
		local unbanMeth = ""
		if ( d.unban_year > today.year ) then
			isBanContinuted = true
			unbanMeth = 1
		elseif ( d.unban_year == today.year and d.unban_month > today.month ) then
			isBanContinuted = true
			unbanMeth = 2
		elseif ( d.unban_year == today.year and d.unban_month == today.month and d.unban_day > today.day ) then
			isBanContinuted = true
			unbanMeth = 3
		end
		if ( not isBanContinuted ) then
			bans [ serial ] = nil
			return false
		end
		
		-- try to detect the player
		for i, v in pairs ( getElementsByType ( "player" ) ) do
			if ( getPlayerSerial ( v ) == serial ) then
				loadBanScreenForPlayer ( v )
				break
			end
		end
		return true
	end
end

function loadBanScreenForPlayer ( player )
	toggleAllControls ( player, false )
	showChat ( player, false )
	showCursor(player, true)
	setPlayerHudComponentVisible ( player, 'all', false )
	setElementData ( player, "Job", "Banido" )
	setElementData ( player, "Job Rank", "Banido" )
	
	local d = bans [ getPlayerSerial ( player ) ]
	local banInfo = {
		account = d.account,
		ip = d.ip,
		serial = d.serial,
		reason = d.reason,
		banner = d.banner,
		unban_day = d.unban_day,
		unban_month = d.unban_month,
		unban_year = d.unban_year,
		banned_on = d.banned_on,
		banned_ont = d.banned_ont
	}


	for i, v in pairs ( banInfo ) do
		banInfo [ i ] = tostring ( v )
	end
	triggerClientEvent ( player, "VDBGBans:OpenClientBanScreen", player, banInfo ) 
end

addEventHandler ( "onPlayerLogin", root, function ( )
	local s = getPlayerSerial ( source )
	if ( bans [ s ] ) then
		kickPlayer ( source, "Pare de evitar o sistema de banimento, acesse nosso fórum !" )
	end
end )
	

function unbanAccount ( acc )
	local rV = false
	for i, v in pairs ( bans ) do
		if ( v.account == acc ) then
			bans[i] = nil
			rV = true
			break
		end
	end
	return rV
end

function saveBans ( )
	exports.VDBGSQL:db_exec ( "DELETE FROM ban_system" );
	local c = 0
	for i, v in pairs ( bans ) do
		exports.VDBGSQL:db_exec ( "INSERT INTO ban_system ( serial, ip, account, unban_day, unban_month, unban_year, banner, reason, banned_on, banned_ont ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )",
			v.serial, v.ip, v.account, v.unban_day, v.unban_month, v.unban_year, v.banner, v.reason, v.banned_on, v.banned_ont )
		c = c + 1
	end
	return c
end
addEventHandler ( "onResourceStop", resourceRoot, saveBans )


-- misc functions
function today ( )
	local d = getRealTime ( )
	local day = d.monthday
	local month = d.month + 1
	local year = d.year + 1900
	return { year=year, day=day, month=month }
end

function table.len ( t )
	local c = 0;
	for i, v in pairs ( t ) do
		c = c + 1
	end
	return c
end