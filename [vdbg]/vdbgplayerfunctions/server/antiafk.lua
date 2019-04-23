local pegasetalogado = false
local max_time = 20		-- Minutes

addEvent ( "onClientPlayerLogin", true )
addEventHandler ( "onClientPlayerLogin", root, function ( )
	pegasetalogado = true
end )

setTimer ( function ( )
	local max_milsecs = ( max_time * 60 ) * 1000
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		if ( not exports.VDBGAdministration:isPlayerStaff ( v ) ) then
		if ( pegasetalogado == false ) then return end
			local idle = getPlayerIdleTime ( v )
			if ( idle > max_milsecs ) then
				kickPlayer ( v, "VDBG:RPG - Você foi kickado por ficar AFK ( 20 AUZENTE )." )
			elseif ( idle > max_milsecs ) then
				outputChatBox ( "#d9534f[VDBG.ORG] #ffffffPor favor, mova-se ou será kickado em: #ffa500".. math.floor ( ( max_milsecs - idle ) / 1000 ).." #ffffffsegundos a partir de agora.", v, 255, 255, 255, true ) 
			end
		end
	end
end, 5000, 0 )