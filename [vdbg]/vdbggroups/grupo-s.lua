----------------------------------------
-- Developer Note:
--		THIS RESOURCE CANNOT BE RESTARTED
--		WHILE THE SERVER IS RUNNIVDBG, IT CAN
--		MAKE MINUTES OF NETWORK TROUBLE 
--		WHILE QUERYIVDBG ALL GROUPS DATA
-----------------------------------------


local groups = { }

addEventHandler ( "onResourceStart", resourceRoot, function ( ) 
	exports.VDBGSQL:db_exec ( "CREATE TABLE IF NOT EXISTS groups ( id INT, name VARCHAR(20), info TEXT )" );
	exports.VDBGSQL:db_exec ( "CREATE TABLE IF NOT EXISTS group_members ( id INT, member_name VARCHAR(30), rank VARCHAR(20), join_date VARCHAR(40) )");
	exports.VDBGSQL:db_exec ( "CREATE TABLE IF NOT EXISTS group_rank ( id INT, rank VARCHAR(30), perms TEXT )" )
	exports.VDBGSQL:db_exec ( "CREATE TABLE IF NOT EXISTS group_logs ( id INT, time VARCHAR(40), account VARCHAR(40), log TEXT )" )

	--exports.scoreboard:scoreboardAddColumn ( "Group", getRootElement ( ), 90, "Clan", 10 )
	--exports.scoreboard:scoreboardAddColumn ( "Group Rank", getRootElement ( ), 90, "CRank", 12 )

	for i, v in pairs ( getElementsByType ( "player" ) ) do
		local g = getElementData ( v, "Group" )
		if ( not g ) then
			setElementData ( v, "Group", "Nenhum" )
			setElementData ( v, "Group Rank", "Nenhum")
		end

		if ( not getElementData ( v, "Group Rank" ) ) then
			setElementData ( v, "Group Rank", "Nenhum" )
		end
	end
end )

addEventHandler ( "onPlayerJoin", root, function ( )
	setElementData ( source, "Group", "Nenhum" )
	setElementData ( source, "Group Rank", "Nenhum")
end )


groups = { }

function saveGroups ( )
	exports.VDBGSQL:db_exec ( "DELETE FROM groups" )
	exports.VDBGSQL:db_exec ( "DELETE FROM group_rank" )
	exports.VDBGSQL:db_exec ( "DELETE FROM group_members")
	exports.VDBGSQL:db_exec ( "DELETE FROM group_logs")

	for i, v in pairs ( groups ) do
		exports.VDBGSQL:db_exec ( "INSERT INTO groups ( id, name, info ) VALUES ( ?, ?, ? )", tostring ( v.info.id ), tostring ( i ), toJSON ( v.info ) )
		for k, val in pairs ( v.ranks ) do 
			exports.VDBGSQL:db_exec ( "INSERT INTO group_rank ( id, rank, perms ) VALUES ( ?, ?, ? )", tostring ( v.info.id ), k, toJSON ( val ) )
		end 
		for k, val in pairs ( v.members ) do
			exports.VDBGSQL:db_exec ( "INSERT INTO group_members ( id, member_name, rank, join_date ) VALUES ( ?, ?, ?, ? )", tostring ( v.info.id ), k, val.rank, val.joined )
		end 

		for k, val in ipairs ( v.log ) do
			exports.VDBGSQL:db_exec ( "INSERT INTO group_logs ( id, time, account, log ) VALUES ( ?, ?, ?, ? )", tostring ( v.info.id ), val.time, val.account, val.log )
		end 
	end
end 

