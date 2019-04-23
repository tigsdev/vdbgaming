function onGuiHandbrakeStateChange(state, veh)
	if state == true then
		setElementFrozen(veh, true)
		setElementData(veh, "freiodemao", true)
	else
		setElementFrozen(veh, false)
		setElementData(veh, "freiodemao", false)
	end
end
addEvent("onGuiHandbrakeStateChange", true)
addEventHandler("onGuiHandbrakeStateChange", getRootElement(), onGuiHandbrakeStateChange)