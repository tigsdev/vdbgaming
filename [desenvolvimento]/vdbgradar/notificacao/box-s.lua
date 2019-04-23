function showBox(player, value, str)
	if isElement(player) then
		triggerClientEvent(player, "CreateBox", getRootElement(), value, str)
	end
end