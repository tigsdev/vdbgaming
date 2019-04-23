--
-- c_handling_loader.lua
--

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		sendHandlingCfgToServer()
	end
)

---------------------------------------------------------------------
-- Read handling and send datum to swerver
---------------------------------------------------------------------
function sendHandlingCfgToServer()
	local handlingTable = readHandlingCfg( "handling.cfg" )
	triggerServerEvent( "onPlayerHandlingCfgChange", resourceRoot, handlingTable )
end


---------------------------------------------------------------------
-- Command in case the client file gets changed while connected
---------------------------------------------------------------------
addCommandHandler ( "reload_handling", sendHandlingCfgToServer )
