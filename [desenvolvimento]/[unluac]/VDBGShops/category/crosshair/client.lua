local sx, sy = guiGetScreenSize()
local px, py = guiGetScreenSize()
local size = 32
local cursorX, cursorY = 0, 0
local clicked = false
local red = nil
local green = nil
local blue = nil
local alpha = nil
local tamanhoaumenta = false




addCommandHandler("mira", function()
    addEventHandler("onClientRender", root, drawCrosshairSettings)
	showCursor(true)
    clicked = false
	playSound("files/abrir.mp3", false)
end)

function drawCrosshair() 
	local red = getElementData ( localPlayer, "VDBGCrossR" )
	local green = getElementData ( localPlayer, "VDBGCrossG" )
	local blue = getElementData ( localPlayer, "VDBGCrossB" )
	local alpha = getElementData ( localPlayer, "VDBGCrossA" )
    local hX,hY,hZ = getPedTargetEnd ( getLocalPlayer() )
    local screenX1, screenY1 = getScreenFromWorldPosition ( hX,hY,hZ )
	if tamanhoaumenta == true then
	dxDrawImage(screenX1-(size/2)-5, screenY1-(size/2)-5, size+10, size+10, "category/crosshair/images/mira.png", 0,0,0, tocolor(red,green,blue,alpha))
	else
    dxDrawImage(screenX1-(size/2), screenY1-(size/2), size, size, "category/crosshair/images/mira.png", 0,0,0, tocolor(red,green,blue,alpha))
	end
	setElementData(localPlayer, "VDBGCrossR", red )
	setElementData(localPlayer, "VDBGCrossG", green )
	setElementData(localPlayer, "VDBGCrossB", blue )
	setElementData(localPlayer, "VDBGCrossA", alpha )
end 

bindKey("aim_weapon", "both", function(key, state)        
    local weapon = getPlayerWeapon(getLocalPlayer())
    if weapon ~= 0 and weapon ~=1 then
        if state == "down" then 
			setPlayerHudComponentVisible( "crosshair", false )
            addEventHandler("onClientRender", root, drawCrosshair)
        else
            removeEventHandler("onClientRender", root, drawCrosshair) 
        end 
    end
end)

bindKey("mouse1", "both", function(key, state)        
    local weapon = getPlayerWeapon(getLocalPlayer())
    if weapon ~= 0 and weapon ~=1 then
        if state == "down" then 
            tamanhoaumenta = true
        else
            tamanhoaumenta = false
        end 
    end
end)

