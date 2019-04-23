addEvent ( "VDBGWarpManager->SetPlayerPositionInteriorDimension", true )
addEventHandler ( "VDBGWarpManager->SetPlayerPositionInteriorDimension", root, function ( x, y, z, int, dim )
	setElementPosition ( source, x, y, z )
	source.dimension = dim
	source.interior = int
end )