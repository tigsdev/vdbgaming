local _setElementData = setElementData
function setElementData ( element, group, value )
	return _setElementData ( element, group, value, true )
end

local turfLocs = { }
function createTurf ( x, y, z, width, height, owner, forcedId )
	local owner = tostring ( owner ) or "server"
	local r, g, b = exports['VDBGGroups']:getGroupColor ( owner )
	if not r then r = 255 end
	if not g then g = 255 end
	if not b then b = 255 end

	if ( owner == "server" ) then
		r, g, b = 255, 255, 255
	end

	local rad = createRadarArea ( x, y, width, height, r, g, b, 170, getRootElement ( ) )
	local col = createColCuboid ( x, y, z-5, width, height, 35)
	if ( not forcedId or turfLocs [ id ] ) then
		id = 0
		while ( turfLocs [ id ] ) do
			id = id + 1
		end
	else
		id = forcedId
	end

	turfLocs[id] = { }
	turfLocs[id].col = col
	turfLocs[id].radar = rad
	turfLocs[id].owner = owner or "server"
	turfLocs[id].attackers = nil
	turfLocs[id].attackProg = 0
	turfLocs[id].prepProg = 0
	turfLocs[id].logoclanattackers = "nenhuma"
	turfLocs[id].logoclanowner = "nenhuma"
	
	
	setElementData ( turfLocs[id].col, "VDBGTurf:TurfId", id )
	setElementData ( turfLocs[id].col, "VDBGTurf:TurffingTable", turfLocs [ id ] )
	addEventHandler ( "onColShapeHit", turfLocs[id].col, onColShapeHit )
	addEventHandler ( "onColShapeLeave", turfLocs[id].col, onColShapeLeave )
	return turfLocs[id];
end

function updateTurfGroupColor ( group )
	local r, g, b = exports['VDBGGroups']:getGroupColor ( group )
	for i, v in pairs ( turfLocs ) do
		if ( v.owner == group ) then
			setRadarAreaColor ( v.radar, r, g, b, 120 )
		end 
	end 
end 

function onColShapeHit ( player ) 
	if ( player and isElement ( player ) and getElementType ( player ) == "player" and not isPedInVehicle ( player ) ) then
		local gang = exports['VDBGGroups']:getPlayerGroup ( player )
		local logo = exports['VDBGGroups']:getGroupLogo ( gang )
		triggerClientEvent ( player, "VDBGTurfs:onClientEnterTurfArea", player, turfLocs [ id ] )
		local team = getPlayerTeam(player)
        local NomeAcl = getAccountName(getPlayerAccount(player))  
		if	 ( team and getTeamName(team) ~= "Criminoso" ) or ( not gang  ) then 
		return outputChatBox ( "#d9534f[C.F]#ffffff Você precisa estar um um grupo e ser criminoso para iniciar o confronto de facções.", player, 255, 255, 255, true )
		end
		local id = tonumber ( getElementData ( source, "VDBGTurf:TurfId" ) )
		if ( turfLocs[id].owner == gang ) then
			return
		end
		local logo2 = exports['VDBGGroups']:getGroupLogo ( turfLocs[id].owner )
		if ( turfLocs[id].attackers and turfLocs[id].attackers ~= gang ) then
			return outputChatBox ( "#d9534f[C.F] #ffffff O grupo "..tostring(turfLocs[id].attackers).."", player, 255, 255, 0 )
		end

		if ( not turfLocs[id].attackers ) then
			outputChatBox ( "#d9534f[C.F] #ffffff Você iniciou a preparação do confronto de facções. Chame sua facção, e espere o confronto começar.", player, 255, 255, 255, true )
			local x, y, z = getElementPosition ( source )
			local nome = getElementData(player, "AccountData:Name")
			exports['VDBGGroups']:outputGroupMessage ( "#d9534f[C.F] #ffffff "..nome.." está preparando um confronto de facções com #d9534f"..tostring(turfLocs[id].owner).." #ffffffem #4aabd0"..getZoneName(x,y,z).."["..getZoneName(x,y,z,true).."]! #ffffffVá lá para ajudá-lo, o confronto vai começar em instantes!", gang, 255, 255, 255, true )
			setRadarAreaFlashing ( turfLocs[id].radar, true )
			turfLocs[id].attackers = gang
			turfLocs[id].attackProg = 0
			turfLocs[id].prepProg = 0
			turfLocs[id].logoclanattackers = logo
			turfLocs[id].logoclanowner = logo2
			setElementData ( turfLocs[id].col, "VDBGTurf:TurffingTable", turfLocs [ id ] )
		end
	end
