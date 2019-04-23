function spawnOnJoin ( )    
givePlayerMoney ( source, 100 )

end

function setMoneyOnWasted ( )    
givePlayerMoney ( source, -50 )

end

function rewardOnWasted ( ammo, killer, killerweapon, bodypart )

	if ( killer ) and ( killer ~= source ) then
		givePlayerMoney ( killer, 100 )
    end
end
addEventHandler ( "onPlayerWasted", getRootElement(), rewardOnWasted )
addEventHandler ( "onPlayerWasted", getRootElement(), setMoneyOnWasted )
addEventHandler ( "onPlayerJoin", getRootElement(), spawnOnJoin )