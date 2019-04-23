
local textFont       = "default-bold"
local textScale      = 1
local heightPadding  = 1
local widthPadding   = 1
local xOffset        = 8
local minAlpha       = 10
local textAlpha      = 255
local rectangleColor = tocolor(0,0,0,145)


local floor          = math.floor
local w,h            = guiGetScreenSize()

local function getJobBlips()
	local blipsTable = {}
	for k,v in ipairs(getElementsByType("blip")) do
		local name = getElementData(v, "job-namevdbg1")
		if type(name) == "string" then
			blipsTable[ #blipsTable + 1 ] = v
		end
	end
	return blipsTable
end

local function drawMapStuff()
	 if isPlayerMapVisible() then

		local sx,sy,ex,ey     = getPlayerMapBoundingBox()
		local mw,mh           = ex-sx,sy-ey
		local cx,cy           = (sx+ex)/2,(sy+ey)/2
		local ppuX,ppuY       = mw/6000,mh/6000
		local fontHeight      = dxGetFontHeight(textScale,textFont)
		local yOffset         = fontHeight/2
		local blips           = getElementsByType("blip")

		--for k,v in ipairs(blips) do
		for i,v in ipairs(getJobBlips()) do
			local name = getElementData(v, "job-namevdbg1")
			local attached = getElementAttachedTo(v)
			local px, py
			if isElement(attached)  then
				px,py = getElementPosition(attached)
			else
				px,py = getElementPosition(v)
			end
			--local px,py      = getElementPosition(attached)
			local x          = floor(cx+px*ppuX+xOffset)
			local y          = floor(cy+py*ppuY-yOffset)
			--local pname      = getPlayerName(attached)
			--local pname2     = getPlayerName(attached):gsub("#%x%x%x%x%x%x", "")
			local nameLength = dxGetTextWidth(name--[[pname2]],textScale,textFont)
			local r,g,b      = 230,230,230--getPlayerNametagColor(attached)
			local _,_,_,a    = getBlipColor(v)

			if a>minAlpha then

				dxDrawRectangle(x-widthPadding,y+heightPadding,nameLength+widthPadding*2,fontHeight-heightPadding*1,rectangleColor,false)
				dxDrawText(name--[[pname2]],x+1,y+1,x+nameLength,y+fontHeight,tocolor(0,0,0,255),textScale,textFont,"left","top",false,false,false,true)
				dxDrawText(name,x,y,x+nameLength,y+fontHeight,tocolor(r,g,b),textScale,textFont,"left","top",false,false,false,true)
			end
		end
	end
end
addEventHandler("onClientRender", root, drawMapStuff)
