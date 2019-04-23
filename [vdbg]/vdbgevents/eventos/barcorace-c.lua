local track = {
    { 2981.76, -1405.54, 0.66 }, 
    { 2991.91, -1194.95, 0.87 }, 
    { 3012.29, -936.94, 0.88 }, 
    { 3032.09, -655.45, 0.74 }, 
    { 2932.37, -422.75, 0.83 }, 
    { 2934.4, -139.13, 0.89 }, 
    { 3005.67, 286.5, 0.69 }, 
    { 2898.97, 389.87, 0.87 }, 
    { 2749.31, 445.45, 0.73 }, 
    { 2315.99, 487.9, 0.79 }, 
    { 1856.94, 506.37, 0.85 }, 
    { 1574.2, 496.97, 0.7 }, 
    { 1223.23, 601.35, 0.83 }, 
    { 972.32, 586.35, 0.89 }, 
    { 664.79, 539.47, 0.81 }, 
    { 400.73, 408.58, 0.73 }, 
    { 67.69, 241.64, 0.74 }, 
    { -195.36, 370.8, 0.78 }, 
    { -549.17, 356.96, 0.7 }, 
    { -759.69, 425.48, 0.84 }, 
    { -984.45, 591.14, 0.87 }, 
    { -1151.51, 777.79, 0.86 }, 
    { -1277.74, 1016.74, 0.84 }, 
    { -1490.83, 1350.05, 0.84 }, 
    { -1569.8, 1468.14, 0.86 }, 
    { -1724.95, 1703.06, 0.87 }, 
    { -1844.68, 1905.12, 0.83 }, 
    { -1967.9, 2027.1, 0.79 }, 
    { -2211.01, 2113.85, 0.86 }, 
    { -2355.58, 2247.83, 0.68 }, 
    { -2411.7, 2309.53, 0.71 }, 
}
addEvent ( "VDBGEvents:Modules->BARCOStreetRace:CreateCheckpoints", true )
addEventHandler ( "VDBGEvents:Modules->BARCOStreetRace:CreateCheckpoints", root, function ( f, d )
	if ( f == "CreateElements" ) then
		RaceTableIndex = 1
		RaceDimension = d
		if ( isElement ( BARCOTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", BARCOTrackMarker, OnBARCORaceMarkerHit )
			destroyElement ( BARCOTrackMarker )
			destroyElement ( BARCOTrackBlip )
		end
		BARCORace_LoadMarkerId ( 1 )
	else
		if ( isElement ( BARCOTrackMarker ) ) then
			removeEventHandler ( "onClientMarkerHit", BARCOTrackMarker, OnBARCORaceMarkerHit )
			destroyElement ( BARCOTrackMarker )
			destroyElement ( BARCOTrackBlip )
		end
	end
end )

function BARCORace_LoadMarkerId ( i, isWin )
	if ( isElement ( BARCOTrackMarker ) ) then
		removeEventHandler ( "onClientMarkerHit", BARCOTrackMarker, OnBARCORaceMarkerHit )
		destroyElement ( BARCOTrackMarker )
		destroyElement ( BARCOTrackBlip )
	end
	local x, y, z = track[i][1], track[i][2], track[i][3]
	if ( not isWin ) then
		BARCOTrackBlip = createBlip ( x, y, z, 0, 3, 255, 255, 0 )
		BARCOTrackMarker = createMarker ( x, y, z, "checkpoint", 9, 255, 255, 0, 120 )
	else
		BARCOTrackBlip = createBlip ( x, y, z, 0, 3, 0, 255, 0 )
		BARCOTrackMarker = createMarker ( x, y, z, "checkpoint", 9, 0, 255, 0, 120 )
	end
	
	setElementDimension ( BARCOTrackMarker, RaceDimension )
	setElementDimension ( BARCOTrackBlip, RaceDimension )
	addEventHandler ( "onClientMarkerHit", BARCOTrackMarker, OnBARCORaceMarkerHit )
end

function OnBARCORaceMarkerHit ( p )
	if ( p and p == localPlayer ) then
		RaceTableIndex = RaceTableIndex + 1
		if ( RaceTableIndex > #track ) then
			ThisPlayerWinsRace ( )
			return
		end
		
		BARCORace_LoadMarkerId ( RaceTableIndex, RaceTableIndex == #track )
		
	end
end 

function ThisPlayerWinsRace  ( )
	triggerServerEvent ( "VDBGEvents:Modules->BARCORace:ThisPlayerWinsRace", localPlayer )
end