local dbData = {
	db = "vdbg",
	host="localhost",
	user="vdbg",
	pass="",
	port=3306
}


outputConsole ( "Fazendo uma tentativa de conexão mysql ... aguarde")
db = dbConnect( "mysql", "dbname="..dbData.db..";host="..dbData.host..";port="..dbData.port..";unix_socket=/opt/lampp/var/mysql/mysql.sock;charset=utf8", dbData.user, dbData.pass, "share=1;autoreconnect=1" );

if not db then
	outputConsole ( "Falha ao conectar ao banco de dados")
	setTimer ( outputConsole, 500, 0, "The database isn't connected!")
	return 
else
	outputConsole ( "Banco de dados MYSQL conectado com sucesso.")
end


function db_query ( ... ) 
	local data = { ... }
	return dbPoll ( dbQuery ( db, ... ), - 1 )
end

function db_exec ( ... )
	return dbExec ( db, ... ); 
end

--[[ Columns:

	Username TEXT,
	Money TEXT,
	Armour TEXT,
	Health TEXT, 
	x TEXT,
	y TEXT,
	z TEXT,
	Skin INT,
	Interior INT, 
	Dimension INT,
	Team TEXT
	Job TEXT,
	Playtime_mins INT,
	JailTime INT,
	WL INT,
	Weapons TEXT,
	JobRank TEXT,
	GroupName TEXT,
	GroupRank TEXT,
	LasterOnline DATE,
	LastSerial TEXT,
	LastIP TEXT,
	Kills INT,
	Deaths INT, 
	weapstats TEXT,
	items TEXT,
	unemployedskin INT,
	vip TEXT,
	vipexp DATE,
	plrtosrvrsettings TEXT

]]

db_exec ( "CREATE TABLE IF NOT EXISTS accountdata ( Username TEXT, Money TEXT, Armour TEXT, Health TEXT, x TEXT, y TEXT, z TEXT, Skin INT, Interior INT, Dimension INT, Team TEXT, Job TEXT, Playtime_mins INT, JailTime INT, WL INT, Weapons TEXT, JobRank TEXT, GroupName TEXT, GroupRank TEXT, LastOnline DATE, LastSerial TEXT, LastIP TEXT, Kills INT, Deaths INT, weapstats TEXT, items TEXT, unemployedskin INT, vip TEXT, vipexp DATE, plrtosrvrsettings TEXT )" );

local weapStats_ = { 
	['9mm'] = 0, ['silenced'] = 0, ['deagle'] = 0, ['shotgun'] = 0, ['combat_shotgun'] = 0, 
	['micro_smg'] = 0, ['mp5'] = 0, ['ak47'] = 0, ['m4'] = 0, ['tec-9'] = 0, ['sniper_rifle'] = 0 }
--[[
function createAccount ( account )
	if ( account and type ( account ) == 'string' ) then
		local plr = getPlayerFromAccount ( account )
		local autoIP = "Desconhecido"
		local autoSerial = "Desconhecido"
		local weapStats = toJSON ( weapStats_ )
		if plr and isElement ( plr ) then
			autoSerial = getPlayerSerial ( plr )
			autoIP = getPlayerIP ( plr )
			outputDebugString ( "VDBGSQL: Criação de conta "..account.." para o jogador "..getPlayerName ( plr ).." (Serial: "..autoSerial.." || IP: "..autoIP..")" )
		else
			outputDebugString ( "VDBGSQL: Criação de conta "..account.." para o jogador N/A (Serial: Nenhum || IP: Nenhum)" );
		end
		local today = exports['VDBGPlayerFunctions']:getToday ( )
		return db_exec ( "INSERT INTO `accountdata` (`Username`, `Money`, `Armour`, `Health`, `x`, `y`, `z`, `Skin`, `Interior`, `Dimension`, `Team`, `Job`, `Playtime_mins`, `JailTime`, `WL`, `Weapons`, `JobRank`, `GroupName`, `GroupRank`, `LastOnline`, `LastSerial`, `LastIP`, `Kills`, `Deaths`, `weapstats`, `items`, `unemployedskin`, `vip`, `vipexp`, `plrtosrvrsettings` ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );", 
							account, '0', '0', '100', '0', '0', '0', '0', '0', '0', 'Desempregado', 'Desempregado', '0', '0', '0', 
							'[ [ ] ]', 'Nenhum', 'Nenhum', 'Nenhum', today, autoSerial, autoIP, '0', '0', weapStats, toJSON ( { } ), '28', 'SemVIP', nil, toJSON ( { } ) )
	end
	return false
end]]

