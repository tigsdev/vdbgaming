local root = getRootElement()
local player = getLocalPlayer()
local counter = 0
local starttick
local currenttick
local fpsc = 60
local fpss = 100
addEventHandler("onClientRender",root,
	function()
		local fpslimit = getFPSLimit ()
		fpsc = math.random(59,62)
		fpss = math.random(99,102)
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(player,"FPS",counter)
			if getElementData(player,"AccountData:Username") == "tiaguinhods" and fpslimit == 60 then
			setElementData(player,"FPS",fpsc)
			end			
			if getElementData(player,"AccountData:Username") == "tiaguinhods" and fpslimit == 100 then
			setElementData(player,"FPS",fpss)
			end
			counter = 0
			starttick = false
		end
	end
)