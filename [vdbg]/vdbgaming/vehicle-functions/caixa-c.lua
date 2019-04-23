------------------------------------------
-- Author: xXMADEXx						--
-- Name: 3D Speakers 2.0				--
-- File: client.lua						--
-- Copyright 2013 ( C ) Braydon Davis	--
------------------------------
-- Variables				--
------------------------------
local subTrackOnSoundDown = 0.1	-- The volume that goes down, when the player clicks "Volume -"
local subTrackOnSoundUp = 0.1	-- The volume that goes up, when the player clicks "Volume +"


function print ( message, r, g, b )
	exports.VDBGmessages:sendClientMessage ( message, r, g, b )
end

------------------------------
-- The GUI					--
------------------------------
local rx, ry = guiGetScreenSize ( )
button = { }
window = guiCreateWindow( ( rx - 295 ), ( ry / 2 - 253 / 2 ), 293, 253, "Caixa de SOM", false)
guiWindowSetSizable(window, false)
guiSetVisible ( window, false )
CurrentSpeaker = guiCreateLabel(8, 33, 254, 17, "Você ja tem uma caixa de som: Não", false, window)
volume = guiCreateLabel(10, 50, 252, 17, "Volume Atual: 100%", false, window)
guiCreateLabel(11, 81, 251, 15, "URL:", false, window)
--url = guiCreateEdit(11, 96, 272, 23, "", false, window)  
url = guiCreateEdit(11, 96, 272, 23, "Coloque a URL Aqui!", false, window)  
button["place"] = guiCreateButton(9, 129, 274, 20, "Criar Caixa de Som", false, window)
button["remove"] = guiCreateButton(9, 159, 274, 20, "Destruir Caixa de SOM", false, window)
button["v-"] = guiCreateButton(9, 189, 128, 20, "Volume -", false, window)
button["v+"] = guiCreateButton(155, 189, 128, 20, "Volume +", false, window)
button["close"] = guiCreateButton(9, 219, 274, 20, "Sair", false, window)  

--------------------------
-- My sweet codes		--
--------------------------
local isSound = false
addEvent ( "onPlayerViewSpeakerManagment", true )
addEventHandler ( "onPlayerViewSpeakerManagment", root, function ( current )
	local toState = not guiGetVisible ( window ) 
	guiSetVisible ( window, toState )
	showCursor ( toState ) 
	if ( toState == true ) then
		guiSetInputMode ( "no_binds_when_editing" )
		local x, y, z = getElementPosition ( localPlayer )
		guiSetText ( pos, "X: "..math.floor ( x ).." | Y: "..math.floor ( y ).." | Z: "..math.floor ( z ) )
		if ( current ) then guiSetText ( CurrentSpeaker, "Você ja tem uma caixa de som: Sim" ) isSound = true
		else guiSetText ( CurrentSpeaker, "Você ja tem uma caixa de som: Não" ) end
	end
end )

addEventHandler ( "onClientGUIClick", root, function ( )
	if ( source == button["close"] ) then
		guiSetVisible ( window, false ) 
		showCursor ( false )
	elseif ( source == button["place"] ) then
		if ( isURL ( ) ) then
			triggerServerEvent ( "onPlayerPlaceSpeakerBox", localPlayer, guiGetText ( url ), isPedInVehicle ( localPlayer ) )
			guiSetText ( CurrentSpeaker, "Você ja tem uma caixa de som: Sim" )
			isSound = true
			guiSetText ( volume, "Volume Atual : 100%" )
		else
			print ( "Você precisa inserir uma URL.", 255, 0, 0 )
		end
	elseif ( source == button["remove"] ) then
		triggerServerEvent ( "onPlayerDestroySpeakerBox", localPlayer )
		guiSetText ( CurrentSpeaker, "Você ja tem uma caixa de som: Não" )
		isSound = false
		guiSetText ( volume, "Volume Atual : 100%" )
	elseif ( source == button["v-"] ) then
		if ( isSound ) then
			local toVol = math.round ( getSoundVolume ( speakerSound [ localPlayer ] ) - subTrackOnSoundDown, 2 )
			if ( toVol > 0.0 ) then
				print ( "Volume : "..math.floor ( toVol * 100 ).."%!", 0, 255, 0 )
				triggerServerEvent ( "onPlayerChangeSpeakerBoxVolume", localPlayer, toVol )
				guiSetText ( volume, "Volume Atual: "..math.floor ( toVol * 100 ).."%" )
			else
				print ( "O Volume está no mínimo.", 255, 0, 0 )
			end
		end
	elseif ( source == button["v+"] ) then
		if ( isSound ) then
			local toVol = math.round ( getSoundVolume ( speakerSound [ localPlayer ] ) + subTrackOnSoundUp, 2 )
			if ( toVol < 1.1 ) then
				print ( "Volume : "..math.floor ( toVol * 100 ).."%!", 0, 255, 0 )
				triggerServerEvent ( "onPlayerChangeSpeakerBoxVolume", localPlayer, toVol )
				guiSetText ( volume, "Volume Atual: "..math.floor ( toVol * 100 ).."%" )
			else
				print ( "O Volume está no Máximo!", 255, 0, 0 )
			end
		end
	end
end )

speakerSound = { }
addEvent ( "onPlayerStartSpeakerBoxSound", true )
addEventHandler ( "onPlayerStartSpeakerBoxSound", root, function ( who, url, isCar )
	if ( isElement ( speakerSound [ who ] ) ) then destroyElement ( speakerSound [ who ] ) end
	local x, y, z = getElementPosition ( who )
	speakerSound [ who ] = playSound3D ( url, x, y, z, true )
	setSoundVolume ( speakerSound [ who ], 1 )
	setSoundMinDistance ( speakerSound [ who ], 15 )
	setSoundMaxDistance ( speakerSound [ who ], 20 )
	if ( isCar ) then
		local car = getPedOccupiedVehicle ( who )
		attachElements ( speakerSound [ who ], car, 0, 5, 1 )
	end
end )

addEvent ( "onPlayerDestroySpeakerBox", true )
addEventHandler ( "onPlayerDestroySpeakerBox", root, function ( who ) 
	if ( isElement ( speakerSound [ who ] ) ) then 
		destroyElement ( speakerSound [ who ] ) 
	end
end )

--------------------------
-- Volume				--
--------------------------
addEvent ( "onPlayerChangeSpeakerBoxVolumeC", true )
addEventHandler ( "onPlayerChangeSpeakerBoxVolumeC", root, function ( who, vol ) 
	if ( isElement ( speakerSound [ who ] ) ) then
		setSoundVolume ( speakerSound [ who ], tonumber ( vol ) )
	end
end )

function isURL ( )
	if ( guiGetText ( url ) ~= "" ) then
		return true
	else
		return false
	end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end