function loadGroups ( )
	local start = getTickCount ( )
	local groups_ = exports.VDBGSQL:db_query ( "SELECT * FROM groups" )
	for i, v in pairs ( groups_ ) do
		if ( v and v.name and not groups [ v.name ] ) then
			groups [ v.name ] = { }
			groups [ v.name ].info = { }
			groups [ v.name ].ranks = { }
			groups [ v.name ].members = { }
			groups [ v.name ].log = { }

			-- load info table
			groups [ v.name ].info = fromJSON ( v.info )
			groups [ v.name ].info.id = tonumber ( v.id )

			-- load rank table
			local ranks = exports.VDBGSQL:db_query ( "SELECT * FROM group_rank WHERE id=?", tostring ( v.id ) )
			for i, val in pairs ( ranks ) do
				if ( not groups [ v.name ].ranks[val.rank] ) then
					groups [ v.name ].ranks[val.rank] = fromJSON ( val.perms )
				end
			end 

			-- load member table
			local members = exports.VDBGSQL:db_query ( "SELECT * FROM group_members WHERE id=?", tostring ( v.id ) )
			for i, val in pairs ( members ) do
				groups [v.name].members[val.member_name] = { }
				groups [v.name].members[val.member_name].rank = val.rank
				groups [v.name].members[val.member_name].joined = val.join_date

				for _, player in pairs ( getElementsByType ( "player" ) ) do
					local a = getPlayerAccount ( player )
					if ( a and not isGuestAccount ( a ) ) then
						local acc = getAccountName ( a )
						if ( val.member_name == acc ) then
							setElementData ( player, "Group", tostring ( v.name ) )
							setElementData ( player, "Group Rank", tostring ( val.rank ) )
							
						end 
					end 
				end 
			end 

			-- load logs table
			local log = exports.VDBGSQL:db_query ( "SELECT * FROM group_logs WHERE id=?", tostring ( v.id ) )
			for i, val in ipairs ( log ) do
				table.insert ( groups[v.name].log, { time=val.time, account=val.account, log=val.log } )
			end 

			groups [ v.name ].pendingInvites = { }
		else
			local reason = "Variável 'v' não definida"
			if ( v and not v.name ) then
				reason = "Variável 'v.name' não definida"
			elseif ( v and v.name and groups [ v.name ] ) then
				reason = "clã já existe na tabela"
			else
				reason = "Não detectado"
			end
			outputDebugString ( "VDBGGroups: falha ao carregar o clã ".. tostring ( v.name ).." - "..  tostring ( reason ), 1 )
		end 
	end

	local load = math.ceil ( getTickCount()-start )
	local tLen = table.len ( groups )
	outputDebugString ( "VDBGGroups: clãs carregados com sucesso. "..tLen.." grupos no banco de dados: ("..tostring(load).."MS - About "..math.floor(load/tLen).."MS/group)" )

end 
addEventHandler ( "onResourceStart", resourceRoot, loadGroups )
addEventHandler ( "onResourceStop", resourceRoot, saveGroups )

function getGroups ( ) 
	return groups
end 


addEvent ( "VDBGGroups->Events:onClientRequestGroupList", true )
addEventHandler ( "VDBGGroups->Events:onClientRequestGroupList", root, function ( )
	local g = getGroups ( )
	triggerClientEvent ( source, "VDBGGroups->onServerSendClientGroupList", source, g )
	g = nil
end )

------------------------------
-- Group Creating			--
------------------------------
function createGroup ( name, color, type, logotipo, tag, owner )
	if ( doesGroupExist ( name ) ) then
		return false
	end
	
	local id = 0
	local ids = { }
	for i, v in pairs ( groups ) do
		ids [ v.info.id ] = true
	end 

	while ( ids [ id ] ) do
		id = id + 1
	end

	groups [ name ] = { 
		info = {
			founder = owner, -- this CANNOT change
			founded_time = getThisTime ( ),
			desc = "",
			color = color,
			type = type,
			logotipo = logotipo,
			tag = tag,
			bank = 0,
			id = id
		},

		members = { 
			[owner] = { rank="Fundador", joined=getThisTime ( ) } 
		},

		ranks = {
			['Fundador'] = {
				-- member access
				['member_kick'] = true,
				['member_invite'] = true,
				['member_setrank'] = true,
				['member_viewlog'] = true,
				-- General group changes
				['group_modify_color'] = true,
				['group_modify_motd'] = true,
				-- banks
				['bank_withdraw'] = true,
				['bank_deposit'] = true,
				-- logs
				['logs_view'] = true,
				['logs_clear'] = true,
				-- ranks
				['ranks_create'] = true,
				['ranks_delete'] = true,
				['ranks_modify'] = true
			}, ["Membro"] = {
				-- button access
				['view_member_list'] = true,
				['view_ranks'] = false,
				['view_bank'] = true,
				-- member access
				['member_kick'] = false,
				['member_invite'] = false,
				['member_setrank'] = false,
				-- General group changes
				['group_modify_color'] = false,
				['group_modify_motd'] = false,
				-- banks
				['bank_withdraw'] = false,
				['bank_deposit'] = true,
				-- logs
				['logs_view'] = false,
				['logs_clear'] = false,
				-- ranks
				['ranks_create'] = false,
				['ranks_delete'] = false,
				['ranks_modify'] = false
			}
		},
		log = {
			-- { time, log }
			{ time=getThisTime ( ), account="Server", log="clã criado" }
		},

		pendingInvites = { }
	}
 	
 	return true, groups [ name ]