end

function onColShapeLeave ( player ) 
	if ( player and getElementType ( player ) == "player" ) then
		triggerClientEvent ( player, "VDBGTurfs:onClientExitTurfArea", player, turfLocs [ getElementData ( source, "VDBGTurf:TurfId" ) ] )
	end
end


setTimer ( function ( ) 
	for id, data in pairs ( turfLocs ) do 
		if ( data.attackers ) then
			local players = { attackers = { }, owners = { } }
			local isGangInTurf = false
			local isOwnerInTurf = false
			for i, v in pairs ( getElementsWithinColShape ( data.col, "player" ) ) do
				local g = exports['VDBGGroups']:getPlayerGroup ( v )
				if ( g == data.attackers ) then
					isGangInTurf = true
					table.insert ( players.attackers, v )
				elseif ( g == data.owner ) then
					isOwnerInTurf = true
					table.insert ( players.owners, v )
				end
			end

			local x, y, z = getElementPosition ( data.col )	
			if ( isOwnerInTurf and isGangInTurf ) then
	      --exports['VDBGGroups']:outputGroupMessage ( "A guerra de territórios em "..getZoneName ( x,y,z )..", "..getZoneName ( x,y,z, true ).." foi pausada, mate os integrantes da gang inimiga", turfLocs[id].owner, 255, 255, 255 )			 
		  --exports['VDBGGroups']:outputGroupMessage ( "A guerra de territórios em "..getZoneName ( x,y,z )..", "..getZoneName ( x,y,z, true ).." foi pausada, mate os integrantes da gang inimiga", turfLocs[id].attackers, 255, 255, 255 )
			else
				-- Add Points To Attackers
				if ( isGangInTurf ) then 
					-- Prep the war 
					if ( turfLocs[id].attackProg == 0 ) then
						turfLocs[id].prepProg = data.prepProg + 50
						if ( turfLocs[id].prepProg >= 100 ) then
							turfLocs[id].prepProg = 0
							turfLocs[id].attackProg = 1
							beginTurfWarOnTurf ( id )
						end
					-- Attack War
					else
						turfLocs[id].attackProg = turfLocs[id].attackProg + 0.25
						if ( turfLocs[id].attackProg == 100 ) then 
							exports['VDBGGroups']:outputGroupMessage ( "#FFA500[C.F] #ffffff Seu grupo dominou a zona em "..getZoneName ( x,y,z )..", "..getZoneName ( x,y,z, true ).." do "..turfLocs[id].owner.."! Boa!", turfLocs[id].attackers, 255, 255, 255, true )
							exports['VDBGGroups']:outputGroupMessage ( "#FFA500[C.F] #ffffff Seu grupo perdeu o confronto de facções em "..getZoneName ( x,y,z )..", "..getZoneName ( x,y,z, true ).." de "..turfLocs[id].attackers..".", turfLocs[id].owner, 255, 255, 255, true )
							setTurfOwner ( id, turfLocs[id].attackers )
						end
					end
					
				-- Take points from attackers
				else 
					-- Prepare war
					if ( turfLocs[id].attackProg == 0 ) then
						turfLocs[id].prepProg = data.prepProg - 50
						if ( turfLocs[id].prepProg <= 0 ) then
							exports['VDBGGroups']:outputGroupMessage ( "#FFA500[C.F] #ffffff Sua gangue perdeu a preparação do confronto em "..getZoneName(x,y,z)..", "..getZoneName ( x,y,z, true ).." do "..turfLocs[id].owner.."!", turfLocs[id].attackers, 255, 255, 255, true )
							exports['VDBGGroups']:outputGroupMessage ( "#FFA500[C.F] #ffffff Sua gangue conseguiu defender a zona em "..getZoneName(x,y,z)..", "..getZoneName(x,y,z,true).."!", turfLocs[id].owner..", de "..turfLocs[id].attackers..", quando a área estava em preparação de um #d9534f[C.F]", 255, 255, 255, true )
							setTurfOwner ( id, turfLocs[id].owner )
						end 
					-- Attacking war
					else 
						turfLocs[id].attackProg = data.attackProg - 0.25
						if ( turfLocs[id].attackProg <= 0 ) then
							exports['VDBGGroups']:outputGroupMessage ( "#FFA500[C.F] #ffffff Sua gangue perdeu a guerra de facções em "..getZoneName(x,y,z)..", "..getZoneName ( x,y,z, true ).." do "..turfLocs[id].owner.."!", turfLocs[id].attackers, 255, 255, 255, true )
							exports['VDBGGroups']:outputGroupMessage ( "#FFA500[C.F] #ffffff Sua gangue conseguiu defenter a zona em "..getZoneName(x,y,z)..", "..getZoneName(x,y,z,true).." de "..turfLocs[id].attackers.."! ", turfLocs[id].owner, 255, 255, 255, true )
							setTurfOwner ( id, turfLocs[id].owner )
						end 
					end
				end
			end
			for i, v in pairs ( players ) do
				for k, p in pairs ( v ) do 
					triggerClientEvent ( p, "VDBGTurfs:upadateClientInfo", p, turfLocs [ id ] )
				end
			end
		end
	end
end, 800, 0 )
addEvent ( "VDBGTurfs:onTurfProgressChange", true )


