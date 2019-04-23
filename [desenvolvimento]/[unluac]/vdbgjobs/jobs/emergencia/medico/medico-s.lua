addEvent ( "VDBGJobs:Medic.onPlayerHealPlayer", true )
addEventHandler ( "VDBGJobs:Medic.onPlayerHealPlayer", root, function ( client, Medico ) 
	if ( getElementHealth ( client ) >= 95 ) then
		setElementHealth ( client, 100 )
		return outputChatBox ( "#d9534f[MEDICO] #FFFFFFEste jogador está com vida cheia.", Medico, 255, 255, 255, TRUE)
	end
	if ( getElementHealth ( client ) < 100 ) then
		setElementHealth ( client, getElementHealth ( client ) + 10 )
		if ( getElementHealth ( client ) >= 100 ) then
			setElementHealth ( client, 100 )
				triggerServerEvent ( "VDBGJobs->GivePlayerMoney", Medico, Medico, "playerscurado", 250, 25 )
				updateJobColumn ( getAccountName ( getPlayerAccount ( Medico ) ), "playerscurado", "AddOne" )
		end
	end
end )