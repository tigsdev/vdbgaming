local tempData = { }
     
    addEventHandler ( "onPlayerWasted", getRootElement(),
        function ( )
            tempData [ source ] =
                {
                    weapons = getWeaponsTable ( source ),
                    skin = getElementModel ( source )
                }
        end
    )
     
    addEventHandler ( "onPlayerSpawn", getRootElement(),
        function ( )
            if ( tempData [ source ] ) then
                setElementModel ( source, tempData [ source ].skin )
                for weapon, ammo in pairs ( tempData [ source ].weapons ) do
                    giveWeapon ( source, weapon, ammo, true )
                end
            end
        end
    )
     
    function getWeaponsTable ( thePlayer )
        local weapons = { }
        local hasAnyWeapon = false
        for slot = 0, 12 do
            local weapon = getPedWeapon ( thePlayer, slot )
            if ( weapon > 0 ) then
                local ammo = getPedTotalAmmo ( thePlayer, slot )
                if ( ammo > 0 ) then
                    weapons [ weapon ] = ammo
                    hasAnyWeapon = true
                end
            end
        end
        if ( hasAnyWeapon ) then
            return weapons
        end
    end