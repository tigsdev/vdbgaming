local isFixing = false
local fixer = nil
local progress = nil
local sx, sy = guiGetScreenSize ( )
local rSX, rSY = sx / 1280, sx / 1024
addEventHandler ( "onClientClick", root, function ( btn, stat, _, _, _, _, _, el )
	if ( getElementData ( localPlayer, "Job" ) == "Mecanico" and btn == 'right' and stat == 'down' and isElement ( el ) and not isFixing ) then
		if ( getElementType ( el ) == 'vehicle' ) then
			local owner = getVehicleOccupant ( el )
			if ( owner ) then
				isFixing = true
				fixer = nil
				progress = 0
				client = nil
				triggerServerEvent ( "VDBGJobs:Mechanic_AttemptFixVehicle", localPlayer, el )
			else
				outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFEste veículo não tem um motorista que possa se responsábilizar pelo mesmo.", 255, 255, 255, true )
			end
		end
	end
end )

addEvent ( "VDBGJobs:Mechanic_CancelFixingRequest", true )
addEventHandler ( "VDBGJobs:Mechanic_CancelFixingRequest", root, function ( pos, msg )
	if ( msg == nil ) then
		msg = true
	end
	if ( pos == 'source' ) then
		isFixing = false
		client = nil
		if ( msg ) then
			outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFTempo expirado.", 255, 255, 255, true )
		end
	else
		fixer = nil
	end
end )

addEvent ( "VDBGjobs:Mechanic_BindClientKeys", true )
addEventHandler ( "VDBGjobs:Mechanic_BindClientKeys", root, function ( p )
	bindKey ( "1", "down", Mech_AcceptRequest )
	bindKey ( "2", "down", Mech_DenyRequest )
	fixer = p
end )

function Mech_AcceptRequest ( c )
	triggerServerEvent ( "VDBGJobs:Mech_OnClientAcceptFixing", localPlayer, fixer )
	unbindKey ( "1", "down", Mech_AcceptRequest )
	unbindKey ( "2", "down", Mech_DenyRequest )
	fixer = nil
	client = c
end

function Mech_DenyRequest ( )
	triggerServerEvent ( "VDBGJobs:Mech_OnClientDenyFixing", localPlayer, fixer )
	unbindKey ( "1", "down", Mech_AcceptRequest )
	unbindKey ( "2", "down", Mech_DenyRequest )
	fixer = nil
	client = nil
end

addEvent ( "VDBGJobs:Mechanic_onDenied", true )
addEventHandler ( "VDBGJobs:Mechanic_onDenied", root, function ( )
	isFixing = false
	client = nil
	fixer = nil
end )








addEvent ( "VDBGMessages:Mechanic_OpenLoadingBar", true )
addEventHandler ( "VDBGMessages:Mechanic_OpenLoadingBar", root, function ( p )
	progress = 0
	l_tick = getTickCount ( )
	client = p
	isFixing = true
	addEventHandler ( "onClientRender", root, mechanic_drawProgressBar ) 
end )

local l_tick = getTickCount ( )
function mechanic_drawProgressBar ( )
	if ( getTickCount ( ) - l_tick >= 150 ) then
		progress = progress + 1
		l_tick = getTickCount ( )
	end
	dxDrawRectangle ( ( sx / 2 - (rSX*604) / 2 ), ( sy / 2 - (rSY*74) / 2 ), rSX*604, rSY*74, tocolor ( 0, 0, 0, 170 ) )
	dxDrawRectangle ( ( sx / 2 - (rSX*600) / 2 ), ( sy / 2 - (rSY*70) / 2 ), rSX*(progress*6), rSY*70, tocolor ( 0, 200, 0, 170 ) )
	dxDrawText ( "Reparando - "..tostring ( math.floor ( progress ) ).."%", ( sx / 2 - (rSX*600) / 2 ), ( sy / 2 - (rSY*70) / 2 ), ( sx / 2 - (rSX*600) / 2 )+(rSX*600), ( sy / 2 - (rSY*70) / 2 )+(rSY*70), tocolor ( 255, 255, 255, 255 ), rSY*1.5, 'bankgothic', 'center', 'center' )
	if ( progress >= 100 ) then
		removeEventHandler ( "onClientRender", root, mechanic_drawProgressBar )
		triggerServerEvent ( "VDBGJobs:Mechanic_onVehicleCompleteFinish", localPlayer, client )
		isFixing = false
	end
end


