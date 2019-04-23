local StuntText = ""
local StuntTextStart = getTickCount ( )
local sx, sy = guiGetScreenSize ( )
local allowedTypes =  { ['quad'] = true, ['bmx'] = true, ['bike'] = true }


addEventHandler ( "onClientRender", root, function ( )
	if ( StuntText ~= "" ) then
		if ( getTickCount ( ) - StuntTextStart < 7000 ) then
			dxDrawText ( StuntText:gsub ( "#%x%x%x%x%x%x", "" ), 0, 0, sx, sy / 1.3, tocolor ( 0, 0, 0, 255 ), 1.5, "default-bold", "center", "bottom" )
			dxDrawText ( StuntText, 2, 2, sx, sy / 1.3, tocolor ( 255, 255, 255, 255 ), 1.5, "default-bold", "center", "bottom", false, false, false, true )
		else
			StuntText = ""
		end
	end
end )



addEventHandler( "onClientPlayerStuntFinish", getRootElement( ), function ( stunt, stuntTime, distance )
	money = nil
	if ( source ~= localPlayer ) then return end
	if ( getElementData ( localPlayer, "Job" ) ~= "Stunter" ) then return end
	local c = getPedOccupiedVehicle ( localPlayer ) 
	if ( not c ) then return end
	if ( not allowedTypes [ string.lower ( getVehicleType ( c ) ) ] ) then return end
	local seconds = math.floor ( stuntTime / 1000 )
	
	if ( seconds >= 40 ) then
		StuntText = "#FF0000Abuso detectado!"
		StuntTextStart = getTickCount ( )
		return
	end
	
	if ( seconds >= 2 and distance == 0 ) then
		money = seconds * 10
		StuntText = "Você fez um "..tostring(stunt).." que durou "..tostring(seconds).." segundos! #00ff00+ R$"..money
	elseif ( seconds > 0 and distance > 0 ) then
		money = ( seconds * 10 ) + ( distance * 3 )
		StuntText = "Você fez um "..tostring(stunt).." que durou "..tostring(seconds).." segundos e "..tostring(distance).." metros! #00ff00+ R$"..money
	end
	
	if ( money ) then
		triggerServerEvent ( "VDBGJobs->GivePlayerMoney", localPlayer, localPlayer, "stunts", money, 1 )
		triggerServerEvent ( "VDBGJobs->SQL->UpdateColumn", localPlayer, localPlayer, "stunts", "AddOne" )
		StuntTextStart = getTickCount ( )
	end
end )


