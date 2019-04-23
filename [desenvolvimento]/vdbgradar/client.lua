
local hudTable = {"area_name","vehicle_name","radar"}




local sw = {guiGetScreenSize()}
local sx,sy = guiGetScreenSize()
local newfont = dxCreateFont ("arquivos/fonte.ttf",11)
local radarPos = {sw[1]*20/1440, sw[2]-(200+50)+30, ((318-10)),(185)}
local minVel = 1.3 
local minDist = 180
local maxVel = 20 
local maxDist = 360
local minZoom = 6 --minimum
local maxZoom = 20 --maximum
local zoom=11 -- alap zoom
local zoomPlus="num_add"
local zoomMinus="num_sub" 
local mapSize=1536 
local size=(0.7*(1440))/2
local size2=size*2
local x,y=size*1.7,(900)-size*1.5
local screenSizeCompensate=(900)/500
local blipDimension=16*screenSizeCompensate 
local ratio = (maxDist-minDist)/(maxVel-minVel)
local dmgTab={}
local renderData={}
local blipimages={}
local zoomticks=getTickCount()
local frames,lastsec=0,0
local madeByHUD={}

renderData.radarState = true
renderData.F11State = false


function onStart()
	getBlips()
	blipTimer=setTimer(getBlips,100,0)
	hudrendertarg=dxCreateRenderTarget(256,300,true)
	weptarg=dxCreateRenderTarget(256,256,true)
	texture=dxCreateTexture("arquivos/radar.png")
	dxSetTextureEdge( texture, "clamp" )
	renderImage=dxCreateRenderTarget(size2,size2,false)
	newtarg=dxCreateRenderTarget(size*3,size*3,false)
	addEventHandler("onClientRender",getRootElement(),renderFrame)
end

function getRadarRadius ()
	return minDist
end

function getRot()
	local camRot
	local cameraTarget = getCameraTarget()
	if not cameraTarget then
		local px,py,_,lx,ly = getCameraMatrix()
		camRot = getVectorRotation(px,py,lx,ly)
	else
		if getControlState("look_behind") then
			camRot = -math.rad(getPedRotation(localPlayer))
		else
			local px,py,_,lx,ly = getCameraMatrix()
			camRot = getVectorRotation(px,py,lx,ly)
		end
	end
	return camRot
end

function getVectorRotation(px,py,lx,ly)
	local rotz=6.2831853071796-math.atan2(lx-px,ly-py)%6.2831853071796
	return -rotz
end