-- Recover
local recoverPrice = 0
local marker = nil
local recover = {}
recover.window = guiCreateWindow( ( sx / 2 - (rSX*517) / 2 ), ( sy / 2 - (rSY*419) / 2 ), rSX*517, rSY*330, "VDBGaming - SEGURADORA", false)
recover.grid = guiCreateGridList(rSX*9, rSY*23, rSX*497, rSY*260, false, recover.window)
recover.close = guiCreateButton(rSX*11, rSY*285, rSX*153, rSY*45, "Fechar", false, recover.window)
recover.recover = guiCreateButton(rSX*174, rSY*285, rSX*153, rSY*45, "Recuperar (R$"..recoverPrice..".00)", false, recover.window)
guiSetVisible ( recover.window, false )
guiWindowSetSizable(recover.window, false)
guiGridListAddColumn(recover.grid, "ID", 0.1)
guiGridListAddColumn(recover.grid, "Nome", 0.3)
guiGridListAddColumn(recover.grid, "Preço", 0.3)
guiGridListSetSortingEnabled ( recover.grid, false )

addEvent ( "VDBGJobs:Mechanic.OpenRecovery", true )
addEventHandler ( "VDBGJobs:Mechanic.OpenRecovery", root, function ( cars, marker2 )
	addEventHandler ( "onClientGUIClick", root, onClientRecoverClick )
	guiGridListClear ( recover.grid )
	guiSetVisible ( recover.window, true )
	showCursor ( true )
	marker = marker2
	for i, v in ipairs ( cars ) do
		if tostring ( v['Type'] ) == "Automóvel" then
		recoverPrice = 5000
		elseif tostring ( v['Type'] ) == "Caminhão Monstro" then
		recoverPrice = 10000 
		elseif tostring ( v['Type'] ) == "Helicóptero" then
		recoverPrice = 15000 
		elseif tostring ( v['Type'] ) == "Quadriciclo" then
		recoverPrice = 2500 
		elseif tostring ( v['Type'] ) == "Barco" then
		recoverPrice = 20000
		elseif tostring ( v['Type'] ) == "Avião" then
		recoverPrice = 20000
		elseif tostring ( v['Type'] ) == "Motocicleta" then
		recoverPrice = 20000 
		elseif tostring ( v['Type'] ) == "Bicicleta" then
		recoverPrice = 20000 
		else
		recoverPrice = 500 
		end
		local r = guiGridListAddRow ( recover.grid )
		guiGridListSetItemText ( recover.grid, r, 1, tostring ( v['VehicleID'] ), false, false )
		guiGridListSetItemText ( recover.grid, r, 2, tostring ( getVehicleNameFromModel ( v['ID'] ) ), false, false )
		guiGridListSetItemText ( recover.grid, r, 3, tonumber((recoverPrice)*1.3), false, false )
		
	end
end )

function onClientRecoverClick ( )
	local row, col = guiGridListGetSelectedItem ( recover.grid )
	local vID = tonumber ( guiGridListGetItemText ( recover.grid, row, 3 ) )
	if vID ~= nil then
	guiSetText ( recover.recover, "Recuperar (R$"..vID..".00)" )
	end
	if ( source == recover.close ) then
		executeClose ( )
	elseif ( source == recover.recover ) then
		local row, col = guiGridListGetSelectedItem ( recover.grid )
		if ( row ~= -1 ) then
			if ( getPlayerMoney ( localPlayer ) >= recoverPrice ) then
				local vID = tonumber ( guiGridListGetItemText ( recover.grid, row, 1 ) )
				triggerServerEvent ( "VDBGJobs:Mechanic.onPlayerRecoverVehicle", localPlayer, vID, marker, recoverPrice )
				executeClose ( )
			else
				outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFVocê não tem dinheiro suficiente para recuperar o seu veículo.",255, 255, 255, true )
			end
		else
			outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFSelecione um veículo para se recuperar.",255, 255, 255, true )
		end
	elseif ( source == recover.grid ) then
		local row, col = guiGridListGetSelectedItem ( recover.grid )
	local vID = tonumber ( guiGridListGetItemText ( recover.grid, row, 3 ) )
	if vID ~= nil then
	guiSetText ( recover.recover, "Recuperar (R$"..vID..".00)" )
	end
	else
	guiSetText ( recover.recover, "Recuperar (R$0.00)" )
	end
	end


function executeClose ( )
	guiGridListClear ( recover.grid )
	guiSetVisible ( recover.window, false )
	showCursor ( false )
	removeEventHandler ( "onClientGUIClick", root, onClientRecoverClick )
	marker = nil
end