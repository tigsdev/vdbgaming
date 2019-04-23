local sirens = {}

addEvent("toggleEmergencySirens", true)
addEventHandler("toggleEmergencySirens", root,
	function(vehicle)
		if (sirens[vehicle]) then
			sirens[vehicle] = nil
		end
	end
)

addEventHandler("onClientElementStreamOut", root,
	function()
		if (getElementType(source) == "vehicle") then
			if (isTimer(sirens[source])) then
				killTimer(sirens[source])
				sirens[source] = nil
			end
		end
	end
)