addCommandHandler ( "cc", function ( p, _, ... )
	if ( isPlayerMuted ( p ) ) then
		return exports['VDBGMessages']:sendClientMessage ( "Você está mutado.", p, 255, 0, 0 )
	end
	if ( isPedInVehicle ( p ) ) then
		if ( ... ) then
			local car = getPedOccupiedVehicle ( p )
			if ( car ) then
				local msg = table.concat ( { ... }, " " )
				local pN = exports['VDBGChat']:getPlayerTags(p)..getPlayerName(p):gsub ( "#%x%x%x%x%x%x", "" )
				outputChatBox ( "(CHAT VEICULAR)"..pN..": #ffffff"..msg, p, 255, 0, 130, true )
				for seat, player in ipairs ( getVehicleOccupants ( car ) ) do
					outputChatBox ( "(CHAT VEICULAR)"..pN..": #ffffff"..msg, player, r, g, b, true )
				end
			end
		else
			outputChatBox ( "Comando: /cc [mensagem]", p, 255, 0, 100 )
		end
	else
		outputChatBox ( "Você não está em um veículo.", p, 255, 0, 100 )
	end
end )
