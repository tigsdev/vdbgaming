local lastClick = getTickCount()

addEventHandler ("onClientRender",getRootElement(),
	function ()
		local cTick = getTickCount ()
		if cTick-lastClick >= 900000 then
			if getElementData(getLocalPlayer(),"afk") == false then
				local hp = getElementHealth (getLocalPlayer())
				if hp > 0 then
					setElementData (getLocalPlayer(),"afk",true)
				end
			end
		end
	end
)

addEventHandler( "onClientRestore", getLocalPlayer(),
	function ()
		lastClick = getTickCount ()
		setElementData (getLocalPlayer(),"afk",false)
	end
)

addEventHandler( "onClientMinimize", getRootElement(),
	function ()
		setElementData (getLocalPlayer(),"afk",true)
	end
)

addEventHandler( "onClientCursorMove", getRootElement( ),
    function ( x, y )
		lastClick = getTickCount ()
		if getElementData(getLocalPlayer(),"afk") == true then
			setElementData (getLocalPlayer(),"afk",false)
		end
    end
)

addEventHandler("onClientKey", getRootElement(), 
	function ()
		
		lastClick = getTickCount ()
		if getElementData(getLocalPlayer(),"afk") == true then
			setElementData (getLocalPlayer(),"afk",false)
		end
	end
)

