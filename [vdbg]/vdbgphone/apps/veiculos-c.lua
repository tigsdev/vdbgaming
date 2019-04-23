function appFunctions.vehicles:onPanelLoad ( )
	guiGridListClear ( pages['vehicles'].grid )
	givingVehicle = nil
	appFunctions.vehicles:ReloadList ( )
	
	guiSetEnabled ( pages['vehicles'].show, false )
	guiSetEnabled ( pages['vehicles'].recover, false )
	guiSetEnabled ( pages['vehicles'].sell, false )
	guiSetEnabled ( pages['vehicles'].warptome, false )
end

addEvent ( "VDBGPhone:App->Vehicles:onClientGetVehicles", true )
addEventHandler ( "VDBGPhone:App->Vehicles:onClientGetVehicles", root, function  ( cList ) 
	vehicleData = { }
	guiGridListClear ( pages['vehicles'].grid )
	if ( #cList == 0 ) then
		guiGridListSetItemText ( pages['vehicles'].grid, guiGridListAddRow ( pages['vehicles'].grid ), 2, "Você não tem veículos.", true, true )
	else
		local impoundedVehicles = 0
		for i, v in ipairs ( cList ) do
			if ( v[11] == 0 ) then
				local row = guiGridListAddRow ( pages['vehicles'].grid )
				guiGridListSetItemText ( pages['vehicles'].grid, row, 1, tostring ( getVehicleNameFromModel ( v[3] ) ), false, false )
				guiGridListSetItemData ( pages['vehicles'].grid, row, 1, v[2] )
				table.insert ( vehicleData, v[2], v )
			else
				impoundedVehicles = impoundedVehicles + 1
			end
		end
		if ( impoundedVehicles ~= 0 ) then
			exports['VDBGMessages']:sendClientMessage ( "Você tem "..impoundedVehicles.." veículos apreendidos.", 255, 255, 0 )
		end
	end
end )

function appFunctions.vehicles:CloseMenu ( )
	guiSetText ( pages['vehicles'].show, "Show" )
	guiGridListClear ( pages['vehicles'].grid )
	showCursor ( false )
	vehicleData = nil
end

function appFunctions.vehicles:ReloadList ( )
	guiGridListClear ( pages['vehicles'].grid )
	guiGridListSetItemText ( pages['vehicles'].grid, guiGridListAddRow ( pages['vehicles'].grid ), 2, "Carregando...", true, true )
	triggerServerEvent ( "VDBGPhone:App->Vehicles:onPanelOpened", localPlayer )
end

function appFunctions.vehicles:GetVehicleVisible ( id )
	local i = vehicleData[id][9]
	if ( i == 1 ) then
		return true
	else
		return false
	end
end