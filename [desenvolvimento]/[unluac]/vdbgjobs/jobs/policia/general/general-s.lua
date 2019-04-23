arresties = { }
tased = { }


addEventHandler ( "onPlayerDamage", root, function ( cop, weapon, _, loss ) 
	-- arrest system
	if ( isElement ( cop ) and weapon and cop ~= source  ) then
		
		if ( getElementData ( cop, "VDBGEvents:IsPlayerInEvent" ) or getElementData ( source, "VDBGEvents:IsPlayerInEvent" ) ) then
			return 
		end
	
		if ( cop == source ) then return end
		if ( getElementType ( cop ) == 'vehicle' ) then
			cop = getVehicleOccupant ( cop )
		end
		if ( not isElement ( cop ) or getElementType ( cop ) ~= 'player' ) then return end
		if ( not getPlayerTeam ( cop ) ) then
			return
		end

		if ( exports['VDBGPlayerFunctions']:isTeamLaw ( getTeamName ( getPlayerTeam ( cop ) ) ) ) then
			if ( getElementData ( source, "isSpawnProtectionEnabled" ) == true ) then 
				return outputChatBox ( "#d9534f[D.P] #FFFFFFEste jogador está protegido pelo hospital durante alguns segundos.", cop, 255, 255, 255, true) 
			end
			
			if ( getPlayerTeam ( source ) and getTeamName ( getPlayerTeam ( source ) ) == "Administração" ) then 
				return outputChatBox ( "#d9534f[D.P] #FFFFFFVocê não pode prender um membro da equipe.", cop, 255, 255, 255, true) 
			end
					if ( getPlayerWantedLevel ( source ) >= 1 ) then
				if ( weapon == 3 ) then
					-- Arrest
					arrestPlayer ( source, cop )
					outputChatBox ( "#d9534f[D.P] #FFFFFFVocê algemou "..getPlayerName ( source )..", bata nele com a algema até prende-lo", cop, 255, 255, 255, true)
					outputChatBox ( "#d9534f[D.P] #FFFFFF".. getPlayerName ( cop ).." algemou você!", source, 255, 255, 255, true)
					setElementHealth ( source, getElementHealth ( source ) + loss )
					setElementData ( source, "VDBGJobs:ArrestingOfficer", cop )
				elseif ( weapon == 23 ) then
					-- Taze Player
					if ( tased [ source ] ) then
	
			if ( getPlayerTeam ( source ) and getTeamName ( getPlayerTeam ( source ) ) == "Policial" ) then 
				return outputChatBox ( "#d9534f[D.P] #FFFFFFVocê não pode prender um membro da equipe.", cop, 255, 255, 255, true) 
			end
			
			if ( getPlayerTeam ( source ) and getTeamName ( getPlayerTeam ( source ) ) == "Exercito" ) then 
				return outputChatBox ( "#d9534f[D.P] #FFFFFFVocê não pode prender um membro da equipe.", cop, 255, 255, 255, true) 
			end
			
			if ( arresties[source] ) then 
				return outputChatBox ( "#d9534f[D.P] #FFFFFFEste jogador já está preso.", cop, 255, 255, 255, true) 
			end
						return outputChatBox ( "#d9534f[D.P] #FFFFFFEste jogador já está com o efeito da arma de choque", cop, 255, 255, 255 , true )
					end
					
					local a = cop
					local t = getPlayerTeam ( a )
					if ( not t ) then return end
					if ( getPlayerWantedLevel ( source ) == 0 ) then return end
					if ( exports.VDBGPlayerFunctions:isTeamLaw ( getTeamName ( t ) ) and not getElementData ( source, "VDBGJobs:ArrestingOfficer" ) ) then
						-- now we know:
						-- source 	-> wanted, not arrested
						-- w 		-> teaser
						toggleAllControls ( source, false )
						if ( isPedInVehicle ( source ) ) then
							removePedFromVehicle ( source )
						end
						setPedAnimation(source, "CRACK", "crckdeth2", 4000, false, true, false)
						
						outputChatBox ( "#d9534f[D.P] #FFFFFFVocê deu um choque no(a) ".. getPlayerName ( source ), a, 255, 255, 255, true)
						outputChatBox ( "#d9534f[D.P] #FFFFFFVocê levou um choque do(a) "..getPlayerName ( a ), source, 255, 255, 255, true)
						tased [ source ] = true
						setTimer ( function ( p, c )
							if ( isElement ( p ) ) then
								setPedAnimation ( p )
								toggleAllControls ( p, true )
								outputChatBox ( "#d9534f[D.P] #FFFFFFVocê não está mais com o efeito da arma de choque", p, 255, 255, 255, true)
								if ( isElement ( c ) ) then
									outputChatBox ( "#d9534f[D.P] #428bca"..getPlayerName ( p ).." #FFFFFFperdeu o efeito da arma de choque.", c, 255, 255, 255, true)
								end
							end
							tased [ p ] = false
						end, 4000, 1, source, a )
					end
				else
					if ( isPedInVehicle ( cop ) ) then return end 
					outputChatBox ( "#d9534f[D.P] #FFFFFFUse o cacetete para algemar o sugeito e a teaser (pistola silenciada ) para dar choque.", cop, 255, 255, 255 )
				end
			else
				local f = math.floor ( loss * 1.2)
				setElementHealth ( cop, getElementHealth ( cop ) - f )
				outputChatBox ( "#d9534f[D.P] #FFFFFFVocê perdeu "..tostring ( f ).."% de sua via por tentar prender um jogador inocente.", cop, 255, 255, 255, true)
			end
		end	
	end
end )
 
