addEventHandler ("onPlayerChangeNick",getRootElement(),
	function (old,new)
		cancelEvent ()
	end
)



function getwan()
local players = getElementsByType ( "player" )
for theKey,thePlayer in ipairs(players) do
local wanted = getPlayerWantedLevel(thePlayer)
if wanted == 10 then
		setElementData ( thePlayer, "Wanted", 10 )
	else if wanted == 0 then
		setElementData ( thePlayer, "Wanted", 0 )
	else if wanted == 1 then
		setElementData ( thePlayer, "Wanted", 1 )
	else if wanted == 2 then
		setElementData ( thePlayer, "Wanted", 2 )
	else if wanted == 3 then
		setElementData ( thePlayer, "Wanted", 3 )
	else if wanted == 4 then
		setElementData ( thePlayer, "Wanted", 4 )
	else if wanted == 5 then
		setElementData ( thePlayer, "Wanted", 5 )
	else if wanted == 6 then
		setElementData ( thePlayer, "Wanted", 6 )
		end
	end
end
end
end
end
end
end
end
end

setTimer(getwan,100,0)
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), getwan )