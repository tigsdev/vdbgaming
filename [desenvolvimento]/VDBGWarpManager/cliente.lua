local warps = { }
local fadeScreen = fadeCamera
local hitWarp = nil
local warping = false
local textowarp = ""

function makeWarp ( data )
	if ( not data or type ( data ) ~= "table" or not data.pos or not data.toPos ) then
		return false
	end
	local namewarp = data.namewarp
	local cInt = data.cInt or 0
	local cDim = data.cDim or 0
	local tInt = data.tInt or 0
	local tDim = data.tDim or 0
	local size = data.size or 2
	local r, g, b, a = 255, 255, 0, 120
	if ( data.color ) then
		if ( data.color.r ) then r = data.color.r end
		if ( data.color.g ) then g = data.color.g end
		if ( data.color.b ) then b = data.color.b end
		if ( data.color.a ) then a = data.color.a end 
	end
		
	local type = data.type or "arrow"
	local x, y, z = unpack ( data.pos )
	local i = 0

	while ( warps [ i ] ) do
		i = i + 1
	end

	data.namewarp = namewarp
	data.cInt = cInt
	data.cDim = cDim
	data.tInt = tInt
	data.tDim = tDim
	data.size = size
	data.color =  { }
	data.color.r = r
	data.color.g = g
	data.color.b = b
	data.color.a = a
	data.type = type
	data.sResource = getResourceName ( sourceResource or getThisResource() )

	warps [ i ] = Marker.create ( x, y, z, type, size, r, g, b, a )

	setElementData ( warps [ i ], "VDBGWarpManager->WarpData", data, false )

	setElementInterior ( warps [ i ], cInt )
	setElementDimension ( warps [ i ], cDim )

	addEventHandler ( "onClientMarkerHit", warps [ i ], onWarpHit )

	addEventHandler ( "onClientResourceStop", getResourceRootElement ( getResourceFromName ( data.sResource ) ), function ( source )
		local res = getResourceName ( source )
		for i, v in pairs ( warps ) do
			local d = getElementData ( v, "VDBGWarpManager->WarpData" )
			if ( d.sResource == res ) then
				removeEventHandler ( "onClientMarkerHit", v, onWarpHit )
				destroyElement ( v )
				warps [ i ] = nil
			end 
		end 
	end )
end 

function onWarpHit ( p )
	if ( source.dimension == p.dimension and source.interior == p.interior and p == localPlayer ) then
		hitWarp = source
		bindKey ( "E", "down", beginPlayerWarp )
		bindKey ( "e", "down", beginPlayerWarp )
		local data = getElementData ( source, "VDBGWarpManager->WarpData" )
		textowarp = data.namewarp
	end
end

function triggerWarp ( p, source )
	if ( p and isElement ( p ) and getElementType ( p ) == "player" and p == localPlayer and not isPedInVehicle ( p ) ) then
		local int, dim = getElementInterior ( localPlayer ), getElementDimension ( localPlayer )
		if ( int ==  getElementInterior ( source ) and dim == getElementDimension ( source ) ) then
			local data = getElementData ( source, "VDBGWarpManager->WarpData" )
			playSound("arquivos/entrar.mp3")
			
			toggleAllControls ( false )
			fadeScreen ( false )
			setTimer ( function ( data )
				local int = data.tInt
				local dim = data.tDim 
				local x, y, z = unpack ( data.toPos )
				triggerServerEvent ( "VDBGWarpManager->SetPlayerPositionInteriorDimension", localPlayer, x, y, z, int, dim )
				fadeScreen ( true )
				toggleAllControls ( true )
			end, 1000, 1, data )
		end
	end
end 

local prog = 0
local mode = true
local sx_, sy_ = guiGetScreenSize ( )
local sx, sy = sx_/1280, sy_/720
local fonte = dxCreateFont("arquivos/opensans.ttf",12)
local x,y,z = 0,0,0
local location = ""
local city = ""
local cityname = ""

