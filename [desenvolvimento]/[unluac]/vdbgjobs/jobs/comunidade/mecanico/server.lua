local vehicleDropPoints = {
	-- x, y, z, rz
	{ -2025.8, 179.06, 28.84 }
}

addEventHandler ( "onResourceStart", resourceRoot, function ( )
	for i, v in ipairs ( vehicleDropPoints ) do 
		local x, y, z, rz = unpack ( v )
		exports.VDBG3DTEXT:create3DText ( 'Porto Seguros', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Mecanico", "JOB")
		local marker = createMarker ( x, y, z-2, "cylinder", 5, 255, 255, 0, 80 )
		setElementData ( marker, "VDBGJobs:Mechanic.DropPointRotation", rz )
		addEventHandler ( "onMarkerHit", marker, function ( p )
			if ( getElementType ( p ) == 'player' ) then
				if ( isPedInVehicle ( p ) and getElementData ( p, "Job" ) == "Mecanico" and getElementModel ( getPedOccupiedVehicle ( p ) ) == 525 ) then
					local car = getVehicleTowedByVehicle ( getPedOccupiedVehicle ( p ) )
					if car then
						local vehicleID = getElementData ( car, "VDBGVehicles:VehicleID" )
						local vehicleOwner = getElementData ( car, "VDBGVehicles:VehicleAccountOwner" )
						local name = getVehicleNameFromModel ( getElementModel ( car ) )
						if vehicleID and vehicleOwner then
							local owner = exports['VDBGPlayerFunctions']:getPlayerFromAcocunt ( vehicleOwner )
							if owner then
								outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFSeu #428bca"..name.." #FFFFFFfoi colocado na oficina pela empresa de #4aabd0seguros.", owner,255, 255, 255, true )
							end
							setElementHealth ( car, 311 )
							exports['VDBGVehicles']:showVehicle ( vehicleID, false )								
							exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Impounded=? WHERE VehicleID=?", '1', vehicleID )
						else
							setElementHealth ( car, 311 )
							exports['VDBGVehicles']:showVehicle ( vehicleID, false )
							exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Impounded=? WHERE VehicleID=?", '1', vehicleID )
							local cash = 3000 + math.random ( 0, 150 )
							if ( cash ) then
								triggerEvent ( "VDBGJobs->GivePlayerMoney", p, p, "TowedVehicles", cash, 5 )
								updateJobColumn ( getAccountName ( getPlayerAccount ( p ) ), "TowedVehicles", "AddOne" )
							end
							outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFVocê ganhou: #acd373"..cash.." #FFFFFFpor colocar o carro do "..vehicleOwner.." #4aabd0seguro.", p,255, 255, 255, true )
							
						end
					else
						outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFVocê precisa rebocar um veículo para soltá-lo.", p, 255, 255, 255, true )
					end
				elseif ( not isPedInVehicle ( p ) ) then
					local acc = getPlayerAccount ( p )
					if isGuestAccount ( acc ) then return end
					
					local cars = exports['VDBGSQL']:db_query ( "SELECT * FROM vehicles WHERE Owner=? AND Impounded=?", getAccountName ( acc ), '1' )
					if ( #cars == 0 ) then
						return outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFVocê não tem veículos assegurados pelo #4aabd0seguro.", p,255, 255, 255, true )
					end
					
					triggerClientEvent ( p, "VDBGJobs:Mechanic.OpenRecovery", p, cars, source )
				end
			end
		end )
	end
end )

addEvent ( "VDBGJobs:Mechanic.onPlayerRecoverVehicle", true )
addEventHandler ( "VDBGJobs:Mechanic.onPlayerRecoverVehicle", root, function ( id, marker, price ) 
	if id and marker then
		local x, y, z = getElementPosition ( marker )
		local rz = getElementData ( marker, "VDBGJobs:Mechanic.DropPointRotation" ) or 0
		veh = exports['VDBGVehicles']:showVehicle ( id, true )
		setElementPosition ( veh, x, y, z + 3.5 )
		setElementRotation ( veh, 0, 0, rz )
		warpPedIntoVehicle ( source, veh )
		exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Impounded=? WHERE VehicleID=?", '0', id )
		takePlayerMoney ( source, price )
	end
end )


local vehiclesBeingFixed = { }
local timer = { }
addEvent ( "VDBGJobs:Mechanic_AttemptFixVehicle", true )
addEventHandler ( "VDBGJobs:Mechanic_AttemptFixVehicle", root, function ( v )
	if ( vehiclesBeingFixed[v] ) then
		outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFEste veículo já está a sendo reparado.", source,255, 255, 255, true )
		return triggerClientEvent ( source, "VDBGJobs:Mechanic_CancelFixingRequest", source, 'source', false )
	end
	
	local controller = getVehicleController ( v )
	local price = (1000-(math.floor(getElementHealth(v))))
	if ( getPlayerMoney ( controller ) >= price ) then
		if ( price == 0 ) then
			return outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFEste veículo não precisa ser reparado.", source,255, 255, 255, true )
		end
		
		outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFEnviando para #428bca"..getElementData(controller, "AccountData:Name").." #FFFFFFum pedido que vai expirar em 15 segundos.", source,255, 255, 255, true )
		outputChatBox ( "#d9534f[MECÂNICO] #428bca"..getElementData(source, "AccountData:Name").."#FFFFFF quer consertar seu veículo por #acd373R$"..tostring(price)..".00, #FFFFFFPressione #acd3731 #FFFFFFpara aceitar, e #d9534f2 #FFFFFFpara negar.", controller, 255, 255, 255, true )
		setElementFrozen ( v, true )
		setElementFrozen ( source, true )
		showCursor ( controller, true )
		showCursor ( source, true )
		vehiclesBeingFixed[v] = true
		triggerClientEvent ( controller, "VDBGjobs:Mechanic_BindClientKeys", controller, source )
		timer[v] = setTimer ( function ( s, p, v )
			if ( isElement ( s ) ) then
				triggerClientEvent ( s, "VDBGJobs:Mechanic_CancelFixingRequest", s, 'source' )
				setElementFrozen ( s, false )
				showCursor ( s, false )
			end
			
			if ( isElement ( p ) ) then
				triggerClientEvent ( p, "VDBGJobs:Mechanic_CancelFixingRequest", p, 'client' )
				setElementFrozen ( p, false )
				showCursor ( p, false )
			end
			
			if ( isElement ( v ) ) then
				setElementFrozen ( v, false )
				vehiclesBeingFixed[v] = nil
			end
			
		end, 15000, 1, source, controller, v )
	else
		outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFEste jogador não tem dinheiro suficiente para pagá-lo.", source,255, 255, 255, true )
	end
end )

addEvent ( "VDBGJobs:Mech_OnClientAcceptFixing", true )
addEventHandler ( "VDBGJobs:Mech_OnClientAcceptFixing", root, function ( fixer )
	local v = getPedOccupiedVehicle ( source )
	
	if ( isTimer ( timer[v] ) ) then
		killTimer ( timer[v] )
	end
	
	if ( isElement ( v ) and isElement ( fixer ) ) then
		outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFO seu veículo está começando ser reparado por #428bca"..getElementData(fixer, "AccountData:Name")..".", source,255, 255, 255, true )
		outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFComeçando reparos...", fixer,255, 255, 255, true )
		triggerClientEvent ( fixer, "VDBGMessages:Mechanic_OpenLoadingBar", fixer, source )
		setVehicleDoorOpenRatio ( v, 0, 1 )
	else
		outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFFalha!", source,255, 255, 255, true )
		if ( isElement ( v ) ) then
			setElementFrozen ( v, false )
		end if ( isElement ( fixer ) ) then
			setElementFrozen ( fixer, false )
			showCursor ( fixer, false )
		end
		
		showCursor ( source, false )
		vehiclesBeingFixed[v] = nil
	end
end )

addEvent ( "VDBGJobs:Mech_OnClientDenyFixing", true )
addEventHandler ( "VDBGJobs:Mech_OnClientDenyFixing", root, function ( f )
	setElementFrozen ( source, false )
	setElementFrozen ( f, false )
	showCursor ( source, false )
	showCursor ( f, false )
	local car = getPedOccupiedVehicle ( source )
	if ( isElement ( car ) ) then
		setElementFrozen ( car, false )
		vehiclesBeingFixed[car] = nil
	end
	outputChatBox ( "#d9534f[MECÂNICO]#428bca "..getElementData(source, "AccountData:Name").." #d9534fNegou-lhe #FFFFFFum reparo em seu veículo.", f,255, 255, 255, true )
	outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFVocê negou a #428bca"..getElementData(f, "AccountData:Name").." #FFFFFFum reparo em seu veículo.", source,255, 255, 255, true )
	if ( isTimer ( timer[car] ) ) then
		killTimer ( timer[car] )
	end
	triggerClientEvent ( f, 'VDBGJobs:Mechanic_onDenied', f )
end )

addEvent ( "VDBGJobs:Mechanic_onVehicleCompleteFinish", true )
addEventHandler ( "VDBGJobs:Mechanic_onVehicleCompleteFinish", root, function ( p )
	-- p = client being fixed
	if ( isElement ( p ) ) then
		local car = getPedOccupiedVehicle ( p )
		if ( isElement ( car ) ) then
			local price = (1000-(math.floor(getElementHealth(car))))
			fixVehicle ( car )
			local rx, ry, rz = getElementRotation ( car )
			setElementRotation ( car, rx, 0, rz )
			takePlayerMoney ( p, price )			
			if ( price ) then
				triggerEvent ( "VDBGJobs->GivePlayerMoney", p, p, "veiculosreparados", price, 10 )
				updateJobColumn ( getAccountName ( getPlayerAccount ( p ) ), "veiculosreparados", "AddOne" )
			end
			outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFO seu veículo foi reparado por #acd373R$"..tostring ( price )..".00 .", p,255, 255, 255, true )
			outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFVocê reparou o veículo de #428bca"..getElementData(p, "AccountData:Name").."' #FFFFFFe ganhou #acd373R$"..tostring ( price )..".00 !", source,255, 255, 255, true )
			mechanic_reset ( p, source, car )
		else
			outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFFalha ao reparar o veículo ; #d9534fo veículo não existe.", source,255, 255, 255, true )
			mechanic_reset ( p, source, car )
		end
	else
		outputChatBox ( "#d9534f[MECÂNICO] #FFFFFFFalha ao reparar o veículo ; #d9534fo cliente não existe.", source,255, 255, 255, true )
		mechanic_reset ( p, source, car )
	end
end )

function mechanic_reset ( p, s, car )
	if ( isElement ( p ) ) then
		showCursor ( p, false )
		setElementFrozen ( p, false )
	end
	
	if ( isElement ( s ) ) then
		showCursor ( s, false )
		setElementFrozen ( s, false )
	end
	
	if ( isElement ( car ) ) then
		setElementFrozen ( car, false )
		vehiclesBeingFixed[car] = nil
	end
	
end