function drawCrosshairSettings()
    if isCursorShowing() then
	if ( exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
        local cursorX, cursorY = getCursorPosition()
        cursorX, cursorY = cursorX*sx, cursorY*sy
        --exports.VDBG_Blur:createBlur() 	
		
		local red = getElementData ( localPlayer, "VDBGCrossR" ) or 0
		local green = getElementData ( localPlayer, "VDBGCrossG" ) or 0
		local blue = getElementData ( localPlayer, "VDBGCrossB" ) or 0 
		local alpha = getElementData ( localPlayer, "VDBGCrossA" ) or 0
		
		dxDrawImage(sx/2-350/2, sy/2-500/2, 350, 481, "category/crosshair/images/BG.png")
        dxDrawImage(sx/2-286/2, sy/2-468/2, 279, 61, "category/crosshair/images/logo.png")       
	   --Draw Selectors
        dxDrawImage(sx/2-265/2, sy/2-150, 265, 40, "category/crosshair/images/selecionar_vermelho.png")
        dxDrawImage(sx/2-265/2, sy/2-100, 265, 40, "category/crosshair/images/selecionar_verde.png")
        dxDrawImage(sx/2-265/2, sy/2-50, 265, 40, "category/crosshair/images/selecionar_azul.png")
        dxDrawImage(sx/2-265/2, sy/2+130, 265, 40, "category/crosshair/images/selecionar_alpha.png")
        
        dxDrawImage(sx/2-265/2+5+red-1, sy/2-145, 3, 30, "category/crosshair/images/selecionar.png")
        dxDrawImage(sx/2-265/2+5+green-1, sy/2-95, 3, 30, "category/crosshair/images/selecionar.png")
        dxDrawImage(sx/2-265/2+5+blue-1, sy/2-45, 3, 30, "category/crosshair/images/selecionar.png")
        dxDrawImage(sx/2-265/2+5+alpha-1, sy/2+135, 3, 30, "category/crosshair/images/selecionar.png")
        
        dxDrawImage(sx/2-100/2, sy/2+10, 100, 100, "category/crosshair/images/mira.png", 0,0,0, tocolor(red,green,blue,alpha))
        
        if cursorX >= sx/2-265/2 and cursorX <= sx/2+255/2 and cursorY >= sy/2+180 and  cursorY <=  sy/2+180+30 then
            dxDrawImage(sx/2-260/2+5, sy/2+180, 255, 30, "category/crosshair/images/salvar_h.png")
        else
            dxDrawImage(sx/2-260/2+5, sy/2+180, 255, 30, "category/crosshair/images/salvar.png")
        end
        if clicked then
            if cursorX >= sx/2-255/2 and cursorX <= sx/2+255/2 and cursorY >= sy/2-145 and  cursorY <=  sy/2-145+30 then
                red = cursorX-sx/2-255/2+255
				setElementData(localPlayer, "VDBGCrossR", red )
            end
            
            if cursorX >= sx/2-255/2 and cursorX <= sx/2+255/2 and cursorY >= sy/2-95 and  cursorY <=  sy/2-95+30 then
                green = cursorX-sx/2-255/2+255
				setElementData(localPlayer, "VDBGCrossG", green )
            end
            
            if cursorX >= sx/2-255/2 and cursorX <= sx/2+255/2 and cursorY >= sy/2-45 and  cursorY <=  sy/2-45+30 then
                blue = cursorX-sx/2-255/2+255
				setElementData(localPlayer, "VDBGCrossB", blue )
            end
            
            if cursorX >= sx/2-255/2 and cursorX <= sx/2+255/2 and cursorY >= sy/2+130 and  cursorY <=  sy/2+130+30 then
                alpha = cursorX-sx/2-255/2+255
				setElementData(localPlayer, "VDBGCrossA", alpha )
            end
           
		   if cursorX >= sx/2-265/2 and cursorX <= sx/2+255/2 and cursorY >= sy/2+180 and  cursorY <=  sy/2+180+30 then
           exports.VDBGRadar:showBox("info","Crosshair Modificado com sucesso!")               			
			removeEventHandler("onClientRender", root, drawCrosshairSettings)
                showCursor(false)
                clicked = false
				showChat(true)
				playSound("files/salvar.mp3", false)
			end
		end
    end
end

local lojasitem = { }
function criarLoja ( x, y, z, int, dim )

	local i = 0
	while ( lojasitem [ i ] ) do
		i = i + 1
	end

	lojasitem [ i ] = createMarker ( x, y, z - 1, "cylinder", 2, 217, 83, 79, 170 )
	setElementInterior( lojasitem [ i ], int )
	setElementDimension( lojasitem [ i ], dim )


	addEventHandler ( "onClientMarkerHit", lojasitem[i], function ( p )
		if ( p == localPlayer and not isPedInVehicle ( localPlayer ) ) then
			visibilidade = true
			toggleControl("all",true)
			addEventHandler("onClientRender", root, drawCrosshairSettings)
	showCursor(true)
    clicked = false
	playSound("files/abrir.mp3", false)
		end 
	end )
end 
-- X,Y,Z,INT,DIM BAR 1
criarLoja (298.78, -31.71, 1001.52, 1, 103)


addEventHandler("onClientClick", root, function(button, state)
    if button == "left" and state == "down" then
        clicked = true
    else
        clicked = false
    end
end)
