exports['Scoreboard']:scoreboardAddColumn ( "Dinheiro" );

for i, v in ipairs ( getElementsByType ( "player") ) do 
	if ( not getElementData ( v, "Dinheiro")) then
		setElementData ( v, "Dinheiro", "R$0" )
	end
end

addEventHandler ( "onPlayerJoin", root, function ( )
	setElementData ( source, "Dinheiro", "R$0" )
end )

addEventHandler ( "onPlayerLogin", root, function ( )
	setTimer ( function ( p )
		if ( isElement ( p )) then
			setElementData ( p, "Dinheiro", "R$"..convertNumber ( getPlayerMoney ( p ) ) )
		end 
	end, 1000, 1, source )
end )

setTimer ( function ( )
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		setElementData ( v, "Dinheiro", "R$"..convertNumber ( getPlayerMoney ( v ) ) )
	end
end, 5000, 0 )



function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end