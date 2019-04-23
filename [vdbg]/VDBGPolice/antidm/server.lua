local jailTimes = { 100, 200, 300, 400, 900 }

addEvent ( "VDBGAntiDM->Modulos->Punicao", true )
addEventHandler ( "VDBGAntiDM->Modulos->Punicao", root, function ( killer )
		local client = client or source
		local conta = getPlayerAccount(killer)
		local quantiadm = tonumber( getAccountData(conta, "numerosdm") or 0 )
			if (conta) then
					if ( killer ) and ( killer ~= client ) then
						if  isPedInVehicle(killer) then
							destroyElement( getPedOccupiedVehicle(killer) )
						end
					end
					local DMs = quantiadm + 1
					local jailTime = jailTimes[ DMs ]
					if type(jailTime) == "number" then
						exports['VDBGPolice']:jailPlayer ( killer, jailTime, false, "Police Arrest" )
						exports.VDBGMessages:sendClientMessage ( "O jogador "..getElementData(killer, "AccountData:Name").." foi preso por matar "..getElementData(client, "AccountData:Name").." em Los Santos ( DM )", root, 255, 120, 0 )
						givePlayerMoney ( client, 2000 )
					else
						kickPlayer ( killer, "VDBG:AUTO-ADMIN MATANDO EM LS (6 VEZ)" )
						exports.VDBGMessages:sendClientMessage ( "O jogador "..getElementData(killer, "AccountData:Name").." foi kickado por matar "..getElementData(client, "AccountData:Name").." em Los Santos ( DM )", root, 255, 120, 0 )
						givePlayerMoney ( client, 2000 )
					end
					setAccountData ( conta, "numerosdm", tostring(DMs) )
		end
end
)


addEvent ( "VDBGAntiDM->Modulos->Punicao1", true )
addEventHandler ( "VDBGAntiDM->Modulos->Punicao1", root, function ( killer )
		if not isElement(killer) then return end
		local client = client or source
		local x, y, z = getElementPosition ( killer )
		local conta = getPlayerAccount(killer)
		local quantiadm = tonumber( getAccountData(conta, "numerosdm") or 0 )
			if (conta) then
				if ( getZoneName ( x, y, z, true ) == "Los Santos" ) then 
					local sourceTeam = getPlayerTeam(client)
					local killerTeam = getPlayerTeam(killer)
					
					if (sourceTeam and getTeamName(sourceTeam) == "Policial" and
					killerTeam and getTeamName(killerTeam) == "Criminoso") then return end	
					if (sourceTeam and getTeamName(sourceTeam) == "Criminoso" and
					killerTeam and getTeamName(killerTeam) == "Policial") then return end
					
					triggerClientEvent(client, "DMPanel:OnRequestPunishWindow", client, killer)
				end
		end
end
)


addEventHandler( "onPlayerWasted", root,
	function (_, attacker)
		if attacker then
			if getElementType(attacker) == "vehicle" then
				attacker = getVehicleController(attacker)
			end
			triggerEvent( "VDBGAntiDM->Modulos->Punicao1", source, attacker )
		end
	end
)

addEventHandler( "onPlayerLogin", getRootElement(),
	function (_, account)
		if not getAccountData(account, "numerosdm") then
			setAccountData ( account, "numerosdm", "0" )
		end
	end
)