local usedVehicles = { }

function addVehicleFromId ( id, price, description )
	
	local query = exports["VDBGSQL"]:db_query ( "SELECT * FROM vehicles WHERE VehicleID=?", id );
	
	if ( query and query [ 1 ] and price and description ) then 
		local query = query [ 1 ];
		if ( query.Visible == 0 and query.Impounded == 0 ) then 
			exports["VDBGSQL"]:db_exec ( "INSERT INTO used_vehicles ( seller, veh_id, uniq_id, color, upgrades, handling, price, description, DistanceTraveled, Type, Paintjob ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )",
				query.Owner, query.ID, query.VehicleID, query.Color, query.Upgrades, query.Handling, price, description, query.DistanceTraveled, query.Type, query.Paintjob );
			
			local temp = { }
			temp.seller = tostring ( query.Owner );
			temp.vehicle_id = tonumber ( query.ID );
			temp.unique_id = tonumber ( query.VehicleID );
			temp.upgrades = fromJSON ( query.Upgrades );
			temp.handling = fromJSON ( query.Handling );
			temp.price = tonumber ( price );
			temp.desc = tostring ( description );
			temp.distancia = tonumber ( query.DistanceTraveled );
			temp.tipo = tostring ( query.Type );
			temp.pjob = tonumber ( query.Paintjob );
			
			local color = fromJSON ( query.Color )
			local color = split ( color, ', ' )
			temp.color = { r=tonumber(color[1]), g=tonumber(color[2]), b=tonumber(color[3]) }
			
			usedVehicles[temp.unique_id] = temp;
			
			return true;
			
		end 
	end 
	
	return false;
	
end 

function getList ( ) 
	return usedVehicles;
end 

addEventHandler ( "onResourceStart", resourceRoot, function ( )
	exports["VDBGSQL"]:db_exec ( "CREATE TABLE IF NOT EXISTS used_vehicles ( seller TEXT, veh_id INT, uniq_id INT, color TEXT, upgrades TEXT, handling TEXT, price INT, description TEXT, DistanceTraveled INT, Type TEXT, Paintjob INT )" );
	
	local query = exports["VDBGSQL"]:db_query ( "SELECT * FROM used_vehicles" );
	
	if ( query and type ( query ) == "table" ) then
		for _, col in pairs ( query ) do 
			local temp = { }
			temp.seller = tostring ( col.seller );
			temp.vehicle_id = tonumber ( col.veh_id );
			temp.unique_id = tonumber ( col.uniq_id );
			temp.upgrades = fromJSON ( col.upgrades );
			temp.handling = fromJSON ( col.handling );
			temp.price = tonumber ( col.price );
			temp.desc = tostring ( col.description );
			temp.distancia = tonumber ( col.DistanceTraveled );
			temp.pjob = tonumber ( col.Paintjob );
			temp.tipo = tostring ( col.Type );
			

			local color = fromJSON ( col.color )
			local color = split ( color, ', ' )
			temp.color = { r=tonumber(color[1]), g=tonumber(color[2]), b=tonumber(color[3]) }
			
			usedVehicles[temp.unique_id] = temp;
		end 
	else 
		usedVehicles = { }
	end
	
end );


function setVehicleOwner ( id, account )
	if ( not id or not usedVehicles [ id ] or not account ) then 
		return false;
	end 
	
	local d = usedVehicles [ id ];
	
	local owner = account; 
	local vehicle_id = id; 
	local id = d.vehicle_id;
	local color = toJSON ( table.concat({d.color.r,d.color.g,d.color.b},", " ) );
	local upgrades = toJSON ( d.upgrades );
	local position = toJSON ( { } );
	local rotation = toJSON ( { 0, 0, 0 } );
	local health = "1000"
	local visible = 0;
	local fuel = 100;
	local impounded = 0;
	local distancia = d.distancia;
	local pjob = d.pjob;
	local tipo = d.tipo;
	local handling = toJSON ( d.handling );
	
	local at = "Los Santos";
	
	local t = getVehicleType ( id ):lower();
	if ( t == "plane" or t == "helicopter" ) then 
		position = toJSON ( table.concat ( { 1949.38, -2400.59, 14.5 }, ", " ) );
		rotation = toJSON ( table.concat ( { 0, 0, 180 }, ", " ) );
		at = "Los Santos Airport"
	elseif ( t == "boat" ) then 
		position = toJSON ( table.concat ( { 626, -1942.6, 1.5 }, ", " ) );
		rotation = toJSON ( table.concat ( { 0, 0, 180 }, ", " ) );
		at = "Los Santos Beach"
	else 
		position = toJSON ( table.concat ( { 2276.05, -2329.12, 14.5 }, ", " ) );
		rotation = toJSON ( table.concat ( { 0, 0, 311.5 }, ", " ) );
		at = "Los Santos Recovery Point"
	end
	
	
	exports["VDBGSQL"]:db_exec ( "INSERT INTO vehicles ( DistanceTraveled, Type, Paintjob, Owner, VehicleID, ID, Color, Upgrades, Position, Rotation, Health, Visible, Fuel, Impounded, Handling ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )",
		distancia, pjob, tipo, owner, vehicle_id, id, color, upgrades, position, rotation, health, visible, fuel, impounded, handling );
	
	exports["VDBGSQL"]:db_exec ( "DELETE FROM used_vehicles WHERE uniq_id=?", vehicle_id );
	
	usedVehicles [ vehicle_id ] = nil 
	
	return at;