end

function deleteGroup ( group )
	if ( not doesGroupExist ( group ) ) then 
		return false
	end
	local id = groups [ group ].info.id
	groups [ group ] = nil
	exports.VDBGSQL:db_exec ( "DELETE FROM groups WHERE id=?", tostring ( id ) )
	exports.VDBGSQL:db_exec ( "DELETE FROM group_logs WHERE id=?", tostring ( id ) )
	exports.VDBGSQL:db_exec ( "DELETE FROM group_members WHERE id=?", tostring ( id ) )
	exports.VDBGSQL:db_exec ( "DELETE FROM group_rank WHERE id=?", tostring ( id ) )
	exports.VDBGLogs:outputServerLog ( "Group "..tostring ( group ).." deleted" )
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		local gang = getElementData ( v, "Group" )
		if ( gang == group ) then
			setElementData ( v, "Group", "Nenhum" )
			setElementData ( v, "Group Rank", "Nenhum" )
		end
	end 
	exports.VDBGSQL:db_exec ( "UPDATE accountdata SET GroupName=?, GroupRank=? WHERE GroupName=?", "Nenhum", "Nenhum", tostring ( group ) )
end 
addEvent ( "VDBGGroups->Modules->Gangs->Force->DeleteGroup", true )
addEventHandler ( "VDBGGroups->Modules->Gangs->Force->DeleteGroup", root, deleteGroup )

addEvent ( "VDBGGroups->GEvents:onPlayerAttemptGroupMake", true )
addEventHandler ( "VDBGGroups->GEvents:onPlayerAttemptGroupMake", root, function ( data ) 
	--[[
	data = {
		name = "Group Name",
		type = "Group Type",
		color = { 
			r = GroupColorR,
			g = GroupColorG,
			b = GroupColorB
		}
	} ]]

	if ( doesGroupExist ( data.name ) or tostring ( data.name ):lower() == "nenhum" ) then
		return outputChatBox ( "#FFA500[G.E] #ffffffUm clã com o nome dê: #ffa500"..data.name.." #ffffffjá está cadastrado em nosso banco de dados.", source, 255, 255, 0 )
	end

	local created, __ = createGroup ( data.name, data.color, data.type, data.logotipo, data.tag, getAccountName ( getPlayerAccount ( source ) ) )
	if ( created ) then
	
		setElementData ( source, "Group", data.name );
		setElementData ( source, "Group Rank", "Fundador" );
		
		--groups [ data.name ].members [ getAccountName ( getPlayerAccount ( source ) ) ].rank = "Fundador";
		
		outputDebugString ( "CREATED GROUP "..tostring(data.name)..". Owner: "..getPlayerName(source) );
		outputChatBox ( "#FFA500[G.E] #ffffffVocê fundou o clã: #ffa500"..data.name.."  #ffffffpor #acd373R$ 200.000", source, 255, 0, 0 );
		takePlayerMoney ( source, 200000 ) 
		
		refreshPlayerGroupPanel ( source )
		return true
	else 
		outputDebugString ( "FALHA AO CRIAR O GRUPO "..tostring(data.name).." DE "..getplayerName(source) );
	end
	return false
end )

addEvent ( "VDBGGroups->gEvents:onPlayerDeleteGroup", true )
addEventHandler ( "VDBGGroups->gEvents:onPlayerDeleteGroup", root, function ( group )
	deleteGroup ( group )
	exports.VDBGLogs:outputActionLog ( getPlayerName(source).." ("..getAccountName(getPlayerAccount(source))..") deletou o clã: "..tostring(group).." | id: "..tostring ( id ) )
	refreshPlayerGroupPanel ( source )
end )

------------------------------
-- Group Banking Functions	--
------------------------------
function getGroupBank ( group )
	if ( groups [ group ] and groups [ group ].info ) then
		local a = groups [ group ].info.bank or 0
		return a
	end
	return false
end

function getGroupLogo ( group )
	if ( groups [ group ] and groups [ group ].info ) then
		local a = groups [ group ].info.logotipo or "nenhuma"
		return a
	end
	return false
end

