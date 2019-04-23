--[[addEventHandler( "onClientElementStreamIn", getRootElement(),
    function ()
		outputChatBox (tostring(getElementType(source)))
		if getElementType (source) == "object" then
			--if isObjectBreakable (source) then
				--outputChatBox ("set")
				setObjectBreakable (source,false)
				--setElementFrozen (source,true)
			--end
		end
	end
)]]

--[[addEventHandler ("onClientResourceStart",getResourceRootElement(getThisResource()),
	function ()
		local el = getElementsByType ("object")
		for k,v in ipairs(el) do
			setObjectBreakable (v,false)
			setElementFrozen (v,true)
		end
	end
)]]

engineSetModelLODDistance ( 1558, 400 )
engineSetModelLODDistance ( 9818, 400 )

local list = {}
list[3465] = true -- stacja
list[1686] = true -- jw
list[1244] = true -- jw
list[1676] = true -- jw
list[1215] = true -- swiatelko
list[1214] = true -- betonowy słup
list[1257] = true -- przystanek
list[2942] = true -- bankomat
list[1319] = true -- słupek
list[1558] = true -- tábla
list[9818] = true -- tábla 2
list[1649] = true -- ablak

addEventHandler ("onClientResourceStart",getResourceRootElement(getThisResource()),
	function ()
		local el = getElementsByType ("object")
		for k,v in ipairs(el) do
			local model = getElementModel (v)
			if list[model] then
				setObjectBreakable (v,false)
				setElementFrozen (v,true)
			end
		end
	end
)