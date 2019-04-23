chgnick = false
addEventHandler("onPlayerLogin", root,
function(_, account)
	local name = string.gsub(getElementData ( source, "AccountData:Name" ), " ", "_")
	setPlayerName ( source, name )
end)

addEventHandler("onPlayerChangeNick", getRootElement(), function (oldNick, newNick)
	chgnick = true
		if (chgnick == false) then 
			local name = string.gsub(getElementData ( source, "AccountData:Name" ), " ", "_")
			setPlayerName ( source, name )
			chgnick = false
			cancelEvent()
		end
end)