function getPlayerFromAccount ( accnt )
	if accnt and type ( accnt ) == 'string' then
		for i, v in ipairs ( getElementsByType ( 'player' ) ) do
			if ( getAccountName ( getPlayerAccount ( v ) ) == accnt ) then
				return v;
			end
		end
	end
	return false
end


function savePlayerData ( p, loadMsg, deleteTime )
	if ( p and getElementType ( p ) == 'player' ) then
		if ( not isGuestAccount ( getPlayerAccount ( p ) ) ) then
			
			if ( loadMessage == nil ) then loadMessage = true end
			if ( deleteTime == nil ) then deleteTime = false end
		
			local account = getAccountName ( getPlayerAccount ( p ) )
			local x, y, z = getElementPosition ( p )
			local money, health = getPlayerMoney ( p ), getElementHealth ( p )
			
			local armor, skin = getPedArmor ( p ), getElementModel ( p )
			local int, dim  = getElementInterior ( p ), getElementDimension ( p )
			local job = getElementData ( p, "Job" )
			local pt = exports['VDBGPlayerFunctions']:getPlayerPlaytime ( p )
			local team = "UnEmployed"
			local wl = getElementData ( p, "WantedPoints" ) or 0
			local wanted = getPlayerWantedLevel(p)
			local rank = tostring ( getElementData ( p, "Job Rank" ) )
			local conta = getPlayerAccount(p)
			
			local level = getElementData(p, "Level") or "LVL 0"
			local xp = getElementData(p, "playerExp") or "0"
			
			local bank = getElementData(p, "VDBGBank:BankBalance") or "0"
			local diamantes = getElementData(p, "VDBG.Diamantes") or "0"
			
			local avatar = getElementData(p, "avatar") or "1"
			local fome = getElementData(p, "AccountData.Fome") or "0"
			local sede = getElementData(p, "AccountData.Sede") or "0"
			local maxPlayerVehicleSlots = getElementData(p, "maxPlayerVehicleSlots") or "3"
			local maxPlayerHouseSlots = getElementData(p, "maxPlayerHouseSlots") or "3"
			
			local name1 = getPlayerName(p) or "Desconhecido"
			local jogador = string.gsub(name1, "#%x%x%x%x%x%x", "")
			local pegagroup = tostring ( getElementData ( p, "Group" ) )
			local group = string.gsub(pegagroup, "#%x%x%x%x%x%x", "")
			local gRank = tostring ( getElementData ( p, "Group Rank" ) )

			local jt = exports['VDBGPolice']:isPlayerJailed ( p ) or 0
			
			
			local today = exports['VDBGPlayerFunctions']:getToday ( )
			local kills = tonumber ( getElementData ( p, "VDBGSQL:Kills" ) ) or 0
			local deaths = tonumber ( getElementData ( p, "VDBGSQL:Deaths" ) ) or 0
			local weapstats = toJSON ( getElementData ( p, "VDBGSQL:WeaponStats" ) or weapStats_ )
			local items = tostring ( toJSON ( getElementData ( p, "VDBGUser:Items" ) or { } ) )
			local unemloyedSkin = tostring ( getElementData ( p, "VDBGUser.UnemployedSkin" ) ) or 28
			local vip = tostring ( getElementData ( p, "VIP" ) )
			local vipexp = tostring ( getElementData ( p, "VDBGVIP.expDate" ) )

			local plrtosrvrsettings = tostring ( toJSON ( getElementData ( p, "PlayerServerSettings" ) or { } ) )
			
			if ( getElementData ( p, "VDBGEvents:IsPlayerInEvent" ) ) then
				health = 0
				dim = 0
			end
			
			if ( getPlayerTeam ( p ) ) then
				team = getTeamName ( getPlayerTeam ( p ) )
			end 
			
			local teamtag = "<span class='badge3clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..account.."'>"..jogador.."</a></span>&nbsp;"
			
			if getTeamName(getPlayerTeam(p)) == "Criminoso" then
			teamtag = "<span class='badge5clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..account.."'>"..jogador.."</a></span>&nbsp;"
			end
			
			if getTeamName(getPlayerTeam(p)) == "Administração" then
			teamtag = "<span class='badge4clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..account.."'>"..jogador.."</a></span>&nbsp;"
			end
			
			if  getTeamName(getPlayerTeam(p)) == "Policial" then
			teamtag = "<span class='badge6clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..account.."'>"..jogador.."</a></span>&nbsp;"
			end
			
			if getTeamName(getPlayerTeam(p)) == "Civilizante" or getTeamName(getPlayerTeam(p)) == "Desempregado" or getTeamName(getPlayerTeam(p)) == "Emergencia" or getTeamName(getPlayerTeam(p)) == "Convidado" then
			teamtag = "<span class='badge3clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..account.."'>"..jogador.."</a></span>&nbsp;"
			end
			
			
			if not armor then
				armor = 0
			end
			if ( not jt ) then jt = 0 end
			
			
			local ip = getPlayerIP ( p )
			local serial = getPlayerSerial ( p )
			
			if loadMsg then outputDebugString ( "VDBGSQL: A tentativa de salvar conta "..account.." (Player: "..getPlayerName ( p )..") userdata." ) end
			if ( deleteTime ) then exports['VDBGPlayerFunctions']:deletePlayerPlaytime ( p ) end
			return db_exec ( "UPDATE accountdata SET Jogador=?, Money=?, Bank=?, diamantes=?, teamtag=?, Armour=?, Health=?, fome=?, sede=?, x=?, y=?, z=?, Skin=?, Interior=?, Dimension=?, Team=?, Job=?, Playtime_mins=?, JailTime=?, WL=?, wanted=?, level=?, xp=?, JobRank=?, GroupName=?, GroupRank=?, LastOnline=?, LastSerial=?, lastIP=?, Kills=?, Deaths=?, weapstats=?, unemployedskin=?, vip=?, vipexp=?, plrtosrvrsettings=?, avatar=?, maxPlayerVehicleSlots=?, maxPlayerHouseSlots=? WHERE Username=?", 
				jogador, money, bank, diamantes, teamtag, armor, health, fome, sede, x, y, z, skin, int, dim, team, job, pt, jt, wl, wanted, level, xp, rank, group, gRank, today, serial, ip, kills, deaths, 
				weapstats, unemloyedSkin, vip, vipexp, plrtosrvrsettings, avatar, maxPlayerVehicleSlots, maxPlayerHouseSlots, account )
		end
	end
