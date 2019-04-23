--[[addEventHandler ( "onPlayerWasted", root,
    function( totalAmmo, killer, killerWeapon, bodypart, stealth )
        if killer then
            local account = getPlayerAccount ( killer )
            if killer ~= source then
                setAccountData( account,"totalkillsdeaths.Kills",tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) or 0 ) +1 )
                setElementData( killer, "Matou", tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) ) )
            end 
        else
            local accountSource = getPlayerAccount ( source )
            setAccountData( accountSource,"totalkillsdeaths.Deaths",tonumber( getAccountData(accountSource,"totalkillsdeaths.Deaths") or 0 ) +1 )
            setElementData( source, "Morreu", tonumber( getAccountData( accountSource,"totalkillsdeaths.Deaths" ) ) )
        end
    end
)      
 
addEventHandler( "onPlayerLogin",root,
    function( thePreviousAccount, theCurrentAccount, autoLogin )
        local account = getPlayerAccount ( source )
        if not getAccountData( account,"totalkillsdeaths.Kills" ) and not getAccountData( account,"totalkillsdeaths.Deaths" ) then
            setAccountData( account,"totalkillsdeaths.Kills",0 )
            setAccountData( account,"totalkillsdeaths.Deaths",0 )
        end
        setElementData( source,"Morreu",tonumber( getAccountData( account,"totalkillsdeaths.Deaths" ) or 0 ) )
        setElementData( source,"Matou",tonumber( getAccountData( account,"totalkillsdeaths.Kills" ) or 0 ) )
    end
 )
 
addEventHandler( "onResourceStart",resourceRoot,
    function( )
        outputDebugString( "add Total Kills to scoreboard Return: "..tostring(
            call( getResourceFromName("Scoreboard"), "addScoreboardColumn", "Matou",root,2, 0.100 )
        ) )
        outputDebugString( "add Total Deaths to scoreboard Return: "..tostring(
            call( getResourceFromName("Scoreboard"), "addScoreboardColumn", "Morreu",root,3, 0.100 )
        ) )
    end
)]]
 