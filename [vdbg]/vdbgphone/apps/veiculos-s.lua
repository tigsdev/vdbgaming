addEvent ( "VDBGPhone:App->Vehicles:onPanelOpened", true )
addEventHandler ( "VDBGPhone:App->Vehicles:onPanelOpened", root, function ( ) 
	local cars = exports.VDBGVehicles:getAccountVehicles ( getAccountName ( getPlayerAccount ( source ) ) )
	triggerClientEvent ( source, "VDBGPhone:App->Vehicles:onClientGetVehicles", source, cars )
end )

addEvent ( "VDBGPhone:Apps->Vehicles:SetVehicleVisible", true )
addEventHandler ( "VDBGPhone:Apps->Vehicles:SetVehicleVisible", root, function ( id, stat ) 
	local v = exports.VDBGVehicles:SetVehicleVisible ( id, stat, source )
end )

addEvent ( "VDBGPhone:Apps->Vehicles:AttemptRecoveryOnID", true )
addEventHandler ( "VDBGPhone:Apps->Vehicles:AttemptRecoveryOnID", root, function ( id )
	exports.VDBGVehicles:recoverVehicle ( source, id )
end ) 

addEvent ( "VDBGPhone:App->Vehicles:sellPlayerVehicle", true )
addEventHandler ( "VDBGPhone:App->Vehicles:sellPlayerVehicle", root, function ( plr, data )
	exports.VDBGVehicles:sellVehicle ( plr, data )
end )

addEvent ( "VDBGPhone:Apps->Vehicles:WarpThisVehicleToMe", true )
addEventHandler ( "VDBGPhone:Apps->Vehicles:WarpThisVehicleToMe", root, function ( id )
	if ( not exports.VDBGVehicles:warpVehicleToPlayer ( id, source ) ) then
		exports.VDBGMessages:sendClientMessage ( "Erro: Incapaz de trazer veículo", source, 255, 0, 0 )
	end
end )

