local locs = {
	{ 1072.6, -1385.51, 13.88, 139 }
}

local peds = { }
for i, v in ipairs ( locs ) do
	local x, y, z, rot = unpack ( v )
	peds[i] = createPed ( 57, x, y, z, rot )
	exports.VDBGJobs:create3DText ( "Loterica", { x, y, z }, { 255, 255, 0 }, nil, { } )
	local blip = createBlip( x, y, 2, 52, 0, 0, 0, 0, 0, 0, 250)
	outputDebugString("Blip visible distance: "..getBlipVisibleDistance(blip))
	setBlipVisibleDistance(blip, 150) -- 150 é a distancia perfeita
	setElementFrozen ( peds[i], true )
	addEventHandler ( "onClientPedDamage", peds[i], cancelEvent )


	local m = createMarker ( x, y, z - 1, "cylinder", 1.5, 0, 0, 0, 0 )
	addEventHandler ( "onClientMarkerHit", m, function ( p ) 
		if ( p == localPlayer and not isPedInVehicle ( p ) and not isElement ( window ) ) then
			createLotteryGUI ( )
		end
	end )
end



--------------------------
-- GUI					--
--------------------------
local sx, sy = guiGetScreenSize ( )
function createLotteryGUI ( )
	window = guiCreateWindow((sx/2-373/2), (sy/2-158/2), 373, 158, "Leterica", false)
	guiWindowSetSizable(window, false)
	lbl1 = guiCreateLabel(94, 26, 264, 21, "Escolha um número entre 1 e 80.", false, window)
	lbl2 = guiCreateLabel(94, 47, 264, 44, "Carregando banco de dados..", false, window)
	num = guiCreateEdit(94, 91, 162, 28, "", false, window)
	img = guiCreateStaticImage(14, 47, 70, 65, ":VDBGLottery/icon.png", false, window)
	buy = guiCreateButton(256, 91, 58, 28, "Comprar", false, window)
	exit  = guiCreateButton(320, 91, 58, 28, "Fechar", false, window)
	lbl4 = guiCreateLabel(93, 123, 163, 21, "Bilhete tem o custo de R$ 100,00", false, window)    
	addEventHandler ( "onClientGUIClick", root, onClientGUIModify )
	showCursor ( true )
	triggerServerEvent ( "VDBGLotter->onClientRequestTimerDetails", localPlayer )
end

addEvent ( "VDBGLottery->onServerSendClientTimerDetails", true )
addEventHandler ( "VDBGLottery->onServerSendClientTimerDetails", root, function ( t ) 
	guiSetText ( lbl2, "Próximo sorteio será em\n"..tostring ( t ) )
end )

function onClientGUIModify( )
	local e = tostring ( eventName ):lower ( )
	if ( e == "onclientguiclick" ) then
		if ( source == buy ) then
			local n = tonumber ( guiGetText ( num ) )
			if ( n and n >= 1 and n <= 80 ) then
				triggerServerEvent ( "VDBGLottery->onClientAttemptToBuyLotteryTicket", localPlayer, n )
				destroyElement ( window )
				showCursor ( false )
				removeEventHandler ( "onClientGUIClick", root, onClientGUIModify )
			else
				return exports.VDBGMessages:sendClientMessage ( "\""..tostring ( n ) .."\" é um número inválido.", 255, 255, 0 )
			end
		elseif ( source == exit ) then
			destroyElement ( window )
			showCursor ( false )
			removeEventHandler ( "onClientGUIClick", root, onClientGUIModify )
		end
	end
end
