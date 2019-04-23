local Fisherman = { GUI = {}, GUI2 = {} }
local sx, sy = guiGetScreenSize ( )
Fisherman.GUI.window = guiCreateWindow( ( sx / 2 - 437 / 2 ), ( sy / 2 - 340 / 2 ), 437, 340, "Minhas Capturas", false)
guiWindowSetSizable(Fisherman.GUI.window, false)
guiSetVisible ( Fisherman.GUI.window, false )
Fisherman.GUI.list = guiCreateGridList(9, 26, 420, 254, false, Fisherman.GUI.window)
guiGridListAddColumn(Fisherman.GUI.list, "Item", 0.5)
guiGridListAddColumn(Fisherman.GUI.list, "Quantidade", 0.2)
guiGridListAddColumn(Fisherman.GUI.list, "Vale", 0.2)
guiGridListSetSortingEnabled ( Fisherman.GUI.list, false )
Fisherman.GUI.close = guiCreateButton(286, 290, 143, 41, "Fechar", false, Fisherman.GUI.window)

local fisherman_maxCatch = 10
local fisherman_nextCatchTick = nil

local shopLocations = {
	{ 2109.32, -102.33, 0.89 },
	{ 176, -1897.42, -1.27 }
}

local fisherman_itemsToCatch = { 
	["ABRAMITES "]=300, 
	["ACARA BANDEIRA"]=100, 
	["ACARA DISCO"]=480, 
	["ACARA MOZAIC"]=560, 
	["ACARA PIGEON "]=320, 
	["ELECTRIC BLUE"]=390,
	["ESPADA"]=260,
	["BOTA"]=0, 
	["CORAL"]=200, 
	["ALGA"]=20 
}

function fisherman_onSellMarkerHit ( p )
	if ( p ~= localPlayer ) then 
		return
	end
	if ( getElementData ( p, "Job" ) ~= "Fisherman" ) then
		return outputChatBox ( "#d9534f[PESCADOR] #FFFFFFVocê não é um pescador",255, 255, 255, true )
	end
	if ( isPedInVehicle ( p ) ) then
		return outputChatBox ( "#d9534f[PESCADOR] #FFFFFFVocê não pode estar em um veículo para vender seus produtos",255, 255, 255, true )
	end
	
	if ( fisherman_getClientCatchTotal ( ) == 0 ) then
		return outputChatBox ( "#d9534f[PESCADOR] #FFFFFFVocê não tem quaisquer peixe para vender",255, 255, 255, true )
	end
	
	local total = fisherman_getClientCatchTotal ( )
	local items = fisherman_catch
	triggerServerEvent ( "VDBGJobs:Fisherman:onClientSellCatch", localPlayer, total, items, fisherman_itemsToCatch )
	fisherman_setCatch ( )
end

function fisherman_setCatch ( )
	fisherman_catch = { }
	for i, v in pairs ( fisherman_itemsToCatch ) do
		fisherman_catch [ i ] = 0
	end
	return fisherman_catch
end
addEvent ( "VDBGJobs:Fisherman:executeFunction->fisherman_setCatch", true )
addEventHandler ( "VDBGJobs:Fisherman:executeFunction->fisherman_setCatch", root, fisherman_setCatch )

function fisherman_getClientCatchTotal ( )
	local total = 0
	for i, v in pairs ( fisherman_catch ) do
		local total_ = fisherman_itemsToCatch [ i ] * v
		total = total + total_
	end
	return total
end

for i, v in ipairs ( shopLocations ) do
	local x, y, z = unpack ( v )
	local m = createMarker ( x, y, z, "cylinder", 3.5, 200, 200, 200, 120 )
	exports.VDBG3DTEXT:create3DText ( 'Venda seus peixes aqui', { x, y, z+0.5 }, { 200, 200, 200 }, { nil, true },  { }, "Pesqueiro", "Pesqueiro")
	addEventHandler ( "onClientMarkerHit", m, fisherman_onSellMarkerHit )
end


-- Rendering The Catch --
local fisherman_isRenderTextActive = false
local tick = getTickCount ( )
addEventHandler ( "onClientPlayerVehicleEnter", root, function ( v, s )
	if ( source == localPlayer and getElementData ( source, "Job" ) == "Fisherman" and not fisherman_isRenderTextActive and getElementModel( v ) == 453 and s == 0 ) then
		fisherman_isRenderTextActive = true
		outputChatBox ( "#d9534f[PESCADOR] #FFFFFFPara capturar peixes, dirija em torno do lago.", 255, 255, 255, true )
		addEventHandler ( "onClientRender", root, fisherman_onClientCatchRender )
		fisherman_nextCatchTick = ( getTickCount ( ) + 12000 ) + math.random ( -2000, 2000 )
	end
end )

function fisherman_getItemCountInNet ( )
	local c = 0
	for i, v in pairs ( fisherman_catch ) do
		c = c + v
	end
	return c
end

