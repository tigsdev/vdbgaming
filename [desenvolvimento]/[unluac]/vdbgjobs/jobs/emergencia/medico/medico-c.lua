addEventHandler ( "onClientPlayerDamage", root, function ( att, weap, loss )
	if ( isElement ( att ) and weap and att == localPlayer and source ~= localPlayer ) then
		local job = tostring ( getElementData ( att, "Job" ) or "" )
		if ( job == "Medico" and weap == 14 ) then
			cancelEvent ( )
			setElementHealth ( source, getElementHealth ( source ) + loss )
			triggerServerEvent ( "VDBGJobs:Medic.onPlayerHealPlayer", localPlayer, source, att )
		end
	end
end )