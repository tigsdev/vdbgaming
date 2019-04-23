zombiehunterpickup55555 = createPickup (1092.5999755859, 2121.6999511719, 15.39999961853, 0, 0, 0 )
function zombiehunterskinpickup55555 ( thePlayer )
  setPedSkin ( thePlayer, 10 )
  setPlayerTeam ( thePlayer, teamzombie )
 setElementData ( thePlayer, "zombie", true  )  
end
addEventHandler ( "onPickupUse", zombiehunterpickup55555, zombiehunterskinpickup55555 )
addEventHandler ("onPickupUse", getRootElement(), 

function (playerWhoUses)
  if (source == zombiehunterpickup55555) then
    setPlayerNametagText (playerWhoUses, "" .. getPlayerName (playerWhoUses))
    setElementData (playerWhoUses, "job", "farm")
  end
end)

