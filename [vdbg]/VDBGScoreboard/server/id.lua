
playerIDDataName = "ID"

function assignPlayerGameID ( source )
	if getElementData ( source, "id" ) then return nil end
	
	local players = getElementsByType ( "player" )
	local assignedIDs = {}
	local newid = nil
	
	if not players then newid = 1 else
		for _, value in ipairs ( players ) do
			local pid = getElementData ( value, "id" )
			if pid then table.insert ( assignedIDs, pid ) end
		end
		
		table.sort ( assignedIDs )
		
		for index, id in ipairs ( assignedIDs ) do
			if index ~= id then
				newid = index
			end
		end
		
		if not newid then
			newid = #assignedIDs + 1
		end
	end
	
	setElementData ( source, "id", newid )
	return newid
end
addEventHandler( "onPlayerJoin", root, function () 
assignPlayerGameID ( source )
 end )
 
 
function updatePlayersMoney ( )
    for index, player in ipairs ( getElementsByType "player" ) do
        setElementData ( player, "Money",getPlayerMoney ( player ))
		local name = string.gsub(getElementData ( player, "AccountData:Name" ) or "Sem_Nome", " ", "_")
		setPlayerName ( player, name )
    end
end
setTimer(updatePlayersMoney, 2500, 0)