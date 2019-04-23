function getPlayerDiamound(login)
local diamantes = 0
	for _, p in pairs ( getElementsByType ( "player" ) ) do 
		if ( getAccountName ( getPlayerAccount ( p ) ) == login ) then 
			count = getElementData(p, "VDBG.Diamantes" )
			diamantes = count
			foundPlayer = true;
			break;
		end 
	end

	if ( not foundPlayer ) then 
		local q = exports["VDBGSQL"]:db_query ( "SELECT diamantes FROM accountdata WHERE Username=?", login );
		if (q and q[1] and q[1].diamantes ) then 
			local m = tonumber ( q[1].diamantes )
			diamantes = m
		end 
	end 
	return diamantes or 0
end

function givePlayerDiamound(login,amount)
local foundPlayer = false;
	for _, p in pairs ( getElementsByType ( "player" ) ) do 
		if ( getAccountName ( getPlayerAccount ( p ) ) == login ) then 
			count = getElementData(p, "VDBG.Diamantes" )
			setElementData(p, "VDBG.Diamantes", count + amount )
			['VDBGSQL']:db_exec("UPDATE accountdata SET diamantes=? WHERE Username=?", count + amount, login )
			foundPlayer = true;
			break;
		end 
	end

	if ( not foundPlayer ) then 
		local q = exports["VDBGSQL"]:db_query ( "SELECT diamantes FROM accountdata WHERE Username=?", login );
		if (q and q[1] and q[1].diamantes ) then 
			local m = tonumber ( q[1].diamantes ) + amount
			exports['VDBGSQL']:db_exec("UPDATE accountdata SET diamantes=? WHERE Username=?", m, login )
		end 
	end 
end
addEvent( "givePlayerDiamound", true )
addEventHandler( "givePlayerDiamound", resourceRoot, givePlayerDiamound )

function takePlayerDiamound (login,amount)
local foundPlayer = false;
	for _, p in pairs ( getElementsByType ( "player" ) ) do 
		if ( getAccountName ( getPlayerAccount ( p ) ) == login ) then 
			count = getElementData(p, "VDBG.Diamantes" )
			setElementData(p, "VDBG.Diamantes", count - amount )
			foundPlayer = true;
			break;
		end 
	end

	if ( not foundPlayer ) then 
		local q = exports["VDBGSQL"]:db_query ( "SELECT diamantes FROM accountdata WHERE Username=?", login );
		if (q and q[1] and q[1].diamantes ) then 
			local m = tonumber ( q[1].diamantes ) - amount
			exports['VDBGSQL']:db_exec("UPDATE accountdata SET diamantes=? WHERE Username=?", m, login )
		end 
	end 
end

addEvent( "takePlayerDiamound", true )
addEventHandler( "takePlayerDiamound", resourceRoot, takePlayerDiamound )


function hasPlayerDiamound(login, amount)
	amount = tonumber( amount ) or 0
	local count = getPlayerDiamound(login)
	if login and  count >= amount then
	return true
	end
	return false
end

function updateDiamante(login,cart)
local amount = 1
	if tostring(cart) == "pack_diamante_1" then
		amount = 1000
			elseif tostring(cart) == "pack_diamante_2" then
				amount = 2000
					elseif tostring(cart) == "pack_diamante_3" then
						amount = 3000
	end
	outputConsole("teste")
	givePlayerDiamound ( login, amount )
end