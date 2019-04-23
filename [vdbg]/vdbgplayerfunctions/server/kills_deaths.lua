addEventHandler ( "onPlayerWasted", root, function ( _, killer )
	local d = tonumber ( getElementData ( source, "VDBGSQL:Deaths" ) ) or 0
	setElementData ( source, "VDBGSQL:Deaths", d + 1 )
	if ( isElement ( killer ) ) then
		local k = tonumber ( getElementData ( killer, "VDBGSQL:Kills" ) ) or 0
		setElementData ( killer, "VDBGSQL:Kills", k + 1 )
	end
end )