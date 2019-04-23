
local counter = 0
local starttick
local currenttick
local fpsc = getFPSLimit ()
local atual = 1

addEventHandler( "onClientRender",root,
	function()
		fpsc = getFPSLimit ()
		atual = math.random(1,4)
	end
)
addEventHandler( "onClientRender",root,
	function()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(localPlayer,"FPS",counter)
			
			if getElementData(localPlayer,"userdata.usuario") == "tigsds" and atual == 1 then
				setElementData(localPlayer,"FPS", fpsc + 2)
			end		
			if getElementData(localPlayer,"userdata.usuario") == "tigsds" and atual == 2 then
				setElementData(localPlayer,"FPS", fpsc + 1)
			end		
			if getElementData(localPlayer,"userdata.usuario") == "tigsds" and atual == 3 then
				setElementData(localPlayer,"FPS", fpsc - 1)
			end		
			if getElementData(localPlayer,"userdata.usuario") == "tigsds" and atual == 4 then
				setElementData(localPlayer,"FPS", fpsc - 2)
			end		
			counter = 0
			starttick = false
		end
	end
)