addEventHandler ( "onClientPreRender", root, function ( )
	prog = prog + 0.01
	for i, v in pairs ( warps ) do
		local data = getElementData ( v, "VDBGWarpManager->WarpData" )
		local x, y, z = unpack ( data.pos )
		
		local cx, cy, cz = getElementPosition ( v )

		if ( mode ) then
			ix, iy, iz = interpolateBetween ( cx, cy, z, cx, cy, z+0.5, prog, "InOutQuad" )
		else
			ix, iy, iz = interpolateBetween ( cx, cy, z+0.5, cx, cy, z, prog, "InOutQuad" )
		end
		setElementPosition ( v, x, y, iz )

		if ( prog >= 1.1 ) then
			mode = not mode
			prog = 0
		end
	end 

		if ( hitWarp ) then
		if ( not isElementWithinMarker ( localPlayer, hitWarp ) ) then
			hitWarp = nil
			warping = false
			unbindKey ( "e", "down", beginPlayerWarp )
			unbindKey ( "E", "down", beginPlayerWarp )
		end

		if ( hitWarp and not warping ) then
			if  getElementInterior(localPlayer) == 0 then 
			dxDrawImage(sx_/2-143, sy*600, 286, 56, "arquivos/entrar.png",0,0,0,tocolor(255, 255, 255, 255))		
				x,y,z = getElementPosition(localPlayer)
				cityname = getZoneName ( x, y, z, true )
				if cityname == "Los Santos" then
				city = "#FFFFFF | #428bcaLS"
				elseif cityname == "San Fierro" then
				city = "#FFFFFF | #428bcaSF"
				elseif cityname == "Las Venturas" then
				city = "#FFFFFF | #428bcaLV"
				elseif cityname == "Tierra Robada" then
				city = "#FFFFFF | #428bcaTR"
				elseif cityname == "Bone County" then
				city = "#FFFFFF | #428bcaBC"
				elseif cityname == "Red County" then
				city = "#FFFFFF | #428bcaRC"
				elseif cityname == "Flint County" then
				city = "#FFFFFF | #428bcaFC"
				elseif cityname == "Whetstone" then
				city = "#FFFFFF | #428bcaWT"
				end
			elseif  getElementInterior(localPlayer) ~= 0 then 
			city = ""
			dxDrawImage(sx_/2-143, sy*600, 286, 56, "arquivos/sair.png",0,0,0,tocolor(255, 255, 255, 255))
			end
			dxDrawColorText ( textowarp..city, sx_/2-83, sy*605, sx_, sx*620, tocolor ( 255, 255, 255, 255 ), 1, fonte, "left", "top", nil, nil, nil, nil, nil, nil, nil, nil, 1.5 ,true)
		end
	end 
	
end )

function beginPlayerWarp ( )
	if ( warping ) then return end 
	triggerWarp ( localPlayer, hitWarp )
	warping = true
end 
function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY)
  bx, by, color, scale, font = bx or ax, by or ay, color or tocolor(255,255,255,255), scale or 1, font or "default"
  if alignX then
    if alignX == "center" then
      ax = ax + (bx - ax - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font))/2
    elseif alignX == "right" then
      ax = bx - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
    end
  end
  if alignY then
    if alignY == "center" then
      ay = ay + (by - ay - dxGetFontHeight(scale, font))/2
    elseif alignY == "bottom" then
      ay = by - dxGetFontHeight(scale, font)
    end
  end
   local clip = false
   if dxGetTextWidth(str:gsub("#%x%x%x%x%x%x","")) > bx then clip = true end
  local alpha = string.format("%08X", color):sub(1,2)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  local text = ""
  local broke = false
  while s do
    if cap == "" and col then color = tocolor(getColorFromString("#"..col..alpha)) end
    if s ~= 1 or cap ~= "" then
      local w = dxGetTextWidth(cap, scale, font)
           if clip then
                local text_ = ""
                 for i = 1,string.len(cap) do
                  if dxGetTextWidth(text,scale,font) < bx then
                  text = text..""..string.sub(cap,i,i)
                  text_ = text_..""..string.sub(cap,i,i)
                  else
                  broke = true
                   break
                  end
                 end
                 cap = text_
                end
      dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
      ax = ax + w
      color = tocolor(getColorFromString("#"..col..alpha))
    end
    last = e + 1
    s, e, cap, col = str:find(pat, last)
  end
  if last <= #str and not broke then
    cap = str:sub(last)
                   if clip then
                local text_ = ""
                 for i = 1,string.len(cap) do
                  if dxGetTextWidth(text,scale,font) < bx then
                  text = text..""..string.sub(cap,i,i)
                  text_ = text_..""..string.sub(cap,i,i)
                  else
                  broke = true
                   break
                  end
                 end
                 cap = text_
                end
    dxDrawText(cap, ax, ay, ax + dxGetTextWidth(cap, scale, font), by, color, scale, font)
  end
end