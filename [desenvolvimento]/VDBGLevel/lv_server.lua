function addXP(player, nexp)
	if player and  nexp then
		local expa = (getElementData(player, "playerExp") or 0)
		setElementData(player, "playerExp", expa + nexp)
	end
end






































--[[
	Aqui vai aumentar a exp do jogador, e setar no element-data "playerExp"
	No client, vai ser chamado o evento onClientElementDataChange,
	que verifica quando muda o level
	
	addEventHandler("onPlayerWasted", root,
function (ammo, killer, weapon, bodypart, stealth)
	if killer and  killer ~= source and (getElementType(killer) == "player") then
		local newExp = 5 -- exp a ser acrescentada
		if (bodypart == 9) or stealth then
			newExp = 7
		end
		-- local Kills = (getElementData(killer, "totalkills") or 0)
		local exp = (getElementData(killer, "playerExp") or 0)
		-- setElementData(killer, "totalkills", Kills + 1)
		setElementData(killer, "playerExp", exp + newExp)
	end
	-- local deaths = (getElementData(source, "totaldeaths") or 0)
	-- setElementData(source, "totaldeaths", deaths + 1)
end)
]]