function fisherman_getRandomItem ( )
	local indexCount = 0
	for i, v in pairs ( fisherman_itemsToCatch ) do
		indexCount = indexCount + 1
	end
	
	local indexToReturn = math.random ( indexCount )
	local i2 = 0
	local rV = nil
	for i, v in pairs ( fisherman_itemsToCatch ) do
		i2 = i2 + 1
		if ( i2 == indexToReturn ) then
			rV = i
			break
		end
	end
	return rV
end
local x,y = guiGetScreenSize()
local opensans = dxCreateFont(":VDBGPDU/arquivos/opensans.ttf", 22)
function fisherman_onClientCatchRender ( )
	if not fisherman_isRenderTextActive or getElementData ( localPlayer, "Job" ) ~= "Fisherman" or not isPedInVehicle ( localPlayer ) then
		fisherman_isRenderTextActive = false
		removeEventHandler ( "onClientRender", root, fisherman_onClientCatchRender )
		fisherman_nextCatchTick = nil
		return false
	end
	dxDrawRectangle ( 30, y/2-30, 200, 60, tocolor ( 0, 0, 0, 180 ) ) 
	dxDrawRectangle ( 30, y/2-30, 3, 60, tocolor ( 0, 0, 0, 255 ) ) 
	dxDrawRectangle ( 30, (y/2)+30, 200, 3, tocolor ( 0, 0, 0, 255 ) ) 
	dxDrawRectangle ( 30, y/2-30, 200, 3, tocolor ( 0, 0, 0, 255 ) ) 
	dxDrawRectangle ( 230, y/2-30, 3, 63, tocolor ( 0, 0, 0, 255 ) ) 
	
	dxDrawText ( "Rede: "..fisherman_getItemCountInNet().."#ffffff de #d9534f"..fisherman_maxCatch, 50, 0, 0, sy, tocolor (255, 255, 255, 255 ), 1, opensans, "left", "center" ,true, true, true, true, true)
	if ( fisherman_nextCatchTick and getTickCount ( ) >= fisherman_nextCatchTick ) then
		fisherman_nextCatchTick = ( getTickCount ( ) + 12000 ) + math.random ( -2000, 2000 )
		if ( fisherman_getItemCountInNet ( ) == fisherman_maxCatch ) then
			return outputChatBox ( "#d9534f[PESCADOR] #FFFFFFA rede está cheia, vá ao porto para vender seus produtos!", 255, 255, 255, true )
		end
		local item = fisherman_getRandomItem ( )
		outputChatBox ( "#d9534f[PESCADOR] #FFFFFFVocê pegou um(a) #ffa500"..item.."#FFFFFF; o seu valor de venda é dê #acd373R$"..tostring(fisherman_itemsToCatch[item])..".00 !", 255, 255, 255, true )
		fisherman_catch [ item ] = fisherman_catch [ item ] + 1
	end
end

addEvent ( "VDBGJobs:Fisherman:updateMaxNetCatch", true )
addEventHandler ( "VDBGJobs:Fisherman:updateMaxNetCatch", root, function ( x )
	fisherman_maxCatch = x
end )

if ( getElementData ( localPlayer, "Job" ) == "Fisherman" and isPedInVehicle ( localPlayer ) and getVehicleController ( getPedOccupiedVehicle ( localPlayer ) ) == localPlayer ) then
	fisherman_isRenderTextActive = true
	outputChatBox ( "#d9534f[PESCADOR] #FFFFFFPara capturar peixes, dirija em torno do lago.", 255, 255, 255, true )
	addEventHandler ( "onClientRender", root, fisherman_onClientCatchRender )
	fisherman_nextCatchTick = ( getTickCount ( ) + 12000 ) + math.random ( -2000, 2000 )
end

fisherman_setCatch ( )



addCommandHandler ( "net", function ( )
	if ( getElementData ( localPlayer, "Job" ) ~= "Fisherman" ) then
		return outputChatBox ( "#d9534f[PESCADOR] #FFFFFFVocê não é um pescador", 255, 255, 255, true )
	end
	guiGridListClear ( Fisherman.GUI.list )
	if ( guiGetVisible ( Fisherman.GUI.window ) ) then
		guiSetVisible ( Fisherman.GUI.window, false )
		showCursor ( false )
		removeEventHandler ( "onClientGUIClick", Fisherman.GUI.close, fisherman_onClientGUIClick )
	else
		guiSetVisible ( Fisherman.GUI.window, true )
		showCursor ( true )
		addEventHandler ( "onClientGUIClick", Fisherman.GUI.close, fisherman_onClientGUIClick )
		
		local totalPrice = 0
		for i, v in pairs ( fisherman_catch ) do
			local r = guiGridListAddRow ( Fisherman.GUI.list )
			guiGridListSetItemText ( Fisherman.GUI.list, r, 1, tostring ( i ), false, false )
			guiGridListSetItemText ( Fisherman.GUI.list, r, 2, tostring ( v ), false, false )
			local worth = fisherman_itemsToCatch [ i ] * v
			totalPrice = totalPrice + worth
			guiGridListSetItemText ( Fisherman.GUI.list, r, 3, "R$"..tostring ( worth ), false, false )
		end
		
		local r = guiGridListAddRow ( Fisherman.GUI.list )
		guiGridListSetItemText ( Fisherman.GUI.list, r, 1, "", true, true )
		guiGridListSetItemText ( Fisherman.GUI.list, r, 2, "", true, true )
		guiGridListSetItemText ( Fisherman.GUI.list, r, 3, "", true, true )
		
		local r = guiGridListAddRow ( Fisherman.GUI.list )
		guiGridListSetItemText ( Fisherman.GUI.list, r, 3, "", true, true )
		guiGridListSetItemText ( Fisherman.GUI.list, r, 2, "", true, true )
		guiGridListSetItemText ( Fisherman.GUI.list, r, 1, "Total: R$"..tostring(totalPrice), true, true )
	end
end )


