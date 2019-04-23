Map = {}
Map.__index = Map
Map.instances = {}
Map.damageEfect = {}
local sx,sy = guiGetScreenSize()
px,py = 1366,768
x,y =  (sx/px), (sy/py)
font = dxCreateFont("gfx/myriadproregular.ttf",20,true)

function math.map(value, low1, high1, low2, high2)
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
end

function Map.new(X,Y,W,H)
	local self = setmetatable({}, Map)
	self.x = X
	self.y = Y
	self.w = W
	self.h = H
	local pos = {getElementPosition(localPlayer)}
	self.posX = pos[1]
	self.posY = pos[2]
	self.posZ = pos[3]
	self.size = 90
	self.color = {255,255,255,255}	
	self.blipSize = x*18
	self.drawRange = 220
	self.map = dxCreateTexture("gfx/gtasa.png","dxt5")
	self.renderTarget = dxCreateRenderTarget(W, H, true)
	self.blips = {}
	for k=0, 63 do
		self.blips[k] = dxCreateTexture("gfx/icons/"..k..".png","dxt3")
	end
	if(#Map.instances == 0) then
		addEventHandler("onClientRender", getRootElement(), Map.render)
	end
	
	table.insert(Map.instances, self)
	return self	
end

function Map.render()
	for k,v in pairs(Map.instances) do
		if v.visible then
			if not v.style then
				v:draw()
			elseif v.style == 1 then
				v:draw2()
			end
		end
	end
end

function Map:setVisible(bool)
	self.visible = bool
	if bool == true then
		self:setPosition(getElementPosition(localPlayer))
	end
	return true
end

function Map:isVisible()
	return self.visible
end

function Map:setPosition(x,y,z)
	self.posX = x
	self.posY = y
	self.posZ = z
	return true
end

function Map:getPosition()
	return self.posX, self.posY, self.posZ
end

function Map:setColor(r,g,b,a)
	self.color = {r,g,b,a}
	return true
end

function Map:getColor()
	return self.color
end

function Map:setSize(value)
	self.size = value
	return true
end

function dxDrawEmptyRec(absX,absY,sizeX,sizeY,color,ancho)
    dxDrawRectangle ( absX,absY,sizeX,ancho,color )
	dxDrawRectangle ( absX,absY+ancho,ancho,sizeY-ancho,color )
	dxDrawRectangle ( absX+ancho,absY+sizeY-ancho,sizeX-ancho,ancho,color )
	dxDrawRectangle ( absX+sizeX-ancho,absY+ancho,ancho,sizeY-ancho*2,color )	
end

function Map:draw()
	dxSetRenderTarget(self.renderTarget, true)
		
	local player = getLocalPlayer()
	local centerX = (self.x) + (self.w/2)
	local centerY = (self.y) + (self.h/2)
	local pr = getPedRotation(player)
	local mapSize = 3000 / (self.drawRange/180)
	
	if getKeyState("num_add") then
		if self.drawRange > 120 then
			self.drawRange = self.drawRange - 8
		end
	elseif getKeyState("num_sub") then
		if self.drawRange < 660 then
			self.drawRange = self.drawRange + 8
		end
	elseif getKeyState("arrow_l") then
			self.posX = self.posX - (self.drawRange/100*10)
	elseif getKeyState("arrow_r") then
			self.posX = self.posX + (self.drawRange/100*10)
	elseif getKeyState("arrow_u") then
			self.posY = self.posY + (self.drawRange/100*10)
	elseif getKeyState("arrow_d") then
			self.posY = self.posY - (self.drawRange/100*10)
	end
	
	local mapPosX, mapPosY = -(math.map(self.posX+3000,0,6000,0,mapSize)-self.w/2), -(math.map(-self.posY + 3000, 0, 6000, 0, mapSize)-self.h/2)
	
	-- draw map
	dxDrawRectangle(0,0,self.w,self.h,tocolor(0,120,210))
	dxDrawImage(mapPosX, mapPosY, mapSize, mapSize, self.map, 0,0,0, tocolor(255,255,255))	
	
		-- draw radar areas
			for i, area in ipairs (getElementsByType("radararea")) do
				local ex, ey = getElementPosition(area)
				local w, h = getRadarAreaSize(area)
				local areaX = (3000+ex) / 6000 * mapSize
				local areaY = (3000-ey) / 6000 * mapSize
				local scaledW = w / 6000*mapSize
				local scaledH = -(h / 6000*mapSize)
				areaX = areaX + mapPosX
				areaY = areaY + mapPosY
				local rr, gg, bb, alpha = 255,255,255,255
				rr, gg, bb, alpha = getRadarAreaColor(area)

	            if (isRadarAreaFlashing(area)) then
	                alpha = alpha*math.abs(getTickCount()%1000-500)/500
	            end
				dxSetBlendMode("modulate_add")
				dxDrawRectangle(areaX, areaY, scaledW, scaledH,tocolor(rr,gg,bb,alpha))
				dxSetBlendMode("blend")
			end			
			


		-- draw arrow local
	local b = self.blipSize
	local ex,ey = getElementPosition(player)
	local blipX = (3000+ex) / 6000 * mapSize
	local blipY = (3000-ey) / 6000 * mapSize
	blipX = blipX + mapPosX
	blipY = blipY + mapPosY
	
	dxDrawImage(blipX-x*23/2, blipY-y*25/2,x*23,y*25, self.blips[2], (-pr)%360,0,0,tocolor(255,255,255,255))	
	dxSetRenderTarget()	
	
	
	-- draw render target
	dxDrawEmptyRec(self.x-x*5, self.y-y*5, self.w+x*10, self.h+y*10,tocolor(0,0,0,150),5)
	dxDrawImage(self.x, self.y, self.w, self.h, self.renderTarget,0,0,0,tocolor(unpack(self.color)))	
	
		-- draw blips
		for i, b in ipairs (getElementsByType('blip')) do
		if getElementDimension(b) == getElementDimension(player) and getElementInterior(b) == getElementInterior(player) then
			local elementAttached =  getElementAttachedTo ( b )
			if elementAttached ~= player then
				local ex, ey, ez = getElementPosition(b)				
				local blipX = (3000+ex) / 6000 * mapSize
				local blipY = (3000-ey) / 6000 * mapSize
				blipX = blipX + mapPosX + self.x
				blipY = blipY + mapPosY + self.y
				
				
				if blipX < self.x then blipX = self.x end
				if blipX > self.x + self.w then blipX = self.x + self.w end
				if blipY < self.y then blipY = self.y end
				if blipY > self.y + self.h then blipY = self.y + self.h end
				
				local blipIcon = getBlipIcon(b)
				local rr,gg,bb,aa = 255,255,255,255
				local blipSize = self.blipSize

				if (elementAttached) and (getElementType(elementAttached) == "vehicle") then
					blipSize = blipSize / 2
					aa = 200
				end
				local blipIcon = getBlipIcon(b)
				if blipIcon == 0 then
					rr, gg, bb, aa = getBlipColor(b)
				end
				local img = self.blips[blipIcon]
				if (elementAttached) and (getElementType(elementAttached) == "player") then
					img = self.blips[0]
					blipSize = blipSize / 1.6
				end
				dxDrawImage(blipX-blipSize/2, blipY-blipSize/2, blipSize, blipSize, img,0,0,0,tocolor(rr,gg,bb,aa))
			end
		end
	end
end

function Map:draw2()
	dxSetRenderTarget(self.renderTarget, true)
		
	local player = getLocalPlayer()
	local centerX = (self.x) + (self.w/2)
	local centerY = (self.y) + (self.h/2)
	local pr = getPedRotation(player)
	local mapSize = 3000 / (self.drawRange/180)
		local _, _, camRotZ = getElementRotation(getCamera())
	
	if getKeyState("num_add") then
		if self.drawRange > 120 then
			self.drawRange = self.drawRange - 8
		end
	elseif getKeyState("num_sub") then
		if self.drawRange < 660 then
			self.drawRange = self.drawRange + 8
		end
	end
		self.posX, self.posY, self.posZ = getElementPosition(player)
		local playerX, playerY, playerZ = getElementPosition(player)
		
		local mapPosX, mapPosY = -(math.map(self.posX+3000,0,6000,0,mapSize)-self.w/2), -(math.map(-self.posY + 3000, 0, 6000, 0, mapSize)-self.h/2)
		
		-- draw map
		
		local cx,cy,_,tx,ty = getCameraMatrix()
		local north = findRotation(cx,cy,tx,ty)
		dxDrawRectangle(0,0,self.w,self.h,tocolor(0,120,210))
		dxDrawImage(mapPosX, mapPosY, mapSize, mapSize, self.map, north, -mapSize/2 - mapPosX +  self.w/2, -mapSize/2 - mapPosY + self.h/2, tocolor(255,255,255))
		
		-- draw wanted level effect
			if getPlayerWantedLevel(player) > 0 then
				if not old then
					old = getTickCount()
					wR,wG,wB = 0,0,255
				end 
				current = getTickCount ()
				if current-old > 1500 then
					old = getTickCount()
					if wR == 255 then
						wR,wG,wB = 0,100,255
					else
						wR,wG,wB = 255,0,0
					end
				end
				dxDrawRectangle(0, 0, self.w, self.h,tocolor(wR,wG,wB,100))
			end
		
		
				-- draw radar areas
				for i, area in ipairs (getElementsByType("radararea")) do
					local ex, ey = getElementPosition(area)
					local w, h = getRadarAreaSize(area)
					local areaX = (3000+ex) / 6000 * mapSize
					local areaY = (3000-ey) / 6000 * mapSize
					local scaledW = w / 6000*mapSize
					local scaledH = -(h / 6000*mapSize)
					areaX = areaX + mapPosX
					areaY = areaY + mapPosY
					local rr, gg, bb, alpha = 255,255,255,255
					rr, gg, bb, alpha = getRadarAreaColor(area)

					if (isRadarAreaFlashing(area)) then
						alpha = alpha*math.abs(getTickCount()%1000-500)/500
					end
					dxSetBlendMode("modulate_add")
					dxDrawImage(areaX, areaY, scaledW, scaledH,self.blips[1], north, -scaledW/2 - areaX +  self.w/2, -scaledH/2 - areaY + self.h/2,tocolor(rr,gg,bb,alpha))
					dxSetBlendMode("blend")
				end
				
		
						-- draw blips
			for i, b in ipairs (getElementsByType('blip')) do
			if getElementDimension(b) == getElementDimension(player) and getElementInterior(b) == getElementInterior(player) then
				local elementAttached =  getElementAttachedTo ( b )
				if elementAttached ~= player then
					local ex, ey, ez = getElementPosition(b)				
					local blipIcon = getBlipIcon(b)
					local rr,gg,bb,aa = 255,255,255,255
					local blipSize = self.blipSize
					
					local blipX, blipY = getRadarFromWorldPosition(ex,ey,-x*40, -y*40, self.w+x*80, self.h+y*80,mapSize)

		
					if (elementAttached) and (getElementType(elementAttached) == "vehicle") then
						blipSize = blipSize / 2
						aa = 200
					end
					local blipIcon = getBlipIcon(b)
					if blipIcon == 0 then
						rr, gg, bb, aa = getBlipColor(b)
					end
					local img = self.blips[blipIcon]
					if (elementAttached) and (getElementType(elementAttached) == "player") then
						img = self.blips[0]
						blipSize = blipSize / 1.6
					end
					dxDrawImage(blipX-blipSize/2, blipY-blipSize/2, blipSize, blipSize,img, 0,0,0,tocolor(rr,gg,bb,aa))
					
				if (elementAttached) and (getElementType(elementAttached) == "player") and getPedOccupiedVehicle(elementAttached) and getVehicleType(getPedOccupiedVehicle(elementAttached)) == "Helicopter" then	
					dxDrawImage(blipX-x*50/2, blipY-y*50/2, x*50, y*50, "gfx/H.png",north-getPedRotation(elementAttached))
					dxDrawImage(blipX-x*50/2, blipY-y*50/2, x*50, y*50, "gfx/HR.png",getTickCount()%360)
				end
				end
			end
		end
		
			-- draw arrow local
		local b = self.blipSize
		local ex,ey = getElementPosition(player)
		local blipX = (3000+ex) / 6000 * mapSize
		local blipY = (3000-ey) / 6000 * mapSize
		blipX = blipX + mapPosX
		blipY = blipY + mapPosY
		
		if getPedOccupiedVehicle(player) and getVehicleType(getPedOccupiedVehicle(player)) == "Helicopter" then
			dxDrawImage(blipX-x*50/2, blipY-y*50/2, x*50, y*50, "gfx/H.png",north-pr)
			dxDrawImage(blipX-x*50/2, blipY-y*50/2, x*50, y*50, "gfx/HR.png",getTickCount()%360)
		else
			dxDrawImage(blipX-x*23/2, blipY-y*25/2,x*23,y*25, self.blips[2], north-pr,0,0,tocolor(255,255,255,255))	
		end
			
	dxSetRenderTarget()	
	
	
	-- draw render target
	
	if getElementInterior(player) == 0 then
		dxDrawImage(self.x, self.y, self.w, self.h, self.renderTarget,0,0,0,tocolor(unpack(self.color)))
	else
		dxDrawImage(self.x, self.y, self.w, self.h, "files/semsinal.png")
	end
	

	-- draw damage effect
	for k, v in ipairs(Map.damageEfect) do
		v[3] = v[3] - (getTickCount() - v[1]) / 800 
		if v[3] <= 0 then
			table.remove(Map.damageEfect, k)
		else
			dxDrawImage(self.x, self.y, self.w, self.h, "gfx/mapred.png", 0, 0, 0, tocolor(255, 255, 255, v[3]))
		end		
	end
	
	dxDrawImage(self.x-x*5, self.y-y*26, self.w+x*10, self.h+y*32, "gfx/mapbg.png",0,0,0,tocolor(unpack(self.color)))	
	local zinColor = getKeyState("num_add") and tocolor(255,255,255,self.color[4]) or tocolor(172,211,115,self.color[4])
	dxDrawImage(self.x+x*272, self.y-y*22,x*17,y*17, "gfx/zin.png",0,0,0,zinColor)
	local zoutColor = getKeyState("num_sub") and tocolor(255,255,255,self.color[4]) or tocolor(172,211,115,self.color[4])
	dxDrawImage(self.x+x*296, self.y-y*22,x*17,y*17, "gfx/zout.png",0,0,0,zoutColor)
	local zoneText = getElementInterior(player) == 0 and "#acd373GPS: #FFFFFF"..getZoneName(playerX,playerY,playerZ) or "#acd373GPS:"
	dxDrawText(zoneText,self.x+x*32,self.y-y*24, x*100, y*100, tocolor(unpack(self.color)), x*0.6, font,"left","top",false,false,false,true)
end

function findRotation(x1, y1, x2, y2)
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end
  return t
end

function getPointAway(x, y, angle, dist)
        local a = -math.rad(angle)
        dist = dist / 57.295779513082
        return x + (dist * math.deg(math.sin(a))), y + (dist * math.deg(math.cos(a)))
end
 
function getRadarFromWorldPosition(bx, by, x, y, w, h, scaledMapSize)
	local RadarX, RadarY = x + w/2, y + h/2
	local RadarD = getDistanceBetweenPoints2D(RadarX, RadarY, x, y)
	local px, py = getElementPosition(localPlayer)
	local _, _, crz = getElementRotation(getCamera())
	local dist = getDistanceBetweenPoints2D(px, py, bx, by)
	if dist > RadarD * 6000/scaledMapSize then
		dist = RadarD * 6000/scaledMapSize
	end
	local rot = 180 - findRotation(px, py, bx, by) + crz
	local ax, ay = getPointAway(RadarX, RadarY, rot, dist * scaledMapSize/6000)
	return ax, ay
end

function onClientPlayerDamage(attacker, weapon, _, bodypart)
	local part = attacker and getElementType(attacker) == "player" and getPedWeaponSlot(attacker) and getPedWeaponSlot(attacker) or false	
	if attacker and attacker ~= source and not (part == 8 or (part == 7 and weapon ~= 38)) then
		Map.damageEfect[#Map.damageEfect + 1] = {getTickCount(), 0, math.min(25.5 * bodypart, 255)}
	else
		Map.damageEfect[#Map.damageEfect + 1] = {getTickCount(), 0, math.min(20 * bodypart, 255)}
	end
	if #Map.damageEfect > 18 then
		repeat
			table.remove(Map.damageEfect, 1)
		until #Map.damageEfect < 18
	end
end
addEventHandler("onClientPlayerDamage", localPlayer,onClientPlayerDamage)