function getGroupTag ( group )
	if ( groups [ group ] and groups [ group ].info ) then
		local a = groups [ group ].info.tag or "nenhuma"
		return a
	end
	return false
end

function getGroupType ( group )
	if ( groups [ group ] and groups [ group ].info ) then
		local a = groups [ group ].info.type or "nenhuma"
		return a
	end
	return false
end

function setGroupBank ( group, money )
	if ( groups [ group ] and groups [ group ].info ) then
		groups [ group ].info.bank = money
		local a = true
		return a
	end
	return false
end 


addEvent ( "VDBGGroups:Module->Bank:returnBankBalanceToClient", true )
addEventHandler ( "VDBGGroups:Module->Bank:returnBankBalanceToClient", root, function ( group )
	local bank = getGroupBank ( group ) or 0
	triggerClientEvent ( source, "VDBGGroups:Module->Bank:onServerSendClientBankLevel", source, bank )
end )

addEvent ( "VDBGGroups:Modules->BankSys:onPlayerAttemptWithdawl", true )
addEventHandler ( "VDBGGroups:Modules->BankSys:onPlayerAttemptWithdawl", root, function ( group, amount )
	if ( not doesGroupExist ( group ) ) then
		outputChatBox ( "[G.E] #ffffffAlgo deu errado com o servidor, contate um administrador #d9534f[ERRO G.E006]", source, 255, 0, 0 );
		setElementData ( source, "Group", "Nenhum" );
		setElementData ( source, "Group Rank", "Nenhum" );
		refreshPlayerGroupPanel ( source );
		return false
	end
	local bank = getGroupBank ( group );
	if ( amount > bank ) then
		return outputChatBox ( "#FFA500[G.E] #ffffffSeu clã não tem fundos suficientes para retirar a quantia dê #acd373R$ "..tostring(amount)..".00", source, 255, 0, 0 )
	end
	outputChatBox ( "#FFA500[G.E] #ffffffVocê retirou: #acd373R$"..tostring(amount)..".00 #ffffffdos fundos do clã.", source, 0, 255, 0 )
	givePlayerMoney ( source, amount )
	setGroupBank ( group, bank - amount )
	outputGroupLog ( group, "Sacou $"..tostring(amount).." do banco do clã", source )
end )

addEvent ( "VDBGGroups:Modules->BankSys:onPlayerAttemptDeposit", true )
addEventHandler ( "VDBGGroups:Modules->BankSys:onPlayerAttemptDeposit", root, function ( group, amount ) 
	if ( not doesGroupExist ( group ) ) then
		outputChatBox ( "#FFA500[G.E] #ffffffAlgo deu errado com o servidor. #d9534f[ERRO G.E007]", source, 255, 255, 255, true );
		setElementData ( source, "Group", "Nenhum" );
		setElementData ( source, "Group Rank", "Nenhum" );
		refreshPlayerGroupPanel ( source );
		return false
	end

	local m = source.money;
	if ( amount > m ) then
		return outputChatBox ( "#FFA500[G.E] #ffffffVocê não tem #acd373R$ "..tostring(amount)..",00", source, 255, 255, 255, true )
	end

	outputChatBox ( "#FFA500[G.E] #ffffffVocê depositou R$ "..tostring(amount)..",00 no banco do seu clã", source, 255, 255, 255, true )
	source.money = m - amount;
	outputGroupLog ( group, "Depositou $"..tostring(amount).." no banco do clã.", source )
	setGroupBank ( group, getGroupBank ( group ) + amount )
end )

------------------------------
-- Group Membro Functions	--
------------------------------
function getPlayerGroup ( player ) 
	local g = getElementData ( player, "Group" ) or "Nenhum"
	if ( g:lower ( ) == "nenhum" ) then
		g = nil
	end
	return g
end 


function refreshPlayerGroupPanel ( player )
	triggerClientEvent ( player, "VDBGGroups->pEvents:onPlayerRefreshPanel", player )

	-- memory sweep 
	player = nil
end 

function setPlayerGroup ( player, group )
	local acc = getPlayerAccount ( player )
	if ( isGuestAccount ( acc ) ) then
		return false
	end

	if ( not group ) then
		group = "Nenhum"
	end

	if ( group ~= "Nenhum" ) then
		if ( not groups [ group ] ) then
			return false
		end
	end 

	setElementData ( player, "Group", group )
	if ( group == "Nenhum" ) then
		return setElementData ( player, "Group Rank", "Nenhum" )
	else
		groups [ group ].members [ getAccountName ( acc ) ] = { rank="Membro", joined=getThisTime() }
		return setElementData ( player, "Group Rank", "Membro" )
	end

	return false
