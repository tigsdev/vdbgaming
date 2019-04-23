function getVdbgDiamantes(player)
	local VdbgDiamantes = tonumber(getElementData(player, "VDBG.Diamantes")) or 0
	return VdbgDiamantes
end

function hasVdbgDiamantes(thePlayer, amount)
	if getVdbgDiamantes(thePlayer) >= amount then
		return true
	end
	return false
end

function takeVdbgDiamantes(thePlayer, amount)
	if hasVdbgDiamantes(thePlayer, amount) then
		setElementData(thePlayer, "VDBG.Diamantes", getVdbgDiamantes(thePlayer) - amount)
		return true
	else
		return false
	end
end

function giveVdbgDiamantes(thePlayer, amount)
	setElementData(thePlayer, "VDBG.Diamantes", getVdbgDiamantes(thePlayer) + amount)
	return
end

function setVdbgDiamantes(thePlayer, amount)
	setElementData(thePlayer, "VDBG.Diamantes", amount)
	return
end