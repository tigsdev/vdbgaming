local scoreboardDummy

addEventHandler ( "onResourceStart", resourceRoot, function ()
	scoreboardDummy = createElement ( "scoreboard" )
	setElementData( scoreboardDummy, "maxPlayers", getMaxPlayers() )
	
end, false )

addEventHandler( "onResourceStart", resourceRoot,
	function ()
		playerIDDataName = playerIDDataName or "ID"
		scoreboardAddColumn(playerIDDataName, 28, 1)
		scoreboardAddColumn("FPS", 42, 4)
	
		for id, player in ipairs( getElementsByType("player") ) do
			setElementData( player, playerIDDataName, id )
		end
	end
)

addEventHandler ( "onResourceStop", resourceRoot, function ()
	if scoreboardDummy then
		destroyElement( scoreboardDummy )
	end
end, false )

function scoreboardAddColumn(player, columnName, columnWidth, prioritySlot)
	if isElement(player) and type(columnName) == "string" then
		prioritySlot, columnWidth = prioritySlot or false, tonumber(columnWidth) or 70
		triggerClientEvent(player, "DNLScoreboard:scoreboardAddColumn", player, columnName, columnWidth, prioritySlot)
	end
end