addCommandHandler ( "soltar", function ( p, _, p2 )
	if ( getPlayerTeam ( p ) and exports['VDBGPlayerFunctions']:isTeamLaw ( getTeamName ( getPlayerTeam ( p ) ) ) ) then
		if ( p2 ) then
			local c = getPlayerFromName ( p2 ) or exports['VDBGPlayerFunctions']:getPlayerFromNamePart ( p2 )
			if c then
				if ( arresties[c] ) then
					if ( getElementData ( c, "VDBGJobs:ArrestingOfficer") == p ) then
						outputChatBox ( "#d9534f[D.P] #FFFFFFVocê soltou o "..getPlayerName ( c ), p, 255, 255, 255, true)
						outputChatBox ( "#d9534f[D.P] #FFFFFF".. getPlayerName ( p ).." Tirou você da cadeia.", c, 255, 255, 255, true)
						releasePlayer ( c )
						local arresties2 = { }
						for i, v in pairs ( arresties ) do
							if ( getElementData ( v, "VDBGJobs:ArrestingOfficer" ) == p ) then
								table.insert ( arresties2, v )
							end
						end
						triggerClientEvent ( root, "onPlayerEscapeCop", root, c, p, arresties2 )
					else outputChatBox ( "#d9534f[D.P] #FFFFFFVocê "..getPlayerName ( c ).."'Não tem patente suficiente para tirar alguém da cadeia.", p, 255, 255, 255, true) end
				else outputChatBox ( "#d9534f[D.P] #FFFFFF".. getPlayerName ( c ).." não está sendo preso", p, 255, 255, 255, true) end
			else exports['VDBGMessages']:sendClientMessage ( p2.." não existe. ", p, 255, 255, 255, true) end
		else outputChatBox ( "#d9534f[D.P] #FFFFFFerro de sintaxe. /soltar [jogador]", p, 255, 255, 255, true) end
	else outputChatBox ( "#d9534f[D.P] #FFFFFFVocê não é um agente da lei do VDBG.", p, 255, 255, 255, true) end
end )
local crimscache = {}
function arrestPlayer ( crim, cop )
	showCursor ( crim, true )
	arresties[crim] = true
	toggleControl ( crim, 'right', false )
	toggleControl ( crim, 'left', false )
	toggleControl ( crim, 'forwards', false )
	toggleControl ( crim, 'backwards', false )
	toggleControl ( crim, 'jump', false )
	toggleControl ( crim, 'sprint', false )
	toggleControl ( crim, 'walk', false )
	toggleControl ( crim, 'fire', false )
	onTimer ( crim, cop )
	triggerClientEvent ( root, "onPlayerStartArrested", root, crim, cop )
	crimscache[crim] = {getPlayerAccount ( cop ),getPlayerAccount ( crim ), getElementData ( crim, "WantedPoints" )}
	end

