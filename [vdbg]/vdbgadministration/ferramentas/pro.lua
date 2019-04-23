addCommandHandler ( "pro", function ( p )
	if ( isPlayerStaff ( p ) ) then
		local st, lvl = getPlayerStaffLevel ( p, 'both' )
		if ( lvl >= 5 ) then
			setElementModel ( p, 217 )
		else
			setElementModel ( p, 0 )
		end
		setElementData ( p, "Job", "Staff" )
		setElementData ( p, "Job Rank", tostring ( st ) )
		exports['VDBGPlayerFunctions']:setTeam ( p, 'Administração' )
		exports['VDBGlogs']:outputActionLog ( getPlayerName ( p ).." está como admih" )
	end
end )