end 


addEvent( "VDBGShops->UsedVehicles->onPlayerTryBuyVehicle", true );
addEventHandler ( "VDBGShops->UsedVehicles->onPlayerTryBuyVehicle", root, function ( id )
	if ( not usedVehicles [ id ] ) then 
		return exports.vdbgmessages:sendClientMessage ( "Este veículo, não está mais disponível!", source, 200, 100, 130 );
	end 
	
	local data = usedVehicles [ id ];
	local acc = getPlayerAccount ( source );
	
	if ( getPlayerMoney ( source ) < data.price ) then 
		return exports.vdbgmessages:sendClientMessage ( "Você não tem dinheiro suficiente para este veículo", source, 200, 100, 130 );
	end 
	
	if ( isGuestAccount ( acc ) ) then 
		return exports.vdbgmessages:sendClientMessage ( "Você precisa estar logado para comprar um veículo", source, 200, 100, 130 );
	end 
	
	takePlayerMoney ( source, data.price );
	exports.vdbgmessages:sendClientMessage ( "Você comprou um "..getVehicleNameFromModel(data.vehicle_id).." por R$"..data.price..",00 !", source, 0, 255, 0 );
	
	local loc = setVehicleOwner ( id, getAccountName ( acc ) );
	--exports.vdbgmessages:sendClientMessage ( "Seu veículo estará disponível em "..tostring ( loc ), source, 0, 255, 0 );
	
	local foundPlayer = false;
	for _, p in pairs ( getElementsByType ( "player" ) ) do 
		if ( getAccountName ( getPlayerAccount ( p ) ) == data.seller ) then 
			givePlayerMoney ( p, data.price );
			exports.vdbgmessages:sendClientMessage ( getPlayerName ( source ).." comprou o seu "..getVehicleNameFromModel(data.vehicle_id).." por R$ "..data.price..",00", p, 0, 255, 0 );
			foundPlayer = true;
			break;
		end 
	end

	if ( not foundPlayer ) then 
		local q = exports["VDBGSQL"]:db_query ( "SELECT Money FROM accountdata WHERE Username=?", data.seller );
		if ( q and q[1] and q[1].Money ) then 
			local m = tonumber ( q[1].Money ) + data.price
			exports["VDBGSQL"]:db_exec ( "UPDATE accountdata SET Money=? WHERE Username=?", m, data.seller );
		end 
	end 
	
	setClientWindowOpen ( source, false );
	
end );




addEvent ( "VDBGShops->UsedVehicles->onClientRequestUsedList", true )
addEventHandler ( "VDBGShops->UsedVehicles->onClientRequestUsedList", root, function ( )
	triggerClientEvent ( source, "VDBGShops->UsedVehicles->onServerSendClientList", source, getList ( ), exports.vdbgvehicles:getAllAccountVehicles ( getAccountName ( getPlayerAccount ( source ) ) ) );
end );

addEvent ( "VDBGUsedVehicles->SellVehicle->OnPlayerTrySellVehicle", true )
addEventHandler ( "VDBGUsedVehicles->SellVehicle->OnPlayerTrySellVehicle", root, function ( id, price, description )
	if ( id and price and description ) then 
		if ( addVehicleFromId ( id, price, description ) ) then
			exports["VDBGVehicles"]:deletePlayerVehicleFromUsedVehicles(id, source)
			exports.vdbgmessages:sendClientMessage ( "Seu veículo está no mercado de usados por R$"..price..",00.", source, 255, 255, 0 );
			refreshClientWindow ( source );
		else
			exports.vdbgmessages:sendClientMessage ( "Falha ao adicionar este veículo para o mercado, algo deu errado!", source, 255, 0, 0 );	
		end
	end 
end );


function refreshClientWindow ( player )
	setClientWindowOpen ( player, false );
	setClientWindowOpen ( player, true );
end

function setClientWindowOpen ( p, b )
	triggerClientEvent ( p, "VDBGUsedVehicles->Interface->SetInterfaceOpen", p, b );
end 