function onTimer ( crim, cop )
	if ( isElement ( crim ) and isElement ( cop ) ) then
		if ( not getPlayerTeam ( cop ) or not exports['VDBGPlayerFunctions']:isTeamLaw ( getTeamName ( getPlayerTeam ( cop ) ) ) ) then return releasePlayer ( crim ) end
		if ( not arresties[crim] ) then return  end
		local cx, cy, cz = getElementPosition ( crim )
		local px, py, pz = getElementPosition ( cop )
		local rot = findRotation ( cx, cy, px, py )
		setPedRotation ( crim, rot )
		setCameraTarget ( crim, crim )
		local dist = getDistanceBetweenPoints3D ( cx, cy, cz, px, py, pz )
		if ( isPedInVehicle ( cop ) ) then
			if ( not isPedInVehicle ( crim ) ) then
				warpPedIntoVehicle ( crim, getPedOccupiedVehicle ( cop ), 1 )
			end
		else
			if ( isPedInVehicle ( crim ) ) then
				removePedFromVehicle ( crim )
			end
		end
		if ( not isPedInVehicle ( crim ) ) then
			if ( dist >= 20 ) then
				setElementPosition ( crim, px +1, py+1, pz )
			elseif ( dist >= 15 ) then
				setControlState ( crim, 'walk', false )
				setControlState ( crim, 'jump', true )
				setControlState ( crim, 'sprint', true )
				setControlState ( crim, "forwards", true )
			elseif ( dist >= 10 ) then
				setControlState ( crim, 'walk', false )
				setControlState ( crim, 'jump', false )
				setControlState ( crim, 'sprint', true )
				setControlState ( crim, "forwards", true )
			elseif ( dist >= 7 ) then
				setControlState ( crim, 'walk', false )
				setControlState ( crim, 'jump', true )
				setControlState ( crim, 'sprint', false )
				setControlState ( crim, "forwards", true )
			elseif ( dist >= 2 ) then
				setControlState ( crim, 'walk', true )
				setControlState ( crim, 'jump', false )
				setControlState ( crim, 'sprint', false )
				setControlState ( crim, "forwards", true )
			else
				setControlState ( crim, 'walk', false )
				setControlState ( crim, 'jump', false )
				setControlState ( crim, 'sprint', false )
				setControlState ( crim, "forwards", false )
			end
		end
		setTimer ( onTimer, 500, 1, crim, cop )
	else
		arresties[crim] = false
		if ( not isElement ( cop ) ) then
			releasePlayer ( crim )
			outputChatBox ( "#d9534f[D.P] #FFFFFFO policia que te deteu saiu portanto, você foi liberado.", crim, 255, 255, 255, true)
		end
		end
	end	




addEventHandler( "onPlayerQuit", getRootElement(),
function() 
	if crimscache[source] then	
		local tempowp = math.floor ( ( crimscache[crim][3] * 2 ) or 10 )
		local tempo = tempowp + 250
		local cashcop = tempowp*2
		local foundPlayer = false;
		for _, p in pairs ( getElementsByType ( "player" ) ) do 
			if ( getAccountName ( getPlayerAccount ( p ) ) == crimscache[source][2] ) then 
				foundPlayer = true;				
				break;
			end 
		end	
		if ( not foundPlayer ) then 
		local q = exports.VDBGSQL:db_query ( "SELECT JailTime FROM accountdata WHERE Username=?", crimscache[source][2] );
			if ( q and q[1] and q[1].JailTime ) then 
				local m = tonumber ( q[1].JailTime ) + tempo
				exports.VDBGSQL:db_exec ( "UPDATE accountdata SET JailTime=? WHERE Username=?", m, crimscache[source][2] );
			end 
				for _, p in pairs ( getElementsByType ( "player" ) ) do 
					if ( getAccountName ( getPlayerAccount ( p ) ) == crimscache[source][1] ) then 
							if ( cashcop ) then
								triggerServerEvent ( "VDBGJobs->GivePlayerMoney", p, p, "Arrests", math.floor ( cashcop ), 15 )
								updateJobColumn ( getAccountName ( getPlayerAccount ( p ) ), "Arrests", "AddOne" )
								outputChatBox ( "#d9534f[D.P] #FFFFFFVocê ganhou R$"..math.floor ( cashcop ).." pois o jogador que você algemou saiu.", p, 255, 255, 255, true)
							end				
					break;
				end 
		end	
		end 
	end
end	)
	

