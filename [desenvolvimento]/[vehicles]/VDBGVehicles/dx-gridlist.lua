
local sX,sY = guiGetScreenSize()
local font = "default-bold"

addEvent("onDxLibGridlistClick",true)
addEvent("onDxLibScrollMouse",true)

function dxLibCreateGridlist(gridlistElement,gridlistData,positionX,positionY,sizeX,sizeY,fontSize,emptyString,colorRed,colorGreen,colorBlue,alphaGridlist,coloredLabels,postGUI)
	if not getElementData(gridlistElement,"dxGridlistCreate") then
		setElementData(gridlistElement,"dxGridlistCreate",true,false)
		setElementData(gridlistElement,"dxGridlistScroll",0,false)
		setElementData(gridlistElement,"dxGridlistScrollTo",0,false)
		setElementData(gridlistElement,"dxGridlistSelected",0,false)
		setElementData(gridlistElement,"dxGridlistDataCount",1,false)
		setElementData(gridlistElement,"dxGridlistHover",false,false)
		setElementData(gridlistElement,"dxGridlistDataHover",false,false)
		setElementData(gridlistElement,"dxGridlistTick",getTickCount(),false)
		setElementData(gridlistElement,"dxGridlistScrollHover",false,false)
		setElementData(gridlistElement,"dxGridlistScrollClicked",false,false)
		setElementData(gridlistElement,"dxGridlistDatatable",gridlistData,false)
		local renderTarget = dxCreateRenderTarget(sizeX,sizeY,true)
		setElementData(gridlistElement,"dxGridlistRenderTarget",renderTarget,false)
		return
	end
	if type(gridlistData) == "table" then
		local dataCount = getElementData(gridlistElement,"dxGridlistDataCount")
		if dataCount ~= #gridlistData then
			setElementData(gridlistElement,"dxGridlistDataCount",#gridlistData,false)
			setElementData(gridlistElement,"dxGridlistDatatable",gridlistData,false)
		end
		if getElementData(gridlistElement,"dxGridlistSelected") > #gridlistData then
			setElementData(gridlistElement,"dxGridlistSelected",0,false)
		end
	else
		outputDebugString("dxLib: Data for gridlist must be a table value!")
		return
	end
	setElementData(gridlistElement,"dxGridlistHover",false,false)
	if isCursorHover(positionX,positionY,sizeX,sizeY) then
		setElementData(gridlistElement,"dxGridlistHover",true,false)
	end
	local renderTarget = getElementData(gridlistElement,"dxGridlistRenderTarget")
	if renderTarget then
		local rowSize = dxGetFontHeight(fontSize,font)+10
		local gridlistTick = getElementData(gridlistElement,"dxGridlistTick")
		local scroll = getElementData(gridlistElement,"dxGridlistScroll")
		local scrollTo = getElementData(gridlistElement,"dxGridlistScrollTo")
		local visibleRows = sizeY/rowSize
		if #gridlistData*rowSize > sizeY then
			if scrollTo < 0 then
				scrollTo = 0
				setElementData(gridlistElement,"dxGridlistScrollTo",0,false)
			elseif scrollTo > #gridlistData-visibleRows then
				scrollTo = #gridlistData-visibleRows
				setElementData(gridlistElement,"dxGridlistScrollTo",#gridlistData-visibleRows,false)
			end
			if scroll ~= scrollTo then
				local tick = getTickCount() - gridlistTick
				local progress = tick/500
				if progress >= 1 then progress = 1 end
				scroll = interpolateBetween(scroll,0,0,scrollTo,0,0,progress,"Linear")
				setElementData(gridlistElement,"dxGridlistScroll",scroll,false)
			end
		else
			scroll = 0
			setElementData(gridlistElement,"dxGridlistScroll",0,false)
			setElementData(gridlistElement,"dxGridlistScrollTo",0,false)
		end
		local scrollPosition = rowSize*scroll
		dxSetRenderTarget(renderTarget)
		dxDrawRectangle(0,0,sizeX,sizeY,tocolor(15,15,15,160))
		setElementData(gridlistElement,"dxGridlistDataHover",false,false)
		local selectedRow = getElementData(gridlistElement,"dxGridlistSelected")
		if #gridlistData ~= 0 then
			for id,dataPart in pairs(gridlistData) do
				if (positionY+(rowSize*(id-1))-scrollPosition)>=positionY-rowSize and (positionY+(rowSize*(id-1))-scrollPosition)<=positionY+sizeY+rowSize then
					if isCursorHover(positionX,positionY+(rowSize*(id-1))-scrollPosition,sizeX,rowSize) and getElementData(gridlistElement,"dxGridlistHover") then
						setElementData(gridlistElement,"dxGridlistDataHover",id,false)
						if selectedRow == id then
							dxDrawRectangle(0,rowSize*(id-1)-scrollPosition,sizeX,rowSize,tocolor(colorRed,colorGreen,colorBlue,220),false)
							dxDrawText(tostring(dataPart),5,rowSize*(id-1)+5-scrollPosition,sizeX,rowSize*id-5-scrollPosition,tocolor(255,255,255,255),fontSize,font,"left","center",true,false,false,coloredLabels or false)
						else
							dxDrawRectangle(0,rowSize*(id-1)-scrollPosition,sizeX,rowSize,tocolor(50,50,50,200),false)
							dxDrawText(tostring(dataPart),5,rowSize*(id-1)+5-scrollPosition,sizeX,rowSize*id-5-scrollPosition,tocolor(255,255,255,255),fontSize,font,"left","center",true,false,false,coloredLabels or false)
						end
					else
						if selectedRow == id then
							dxDrawRectangle(0,rowSize*(id-1)-scrollPosition,sizeX,rowSize,tocolor(colorRed,colorGreen,colorBlue,200),false)
							dxDrawText(tostring(dataPart),5,rowSize*(id-1)+5-scrollPosition,sizeX,rowSize*id-5-scrollPosition,tocolor(255,255,255,255),fontSize,font,"left","center",true,false,false,coloredLabels or false)
						else
							dxDrawRectangle(0,rowSize*(id-1)-scrollPosition,sizeX,rowSize,tocolor(20,20,20,150),false)
							dxDrawText(tostring(dataPart),5,rowSize*(id-1)+5-scrollPosition,sizeX,rowSize*id-5-scrollPosition,tocolor(255,255,255,255),fontSize,font,"left","center",true,false,false,coloredLabels or false)
						end
					end
				end
			end
		else
			dxDrawText(tostring(emptyString),6,4,sizeX,rowSize-5,tocolor(0,0,0,255),fontSize,font,"left","center",true,false,false,coloredLabels or false)
			dxDrawText(tostring(emptyString),5,5,sizeX,rowSize-5,tocolor(200,15,15,255),fontSize,font,"left","center",true,false,false,coloredLabels or false)
		end
		dxSetRenderTarget()
		dxDrawImage(positionX,positionY,sizeX,sizeY,renderTarget,0,0,0,tocolor(255,255,255,alphaGridlist or 255),postGUI or false)
		dxDrawLine(positionX,positionY,positionX+sizeX,positionY,tocolor(0,0,0,alphaGridlist or 255),1,postGUI or false)
		dxDrawLine(positionX,positionY+sizeY,positionX+sizeX,positionY+sizeY,tocolor(0,0,0,alphaGridlist or 255),1,postGUI or false)
		dxDrawLine(positionX+sizeX,positionY,positionX+sizeX,positionY+sizeY,tocolor(0,0,0,alphaGridlist or 255),1,postGUI or false)
		dxDrawLine(positionX,positionY,positionX,positionY+sizeY,tocolor(0,0,0,alphaGridlist or 255),1,postGUI or false)
		local scrollBar = {}
		if #gridlistData*rowSize > sizeY then
			local hidenRows = #gridlistData - visibleRows
			if ( (#gridlistData-visibleRows) % 1 ) ~= 1 then
				hidenRows = 1
			end
			scrollBar.size = (sizeY - (sizeY/3)) / hidenRows
			if scrollBar.size<=sizeY/8 then
				scrollBar.size = sizeY/8
			end
			scrollBar.position = ((sizeY-scrollBar.size)/(#gridlistData-visibleRows))*scroll
			
			dxDrawRectangle(positionX+sizeX+1,positionY,sX*0.02,sizeY,tocolor(40,40,40,100*((alphaGridlist or 255)/255)),postGUI)
			dxDrawRectangle(positionX+sizeX+1,positionY+scrollBar.position,sX*0.02,scrollBar.size,tocolor(colorRed,colorGreen,colorBlue,255*((alphaGridlist or 255)/255)),postGUI)
			if getElementData(gridlistElement,"dxGridlistScrollClicked") then
				if getKeyState("mouse1") then
					local x,y = getCursorPosition()
					local x,y = x*sX,y*sY
					local newPos = y-positionY
					local barSize = (((#gridlistData-visibleRows)*rowSize)*(newPos/sizeY))/rowSize
					setElementData(gridlistElement,"dxGridlistScroll",barSize,false)
					setElementData(gridlistElement,"dxGridlistScrollTo",barSize,false)
				else
					setElementData(gridlistElement,"dxGridlistScrollClicked",false,false)
				end
			else
				if isCursorHover(positionX+sizeX,positionY+scrollBar.position,sX*0.02,scrollBar.size) then
					setElementData(gridlistElement,"dxGridlistScrollHover",true,false)
				else
					setElementData(gridlistElement,"dxGridlistScrollHover",false,false)
				end
			end
		end
	else
		outputDebugString("dxLib: Cant find a render target")
	end
end

function isCursorHover(posX,posY,sizeX,sizeY)
	local x,y = 0,0
	if isCursorShowing() then x,y = getCursorPosition() x,y = sX*x,sY*y else return false end
	if x>=posX and x<=posX+sizeX and y>=posY and y<=posY+sizeY then
		return true
	else
		return false
	end
end

function onDxLibPlayerClick(button,state)
	if isCursorShowing() then
		if button == "left" and state == "down" then
			for i,dxGridlist in pairs(getElementsByType("dxGridlist")) do
				if getElementData(dxGridlist,"dxGridlistHover") then
					if getElementData(dxGridlist,"dxGridlistDataHover") then
						if getElementData(dxGridlist,"dxGridlistSelected") ~= tonumber(getElementData(dxGridlist,"dxGridlistDataHover")) then
						  setElementData(dxGridlist,"dxGridlistSelected",tonumber(getElementData(dxGridlist,"dxGridlistDataHover")),false)
						  triggerEvent("onDxLibGridlistClick",getRootElement(),dxGridlist)
						end
					end
				elseif getElementData(dxGridlist,"dxGridlistScrollHover") then
					setElementData(dxGridlist,"dxGridlistScrollClicked",true,false)
				end
			end
		end
	end
end
addEventHandler("onClientClick",getRootElement(),onDxLibPlayerClick)


function onDxLibMouseScroll(keyPressed)
	if keyPressed == "mouse_wheel_up" then
		for i,dxGridlist in pairs(getElementsByType("dxGridlist")) do
			if getElementData(dxGridlist,"dxGridlistHover") then
				setElementData(dxGridlist,"dxGridlistTick",getTickCount(),false)
				setElementData(dxGridlist,"dxGridlistScrollTo",getElementData(dxGridlist,"dxGridlistScrollTo")-(3),false)
			end
		end
		triggerEvent("onDxLibScrollMouse",getRootElement(),"up")
	elseif keyPressed == "mouse_wheel_down" then
		for i,dxGridlist in pairs(getElementsByType("dxGridlist")) do
			if getElementData(dxGridlist,"dxGridlistHover") then
				setElementData(dxGridlist,"dxGridlistTick",getTickCount(),false)
				setElementData(dxGridlist,"dxGridlistScrollTo",getElementData(dxGridlist,"dxGridlistScrollTo")+(3),false)
			end
		end
		triggerEvent("onDxLibScrollMouse",getRootElement(),"down")
	end
end
bindKey("mouse_wheel_up","down",onDxLibMouseScroll)
bindKey("mouse_wheel_down","down",onDxLibMouseScroll)


function dxLibGridlistGetSelectedRowText(gridlistElement)
	if isElement(gridlistElement) or not getElementData(gridlistElement,"dxGridlistCreate") then
		if getElementData(gridlistElement,"dxGridlistSelected") and getElementData(gridlistElement,"dxGridlistSelected") ~= 0 then
			local data = getElementData(gridlistElement,"dxGridlistDatatable")
			local row = tonumber(getElementData(gridlistElement,"dxGridlistSelected"))
			local gridlistData = data[row]
			return gridlistData
		else
			return false
		end
	else
		outputDebugString("dxLib: Bad element!")
	end
end

function dxLibGridlistGetSelectedRowNumber(gridlistElement)
	if isElement(gridlistElement) or not getElementData(gridlistElement,"dxGridlistCreate") then
		if getElementData(gridlistElement,"dxGridlistSelected") then
			local row = tonumber(getElementData(gridlistElement,"dxGridlistSelected"))
			if row then
				return row
			else
				return false
			end
		else
			return false
		end
	else
		outputDebugString("dxLib: Bad element!")
	end
end


--####################################################################
--##		Testing													##
--####################################################################


--[[local button = createElement("dxButton")
local gridlist = createElement("dxGridlist")
local edit = createElement("dxEdit")

gridData = {}


for i=1,2000 do
	gridData[i] = " "..i
end

showCursor(true)

function test()
	dxLibCreateButton(button,350,760,400,50,"Find me!",3,255,0,120,0,255,0,255,false)
	dxLibCreateGridlist(gridlist,gridData,350,150,400,600,3,50,0,255,255)
	dxLibCreateEdit(edit,350,100,400,40,"Search player...","person",50,50,50,255)
end
addEventHandler("onClientRender",getRootElement(),test)]]


--####################################################################
--##		Copyrights © & ™ All rights reserved, Apple 2013.		##
--####################################################################

if fileExists('dx-gridlist.lua') then
	fileDelete('dx-gridlist.lua')
end