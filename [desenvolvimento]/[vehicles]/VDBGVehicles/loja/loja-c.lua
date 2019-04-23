local sx, sy = guiGetScreenSize ( )
local rSX, rSY = sx / 1280, sx / 1024
local rec_x = ( sx - (rSX*403) )
local rec_y = ( sy / (rSY*4.2) )
local font = dxCreateFont( "font.ttf",18)
local font2 = dxCreateFont( "font.ttf",15)
local changeCar = { }
local spacebtn = 70
local metodopagamento = "#acd373Dinheiro"
local drawData = { 
	hover_buy = false,
	hover_close = false,
	hover_editColor = false,
	hover_payment_diamound = false,
	hover_payment_money = false,
	hover_testDrive = false,
	active_payment_money = true,
	active_payment_diamound = false
}

function dxDrawVehicleShop ( )
	local cR, cG, cB = unpack ( carColor ) 
	local pR, pG, pB = 217, 83, 79
	local dpR, dpG, dpB = 217, 83, 79
	local lpR, lpG, lpB = 217, 83, 79
	
	if ( getPlayerMoney ( localPlayer ) >= carList[carIndex][2] ) then
		pR, pG, pB = 92, 184, 92
	end
	
	if ( exports.VDBGVIP:getPlayerDiamound(localPlayer) >= carList[carIndex][3] ) then
		dpR, dpG, dpB = 47, 124, 204
	end
	
	if (exports.VDBGLevel:checkLevel(localPlayer) >= carList[carIndex][4] ) then 
		lpR, lpG, lpB = 92, 184, 92
	end
	
	
	
	if ( isElement ( PreviewVehicle ) ) then
		local rx, ry, rz = getElementRotation ( PreviewVehicle )
		if ( rz > 360 ) then
			rz = 0
		end
		setElementRotation ( PreviewVehicle, 0, 0, rz+0.5 )
		local _, _, posZ = getElementPosition ( PreviewVehicle )
		setElementPosition ( PreviewVehicle, createtionPointX, createtionPointY, posZ )
		setVehicleColor ( PreviewVehicle, cR, cG, cB, cR, cG, cB ) 
	end

	dxDrawRectangle(rec_x, rec_y, rSX*390, rSY*270, tocolor(0, 0, 0, 120), false)
	dxDrawRectangle(rec_x, rec_y, rSX*390, 3, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x, rec_y, 3, rSY*270, tocolor(0, 0, 0, 255), false)
	
	dxDrawRectangle(rec_x, rec_y+(rSY*270), rSX*390+3, 3, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x+(rSX*390), rec_y, 3, rSY*270, tocolor(0, 0, 0, 255), false)
	
	dxDrawText( "VDB#428bcaGaming - #d9534fLoja" , rec_x, rec_y, rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, true, true, false)
	
	local preco = convertNumber ( carList[carIndex][2] )
	local nome = returnInfos( carList[carIndex][1], "nome" )
	local velocidade = tostring(returnInfos( carList[carIndex][1], "vreal" ))
	local diamantevalue = carList[carIndex][3]
	local levelvalue = carList[carIndex][4]
	
	
	
	dxDrawRectangle(rec_x, rec_y+(rSY*40), rSX*390, rSY*35, tocolor(0, 0, 0, 120), false)
	dxDrawText( nome, rec_x+15, rec_y+(rSY*45), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
	
	dxDrawRectangle(rec_x, rec_y+(rSY*85), rSX*390, rSY*35, tocolor(0, 0, 0, 120), false)
	dxDrawText( "Velocidade máxima: #acd373"..velocidade.." km/h", rec_x+15, rec_y+(rSY*90),  rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
	
	dxDrawRectangle(rec_x, rec_y+(rSY*130), rSX*390, rSY*35, tocolor(0, 0, 0, 120), false)
	dxDrawText( "#ffffffDinheiro: "..RGBToHex ( pR, pG, pB ).."R$ "..preco, rec_x+15, rec_y+(rSY*135), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
	dxDrawRectangle(rec_x-(rSX*50), rec_y+(rSY*130), rSX*45, rSY*35, tocolor(0, 0, 0, 120), false)
	dxDrawRectangle(rec_x-(rSX*50), rec_y+(rSY*130), rSX*45, 3, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x-(rSX*50), rec_y+(rSY*130), 3, rSY*35, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x-(rSX*50)+rSX*45, rec_y+(rSY*130), 3, rSY*35, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x-(rSX*50), rec_y+(rSY*130)+rSY*35, rSX*45+3, 3, tocolor(0, 0, 0, 255), false)
	
	
	
	dxDrawRectangle(rec_x-(rSX*50), rec_y+(rSY*175), rSX*45, rSY*35, tocolor(0, 0, 0, 120), false)	
	dxDrawRectangle(rec_x-(rSX*50), rec_y+(rSY*175), rSX*45, 3, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x-(rSX*50), rec_y+(rSY*175), 3, rSY*35, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x-(rSX*50)+rSX*45, rec_y+(rSY*175), 3, rSY*35, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x-(rSX*50), rec_y+(rSY*175)+rSY*35, rSX*45+3, 3, tocolor(0, 0, 0, 255), false)	
	dxDrawRectangle(rec_x, rec_y+(rSY*175), rSX*390, rSY*35, tocolor(0, 0, 0, 120), false)
	dxDrawText( "#ffffffDiamante: "..RGBToHex( dpR, dpG, dpB )..diamantevalue, rec_x+15, rec_y+(rSY*180), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
	
	dxDrawRectangle(rec_x, rec_y+(rSY*220), rSX*390, rSY*35, tocolor(0, 0, 0, 120), false)
	dxDrawText( "#ffffffLevel necessário: "..RGBToHex( lpR, lpG, lpB )..levelvalue, rec_x+15, rec_y+(rSY*225), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
	
	dxDrawRectangle(rec_x, rec_y+(rSY*410), rSX*390, rSY*35, tocolor(0, 0, 0, 120), false)
	dxDrawRectangle(rec_x, rec_y+(rSY*410), rSX*390, 3, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x, rec_y+(rSY*410), 3, rSY*35, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x+rSX*390, rec_y+(rSY*410), 3, rSY*35+3, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x, rec_y+(rSY*410)+rSY*35, rSX*390, 3, tocolor(0, 0, 0, 255), false)
	
	dxDrawText( "#ffffffPagamento: "..metodopagamento, rec_x+15, rec_y+(rSY*415), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
	
	
	dxDrawRectangle(rec_x, rec_y-(rSY*50), rSX*390, rSY*35, tocolor(0, 0, 0, 120), false)
	dxDrawRectangle(rec_x, rec_y-(rSY*50), rSX*390, 3, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x, rec_y-(rSY*50), 3, rSY*35, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x+rSX*390, rec_y-(rSY*50), 3, rSY*35+3, tocolor(0, 0, 0, 255), false)
	dxDrawRectangle(rec_x, rec_y-(rSY*50)+rSY*35, rSX*390, 3, tocolor(0, 0, 0, 255), false)
	dxDrawText( "Use as setas para nevegação", rec_x+15, rec_y-(rSY*45), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
	
	dxDrawRectangle(rec_x, rec_y+(rSY*(spacebtn+213)), (rSX*190), rSY*53, tocolor(0, 0, 0, 190), false) -- buy button
	dxDrawRectangle(rec_x, rec_y+(rSY*(spacebtn+213)), (rSX*190), 3, tocolor(0, 0, 0, 190), false) -- buy button	
	dxDrawRectangle(rec_x, rec_y+(rSY*(spacebtn+213)), 3, rSY*53, tocolor(0, 0, 0, 190), false) -- buy button
	dxDrawRectangle(rec_x+(rSX*190), rec_y+(rSY*(spacebtn+213)), 3, rSY*53, tocolor(0, 0, 0, 255), false) -- buy button	
	dxDrawRectangle(rec_x, rec_y+(rSY*(spacebtn+213))+rSY*53, 3+(rSX*190), 3, tocolor(0, 0, 0, 255), false) -- buy button

	
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111), rec_y+(rSY*(spacebtn+213)), rSX*190, rSY*53, tocolor(0, 0, 0, 190), false) -- fechar
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111), rec_y+(rSY*(spacebtn+213)), rSX*190, 3, tocolor(0, 0, 0, 255), false) -- fechar
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111), rec_y+(rSY*(spacebtn+213)), 3, rSY*53, tocolor(0, 0, 0, 255), false) -- fechar
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111)+rSX*190, rec_y+(rSY*(spacebtn+213)), 3, rSY*53, tocolor(0, 0, 0, 255), false) -- fechar
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111), rec_y+(rSY*(spacebtn+213))+rSY*53, rSX*190+3, 3, tocolor(0, 0, 0, 255), false) -- fechar
	
	dxDrawRectangle(rec_x, rec_y+(rSY*(spacebtn+273)), (rSX*190), rSY*53, tocolor(0, 0, 0, 190), false) -- edit button
	dxDrawRectangle(rec_x, rec_y+(rSY*(spacebtn+273)), (rSX*190), 3, tocolor(0, 0, 0, 190), false) -- edit button	
	dxDrawRectangle(rec_x, rec_y+(rSY*(spacebtn+273)), 3, rSY*53, tocolor(0, 0, 0, 190), false) -- edit button
	dxDrawRectangle(rec_x+(rSX*190), rec_y+(rSY*(spacebtn+273)), 3, rSY*53, tocolor(0, 0, 0, 255), false) -- edit button	
	dxDrawRectangle(rec_x, rec_y+(rSY*(spacebtn+273))+rSY*53, 3+(rSX*190), 3, tocolor(0, 0, 0, 255), false) -- edit button
	
	dxDrawRectangle(rec_x-6, rec_y+(rSY*(spacebtn+273)), 6, rSY*56, tocolor(cR, cG, cB, 190), false) -- edit button

	
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111), rec_y+(rSY*(spacebtn+273)), rSX*190, rSY*53, tocolor(0, 0, 0, 190), false) -- test drive
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111), rec_y+(rSY*(spacebtn+273)), rSX*190, 3, tocolor(0, 0, 0, 255), false) -- test drive
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111), rec_y+(rSY*(spacebtn+273)), 3, rSY*53, tocolor(0, 0, 0, 255), false) -- test drive
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111)+rSX*190, rec_y+(rSY*(spacebtn+273)), 3, rSY*53, tocolor(0, 0, 0, 255), false) -- test drive
	dxDrawRectangle((rec_x+(rSX*313))-(rSX*111), rec_y+(rSY*(spacebtn+273))+rSY*53, rSX*190+3, 3, tocolor(0, 0, 0, 255), false) -- test drive
	
	
	if ( drawData.hover_buy ) then
		dxDrawText("Comprar", rec_x, rec_y+(rSY*(spacebtn+spacebtn+263)), rec_x+(rSX*200), rec_y+rSY*(163+53), tocolor(47,124,204, 255), 1, font, "center", "center", false, false, true, false, false)
	else
		dxDrawText("Comprar", rec_x, rec_y+(rSY*(spacebtn+spacebtn+263)), rec_x+(rSX*200), rec_y+rSY*(163+53), tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, true, false, false)
	end

	if	( drawData.hover_close ) then
		dxDrawText("Fechar", ((rec_x+(rSX*313))-(rSX*30)), rec_y+(rSY*(spacebtn+spacebtn+260)), (rec_x+(rSX*313)), rec_y+rSY*(163+53), tocolor(47,124,204, 255), 1, font, "center", "center", false, false, true, false, false)
	else
		dxDrawText("Fechar", ((rec_x+(rSX*313))-(rSX*30)), rec_y+(rSY*(spacebtn+spacebtn+260)), (rec_x+(rSX*313)), rec_y+rSY*(163+53), tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, true, false, false)
	end	
	
	if ( drawData.hover_editColor ) then
		dxDrawText("Cores", rec_x, rec_y+(rSY*(spacebtn+spacebtn+385)), rec_x+(rSX*200), rec_y+rSY*(163+53), tocolor(47,124,204, 255), 1, font, "center", "center", false, false, true, false, false)
	else
		dxDrawText("Cores", rec_x, rec_y+(rSY*(spacebtn+spacebtn+385)), rec_x+(rSX*200), rec_y+rSY*(163+53), tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, true, false, false)
	end
	
	if ( drawData.hover_testDrive ) then
		dxDrawText("Test Drive", ((rec_x+(rSX*313))-(rSX*30)), rec_y+(rSY*(spacebtn+spacebtn+385)), rec_x+(rSX*313), rec_y+rSY*(163+53), tocolor(47,124,204, 255), 1, font, "center", "center", false, false, true, false, false)
	else
		dxDrawText("Test Drive", ((rec_x+(rSX*313))-(rSX*30)), rec_y+(rSY*(spacebtn+spacebtn+385)), rec_x+(rSX*313), rec_y+rSY*(163+53), tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, true, false, false)
	end
	
	if ( drawData.hover_testDrive ) then
		dxDrawText("Test Drive", ((rec_x+(rSX*313))-(rSX*30)), rec_y+(rSY*(spacebtn+spacebtn+385)), rec_x+(rSX*313), rec_y+rSY*(163+53), tocolor(47,124,204, 255), 1, font, "center", "center", false, false, true, false, false)
	else
		dxDrawText("Test Drive", ((rec_x+(rSX*313))-(rSX*30)), rec_y+(rSY*(spacebtn+spacebtn+385)), rec_x+(rSX*313), rec_y+rSY*(163+53), tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, true, false, false)
	end
	
	if drawData.active_payment_money then
		metodopagamento = RGBToHex( pR, pG, pB ).."Dinheiro"
		if ( drawData.hover_payment_money ) then
			dxDrawText( "x", rec_x-(rSX*32), rec_y+(rSY*135), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(47,124,204, 255), 1, font2, "left", "top", false, false, true, true, false)
		else
			dxDrawText( "x", rec_x-(rSX*32), rec_y+(rSY*135), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
		end
	end
	if drawData.active_payment_diamound then
		metodopagamento = RGBToHex( dpR, dpG, dpB ).."Diamante"
		if ( drawData.hover_payment_diamound ) then
			dxDrawText( "x", rec_x-(rSX*32), rec_y+(rSY*180), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(47,124,204, 255), 1, font2, "left", "top", false, false, true, true, false)
		else
			dxDrawText( "x", rec_x-(rSX*32), rec_y+(rSY*180), rec_x+(rSX*390), rec_y+(rSY*40), tocolor(255, 255, 255, 255), 1, font2, "left", "top", false, false, true, true, false)
		end
	end
	
	
	

end 

addEvent ( "VDBGVehicles:openClientShop", true )
addEventHandler ( "VDBGVehicles:openClientShop", root, function ( list, createPoint, spawnpoint )

	showChat ( false )
	spawnPosition = spawnpoint
	carList = list
	carIndex=1
	carColor = { 255, 255, 255 }
	PreviewVehicle = createVehicle ( list[1][1], unpack ( createPoint ) )
	setVehicleLocked ( PreviewVehicle, true )
	setVehicleDamageProof ( PreviewVehicle, true )
	createtionPointX = createPoint[1]
	createtionPointY =  createPoint[2]
	showCursor ( true )
	toggleAllControls ( false )
	addEventHandler ( 'onClientPreRender', root, dxDrawVehicleShop )
	addEventHandler ( 'onClientCursorMove', root, onEvent_CursorMove )
	addEventHandler ( 'onClientClick', root, onEvent_CursorClick )
	
	bindKey ( "arrow_l", "down", changeCar.left )
	bindKey ( "arrow_r", "down", changeCar.right )
end )



function changeCar.left ( )
	local x, y, z = getElementPosition ( PreviewVehicle ) 
	setElementPosition ( PreviewVehicle, x, y, z+0.7 )
	if ( carIndex > 1 ) then
		carIndex = carIndex - 1
		setElementModel ( PreviewVehicle, carList[carIndex][1] )
	else
		carIndex = #carList
		setElementModel ( PreviewVehicle, carList[carIndex][1] )
	end
end 

function changeCar.right ( )
	local x, y, z = getElementPosition ( PreviewVehicle ) 
	setElementPosition ( PreviewVehicle, x, y, z+0.7 )
	if ( carIndex < #carList ) then
		carIndex = carIndex + 1
		setElementModel ( PreviewVehicle, carList[carIndex][1] )
	else
		carIndex = 1
		setElementModel ( PreviewVehicle, carList[carIndex][1] )
	end
end 


function onEvent_CursorMove ( _, _, x, y )
	
	if ( x >= rec_x and y >= rec_y+(rSY*(spacebtn+213)) and x <= rec_x+(rSX*200) and y <= spacebtn+rec_y+rSY*(213+53)  ) then
		--comprar
		drawData.hover_buy = true
		drawData.hover_close = false
		drawData.hover_editColor = false		
		drawData.hover_testDrive = false	
		drawData.hover_payment_money = false	
		drawData.hover_payment_diamound = false	
		return
	
	elseif ( x >= (rec_x+(rSX*313))-(rSX*111) and y >= rec_y+(rSY*(spacebtn+213)) and x <= rec_x+(rSX*395) and y <= spacebtn+rec_y+rSY*(213+53)  ) then
		--fechar
		drawData.hover_editColor = false	
		drawData.hover_close = true
		drawData.hover_buy = false
		drawData.hover_testDrive = false	
		drawData.hover_payment_money = false	
		drawData.hover_payment_diamound = false	
		return
		------
	elseif ( x >= rec_x and y >= rec_y+(rSY*(spacebtn+273)) and x <= rec_x+(rSX*200) and y <= spacebtn+rec_y+rSY*(273+53)  ) then
		--editcor
		drawData.hover_editColor = true
		drawData.hover_close = false
		drawData.hover_buy = false	
		drawData.hover_testDrive = false	
		drawData.hover_payment_money = false	
		drawData.hover_payment_diamound = false	
		return
	elseif ( x >= (rec_x+(rSX*313))-(rSX*111) and y >= rec_y+(rSY*(spacebtn+273)) and x <= rec_x+(rSX*395) and y <= spacebtn+rec_y+rSY*(273+53)  ) then
		--testdrive
		drawData.hover_editColor = false
		drawData.hover_close = false
		drawData.hover_buy = false	
		drawData.hover_testDrive = true	
		drawData.hover_payment_money = false	
		drawData.hover_payment_diamound = false	
		return
		
	elseif ( x >= rec_x-(rSX*50) and y >= rec_y+(rSY*130) and x <= rec_x-(rSX*50)+rSX*45 and y <= rec_y+(rSY*130)+rSY*35  ) then
		--paymentmoney
		drawData.hover_editColor = false
		drawData.hover_close = false
		drawData.hover_buy = false	
		drawData.hover_testDrive = false	
		drawData.hover_payment_money = true	
		drawData.hover_payment_diamound = false	
	return
	
	
	elseif ( x >= rec_x-(rSX*50) and y >= rec_y+(rSY*175) and x <= rec_x-(rSX*50)+rSX*45 and y <= rec_y+(rSY*175)+rSY*35  ) then
		--paymentdiamound
		drawData.hover_editColor = false
		drawData.hover_close = false
		drawData.hover_buy = false	
		drawData.hover_testDrive = false	
		drawData.hover_payment_money = false	
		drawData.hover_payment_diamound = true	
		return
	end
		drawData.hover_editColor = false
		drawData.hover_close = false
		drawData.hover_buy = false	
		drawData.hover_testDrive = false	
		drawData.hover_payment_money = false	
		drawData.hover_payment_diamound = false	
end

function onEvent_CursorClick ( b, s )
	if ( b ~= "left" or s ~= "down" ) then return end
	if ( drawData.hover_close ) then
		restoreSettings ( )
	elseif ( drawData.hover_editColor ) then
		exports['cpicker']:openPicker ( localPlayer, 'fff', 'Loja de Veículos | COR |' )
	elseif ( drawData.hover_testDrive ) then
		--drawData.
	elseif ( drawData.hover_payment_money and drawData.active_payment_diamound == true ) then
		drawData.active_payment_money = true
		drawData.active_payment_diamound = false	
	elseif ( drawData.hover_payment_diamound and drawData.active_payment_money == true ) then
		drawData.active_payment_diamound = true	
		drawData.active_payment_money = false	
	elseif ( drawData.hover_buy and drawData.active_payment_money == true ) then
		if ( getPlayerMoney ( localPlayer ) >= carList[carIndex][2] and exports.VDBGLevel:checkLevel(localPlayer) >= carList[carIndex][4] ) then
			local sx, sy, sz, srz = unpack ( spawnPosition )
			local id = carList[carIndex][1]
			local pricem = carList[carIndex][2]
			triggerServerEvent ( "VDBGVehicles:onClientBuyVehicle", localPlayer, id, {price, "money"}, { sx, sy, sz, srz }, { getVehicleColor ( PreviewVehicle, true ) } )
			restoreSettings ( )
		else
			outputChatBox("Você não tem dinheiro suficiente para este veículo.", 255, 0, 0)
		end

	elseif ( drawData.hover_buy and drawData.active_payment_diamound == true ) then
		if ( exports.VDBGVIP:getPlayerDiamound(localPlayer) >= carList[carIndex][3] and exports.VDBGLevel:checkLevel(localPlayer) >= carList[carIndex][4] ) then
			local sx, sy, sz, srz = unpack ( spawnPosition )
			local id = carList[carIndex][1]
			local price = carList[carIndex][3]
			triggerServerEvent ( "VDBGVehicles:onClientBuyVehicle", localPlayer, id, {price, "diamound"}, { sx, sy, sz, srz }, { getVehicleColor ( PreviewVehicle, true ) } )
			restoreSettings ( )
		else
			outputChatBox("#d9534f[JOB] #FFFFFFVocê não tem diamantes suficiente para este veículo.", 255, 0, 0)
		end
	end
end 

function restoreSettings ( )
	showChat ( true )
	showCursor ( false )
	carList = nil
	carIndex = nil
	if ( isElement ( PreviewVehicle ) ) then destroyElement ( PreviewVehicle ) end
	createtionPointX = nil
	createtionPointX = nil
	removeEventHandler ( 'onClientPreRender', root, dxDrawVehicleShop )
	removeEventHandler ( 'onClientCursorMove', root, onEvent_CursorMove )
	removeEventHandler ( 'onClientClick', root, onEvent_CursorClick )
	setCameraTarget ( localPlayer )
	drawData.hover_close = false
	drawData.hover_buy = false
	drawData.hover_editColor = false
	drawData.hover_testDrive = false	
	drawData.hover_payment_money = false	
	drawData.hover_payment_diamound = false	
	toggleAllControls ( true )
	unbindKey ( "arrow_l", "down", changeCar.left )
	unbindKey ( "arrow_r", "down", changeCar.right )
	spawnPosition = nil
end

addEvent ( "onColorPickerOK", true )
addEventHandler ( "onColorPickerOK", root, function ( e, hex, r, g, b )
	if ( e == localPlayer ) then
		carColor = { r, g, b }
	end
end )

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end


-- blips --
addEvent ( "onClientPlayerLogin", true )
addEventHandler ( "onClientPlayerLogin", root, function ( )
	local makeBlips = exports.VDBGPhone:getSetting ( "usersetting_display_vehicleshopblips" )
	if ( makeBlips ) then
		shopBlips = { }
		for i, v in pairs ( shopLocations ) do
			for k, y in ipairs ( v ) do
				shopBlips[i..k] = createBlip ( y[1], y[2], y[3], 55, 2, 255, 255, 255, 255, 0, 450 ) 
			end
		end
	end
end )

addEvent ( "onClientUserSettingChange", true )
addEventHandler ( "onClientUserSettingChange", root, function ( set, to )
	if ( set == "usersetting_display_vehicleshopblips" ) then
		if ( to and not shopBlips ) then
			shopBlips = { }
			for i, v in pairs ( shopLocations ) do
				for k, y in ipairs ( v ) do
					shopBlips[i..k] = createBlip ( y[1], y[2], y[3], 55, 2, 255, 255, 255, 255, 0, 450 ) 
				end
			end
		elseif ( not to and shopBlips ) then
			for i, v in pairs ( shopBlips ) do
				destroyElement ( v )
			end
			shopBlips = nil
		end
	end
end )
