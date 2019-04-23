
--[[ old
addEvent( "vehicles:returnVehicleNitroLevel", true )
addEventHandler( "vehicles:returnVehicleNitroLevel", root,
	function ( id )
		if getElementType(source) ~= "vehicle" then return end;
		local nitro = getVehicleNitroLevel( source ) or 0
		triggerServerEvent( "vehicles:DoSaveVehicleNitroLevel", source, nitro, id )
	end
)]]