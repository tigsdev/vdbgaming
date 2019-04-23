addEventHandler( "onPlayerQuit", getRootElement(),
	function() 
			local conta = getPlayerAccount(source)
            local r = getElementData ( source, "VDBGCrossR" ) 
			local g = getElementData ( source, "VDBGCrossG" ) 
			local b = getElementData ( source, "VDBGCrossB" ) 
			local a = getElementData ( source, "VDBGCrossA" ) 
            setAccountData ( conta, "CrossR", r )
            setAccountData ( conta, "CrossG", g )
            setAccountData ( conta, "CrossB", b )
            setAccountData ( conta, "CrossA", a )
	end
)

addEventHandler( "onPlayerLogin", getRootElement(),
	function() 
		local conta = getPlayerAccount(source)
			if (conta) then
            local r = getAccountData ( conta, "CrossR" )
            local g = getAccountData ( conta, "CrossG" )
            local b = getAccountData ( conta, "CrossB" )
            local a = getAccountData ( conta, "CrossA" )
			if r then
			setElementData ( source, "VDBGCrossR", r )
			setElementData ( source, "VDBGCrossG", g )
			setElementData ( source, "VDBGCrossB", b )
			setElementData ( source, "VDBGCrossA", a )
			end
			end
		end
)

addEventHandler ("onPlayerJoin", getRootElement(),
    function ()
        	setElementData ( source, "VDBGCrossR", 0   )
			setElementData ( source, "VDBGCrossG", 255 )
			setElementData ( source, "VDBGCrossB", 205 )
			setElementData ( source, "VDBGCrossA", 255 )
end)
 