function fisherman_onClientGUIClick ( )
	executeCommandHandler ( "net" )
end 


if ( getElementData ( localPlayer, "Job" ) == "Fisherman" ) then
	setTimer ( triggerServerEvent, 500, 1, "VDBGJobs:Fisherman:getClientNetLimit", localPlayer, localPlayer )
end


-- Stats Window
Fisherman.GUI2.window = guiCreateWindow( ( sx / 2 - 471 / 2 ), ( sy / 2 - 330 / 2 ), 471, 330, "Pesqueiro", false)
guiWindowSetSizable(Fisherman.GUI2.window, false)
guiSetVisible ( Fisherman.GUI2.window, false )
Fisherman.GUI2.close = guiCreateButton(353, 295, 108, 25, "Fechar", false, Fisherman.GUI2.window)
Fisherman.GUI2.username = guiCreateLabel(10, 34, 437, 18, "Login: N/A", false, Fisherman.GUI2.window)
Fisherman.GUI2.job = guiCreateLabel(10, 62, 437, 18, "Trabalho: Pesqueiro", false, Fisherman.GUI2.window)
Fisherman.GUI2.caughtFish = guiCreateLabel(10, 118, 437, 18, "Peixos Pegos: N/A", false, Fisherman.GUI2.window)
Fisherman.GUI2.jobRank = guiCreateLabel(10, 90, 437, 18, "Nivel: N/A", false, Fisherman.GUI2.window)
Fisherman.GUI2.neededFish = guiCreateLabel(10, 146, 437, 18, "Próximo Nivel: N/A  || N/A Peixes necessários", false, Fisherman.GUI2.window)
Fisherman.GUI2.jobDesc = guiCreateMemo(12, 187, 449, 98, "", false, Fisherman.GUI2.window)
guiMemoSetReadOnly(Fisherman.GUI2.jobDesc, true)

bindKey ( "dsadasdasdsadasdasdas", "down", function ( )
	local j = getElementData ( localPlayer, "Job" )
	if ( j ~= "Fisherman" ) then
		guiSetVisible ( Fisherman.GUI2.window, false )
		showCursor ( false )
		return
	end
	
	local n = not guiGetVisible ( Fisherman.GUI2.window )
	guiSetVisible ( Fisherman.GUI2.window, n )
	showCursor ( n )
	if n then
		triggerServerEvent ( "VDBGJobs:Fisherman:GetClientFisherStatsForInterface", localPlayer )
		addEventHandler ( "onClientGUIClick", Fisherman.GUI2.close, fisherman_onClientGUIClickUSerStats )
	else
		removeEventHandler ( "onClientGUIClick", Fisherman.GUI2.close, fisherman_onClientGUIClickUSerStats )
	end
end )


addEvent ( "VDBGJobs:Fisherman:OnServerSendClientJobInformationForInterface", true )
addEventHandler ( "VDBGJobs:Fisherman:OnServerSendClientJobInformationForInterface", root, function ( d )
	guiSetText ( Fisherman.GUI2.username, "Login: ".. tostring(d.account) )
	guiSetText ( Fisherman.GUI2.job, "Trabalho: ".. tostring(d.job) )
	guiSetText ( Fisherman.GUI2.caughtFish, "Peixes pegos: ".. tostring(d.caughtFish) )
	guiSetText ( Fisherman.GUI2.jobRank, "Nivel: ".. tostring(d.jobRank) )
	guiSetText ( Fisherman.GUI2.neededFish, "Próximo Nivel: "..tostring(d.nextRank).."  ||  ".. tostring(d.requiredCatchesForNext) .." peixe necessária" )
	guiSetText ( Fisherman.GUI2.jobDesc, jobDescriptions [ 'fisherman' ] )
end )

function fisherman_onClientGUIClickUSerStats ( ) 
	if source == Fisherman.GUI2.window then return end
	guiSetVisible ( Fisherman.GUI2.window, false )
	showCursor ( false )
	removeEventHandler ( "onClientGUIClick", Fisherman.GUI2.close, fisherman_onClientGUIClickUSerStats )
end