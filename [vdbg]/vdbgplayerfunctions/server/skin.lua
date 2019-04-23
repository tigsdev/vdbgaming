function onPlayerQuit ( )
      local playeraccount = getPlayerAccount ( source )
      if ( playeraccount ) then
            local playerskin = getPedSkin ( source )
            setAccountData ( playeraccount, "skin", playerskin )
      end
end
 
function onPlayerJoin ( )
      local playeraccount = getPlayerAccount ( source )
      if ( playeraccount ) then
            local playerskin = getAccountData ( playeraccount, "skin" )
            if ( playerskin ) then
                  setPedSkin ( source, playerskin )
            end
      end
end
 
function onPlayerSpawn ( )
      local playeraccount = getPlayerAccount ( source )
      if ( playeraccount ) then
            local playerskin = getAccountData ( playeraccount, "skin" )
            if ( playerskin ) then
                  setPedSkin ( source, playerskin )
            end
      end
end
 
function onPlayerWasted ( )
      local playeraccount = getPlayerAccount ( source )
      if ( playeraccount ) then
            local playerskin = getPedSkin ( source )
            setAccountData ( playeraccount, "skin", playerskin )
      end
end
 
addEventHandler ( "onPlayerQuit", getRootElement ( ), onPlayerQuit )
addEventHandler ( "onPlayerJoin", getRootElement ( ), onPlayerJoin )
addEventHandler ( "onPlayerSpawn", getRootElement ( ), onPlayerSpawn )
addEventHandler ( "onPlayerWasted", getRootElement ( ), onPlayerWasted )