end 


addEvent ( "VDBGGroups->Modules->Gangs->kickPlayer", true )
addEventHandler ( "VDBGGroups->Modules->Gangs->kickPlayer", root, function ( group, account )
	exports.VDBGSQL:db_exec ( "UPDATE accountdata SET GroupName=?, GroupRank=? WHERE Username=?", "Nenhum", "Nenhum", account )
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		local a = getPlayerAccount ( v )
		if ( not isGuestAccount ( a ) and getAccountName ( a ) == account )  then
			setElementData ( v, "Group", "Nenhum" )
			setElementData ( v, "Group Rank", "Nenhum" )
			outputChatBox ( "#FFA500[G.E] #ffffffVocê foi expulso de seu clã.", v, 255, 255, 255, true )
			break
		end
	end 
	groups [ group ].members [ account ] = nil
	outputChatBox ( "#FFA500[G.E] #ffffffVocê removeu: "..tostring(account).." do grupo: "..tostring(group), source, 255, 255, 255, true )
	outputGroupLog ( group, "Kikou: "..tostring(account), source )
	refreshPlayerGroupPanel ( source )
end )

addEvent ( "VDBGGroups->Modules->Groups->OnPlayerLeave", true )
addEventHandler ( "VDBGGroups->Modules->Groups->OnPlayerLeave", root, function ( g )
	groups[g].members[getAccountName(getPlayerAccount(source))] = nil
	setPlayerGroup ( source, nil )
	refreshPlayerGroupPanel ( source )
	outputGroupLog ( g, "Saiu do clã", source  )
end )

	------------------------------------------
	-- Players -> Group Ranking Functions 	--
	------------------------------------------
	function setAccountRank ( group, account, newrank )
		local account, newrank = tostring ( account ), tostring ( newrank )
		exports.VDBGSQL:db_exec ( "UPDATE accountdata SET GroupRank=? WHERE Username=?", newrank, account )
		groups[group].members[account].rank = newrank
		for i, v in pairs ( getElementsByType ( "player" ) ) do
			local a = getPlayerAccount ( v )
			if ( a and not isGuestAccount ( a ) and a == account ) then
				setElementData ( v, "Group Rank", tostring ( newrank ) )
				outputChatBox ( "#FFA500[G.E] #ffffffSua patente no clã foi definida para: #ffa500"..tostring ( newrank ), v, 255, 255, 255, true )
				break
			end
		end

		return true
	end

	addEvent ( "VDBGGroups->Modules->Gangs->Ranks->UpdatePlayerrank", true )
	addEventHandler ( "VDBGGroups->Modules->Gangs->Ranks->UpdatePlayerrank", root, function ( group, account, newrank )
		if ( not groups[group] or not groups[group].ranks[newrank] ) then
			outputChatBox ( "#FFA500[G.E] #ffffffOops! Algo deu errado. Por favor, tente novamente", source, 255, 255, 255, true )
			refreshPlayerGroupPanel ( source )
			return false
		end
		outputGroupLog ( group, "Mudou a patende do: "..account.." - "..groups[group].members[account].rank.." para "..newrank, source )
		setAccountRank ( group, account, newrank )
		outputChatBox ( "#FFA500[G.E] #ffffffVocê mudou a patente do: #428bca"..tostring ( account ).."", source, 255, 255, 255, true )
		refreshPlayerGroupPanel ( source )
	end )


	function sendPlayerInvite ( player, group, inviter )
		local a = getPlayerAccount ( player )
		if ( isGuestAccount( a ) ) then
			return  false
		end

		local a = getAccountName ( a )
		if ( groups [ group ].pendingInvites [ a ] ) then 
			return false
		end

		table.insert ( groups [ group ].pendingInvites, { to=getAccountName(getPlayerAccount(player)), inviter=getAccountName(getPlayerAccount(inviter)), time=getThisTime() } );
		
		return true
	end

	addEvent ( "VDBGGroups->Modules->Groups->InvitePlayer", true )
	addEventHandler ( "VDBGGroups->Modules->Groups->InvitePlayer", root, function ( group, plr )
		local a = getPlayerAccount ( plr )
		if ( isGuestAccount ( a ) ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffO Seu convite para #428bca"..plr.name.." #ffffffparticipar do clã não foi enviado.", source, 255, 255, 255, true )
		end
		local a = getAccountName ( a )
		
		for _, info in pairs ( groups [ group ].pendingInvites ) do 
			if ( info.to == a ) then 
				return outputChatBox ( "#FFA500[G.E] #ffffffEste jogador já foi convidado por: #428bca"..tostring(info.from), source, 255, 255, 255, true )
			end
		end

		outputGroupLog ( group, "Convidou: "..plr.name.." ("..a..")", source )
		
		local r, g, b = getGroupColor ( group );
		outputChatBox ( "#FFA500[G.E] #428bca"..source.name.." convidou-o para participar do clã #ffa500"..group..". #ffffffaceite usando o F4", plr, 255, 255, 255, true )
		outputChatBox ( "#FFA500[G.E] #ffffffVocê convidou #428bca"..plr.name.." para o clã", source, 255, 255, 255, true )
		sendPlayerInvite ( plr, group, source ) 
	end ) 

	addEvent ( "VDBGGroups->Modules->Groups->Invites->OnPlayerDeny", true )
	addEventHandler( "VDBGGroups->Modules->Groups->Invites->OnPlayerDeny", root, function ( g )
		local a = getAccountName ( getPlayerAccount ( source ) )
		groups [ g ].pendingInvites [ a ] = nil
		refreshPlayerGroupPanel ( source )
	end )

	addEvent ( "VDBGGroups->Modules->Groups->Invites->OnPlayerAccept", true )
	addEventHandler ( "VDBGGroups->Modules->Groups->Invites->OnPlayerAccept", root, function ( g )
		local a = getAccountName ( getPlayerAccount ( source ) )

		for index, info in pairs ( groups [ g ].pendingInvites ) do 
			if ( info.to == a ) then
				table.remove ( groups [ g ].pendingInvites, index )
			end 
		end 
		
		groups [ g ].members [ a ] = { rank="Membro", joined = getThisTime() }
		setPlayerGroup ( source, g )
		outputGroupMessage ( getPlayerName ( source ).." Você entrou para o clã.!", g )
		refreshPlayerGroupPanel ( source )
	end )

	function addRankToGroup ( group, name, info )
		if ( not groups [ group ] ) then return false end
		for i, v in pairs ( groups [ group ].ranks ) do
			if ( i:lower() == name:lower() ) then
				return false
			end
		end
		groups [ group ].ranks [ name ] = info
		return true
	end 

	addEvent ( "VDBGGroups->Modules->Groups->Ranks->AddRank", true )
	addEventHandler ( "VDBGGroups->Modules->Groups->Ranks->AddRank", root, function ( group, name, info )
		outputGroupLog ( group, "Patente '"..tostring(name).."' adicionada", source )
		addRankToGroup ( group, name, info )
		refreshPlayerGroupPanel ( source )
		outputChatBox ( "#FFA500[G.E] #ffffffA patente #ffa500"..tostring(name).."#ffffff foi adicionada.", source, 255, 255, 255, true )
	end )

	function setGroupMotd ( group, motd )
		if ( groups [ group ] ) then
			groups[group].info.desc = tostring ( motd )
			return true
		end
		return false
	end

	addEvent ( "VDBGGroups->Modules->Groups->MOTD->Update", true )
	addEventHandler ( "VDBGGroups->Modules->Groups->MOTD->Update", root, function ( g, mo )
		outputGroupLog ( g, "Alterou o anúncio do clã.", source )
		setGroupMotd ( g, mo )
		refreshPlayerGroupPanel ( source )
	end )



------------------------------
-- Group Checking Functions	--
------------------------------
function doesGroupExist ( group )
	local group = tostring ( group ):lower ( )
	for i, v in pairs ( groups ) do
		if ( tostring ( i ):lower ( ) == group ) then
			group = nil
			return true
		end
	end 
	group = nil
	return false
end

function isRankInGroup ( group, rank )
	local group = tostring ( group ):lower ( )
	for i, v in pairs ( groups ) do
		if ( i:lower() == group ) then
			if ( v.ranks and v.ranks [ rank ] ) then
				return true
			end 
			break
		end 
	end 
	return false
end 


------------------------------
-- Group Logging			--
------------------------------
function groupClearLog ( group )
	if ( groups [ group ] ) then
		groups [ group ].log = nil
		exports.VDBGSQL:db_exec ( "DELETE FROM group_logs WHERE id=?", groups[group].info.id )
		groups [ group ].log = { }
		group = nil
		return true
	end 
	group = nil
	return false
end

function outputGroupLog ( group, log, element )
	if ( not groups[group] ) then return end
	if ( not groups[group].log ) then groups[group].log = { } end

	local e = "Server"
	if ( element ) then
		e = element
		if ( type ( element ) == "userdata" ) then
			if ( getElementType ( element ) == "player" ) then
				local a = getPlayerAccount ( element )
				if ( not isGuestAccount ( a ) ) then
					e = getAccountName ( a )
				end 
				a = nil
			end 
		end 
	end 

	table.insert ( groups[group].log, 1, { time=getThisTime(), account=e, log=log } )
end 

function getGroupLog ( group )
	if ( group and groups [ group ] ) then
		local f = groups [ group ].log
		return f
	end 
end 


addEvent ( "VDBGGroups->GEvents:onPlayerClearGroupLog", true )
addEventHandler ( "VDBGGroups->GEvents:onPlayerClearGroupLog", root, function ( group ) 
	groupClearLog ( group )
	outputGroupLog ( group, "Log limpo", source )
	refreshPlayerGroupPanel ( source )
	-- memory sweep
	group = nil
end ) 


------------------------------
-- Misc Functions			--
------------------------------
function getThisTime ( )
	local time = getRealTime ( )
	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local min = time.minute
	local sec = time.second

	if ( month < 10 ) then month = 0 .. month end
	if ( day < 10 ) then day = 0 .. day end
	if ( hour < 10 ) then hour = 0 .. hour end
	if ( min < 10 ) then min = 0 .. min end
	if ( sec < 10 ) then sec = 0 .. sec end
	return table.concat ( { year, month, day }, "-") .. " "..table.concat ( { hour, min, sec }, ":" )
end 

function getGroupColor ( group )
	local r, g, b = 0, 0, 0
	if ( groups [ group ] ) then
		r, g, b  = groups[group].info.color.r, groups[group].info.color.g, groups[group].info.color.b
	end
	return r, g, b
end 

function setGroupColor ( group, r, g, b )
	if ( groups [ group ] ) then
		groups[group].info.color.r = r
		groups[group].info.color.g = g
		groups[group].info.color.b = b
		exports.vdbgturf:updateTurfGroupColor ( group )
		return true
	end 
	return false
end 

addEvent("VDBGGroups->Modules->Groups->Colors->UpdateColor",true)
addEventHandler("VDBGGroups->Modules->Groups->Colors->UpdateColor",root,function(group,r,g,b)
	outputGroupLog ( group, "Mudou a cor do clã para: ".. table.concat ( { r, g, b }, ", " ), source )
	setGroupColor ( group, r, g, b )
	refreshPlayerGroupPanel ( source )
end )


function isRankInGroup ( group, rank )
	if ( doesGroupExist ( group ) ) then
		if ( groups [ group ].ranks [ rank ] ) then
			return true
		end
	end
	return false
end 

function outputGroupMessage ( message, group, blockTag )

	local blockTag = blockTag or false

	if ( not blockTag ) then
		message = "("..tostring(group)..") "..tostring(message)
	end

	local r, g, b = getGroupColor ( group )
	local group = tostring ( group ):lower ( )
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		if ( tostring ( getElementData ( v, "Group" ) ):lower ( ) == group:lower() ) then
			outputChatBox ( message, v, 255, 255, 255, true )
		end 
	end  
end 

function table.len ( t )
	local c = 0
	for i in pairs ( t ) do
		c = c + 1
	end
	return c
end

-- group chat --
addCommandHandler ( "gc", function ( plr, _, ... )
	local message = table.concat ( { ... }, " " )
	local g = getPlayerGroup ( plr )
	if ( not g ) then
		return outputChatBox ( "#FFA500[G.E] #ffffffComando inválido.", plr, 255, 255, 255, true )
	end

	if ( message:gsub ( " ", "" ) == "" ) then
		return outputChatBox ( "#FFA500[G.E] #ffffffVocê não digitou uma mensagem. use: #ffa500/gc [mensagem]", plr, 255, 255, 255, true )
	end

	outputGroupMessage("[CLAN] ".. exports.ngchat:getChatLine ( plr, message ), g, true )
end )