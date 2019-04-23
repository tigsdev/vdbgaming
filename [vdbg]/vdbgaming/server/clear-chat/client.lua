function cleanAll (player)
    for index, player in ipairs ( getElementsByType ( "player" ) ) do
        unbindKey ( player, "O", "down", showPanel )             
    end
end
addEventHandler ( "onResourceStop", getResourceRootElement ( getThisResource() ), cleanAll)

function adminText()
if ( hasObjectPermissionTo ( source, "command.aexec", true ) ) then
    else
	end
end
addEventHandler ( "onPlayerLogin", getRootElement(), adminText)
