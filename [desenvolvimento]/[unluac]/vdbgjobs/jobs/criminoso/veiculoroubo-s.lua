local locations = {
	-- x, y, z, rotation z
	{ 2481.11, -1947.44, 13.48 },
	{ 1365.44, -640.1, 108.4, -90 },
	{ 1037.28, -724.34, 118.05, 45 },
	{ 684.22, -441.59, 16.34, 93 },
	{ 215.46, -230.01, 1.78, -90 },
	{ 513.48, -116.15, 38.16, 330 },
	{ 1105.34, -307.32, 73.69, -90 },
	
}

local vehicleModels = { 402, 411, 414, 415, 434, 440, 442, 444, 451, 455, 456, 475, 477, 489, 494, 495, 498, 499, 502, 503, 404, 506, 522 }

local crimainlTheftVehicle = nil
local CriminosoTheftBlip = nil
local last_i = 0
local CriminosoTheftVehicleLabel = nil

function makeCriminosoTheftVehicle ( )
	if ( isElement ( crimainlTheftVehicle ) ) then
		if ( getVehicleController ( crimainlTheftVehicle ) ) then return end
		destroyElement ( crimainlTheftVehicle ) 
	end  if ( isElement ( CriminosoTheftBlip ) ) then
		destroyElement ( CriminosoTheftBlip )
	end if ( isElement ( CriminosoTheftVehicleLabel ) ) then
		destroyElement ( CriminosoTheftVehicleLabel )
	end if ( isTimer ( CriminosoVehicleTheftTimer ) ) then
		killTimer ( CriminosoVehicleTheftTimer )
	end

	local i = math.random ( #locations )
	if ( i == last_i  ) then
		while ( i == last_i ) do
			i = math.random ( #locations )
		end
	end
	
	local data = locations[i]
	local carModel = vehicleModels[math.random ( #vehicleModels )]
	
	crimainlTheftVehicle  = createVehicle ( carModel, data[1], data[2], data[3], 0, 0, data[4] )
	CriminosoTheftVehicleLabel = exports.VDBG3DTEXT:create3DText ( 'LADRÃO DE CARROS', { 0, 0, 1 }, { 255, 0, 0 }, crimainlTheftVehicle,  { }, "Criminoso", "PERK")
	
	CriminosoTheftBlip = createBlipAttachedTo ( crimainlTheftVehicle, 56 )
	
	addEventHandler ( "onVehicleStartEnter", crimainlTheftVehicle, function ( p, seat ) if ( seat == 0 ) then if ( not getPlayerTeam ( p ) or getTeamName ( getPlayerTeam ( p ) ) ~= "Criminoso" ) then cancelEvent ( ) outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFEste veículo está trancado!", p, 255, 255, 255, true ) end	 end end )
	
	addEventHandler ( 'onVehicleEnter', crimainlTheftVehicle, function ( p, seat ) if ( seat == 0 ) then 
	local nome = getElementData(p, "AccountData:Name")
	outputTeamMessage ( "#d9534f[CRIMINOSO] #428bca"..nome.." #FFFFFFroubou um "..getVehicleNameFromModel ( getElementModel ( source ) ).."!", "Criminoso", 255, 255, 0 ) 
	outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFDirija este veículo até o marcador disponível em seu mapa; Bandeira em seu mapa.", p, 0, 255, 0 ) 
	triggerClientEvent ( p, 'Criminal:Theft:setWaypointsVisible', p, true ) end end )
	addEventHandler ( 'onVehicleExit', crimainlTheftVehicle, function ( p, seat ) if ( seat == 0 ) then outputTeamMessage ( nome.." Saiu do veículo roubado. ", "Criminoso", 0, 255, 0 ) triggerClientEvent ( p, "Criminal:Theft:setWaypointsVisible", p, false ) end end )
	addEventHandler ( 'onVehicleExplode', crimainlTheftVehicle, function ( ) if ( isElement ( CriminosoTheftBlip ) ) then destroyElement ( CriminosoTheftBlip ) end if ( isElement ( CriminosoTheftVehicleLabel ) ) then destroyElement ( CriminosoTheftVehicleLabel ) end outputTeamMessage ( "O carro roubado: "..getVehicleNameFromModel ( getElementModel ( source ) ).." explodiu", "Criminoso", 255, 0, 0 ) if ( isElement ( crimainlTheftVehicle ) ) then destroyElement ( crimainlTheftVehicle ) end triggerClientEvent ( root, "Criminal:Theft:setWaypointsVisible", root, false )  if ( isTimer ( CriminosoVehicleTheftTimer ) ) then killTimer ( CriminosoVehicleTheftTimer ) end CriminosoVehicleTheftTimer = setTimer ( makeCriminosoTheftVehicle, 1000*math.random ( 200, 500 ), 1 ) end )
	
	local city = getZoneName ( data[1], data[2], data[3], true )
	local area = getZoneName ( data[1], data[2], data[3] )
	local vehName = getVehicleNameFromModel ( carModel )
	for i, v in ipairs ( getPlayersInTeam ( getTeamFromName ( "Criminoso" ) ) ) do
		outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFTiago Santos deixou um "..vehName.." em "..area..", "..city.."! Vá rouba-lo! (ícone de ponto amarelo)", v, 255, 255, 255, true )
	end
end

addEvent ( "Criminal:Theft:onPlayerCaptureVehicle", true )
addEventHandler ( "Criminal:Theft:onPlayerCaptureVehicle", root, function ( )
	if ( isElement ( crimainlTheftVehicle ) ) then
		destroyElement ( crimainlTheftVehicle ) 
	end  if ( isElement ( CriminosoTheftBlip ) ) then
		destroyElement ( CriminosoTheftBlip )
	end if ( isElement ( CriminosoTheftVehicleLabel ) ) then
		destroyElement ( CriminosoTheftVehicleLabel )
	end if ( isTimer ( CriminosoVehicleTheftTimer ) ) then
		killTimer ( CriminosoVehicleTheftTimer )
	end
	local cash = math.random ( 5000, 10000 )
	local nome = getElementData(p, "AccountData:Name")
	outputTeamMessage ( "#d9534f[CRIMINOSO] #428bca"..nome.."#FFFFFFRoubou o Veículo de #428bcaTiago Santos #FFFFFFe ganhou #acd373R$ "..cash..".00", "Criminoso", 255, 255, 255, true )
	outputTeamMessage ( "#d9534f[CRIMINOSO] #428bca"..nome.."#FFFFFFRoubou o Veículo de #428bcaTiago Santos", "Policial", 255, 255, 255, true )
	outputChatBox ( "#d9534f[CRIMINOSO] #FFFFFFVocê está sendo procurado!", source, 255, 255, 255, true )
	
	if ( cash ) then
		triggerServerEvent ( "VDBGJobs->GivePlayerMoney", source, source, "CriminosoActions", cash, 15 )
		updateJobColumn ( getAccountName ( getPlayerAccount ( source ) ), "CriminosoActions", "AddOne" )
	end	
	CriminosoVehicleTheftTimer = setTimer ( makeCriminosoTheftVehicle, 1000*math.random ( 200, 500 ), 1 )
	exports['VDBGLogs']:outputActionLog ( exports.VDBGPlayerfunctions:getPlayerName ( source ).." roubou o carro disponível" )
	giveWantedPoints ( source, math.random ( 70, 150 ) ) 
end )

setTimer ( function ( )
	makeCriminosoTheftVehicle ( )
	CriminosoVehicleTheftTimer = setTimer ( makeCriminosoTheftVehicle, 300000, 0 )
end, 1000, 1 )