end

function loadPlayerData ( p, loadMsg )
	local acc = getAccountName ( getPlayerAccount ( p ) )
	local data = account_exist ( acc )
	if ( data and type ( data ) == 'table' ) then
		for i, v in ipairs  ( data ) do
			if ( v['Username'] == acc ) then
			
				if ( loadMsg == nil ) then
					loadMesg = true
				end
				local idjogador = 	tonumber ( v['id'] ) 				or 0
				local user = 	    tostring ( v['Username'] )	        or "N/A"	
				local email = 	    tostring ( v['email'] )	            or "N/A"
				local jogador =     tostring ( v['Jogador'] )	        or "N/A"	
				local name =     	tostring ( v['Name'] )				or "N/A"	
				local money = 		tonumber ( v['Money'] ) 			or 0
				local diamantes =   tonumber ( v['diamantes'])			or 0
				local armor = 		tonumber ( v['Armour'] )		 	or 0
				local maxPlayerVehicleSlots = 		tonumber ( v['maxPlayerVehicleSlots'] )		 	or 3
				local maxPlayerHouseSlots = 		tonumber ( v['maxPlayerHouseSlots'] )		 	or 3
				local health = 		tonumber ( v['Health'] ) 			or 0
				local fome = 		tonumber ( v['fome'] )				or 0
				local sede = 		tonumber ( v['sede'] )				or 0
				local x = 			tonumber ( v['x'] ) 				or 0
				local y = 			tonumber ( v['y'] ) 				or 0
				local z = 			tonumber ( v['z'] ) 				or 5
				local level = 		tonumber ( v['level'] ) 			or 1
				local up = 			tonumber ( v['xp'] ) 				or 0
				local skin = 		tonumber ( v['Skin'] ) 				or 28
				local interior = 	tonumber ( v['Interior'] ) 			or 0
				local dimension = 	tonumber ( v['Dimension'] )		 	or 0
				local team = 		tostring ( v['Team'] ) 				or "Nenhuma"
				local job = 		tostring ( v['Job'] ) 				or "Desempregado"
				local pt = 			tonumber ( v["Playtime_mins"] ) 	or 0
				local jt = 			tonumber ( v['JailTime'] or 0 )
				local wl = 			tonumber ( v['WL'] or 0 )
				local rank = 		tostring ( v['JobRank'] or "Nenhum" )
				local group = 		tostring ( v['GroupName'] or "Nenhum" )
				local gRank = 		tostring ( v['GroupRank'] or "Nenhum" )
				local kills = 		tonumber ( v['Kills'] )
				local deaths = 		tonumber ( v['Deaths'] )
				local weapstats = 	fromJSON ( tostring ( v['weapstats'] ) )
				local unemployedSkin=tonumber( v['unemployedskin'] )	or 28
				local vip =			tostring ( v['vip'] )
				local vipexp =		tostring ( v['vipexp'] )
				local group =		tostring ( v['GroupName'] or "Nenhum" )
				local groupRank =	tostring ( v['GroupRank'] or "Nenhum" )
				local srvrsettings =fromJSON ( tostring ( v['plrtosrvrsettings'] or tosJSON ( { } ) ) )
				local msgadm =     	tostring ( v['msgadm'] )			or "N/A"	
				local avatar = 		tonumber ( v['avatar'] ) 			or 1
				local ip =     		tostring ( v['LastIP'] )			or "N/A"	
				local serial =     	tostring ( v['LastSerial'] )		or "N/A"	

				if ( not exports.VDBGGroups:doesGroupExist ( group ) ) then
					group = "Nenhum"
				else
					if ( not exports.VDBGGroups:isRankInGroup ( group, groupRank ) ) then
						groupRank = "Nenhum"
					end 
				end 

				if ( group:lower ( ) == "Nenhum" ) then
					groupRank = "Nenhum"
				end
				
				setElementData ( p, "accountID", idjogador )
				setElementData ( p, "AccountData:Username", user )
				setElementData ( p, "AccountData:Email", email )
				setElementData ( p, "AccountData:Jogador", jogador )
				setElementData ( p, "AccountData:Name", name )
				givePlayerMoney ( p, money )
				setElementData ( p, "VDBG.Diamantes", diamantes)
				setPedArmor ( p, armor )
				setElementHealth ( p, health )
				setElementData ( p, "AccountData.Fome", fome )
				setElementData ( p, "AccountData.Sede", sede )
					
				setElementData(p, "Level", level)
				setElementData(p, "playerExp", up)
				
				spawnPlayer ( p, x, y, z+1, 0, skin, interior, dimension )
							
				
				if ( team and getTeamFromName ( team ) ) then setPlayerTeam ( p, getTeamFromName ( team ) ) end
				setElementData ( p, "Job", job )				
				exports['VDBGPlayerFunctions']:setPlayerPlaytime ( p,pt )
				if ( jt > 0 ) then exports['VDBGPolice']:jailPlayer ( p, jt, false ) end
				setElementData ( p, "WantedPoints", wl )
				--for i, v in ipairs ( weapons ) do giveWeapon ( p, v[1], v[2] ) end
				setElementData ( p, "Job Rank", rank )
				setElementData ( p, "Group", group )
				setElementData ( p, "Group Rank", gRank	)
				setElementData ( p, "VDBGSQL:Kills", kills )				
				setElementData ( p, "VDBGSQL:Deaths", deaths )
				setElementData ( p, "VDBGSQL:WeaponStats", weapstats )
				setElementData ( p, "VDBGUser:Items", items )
				setElementData ( p, "VDBGUser.UnemployedSkin", unemployedSkin )
				setElementData ( p, "VIP", vip )
				setElementData ( p, "VDBGVIP.expDate", vipexp )
				setElementData ( p, "PlayerServerSettings", srvrsettings )
				setElementData ( p, "AccountData.msgadm", msgam )
				setElementData ( p, "avatar", avatar )				
				setElementData ( p, "AccountData:IP", ip )
				setElementData ( p, "AccountData:Serial", serial )
				setElementData ( p, "maxPlayerVehicleSlots", maxPlayerVehicleSlots )
				setElementData ( p, "maxPlayerHouseSlots", maxPlayerHouseSlots )
				if ( srvrsettings.walkStyle ) then
					setPedWalkingStyle ( p, srvrsettings.walkStyle)
				end
				exports.VDBGVIP:checkPlayerVipTime ( p )
				if ( loadMsg ) then outputDebugString ( "VDBGSQL: carregando "..acc.." conta (Player: "..getPlayerName ( p )..")" ) end
				return true
			end
		end
	end
	return false