function ultilizeDamageScreen(attacker,weapon,_,loss)
	local slot = attacker and getElementType(attacker) == "player" and getPedWeaponSlot(attacker) and getPedWeaponSlot(attacker) or false
	if attacker and attacker~=source and not (slot==8 or (slot==7 and weapon~=38)) then
		local px1,py1=getElementPosition(source)
		local px2,py2=getElementPosition(attacker)
		dmgTab[#dmgTab+1]={getTickCount(),0,math.min(25.5*loss,255)}
	else
		dmgTab[#dmgTab+1]={getTickCount(),0,math.min(35*loss,255)}
	end
	if #dmgTab>18 then
		repeat
			table.remove(dmgTab,1)
		until #dmgTab<18
	end
end


function renderFrame()
	if isPlayerMapVisible() then
		return
	end
	if (getElementData(localPlayer,"opendashboard") == true) then return end
	if (getElementData(localPlayer,"radarstate") == true) then return end
	if (getElementData(localPlayer,"logado") == false) then return end
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
		if renderData.radarState and not renderData.F11State then
			local px,py,pz=getElementPosition(localPlayer)
			vehicle=getPedOccupiedVehicle(localPlayer)
			
				local prz=getPedRotation(localPlayer)
				local nx,ny=(3000+px)/6000*mapSize,(3000-py)/6000*mapSize
				local radius=getRadarRadius()
				local maprad=radius/6000*mapSize*zoom
				local preRot=-getRot()
				local rot=math.deg(preRot)
				local mx,my,mw,mh=nx-maprad,ny-maprad,maprad*2,maprad*2
				local scx,scy,scw,sch=0,0,size2,size2
				local absx,absy=math.abs(px),math.abs(py)
				if absx+radius*zoom>3000 then
					if absx-radius*zoom>3000 then
						dontDrawSc=true
					elseif px<0 then
						mw=mx+mw
						mx=0
						scw=scw*(mw/(maprad*2))
						scx=size2-scw
					else
						mw=mw-(mx+mw-mapSize)
						scw=scw*(mw/(maprad*2))
					end
				end
				if absy+radius*zoom>3000 then
					if absy-radius*zoom>3000 then
						dontDrawSc=true
					elseif py>0 then
						mh=my+mh
						my=0
						sch=sch*(mh/(maprad*2))
						scy=size2-sch
					else
						mh=mh-(my+mh-mapSize)
						sch=sch*(mh/(maprad*2))
					end
				end
				prepareBlips(px,py,pz,preRot,(radius)*zoom)
				dxSetRenderTarget(renderImage,true)
				dxDrawRectangle(0,0,size2-20,size2-20,tocolor(42,42,42))
				dxDrawImageSection(scx,scy,scw,sch,mx,my,mw,mh,texture,0,0,0,tocolor(255,255,255,255))
				dxSetRenderTarget(newtarg,true)
				dxDrawImage(size/2,size/2,size2,size2,renderImage,rot,0,0,tocolor(255,255,255,255),false)
				for _,v in ipairs(blipimages) do
					local bx, by = size*1.5+v[1]-x,size*1.5+v[2]-y
					local alpha = 255
					local kepKX, kepKY = radarPos[1]+(radarPos[3]/2), radarPos[2]+(radarPos[4]/2)
					local kepX, kepY = (kepKX-(v[3]/2))+(bx-(size*1.5)+(v[3]/2)), ((kepKY-(v[4]/2))+(by-(size*1.5)+(v[4]/2)))
					local kiegPos = 0
					local colorblip = v[7]
					if(v[5] ~= "blips/0.png" and v[5] ~= "blips/0-up.png") then
						kiegPos = 0
						colorblip = tocolor(255,255,255,255)
					end
					if(kepX < radarPos[1]) then
						bx = bx+(radarPos[1]-kepX)
						alpha = 0
					end
					if(kepX > radarPos[1]+radarPos[3]-(v[3]+kiegPos)/2) then
						bx = bx+((radarPos[1]+radarPos[3]-(v[3]+kiegPos)/2)-kepX)
						alpha = 0
					end
					if(kepY < radarPos[2]) then
						by = by+(radarPos[2]-kepY)
						alpha = 0
					end
					if(kepY > radarPos[2]+radarPos[4]-v[4]) then
						by = by+((radarPos[2]+radarPos[4]-v[4])-kepY)
						alpha = 0
					end
					dxDrawImage(bx,by,v[3],v[4],v[5],v[6],0,0,colorblip,false)
				end
					dxDrawImage(size*1.5-(blipDimension*0.75)/2,size*1.5-(blipDimension*0.75)/2,20,20,"arquivos/seta.png",rot-prz,0,0,tocolor(255,255,255,255),false)
				
				dxSetRenderTarget()
				blipimages={}
				dxDrawImageSection(radarPos[1]+20, radarPos[2]+51, radarPos[3]-25, radarPos[4]-32, size/2+(size2/2)-(radarPos[3]/2),size/2+(size2/2)-(radarPos[4]/2), 318, 185,newtarg, 0, -90, 0, tocolor(255,255,255,255))
				dxDrawImage(radarPos[1]-20, radarPos[2]+22, 387, 220 ,"arquivos/mapbg.png",0,0,0,tocolor(255,255,255,255))
				--dxDrawRectangle(radarPos[1]-7, radarPos[2]+19, 330, 220,tocolor(0,0,0,180))
				--dxDrawImage(radarPos[1]-20, radarPos[2]-1, 387, 58,"arquivos/line.png",0,0,0,tocolor(255,255,255,255))
				local x,y,z = getElementPosition(localPlayer)
				local location = getZoneName(x,y,z)
				

				if getElementInterior(localPlayer) == 0 then
			dxDrawImage(radarPos[1]-20, radarPos[2]-1, 387, 58,"arquivos/line.png",0,0,0,tocolor(255,255,255,255))
				dxDrawText(location, radarPos[1]+85, radarPos[2]+20, 200, 30, tocolor ( 255, 255, 255 ), 1, newfont,"left","top",false,false,false,false)
				dxDrawText("GPS:",radarPos[1]+52, radarPos[2]+20, 200, 30, tocolor ( 28, 138, 234 ), 1, newfont,"left","top",false,false,false,false)
			
			else
			dxDrawImage(radarPos[1]-20, radarPos[2]-1, 387, 58,"arquivos/line.png",0,0,0,tocolor(255,255,255,255))
			dxDrawImage(radarPos[1]+5, radarPos[2]+35, 318, 185 ,"arquivos/semsinal.png",0,0,0,tocolor(255,255,255,255))
			dxDrawText("GPS:",radarPos[1]+52, radarPos[2]+20, 200, 30, tocolor ( 28, 138, 234 ), 1, newfont,"left","top",false,false,false,false)
			dxDrawText("Sem Conexão", radarPos[1]+85, radarPos[2]+20, 200, 30, tocolor ( 255, 255, 255 ), 1, newfont,"left","top",false,false,false,false)
			end
				for k,v in ipairs(dmgTab) do
					v[3]=v[3]-(getTickCount()-v[1])/800 
					if v[3]<=0 then
						table.remove(dmgTab,k)
					else
						dxDrawImage(radarPos[1]+20, radarPos[2]+51, radarPos[3]-25, radarPos[4]-32,"arquivos/dano.png",0,0,0,tocolor(255,255,255,v[3]))
					end
				end
				local keyIn=getKeyState(zoomPlus)
				local keyOut=getKeyState(zoomMinus)
				if keyIn or keyOut then
					local progress=(getTickCount()-zoomticks)/100
					zoom=math.max(minZoom,math.min(maxZoom,zoom+((keyIn and -1 or 1)*progress)))
				end
			end
		end
	zoomticks=getTickCount()
	frames=frames+1

	

addCommandHandler("togradar", 
    function() 
        renderData.radarState = not renderData.radarState
    end
)

function prepareBlips(px,py,pz,rot,radiusR)
	for _,blip in ipairs(blips) do
		if isElement(blip) then
			local target=renderData[blip][4]
			local targetType=isElement(target) and getElementType(target) or false
			local bx,by,bz=getElementPosition(blip)
			local a=renderData[blip][3][4]
			if not (localPlayer==occupant and airMode)
			and not (madeByHUD[blip] and (doSkip or occupant))
			and (localPlayer~=target and a~=0 and ((madeByHUD[blip] and radiusR*0.9 or (getBlipVisibleDistance(blip)*1.3))>getDistanceBetweenPoints3D(px,py,pz,bx,by,bz) )) then
				local r,g,b=renderData[blip][3][1],renderData[blip][3][2],renderData[blip][3][3]
				local dist=getDistanceBetweenPoints2D(bx,by,px,py)
				local blipPointRot=0
				local id=renderData[blip][5]
				local bSize=renderData[blip][6]
				local path=renderData[blip][7]
				local blipRot=math.deg(-getVectorRotation(px,py,bx,by)-rot)-180
				local customBlipPath=renderData[blip][2]
				local text=renderData[blip][1]
				if id==0 then
					if pz<bz-3 then
						path="blips/"..id.."-up.png"
					elseif pz>bz+3 then
						path="blips/"..id.."-up.png"
						blipPointRot=180
					end
					bSize=bSize/2
				end
				local maxSize=size*0.9
				local sRad=math.min((dist/radiusR)*size,maxSize)
				local dx,dy=getPointFromDistanceRotation(x,y,sRad,blipRot)

				blipimages[#blipimages+1]={dx-bSize/2,dy-bSize/2,22,22,path,blipPointRot,tocolor(r,g,b,255)}
			end
		end
	end
end

function getBlips()
	blips=getElementsByType("blip")
	table.sort(blips,function(b1,b2)
		return getBlipOrdering(b1)<getBlipOrdering(b2)
	end)
	for _,v in pairs(blips) do
		if not renderData[v] then
			renderData[v]={}
		end
		renderData[v][3]={getBlipColor(v)}
		renderData[v][4]=getElementAttachedTo(v)
		renderData[v][5]=getBlipIcon(v)
		renderData[v][6]=math.min(getBlipSize(v),4)/2*blipDimension
		renderData[v][7]="blips/"..renderData[v][5]..".png"
	end
end

function getPointFromDistanceRotation(x,y,dist,angle)
	local a=math.rad(90-angle)
	local dx=math.cos(a)*dist
	local dy=math.sin(a)*dist
	return x+dx,y+dy
end

addEventHandler("onClientResourceStart",getResourceRootElement(),onStart)
addEventHandler("onClientPlayerDamage",localPlayer,ultilizeDamageScreen)

-------------------
-----F11 RADAR-----
-------------------

screenWidth, screenHeight = guiGetScreenSize()
width = (325 / 1920) * screenWidth --300
height = (200 / 1080) * screenHeight --200


map_image = dxCreateTexture( "arquivos/radar.png" )
dxSetTextureEdge( map_image, "clamp" )
	
	
function drawCustomRadar()
	--if getElementData(localPlayer, "loggedin") == 1 then
	if (getElementData(localPlayer,"opendashboard") == true) then return end
	if (getElementData(localPlayer,"radarstate") == true) then return end
	if (getElementData(localPlayer,"logado") == false) then return end
	if ( exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
		if renderData.F11State then
			local _, _, c_Rot = getElementRotation( getCamera());
			local _, _, p_Rot = getElementRotation( localPlayer )	
			local image_size = 1536
			local world_size = 6000
			local image_unit = image_size/world_size
			local x = 40
			local y = screenHeight-height-40
			local draw_radius = 180	
			local player_x, player_y, player_z = getElementPosition( localPlayer )
			local u = (((world_size/2)+player_x)*image_unit)-width/2
			local v = (((world_size/2)-player_y)*image_unit)-height/2
			if ( getElementInterior(localPlayer) == 0 ) then
				dxDrawRectangle( 32, y-9, width+24, height+14, tocolor(0,0,0,170) )
				dxDrawImageSection( x-3, y-4, width+14, height+4, u, v, width, height, map_image, 0, 0, 0, tocolor(255,255,255,190) )
				local zero_x = x+width/2
				local zero_y = y+height/2
				local blips = getElementsByType( "blip" )
				for i in pairs(blips) do
					blip = blips[i]
					local blip_x, blip_y, blip_z = getElementPosition( blip )
					local blip_dist = getDistanceBetweenPoints2D( player_x, player_y, blip_x, blip_y )
						if getBlipVisibleDistance(blip) then
							width = (1800 / 1920) * screenWidth
							height = (980 / 1080) * screenHeight
							local draw_x, draw_y = zero_x, zero_y

							if blip_x > player_x then
								if blip_x > player_x+((width/2)/image_unit) then
									draw_x = draw_x + width/2
								else
									draw_x = draw_x + ((blip_x-player_x)*image_unit)
								end
							elseif blip_x < player_x then
								if blip_x < player_x-((width/2)/image_unit) then
									draw_x = draw_x - width/2
								else
									draw_x = draw_x - ((player_x-blip_x)*image_unit)
								end
							end

							if blip_y > player_y then
								if blip_y > player_y+((height/2)/image_unit) then
									draw_y = draw_y - height/2
								else
									draw_y = draw_y - ((blip_y-player_y)*image_unit)
								end
							elseif blip_y < player_y then
								if blip_y < player_y-((height/2)/image_unit) then
									draw_y = draw_y + height/2 
								else
									draw_y = draw_y + ((player_y-blip_y)*image_unit)
								end
							end

							local icon = getBlipIcon(blip)
							local scale = getBlipSize(blip)
							if icon == 0 then
								scale = scale*6.15
								if blip_z > player_z+10 then
									dxDrawImage( draw_x-20/2, draw_y-20/2, 20, 20, "blips/"..icon.."-up.png", 0, 0, 0, tocolor(getBlipColor(blip)) )
								elseif blip_z < player_z-10 then
									dxDrawImage( draw_x-20/2, draw_y-20/2, 20, 20, "blips/"..icon.."-down.png", 0, 0, 0, tocolor(getBlipColor(blip)) )
								else
									dxDrawImage( draw_x-20/2, draw_y-20/2, 20, 20, "blips/"..icon..".png", 0, 0, 0, tocolor(getBlipColor(blip)) )
								end
							else
								scale = scale*11.5
								dxDrawImage( draw_x-20/2, draw_y-20/2, 20, 20, "blips/"..icon..".png" )
							end
						end
					--end
				end
				local player_rx, player_ry, player_rz = getElementRotation( localPlayer )
				dxDrawImage( zero_x-10, zero_y-10, 20, 21, "arquivos/seta.png", 360-player_rz )
			end
		end
end

addEventHandler("onClientKey", getRootElement(), 
	function(key,state) 
		if state and key == "F11" then
			cancelEvent()
			renderData.F11State = not renderData.F11State
			if renderData.F11State then
				addEventHandler( "onClientRender", getRootElement(), drawCustomRadar )
				showChat(false)
			else
				removeEventHandler( "onClientRender", getRootElement(), drawCustomRadar )
				showChat(true)
			end
		end
	end
)

--local x, y = 50 * sx / sx, 50 * sy / sy
--local width, height = sx -50, sy - 50

--------------------
---SZERVER BLIPEK---
--------------------

north = createBlip( 733.1318359375, 3700.951171875, -200, 4, 2, 255, 255, 255, 255) 
setBlipOrdering ( north,  -2000 )



addEventHandler("onClientResourceStart", resourceRoot, function()
	for id, hudComponents in ipairs(hudTable) do
		showPlayerHudComponent(hudComponents, false)
	end
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	for id, hudComponents in ipairs(hudTable) do
		showPlayerHudComponent(hudComponents, true)
	end
end)