function getPlayerDiamound(player)
local diamantes = 0
local count = getElementData(player, "VDBG.Diamantes" )
	if player and count then	
		diamantes = count
	end
	return diamantes or 0
end

function givePlayerDiamound(player,amount)
	local login = getElementData ( player, "AccountData:Username")
	if login and amount then
		triggerServerEvent ( "givePlayerDiamound", resourceRoot, login, amount )
	end
end

function takePlayerDiamound (player,amount)	
	local login = getElementData ( player, "AccountData:Username")
	if login and amount then
		triggerServerEvent ( "takePlayerDiamound", resourceRoot, login, amount )
	end
end


function hasPlayerDiamound(player, amount)
	amount = tonumber( amount ) or 0
	local count = getPlayerDiamound(player)
	if player and  count >= amount then
		return true
	end
	return false
end