function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
	return t;
end

function releasePlayer ( p )
	toggleAllControls ( p, true )
	setControlState ( p, 'walk', false )
	setControlState ( p, 'jump', false )
	setControlState ( p, 'sprint', false )
	setControlState ( p, "forwards", true )
	setElementData ( p, "VDBGJobs:ArrestingOfficer", nil )
	arresties[p] = nil
	showCursor ( p, false )
end

addEvent ( "vdbgpolice:onJailCopCrimals", true )
addEventHandler ( "vdbgpolice:onJailCopCrimals", root, function ( )
	for v, _ in pairs ( arresties ) do 
		if ( getElementData ( v, "VDBGJobs:ArrestingOfficer" ) == source ) then
			if isPlayerInVehicle ( v ) then
				removePlayerFromVehicle ( v ) 
			end
			releasePlayer ( v )
			local temposs = math.floor (getElementData ( v, "WantedPoints" ) or 0)
			local tempo = temposs * 2
			local orgTime = tempo
			local vip = getElementData ( v, "VIP" )
			if ( exports.VDBGVIP:getVipLevelFromName ( vip ) == 4 ) then
				tempo = tempo - ( tempo * 0.5 )
				outputChatBox ( "#d9534f[D.P] #FFFFFFVocê tem #d9534f50%  #FFFFFFmenos tempo de prisão devido ao  plano do seu VIP! #4aabd0(T:ORIGINAL "..orgTime.." segundos)", v, 255, 255, 255, true)
			elseif ( exports.VDBGVIP:getVipLevelFromName ( vip ) == 3  ) then
				tempo = tempo - ( tempo * 0.25 )
				outputChatBox ( "#d9534f[D.P] #FFFFFFVocê tem #d9534f25%  #FFFFFFmenos tempo de prisão devido ao  plano do seu VIP! #4aabd0(T:ORIGINAL "..orgTime.." segundos)", v, 255, 255, 255, true)
			elseif ( exports.VDBGVIP:getVipLevelFromName ( vip ) == 2 ) then
				tempo = tempo - ( tempo * 0.15 )
				outputChatBox ( "#d9534f[D.P] #FFFFFFVocê tem #d9534f15%  #FFFFFFmenos tempo de prisão devido ao  plano do seu VIP! #4aabd0(T:ORIGINAL "..orgTime.." segundos)", v, 255, 255, 255, true)
			elseif ( exports.VDBGVIP:getVipLevelFromName ( vip ) == 1 ) then
				tempo = tempo - ( tempo * 0.15 )
				outputChatBox ( "#d9534f[D.P] #FFFFFFVocê tem #d9534f5% #FFFFFFmenos tempo de prisão devido ao  plano do seu VIP! #4aabd0(T:ORIGINAL "..orgTime.." segundos)", v, 255, 255, 255, true)
			end
			outputChatBox ( "#d9534f[D.P] #FFFFFFVocê ganhou #acd373R$"..math.floor ( orgTime )..".00 #FFFFFFpor prender #428bca"..getPlayerName ( v ).."!", source, 255, 255, 255, true)
			exports['VDBGPolice']:jailPlayer ( v, tempo, false, source, "Police Arrest" )			
			local tempo = math.floor ( tempo )
			if ( orgTime ) then
			triggerEvent ( "VDBGJobs->GivePlayerMoney", source, source, "prissoes", math.floor ( orgTime ), 30 )
			updateJobColumn ( getAccountName ( getPlayerAccount ( source ) ), "prissoes", "AddOne" )
			end	

			
			local conta = getPlayerAccount ( v )
			local conta1 = getPlayerAccount ( source )
			setAccountData ( conta, "jailPending", 0 ) 
			setAccountData ( conta1, "jailPending", 0 ) 
		end
	end
end )