local locations = {
	{ -2078.4, 1419.06, 7.31 },
	{ -1975.6, 1227.14, 31.83 },
	{ -2285.64, -12.7, 35.53 },
	{ -2147.59, -139.86, 36.73 },
	{ -2035.11, -43.72, 35.65 },
	{ -2120.84, -4.27, 35.53 },
	{ -2053.64, 82.59, 28.6 },
	{ -1917.56, 82.59, 28.6 },
	{ -1481, 686.4, 1.32 },
	{ 2090.35, -1552.9, 13.31 },
	{ 2343.57, -1938.85, 13.56 },
	{ 2659.15, -2043.57, 13.55 },
}

function makeWeaponCrate ( )
	if ( isElement ( criminalWeaponMarker ) ) then
		removeEventHandler ( "onMarkerHit", criminalWeaponMarker, oncriminalHitWeaponPickup )
		destroyElement ( criminalWeaponMarker )
	end if ( isElement ( criminalWeaponText ) ) then
		destroyElement ( criminalWeaponText )
	end if ( isElement ( criminalWeaponBlip ) ) then
		destroyElement ( criminalWeaponBlip )
	end if ( isElement ( criminalWeaponCrate ) ) then
		destroyElement ( criminalWeaponCrate )
	end
	
	local pos = locations[math.random(#locations)]
	local x,y,z = unpack ( pos )
	criminalWeaponMarker = createMarker ( x, y, z - 1.3, "cylinder", 2, 255, 50, 50, 120 )
	criminalWeaponBlip = createBlip ( x, y, z, 37, 2, 255, 255, 255, 255, 0, 350 )
	criminalWeaponCrate = createObject (2977, x, y, z-1.4 )
	criminalWeaponText = exports.VDBG3DTEXT:create3DText ( 'PERK', { x, y, z }, { 255, 0, 0 }, { nil, true },  { }, "Criminoso", "PEAK")
	outputTeamMessage ( "Há uma caixa de armas disponível para conquistar em "..getZoneName ( x, y, z )..", "..getZoneName ( x, y, z, true )..". (Ponto de '?' no mapa.)", "Criminoso", 255, 50,  50 )
	addEventHandler ( "onMarkerHit", criminalWeaponMarker, oncriminalHitWeaponPickup )
end

function oncriminalHitWeaponPickup ( p )
	if ( p and getElementType ( p ) == 'player' and not isPedInVehicle ( p ) ) then
		local team = getPlayerTeam ( p )
		if team and getTeamName ( team ) == "Criminoso" then
		
			if ( isElement ( criminalWeaponMarker ) ) then
				removeEventHandler ( "onMarkerHit", criminalWeaponMarker, oncriminalHitWeaponPickup )
				destroyElement ( criminalWeaponMarker )
			end if ( isElement ( criminalWeaponText ) ) then
				destroyElement ( criminalWeaponText )
			end if ( isElement ( criminalWeaponBlip ) ) then
				destroyElement ( criminalWeaponBlip )
			end if ( isElement ( criminalWeaponCrate ) ) then
				destroyElement ( criminalWeaponCrate )
			end
			
			local weaponID = math.random ( 22, 34 )
			local ammo = math.random ( 400, 3000 )
			local nome = getElementData(p, "AccountData:Name")
			outputTeamMessage ( nome.." Pegou o peak de armas com um(a) "..getWeaponNameFromID ( weaponID ).." com a quantia de "..ammo.." balas!", "Criminoso", 255, 50, 50 )
			giveWeapon ( p, weaponID, ammo )
			giveWantedPoints ( p, 70 )	
		else
			exports['VDBGMessages']:sendClientMessage ( "Esta caixa de armas é só para os criminosos.", p, 255, 50, 50 )
		end
	end
end
setTimer ( makeWeaponCrate, 1000, 1 )
setTimer ( makeWeaponCrate, 350000, 0 )

--[[
 2977
 3798
 944
 2912
 == 3014
 ]]