addCommandHandler ( "turf", function ( p )
	local gangAttacks = { }
	local g = exports['VDBGGroups']:getPlayerGroup ( p )
	if ( not g ) then
		return outputChatBox ( "#d9534f[C.F] #ffffffVocê não está em uma facção criminosa.", p, 255, 255, 255, true )
	end

	for i, v in pairs ( turfLocs ) do
		if ( v.attackers and v.attackers == g ) then
			gangAttacks [ i ] = true
		end 
	end 

	if ( table.len ( gangAttacks ) == 0 ) then
		return outputChatBox ( "#d9534f[C.F] #ffffffSeu grupo não está envolvido em nenhuma guerra de facção neste momento.", p, 255, 255, 255, true )
		end 

	for id, _ in pairs ( gangAttacks ) do 
		local x ,y, z = getElementPosition ( turfLocs[id].col )
		outputChatBox ( "#d9534f[C.F] #ffffff == / STATUS / == ", p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[C.F] #ffffff Pertence a Facção: #4aabd0"..turfLocs[id].owner, p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[C.F] #ffffff Atacando a Zona: #4aabd0"..turfLocs[id].attackers, p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[C.F] #ffffff Processo de Preparação: #4aabd0"..turfLocs[id].prepProg.."%", p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[C.F] #ffffff Processo de Dominação: #4aabd0"..turfLocs[id].attackProg.."%", p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[C.F] #ffffff Localização do Turf: #4aabd0"..getZoneName ( x, y, z )..", "..getZoneName ( x, y, z, true ), p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[C.F] #ffffff ID: #4aabd0"..id, p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[C.F] #ffffff == / STATUS / == ", p, 255, 255, 255, true )
	end

end )

function table.len ( tb ) 
	local c = 0
	for i, v in pairs ( tb ) do
		c = c + 1
	end
	return c
end

function beginTurfWarOnTurf ( id )
	local d = turfLocs [ id ]
	local x, y, z = getElementPosition ( d.col ) 
	exports['VDBGGroups']:outputGroupMessage ( "#FFA500[C.F] #ffffff Seu grupo começou uma guerra de territórios em #4aabd0"..getZoneName ( x, y, z)..", "..getZoneName ( x, y, z, true ).." #ffffff contra o #d9534f"..d.owner.." ! #ffffffVai lá para ajuda-los! /turf", d.attackers, 255, 255, 255, true )
	exports['VDBGGroups']:outputGroupMessage ( "#FFA500[C.F] #ffffff Seu território em #4aabd0"..getZoneName ( x, y, z)..", "..getZoneName ( x, y, z, true ).." #ffffff está sendo atacado pelos #d9534f"..d.attackers.." ! #ffffff/turf", d.owners, 255, 255, 255, true )
	setRadarAreaColor ( d.radar, 255, 255, 255, 170 )
end

function setTurfOwner ( id, owner )
	setRadarAreaFlashing ( turfLocs[id].radar, false )
	turfLocs[id].owner = owner
	turfLocs[id].attackers = nil
	turfLocs[id].attackProg = 0
	local r, g, b = exports['VDBGGroups']:getGroupColor ( owner )
	setRadarAreaColor ( turfLocs[id].radar, r, g, b, 120 )
	saveTurfs ( )
end

function getTurfs ( ) 
	return turfLocs
end 

function saveTurfs ( )
	for id, data in pairs ( turfLocs ) do 
		exports.VDBGSQL:db_exec ( "UPDATE turfs SET owner=? WHERE id=?", data.owner, id )
	end
	return true
end


addEventHandler( "onResourceStart", resourceRoot, function ( )
	exports.VDBGSQL:db_exec ( "CREATE TABLE IF NOT EXISTS turfs ( id INT, owner VARCHAR(50), x FLOAT, y FLOAT, z FLOAT, width INT, height INT )" )
	local query = exports.VDBGSQL:db_query ( "SELECT * FROM turfs" )
	if ( #query == 0 ) then 
		local data = { 
--[[	{ -1867.8, -107.43, 15.1, 58, 65 },
		{ -1866.5, -26.36, 15.29, 49, 200 },
		{ -1811.33, 743.43, 20, 85, 85 },
		{ -1991.5, 862.62, 34, 79, 42 },
		{ -2799.25, -200.6, 7.19, 83, 120 },
		{ -2136.84, 120.12, 30, 120, 190 },
		{ -2516.52, 718.16, 27.97, 118, 80 },
		{ -2516.41, 578.19, 16.62, 117, 120 },
		{ -2596.49, 818.05, 49.98, 59, 80 },
		{ -2453.17, 947.58, 45.43, 54, 80  },
		{ -2740.6, 344.59, 4.41, 68, 61 },
		{ -2696.24, 227.35, 4.33, 39.5, 50.5 },
		{ -2397.31, 82.99, 35.3, 133, 160 },
		{ -2095.33, -280.06, 35.32, 84, 176 },
		{ -1980.58, 107.69, 27.68, 59, 62 },
		{ -2129.01, 741.71, 48, 112, 57 },
		{ -2243.24, 928.4, 66.65, 87, 154 },
		{ -1701.62, 743.44, 10, 129, 83 },
		{ -2696.23, -59.88, 4.73, 83, 89 },
		{ -2541.18, -720.16, 135, 55, 125 }]]
		{ 1858, 623, 10.5, 140, 165 },
		{ 1577, 663, 10.5, 180, 130 },
		{ 1577, 943, 10.5, 185, 190 },
		{ 1383, 909, 10.5, 120, 230 },
		{ 956, 1011, 10.5, 220, 140 },
		{ 1017, 1203, 10.5, 180, 165 },
		{ 1017, 1383, 10.5, 190, 290 },
		{ 917, 1623, 10.5, 80, 220 },
		{ 1017, 1862, 10.5, 140, 180 },
		{ 912, 1958, 10.5, 90, 240 },
		{ 1017, 2063, 10.5, 150, 300 },
		{ 1300, 2092, 10.5, 200, 140 },
		{ 1398, 2323, 10.5, 160, 65 },
		{ 1578, 2284, 10.5, 180, 110 },
		{ 1237, 2581, 10.5, 450, 130 },
		{ 1780, 2567, 10.5, 130, 130 },
		{ 1698, 2724, 10.5, 200, 150 },
		{ 2237, 2723, 10.5, 180, 110 },
		{ 2498, 2704, 10.5, 300, 140 },
		{ 2798, 2303, 10.5, 120, 300 },
		{ 2557, 2243, 10.5, 100, 230 },
		{ 2532, 2063, 10.5, 255.5, 100, 150 },
		{ 2558, 1624, 10.5, 100, 300 },
		{ 2437, 1483, 10.5, 160, 120 },
		{ 2077, 1203, 10.5, 340, 170},
		{ 2082, 979, 10.5, 270, 210 },
		{ 2026.47, 2272.69, 10.82, 270, 100},
		{ 1918.74, 2138.78, 10.82, 210, 100}
	}
		outputDebugString ( "VDBGaming: 0 Turfs encontradas -- Gerando novas.. ".. tostring ( #data ) )
		for i, v in pairs ( data ) do 
			x = { 
				['x'] = v[1],
				['y'] = v[2],
				['z'] = v[3],
				['width'] = v[4],
				['height'] = v[5],
				['owner'] = "Skuderia"
			}
			
			query[i] = x;
			
			exports.VDBGSQL:db_exec ( "INSERT INTO turfs ( id, owner, x, y, z, width, height ) VALUES ( ?, ?, ?, ?, ?, ?, ? )",
				tostring ( i ), "Skuderia", tostring ( x['x'] ), tostring ( x['y'] ), tostring ( x['z'] ), tostring ( x['width'] ), x['height'] );
		end
	end 
	
	for i, v in pairs ( query ) do
		local id, owner, x, y, z, width, height = tonumber ( v['id'] ), v['owner'], tonumber ( v['x'] ), tonumber ( v['y'] ), tonumber ( v['z'] ), tonumber ( v['width'] ), tonumber ( v['height'] )
		createTurf ( x, y, z, width, height, owner, id )
	end
end )


-- Group payout timer 
function sendTurfPayout ( ) 
	local groupTurfs = { }
	for i, v in pairs ( turfLocs ) do 
		if ( not groupTurfs [ v.owner ] ) then 
			groupTurfs [ v.owner ] = 0
		end 

		if ( not v.attackers ) then 
			groupTurfs [ v.owner ] = groupTurfs [ v.owner ] + 1
		end   
	end

	for i, v in pairs ( getElementsByType ( 'player' ) ) do 
		local g = exports['VDBGGroups']:getPlayerGroup ( v ) 
		if ( g and groupTurfs [ g ] and groupTurfs [ g ] > 0 ) then 
			local c = groupTurfs [ g ] * 900
			givePlayerMoney ( v, c )
			outputChatBox ( "#FFA500[C.F][PAGAMENTO] #acd373R$"..tostring(c)..".00  #ffffff por ter #acd373"..tostring ( groupTurfs [ g ] ).." #ffffffzonas sobre domínio da sua facção", v, 255, 255, 255, true )
			outputChatBox ( "#FFA500[C.F][PAGAMENTO] #ffffff Próximo pagamento será daqui, #FFA500 5 horas", v, 255, 255, 255, true )
		end
	end
end 
setTimer ( sendTurfPayout, 18000000, 0 )