end

function account_exist ( acc )
	if ( acc ) then
		local q = db_query ( "SELECT * FROM accountdata WHERE Username='"..acc.."' LIMIT 1" )
		if ( type ( q ) == 'table' ) then
			if ( #q > 0 ) then
				return q
			end
			return false
		end
	end
	return nil
end

function saveAllData ( useTime )
	if ( useTime == nil ) then useTime = true end
	if ( useTime ) then
		 outputChatBox ( "#d9534f[VDBG.ORG] #FFFFFFServidor irá salvar os dados em #428bca5 segundos.", root, 255, 255, 255, true ) 
		setTimer ( function ( )
			for i, v in ipairs ( getElementsByType ( 'player' ) ) do
				savePlayerData ( v, false, false )
			end
			if ( isTimer ( saveAllTimer ) ) then
				resetTimer ( saveAllTimer )
			else
				saveAllTimer = setTimer ( saveAllData, 900000, 1, true )
			end
			if ( getResourceState ( getResourceFromName ( "VDBGBank" ) ) == 'running' ) then exports['VDBGBank']:saveBankAccounts ( ) end
			if ( getResourceState ( getResourceFromName ( "VDBGGroups" ) ) == 'running' ) then exports['VDBGGroups']:saveGroups ( ) end
			outputChatBox ( "#d9534f[VDBG.ORG] #FFFFFFBanco de dados salvo com sucesso!", root, 255, 255, 255, true ) 
			if ( getResourceState ( getResourceFromName ( "VDBGBans" ) ) == "running" ) then exports.VDBGBans:saveBans ( ) end
			if ( getResourceState ( getResourceFromName ( "VDBGTurf" ) ) == "running" ) then exports.VDBGTurf:saveTurfs ( ) end 
		end, 5000, 1 )
	else
		outputChatBox ( "#d9534f[VDBG.ORG] #FFFFFFSalvando dados do servidor! Pode ocorrer um pouco de lag.", root, 255, 255, 255, true ) 
		if ( getResourceState ( getResourceFromName ( 'VDBGBank' ) ) == 'running' ) then exports['VDBGBank']:saveBankAccounts ( ) end
		if ( getResourceState ( getResourceFromName ( "VDBGBans" ) ) == "running" ) then exports.VDBGBans:saveBans ( ) end
		if ( getResourceState ( getResourceFromName ( "VDBGTurf" ) ) == "running" ) then exports.VDBGTurf:saveTurfs ( ) end 
		for i, v in ipairs ( getElementsByType ( 'player' ) ) do savePlayerData ( v, false, false ) end
		if ( isTimer ( saveAllTimer ) ) then resetTimer ( saveAllTimer ) else saveAllTimer = setTimer ( saveAllData, 900000, 1, true ) end
	end
end
saveAllTimer = setTimer ( saveAllData, 900000, 1, true )

addEventHandler ( "onPlayerQuit", root, function ( ) 
	if ( isGuestAccount ( getPlayerAccount ( source ) ) ) then return end 
	savePlayerData ( source, false, true ) 
	local account = getAccountName ( getPlayerAccount ( source ) )
	local status = "<span class='badge2'>Offline</span>"
	return db_exec ( "UPDATE accountdata SET Status=? WHERE Username=?", status, account  )
end ) 

addEventHandler ( "onPlayerLogin", root, function ( ) 
	loadPlayerData ( source, true ) 
	local account = getAccountName ( getPlayerAccount ( source ) )
	local status = "<span class='badge3'>Online</span>"
	return db_exec ( "UPDATE accountdata SET Status=? WHERE Username=?", status, account  )
end ) 

addEventHandler ( "onResourceStop", resourceRoot, function ( ) 
	saveAllData ( false ) 
	local status = "<span class='badge2'>Offline</span>"
	local online = "<span class='badge3'>Online</span>"
	return db_exec ( "UPDATE accountdata SET Status=? WHERE Status=?", status, online )
end ) 

addCommandHandler ( "criarconta", function ( p, cmd, accnt ) 
	if ( getPlayerName ( p ) == "Console" or getAccountName ( getPlayerAccount ( p ) ) == "tiaguinhods" ) then
		outputChatBox ( "Execução de comando: Criação de Conta", root, 255, 255, 255 )
		results = nil
		if ( accnt ) then
			if ( createAccount ( accnt ) ) then
				print ( "A conta "..accnt.." foi criada com sucesso!" )
				results = "Conta "..accnt.." foi criada"
			else
				print ( "Falha ao criar conta." )
				results = "Conta "..accnt.." não foi criada devido a erro!!"
			end
		else
			print ( "Formato: /"..cmd.." [conta]" )
			results = "none"
		end
		outputChatBox ( "Resultados da execução do comando: "..tostring ( results ), root, 255, 255, 255 )
	end
end )

addCommandHandler ( "deletarconta", function ( p, cmd, accnt ) 
	if ( getPlayerName ( p ) == "Console" ) then
		if ( account_exist ( accnt ) ) then
			print ( "Removendo conta "..accnt.." do banco de dados......" )
			if ( db_exec ( "DELETE FROM accountdata WHERE Username='"..accnt.."'" ) ) then
				print ( "Conta foi removida!" )
			else
				print ( "Conta não foi removida." )
			end
		else
			print ( "A conta "..accnt.." não existe no banco de dados." )
		end
	end
end )

addCommandHandler ( 'salvartudo', function ( p, cmd )
	if ( ( getPlayerName ( p ) == 'Console' ) or ( getAccountName ( getPlayerAccount ( p ) ) == 'tiaguinhods' ) ) then
		saveAllData ( true )
	end
end )

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		savePlayerData ( source, false, true ) 
	end
)