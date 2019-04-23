
addEventHandler ( "onResourceStart", resourceRoot, function ( )
	exports['VDBGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS vehicles ( DistanceTraveled INT, Paintjob INT, Type TEXT, Owner TEXT, VehicleID INT, ID INT, Color TEXT, Upgrades TEXT, Position TEXT, Rotation TEXT, Health TEXT, Visible INT, Fuel INT, Impounded INT, Handling TEXT )" )
	for _, p in ipairs ( getElementsByType ( "player" ) ) do
		local veh = getAccountVehicles(getAccountName(getPlayerAccount(p)))
		if veh then 
		for i, v in pairs ( veh ) do 
			if veh[i][10] <= "305" and  veh[i][13] == "0" then
			showVehicle(veh[i][4], true)
			end
		end	
		end
	end
end )

vehicles = { }
local blip = { }
local texts = { }
local vehType = {
	["Automobile"] = "Automóvel", ["Monster Truck"] = "Caminhão Monstro", ["Helicopter"] = "Helicóptero",
	["Quad"] = "Quadriciclo", ["Boat"] = "Barco", ["Plane"] = "Avião", ["Bike"] = "Motocicleta", ["BMX"] = "Bicicleta"
}
function getAllAccountVehicles ( account )
	local cars = { } 
	local q = exports['VDBGSQL']:db_query ( "SELECT * FROM vehicles WHERE Owner=? ", tostring(account) )
	for i, v in pairs ( q ) do 
		table.insert ( cars, v )
	end
	return cars
end

function showAccountVehicleDamage ( account )
local veh = getAccountVehicles(account)
	if veh then 
		for i, v in pairs ( veh ) do 
			if veh[i][4] <= 305 then
			showVehicle(veh[i][4], true)
			end
		end	
	end
end

function showVehicle ( id, stat, player, msg )
	if stat then
		if ( not isElement ( vehicles[id] ) ) then
			local q = exports['VDBGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=? LIMIT 1", tostring(id) )
			if ( q and type ( q ) == 'table' and #q > 0 ) then
				local d = q[1]
				local health = tonumber ( d['Health'] )
				
				local owner, vehID = tostring ( d['Owner'] ), tonumber ( d['ID'] )
				local color, upgrades = fromJSON( d['Color'] ), fromJSON( d['Upgrades'] )
				local pos, rot = fromJSON( d['Position'] ), fromJSON( d['Rotation'] )
				
				pos = split ( pos, ', ' )
				local x, y, z = tonumber ( pos[1] ), tonumber ( pos[2] ), tonumber ( pos[3] )

				rot = split ( rot, ', ' )
				local rx, ry, rz = tonumber ( rot[1] ), tonumber ( rot[2] ), tonumber ( rot[3] )
				
				color = split ( color, ', ' )
				local r, g, b = tonumber ( color[1] ), tonumber ( color[2] ), tonumber ( color[3] )
				local hndl = fromJSON ( d['Handling'] )
				
				vehicles[id] = createVehicle( vehID, x, y, z, rx, ry, rz )
				setElementData(vehicles[id], "travelmeter-vehicleDistanceTraveled", tonumber(("%.1f"):format(d['DistanceTraveled'])))
				setElementData ( vehicles[id], "fuel", tonumber ( d['Fuel'] ) )
				setVehicleColor ( vehicles[id], r, g, b )
				setElementData ( vehicles[id], "VDBGVehicles:VehicleAccountOwner", tostring ( owner ) )
				setElementData ( vehicles[id], "VDBGVehicles:VehicleID", id )
				setElementData ( vehicles[id], "accountID", 300000+id )
				setElementHealth ( vehicles[id], health )
				
				setTimer(function() 
				if ( hndl and type ( hndl ) == "table" ) then
					for i, v in pairs ( hndl ) do
						
						setVehicleHandling ( vehicles [ id ], tostring ( i ), v ) 
						
					end
				end
				end, 1000, 1)
				
				for i, v in ipairs ( upgrades ) do 
					addVehicleUpgrade ( vehicles[id], tonumber ( v ) ) 
				end
				setVehiclePaintjob( vehicles[id], tonumber(d['Paintjob']) )
				
				exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Visible=? WHERE VehicleID=?", '1', id )
				
				if ( isElement ( blip[id] ) ) then
					destroyElement ( blip[id] )
				end if ( isElement ( texts[id] ) ) then
					destroyElement ( texts[id] )
				end 
				
				for _, p in pairs ( getElementsByType ( "player" ) ) do 
				if ( getAccountName ( getPlayerAccount ( p ) ) == owner ) then 
							local avatar = getElementData(p, "avatar")
							local nome = getElementData(p, "AccountData:Name")
							texts[id] =  exports.VDBG3DTEXT:create3DText ( "Veículo", { 0, 0, 0.5 }, { 0, 127, 255 }, vehicles[id],  { }, "veiculonames", nome, avatar)
						break;
					end 
				end
				
				
				
				
				if ( isElement ( player ) ) then 
					blip[id] = createBlipAttachedTo ( vehicles[id], 19, 2, 255, 255, 255, 255, 0, 8000, player )
					setElementData ( vehicles[id], "VDBGVehicles:VehiclePlayerOwner", player )
				end
			
				
				
				addEventHandler ( "onVehicleStartEnter", vehicles[id], function ( p, s ) 
					if ( getVehicleOccupant ( source ) )then
						local t = getPlayerTeam ( p )
						if ( t ) then
							if ( exports['VDBGPlayerFunctions']:isTeamLaw ( getTeamName ( t ) ) and getPlayerWantedLevel ( getVehicleOccupant ( source ) ) > 0 and s == 0 ) then
								setVehicleLocked ( source, false )
								return
							end
						end
					end
					
					if ( isVehicleLocked ( source ) ) then
						outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFEste veículo está trancado.", p, 255, 255, 255, true ) 
						cancelEvent ( ) 
					end 
				end )
				
				addEventHandler ( "onVehicleEnter", vehicles[id], function ( p, seat ) 
					local health = getElementHealth ( source ) 
					local id = getElementData ( source, "VDBGVehicles:VehicleID" )
					if ( health <= 305 ) then 
						setVehicleEngineState ( source, false )
						setElementHealth ( source, 305 )
						outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFMotor deste veículo parece estar danificado.", p, 255, 255, 255, true )
						return 
					end 
				
					local acc = getPlayerAccount ( p )
					if ( isGuestAccount ( acc ) ) then return end
					local acc = getAccountName ( acc )
					local name = getVehicleNameFromModel ( getElementModel ( source ) )
					local owner = getElementData ( source, 'VDBGVehicles:VehicleAccountOwner' )
					if ( acc == owner ) then
						outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFEste é o seu "..name.."!", p, 255, 255, 255, true )
					else
						outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFEste "..name.." pertence ao "..owner..".", p, 255, 255, 255, true )
					end
				end )
				
				if ( msg ) then
					outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFSeu "..getVehicleNameFromModel(vehID).." está localizado em "..getZoneName(x,y,z)..", "..getZoneName(x,y,z,true).."!",player,255, 255, 255, true )
				end
				if ( isElement ( player ) and vehID ) then exports['VDBGLogs']:outputActionLog ( getPlayerName ( player ).." gerou sua"..getVehicleNameFromModel ( vehID ) ) end
				return vehicles[id]
			end
		end
		return vehicles[id]
	else
		if ( isElement(vehicles[id]) ) then
			local rotrightx,rotrighty,rotrightz = getElementRotation(vehicles[id])
			local rotation = '[ "'..rotrightx..', 0, '..rotrightz..'" ]'
			local pos = toJSON ( createToString ( getElementPosition ( vehicles[id] ) ) )
			local rot = rotation
			local color = toJSON ( createToString ( getVehicleColor ( vehicles[id], true ) ) )
			local upgrades = toJSON ( getVehicleUpgrades ( vehicles[id] ) )
			local health, fuel = tostring ( getElementHealth ( vehicles[id] ) ), tonumber ( getElementData ( vehicles[id], "fuel" ) )
			local type = vehType[getVehicleType( vehicles[id] )] or getVehicleType(vehicles[id])
			local model = getElementModel ( vehicles[id] )
			local hdnl = toJSON ( getVehicleHandling ( vehicles[id] ) )
			player = player or getElementData(vehicles[id], "VDBGVehicles:VehiclePlayerOwner")
			local distanceTraveled = exports["travelmeter"]:getVehicleDistanceTraveled(player, vehicles[id]) or 0
			if tonumber(health) <= 305 then 
			exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET DistanceTraveled=?, Paintjob=?, Type=?, Color=?, Upgrades=?, Position=?, Rotation=?, Health=?, Fuel=?, Handling=? WHERE VehicleID=?", tonumber(("%.1f"):format(distanceTraveled)), getVehiclePaintjob(vehicles[id]), type, color, upgrades, pos, rot, health, fuel, hdnl, id )			
			return 
			outputChatBox("#d9534f[VDBG.ORG] #FFFFFFSeu veículo está danificado.", player, 255, 255, 255, true )		
			end
			 local attachedElements = getAttachedElements ( vehicles[id] )
			for i,v in ipairs ( attachedElements ) do
				detachElements ( v, vehicles[id] )
				destroyElement ( v )
			end
			exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET DistanceTraveled=?, Paintjob=?, Type=?, Color=?, Upgrades=?, Position=?, Rotation=?, Health=?, Fuel=?, Handling=? WHERE VehicleID=?", tonumber(("%.1f"):format(distanceTraveled)), getVehiclePaintjob(vehicles[id]), type, color, upgrades, pos, rot, health, fuel, hdnl, id )
			destroyElement ( vehicles[id] )
			
			exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Visible=? WHERE VehicleID=?", '0', id )
			if ( isElement ( blip[id] ) ) then
				destroyElement ( blip[id] )
			end if ( isElement ( texts[id] ) ) then
				destroyElement ( texts[id] )
			end
			
			if ( isElement ( player ) ) then
				exports['VDBGLogs']:outputActionLog ( getPlayerName ( player ).." escondeu sua "..getVehicleNameFromModel ( model ) )
			end
		end
	end
	return false
end

function warpVehicleToPlayer ( id, player )
	if ( not isElement ( vehicles [ id ] ) )  then return false end
	if ( getElementInterior ( player ) ~= 0 or getElementDimension ( player ) ~= 0 ) then return false end 
	if ( getVehicleController ( vehicles [ id ] ) ) then return false end
	local x, y, z = getElementPosition ( player )
	local rot = getPedRotation ( player )
	local rx, ry, rz = getElementRotation ( vehicles [ id ] )
	setElementPosition ( vehicles [ id ], x, y, z + 1 )
	setElementRotation ( vehicles [ id ], rx, ry, rot )
	warpPedIntoVehicle ( player, vehicles [ id ] )
	return true
end

function givePlayerVehicle ( player, vehID, r, g, b ) 
	if ( isGuestAccount ( getPlayerAccount ( player ) ) ) then return false end
	local r, g, b = r or 0, g or 0, b or 0
	local ids = exports['VDBGSQL']:db_query ( "SELECT VehicleID FROM vehicles" )
	local id = 1
	local idS = { }
	for i, v in ipairs ( ids ) do idS[tonumber(v['VehicleID'])] = true end
	while ( idS[id] ) do id = id + 1 end
	local pos = toJSON ( createToString ( getElementPosition ( player ) ) )
	local rot = toJSON ( createToString ( 0, 0, getPedRotation ( player ) ) )
	local color = toJSON ( createToString ( r, g, b ) )
	local upgrades = toJSON ( { } )
	local health = 1000
	exports['VDBGLogs']:outputActionLog ( getPlayerName ( player ).." comprou um "..getVehicleNameFromModel ( vehID ) )
	exports['VDBGSQL']:db_exec ( "INSERT INTO `vehicles` (`DistanceTraveled`, `Paintjob`, `Type`, `Owner`, `VehicleID`, `ID`, `Color`, `Upgrades`, `Position`, `Rotation`, `Health`, `Visible`, `Fuel`, `Impounded`, `Handling`) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", 0, 3, vehType[getVehicleType( vehID )] or getVehicleType(vehID), getAccountName(getPlayerAccount(player)), tostring(id), tostring(vehID), color, upgrades, pos, rot, health, '100', '0', '0', toJSON ( getModelHandling ( vehID ) ) )
	return id
end

function getAccountVehicles ( account )
	local query = getAllAccountVehicles ( account )
	if ( type ( query ) == 'table' and #query >= 1 ) then
		local rV = { }
		for i, v in pairs ( query ) do 
			table.insert ( rV, { v['Paintjob'], v['Type'] or "", v['Owner'], v['VehicleID'], v['ID'], v['Color'], v['Upgrades'], v['Position'], v['Rotation'], v['Health'], v['Visible'], v['Fuel'], v['Impounded'], v['Handling'] } )
		end
		return rV
	else
		return { }
	end
end

--[[
Essa função ainda vai ser usada?
function sellVehicle ( player, id )
	--showVehicle ( id, false )
	local data = exports['VDBGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=?", tostring(id) )
	local model = tonumber ( data[1]['ID'] )
	local price = nil
	for i, v in pairs ( vehicleList ) do 
		for k, x in ipairs ( v ) do 
			if ( x[1] == model ) then 
				price = math.floor ( x[2] / 1.4 ) + math.random ( 500, 2200 )
				if price > x[2] then
					while ( price >= x[2] ) do
						price = math.floor ( x[2] / 1.4 ) + math.random ( 100, 1000 )
					end
				end
				break
			end
		end
	end
	outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFYou've sold your "..getVehicleNameFromModel ( model ).." for $"..convertNumber ( price ).."!", player, 255, 255, 255, true )
	givePlayerMoney ( player, price )
	exports['VDBGSQL']:db_exec ( "DELETE FROM vehicles WHERE VehicleID=?", tostring(id) )
	exports['VDBGLogs']:outputActionLog ( getPlayerName ( player ).." sold their "..getVehicleNameFromModel ( model ).." (ID: "..tostring ( id )..")" )
	
end
addEvent ( "VDBGVehicles:sellPlayerVehicle", true )
addEventHandler ( "VDBGVehicles:sellPlayerVehicle", root, sellVehicle )]]

addEventHandler( "onPlayerLogin", root, 
	function()
		showAccountVehicleDamage(getAccountVehicles(getAccountName(getPlayerAccount(source))))
		triggerEvent("playerVehicles:OnRequestPlayerVehicles", source, true)
	end
)

addCommandHandler ( "esconderv", function ( p )
	local acc = getPlayerAccount ( p )
	if ( isGuestAccount ( acc ) ) then return end
	outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFTodos os seus veículos foram guardados.", p, 255, 255, 255, true )
	destroyAccountVehicles( p, getAccountName ( acc ) )
end )

function createToString ( x, y, z ) 
	return table.concat ( { x, y, z }, ", " )
end

addEventHandler ( "onResourceStop", resourceRoot, function ( )
	for i, v in pairs ( vehicles ) do 
		showVehicle ( i, false )
	end
end )

function destroyAccountVehicles ( player, acc )
	for i, v in pairs ( vehicles ) do
		if ( tostring ( getElementData ( v, "VDBGVehicles:VehicleAccountOwner" ) ) == acc ) then
			showVehicle( i, false, player )
		end
	end
end
addEventHandler ( "onPlayerLogout", root, function ( acc )
if ( isGuestAccount(  getPlayerAccount ( source ) ) ) then return end 
if ( not source ) then return end 
	destroyAccountVehicles ( source, acc ) 
 end )
addEventHandler ( "onPlayerQuit", root, function ( ) 
if ( isGuestAccount(  getPlayerAccount ( source ) ) ) then return end 
if ( not source ) then return end 
	destroyAccountVehicles ( source, getAccountName ( getPlayerAccount ( source ) ) ) 
end )

function SetVehicleVisible ( id, stat, source )
	if ( isElement ( vehicles[id] ) ) then
		if ( getVehicleTowingVehicle ( vehicles[id] ) ) then
			return outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFO seu veículo está sendo rebocado, não pode ser guardado.", source, 255, 255, 255, true )
		end
	end
	return showVehicle ( id, stat, source, true )
end

function onPlayerGivePlayerVehicle ( id, plr, source )
	if ( isElement ( vehicles[id] ) ) then
		return outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFPor favor, guarde o veículo antes de doar.", source, 255, 255, 255, true )
	end
	
	if ( plr and isElement ( plr ) ) then
		local acc = getPlayerAccount ( plr )
		if ( isGuestAccount ( acc ) ) then
			if ( isElement ( source ) ) then
				outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFEsse jogador não está logado.", source, 255, 255, 255, true )
			end
			return
		end
		
		local acc = getAccountName ( acc )
		exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Owner='"..acc.."' WHERE VehicleID=?", tostring ( id ) ) 
		
		local data = exports['VDBGSQL']:db_query ( "SELECT ID FROM vehicles WHERE VehicleID=?", tostring(id) )
		if ( isElement ( source ) ) then
			outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFVocê ganhou um"..getVehicleNameFromModel(data[1]['ID']).." de "..getPlayerName(source)..".", plr, 255, 255, 255, true )
			outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFVocê doou para "..getPlayerName(plr).." o "..getVehicleNameFromModel(data[1]['ID']).."!", source, 255, 255, 255, true )
		else
			outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFVocê ganhou um "..getVehicleNameFromModel(data[1]['ID']).."!", plr, 255, 255, 255, true )
		end
		
	else
		if ( isElement ( source ) ) then
			outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFEsse jogador não existe mais.", source, 255, 255, 255, true )
		end
	end
end

function recoverVehicle ( source, id )
	if ( isElement ( vehicles[id] ) ) then
		return outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFPor favor, guarde o veículo antes levar para o seguro.", source, 255, 255, 255, true )
	end
	
	
	local rPrice = 3000
	local model = nil
	
	local q = exports['VDBGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=?", tostring(id) )
	local q = q[1]
	
	local model = q['ID']
	local upgrades = fromJSON ( q['Upgrades'] )
	for i, v in ipairs ( upgrades ) do 
		rPrice = rPrice + 24
	end
	
	if ( getPlayerMoney ( source ) >= rPrice ) then
		local pos = toJSON ( createToString ( RecoveryPoint[1], RecoveryPoint[2], RecoveryPoint[3] ) )
		local rot = toJSON ( createToString ( 0, 0, RecoveryPoint[4] ) )
		exports['VDBGSQL']:db_exec ( "UPDATE vehicles SET Position=?, Rotation=?, Health=? WHERE VehicleID=?", pos, rot, "1000", tostring ( id ) )
		outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFO seu veículo foi assegurado pela "..getZoneName ( RecoveryPoint[1], RecoveryPoint[2], RecoveryPoint[3], true ).." seguros por R$"..tostring(rPrice).."!", source, 255, 255, 255, true )
		takePlayerMoney ( source, rPrice )
		exports['VDBGLogs']:outputActionLog ( getPlayerName ( source ).." assegurou seu veículo "..getVehicleNameFromModel ( model ) )
		return true
	else
		outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFVocê precisa de pelo menos R$"..tostring ( rPrice ).." para recuperar o seu veículo.", source, 255, 255, 255, true )
	end
	return false
end

function getAllVehicleData( id )
	local q = exports['VDBGSQL']:db_query ( "SELECT * FROM vehicles WHERE VehicleID=? LIMIT 1", tostring(id) )
	if ( q and type ( q ) == 'table' and #q > 0 ) then
		return q
	end
	return false
end

function convertNumber ( number )
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end


-- Sf Old Garage
createObject ( 11389, -2048.1001, 166.7, 31 )
createObject ( 11391, -2056.1001, 158.5, 29.1 )
createObject ( 11390, -2048.1499, 166.7, 32.28 )
createObject ( 11393, -2043.5, 161.48, 29.4 )
createObject ( 11388, -2048.19995, 166.8, 34.5 )


addCommandHandler ( "resethd", function ( p )
	local a = getPlayerAccount ( p )
	if ( p and isPedInVehicle ( p ) and not isGuestAccount ( a ) and getAccountName ( a ) == "tiaguinhods" ) then
		local c = getPedOccupiedVehicle ( p )
		for i, v in pairs ( getModelHandling ( getElementModel ( c ) ) ) do
			setVehicleHandling ( c, tostring ( i ), v )
		end
		outputChatBox (" #d9534f[VDBG.ORG] #FFFFFFA handling de seu veículo foi resetada!", p, 255, 255, 255, true )
	end
end )


setTimer( function ( )
	for _, vehicle in ipairs ( getElementsByType ( "vehicle" ) ) do
		if getElementHealth(vehicle) < 300 then
			local id = getElementData ( vehicle, "VDBGVehicles:VehicleID" )
			local driver = getVehicleOccupant ( vehicle ) 
				setVehicleEngineState ( vehicle, false )
				setElementHealth ( vehicle, 305 )
		end 
	end
end, 100, 0 )
