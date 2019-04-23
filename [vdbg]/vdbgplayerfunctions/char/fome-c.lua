local Hungerstate = false
local textFome = ""

addCommandHandler("fome",
	function()
		if getElementData(localPlayer,"AccountData.Fome") <= 50 then 
			textFome = "#428bca VÁ ATÉ UMA LANCHONETE."
		else
			textFome = "#428bca VOCÊ NÃO ESTÁ COM FOME."
		end
		exports.VDBGRadar:showBox(getLocalPlayer(), "aviso","#d9534f[ATENÇÃO]#ffffff Sua Fome é de: \n "..getElementData(localPlayer,"AccountData.Fome").."% \n \n "..textFome)
	end
)



function Hunger()
	if getElementData(localPlayer, "logado") == false then 
		return 
	end
		if getElementData(localPlayer, "AccountData.Fome") <= 0 then
			removeEventHandler("onClientRender", getRootElement(), Hunger)
			warnThePlayerAboutHungerLoss()
		end

	Hungerstate = true
	
	if not isTimer(HungerTimer) and getElementData(localPlayer, "AccountData.Fome") > 0 and getElementData(localPlayer, "logado") then
		HungerTimer = setTimer(
			function()
				local currentHunger = getElementData(localPlayer, "AccountData.Fome")
				setElementData(localPlayer, "AccountData.Fome", currentHunger - 2.5)
				killTimer(HungerTimer)
			end
		, 100000, 1)
	end
end

function checkHunger()
	if getElementData(localPlayer, "AccountData.Fome") > 10 then
		exports.VDBGRadar:showBox(getLocalPlayer(), "aviso","#d9534f[ATENÇÃO]#fffff Você está com fome!")
		if isTimer(timer) then
			killTimer(timer)
		end
		removeEventHandler("onClientRender", getRootElement(), checkHunger)
		addEventHandler("onClientRender", getRootElement(), Hunger)
	end
end

function warnThePlayerAboutHungerLoss()
	exports.VDBGRadar:showBox(getLocalPlayer(), "aviso","#d9534f[ATENÇÃO]#fffff Você está com fome!")
	if not isTimer(timer) then
		local health = getElementHealth ( getLocalPlayer() )
		timer = setTimer(setElementHealth, health - 5, 1, localPlayer, 0)
		setElementData(localPlayer, "AccountData.Fome", 20)
		exports.VDBGRadar:showBox(getLocalPlayer(), "aviso","#d9534f[ATENÇÃO]#fffff Você irá desmaiar!")
	end
	addEventHandler("onClientRender", getRootElement(), checkHunger)
end

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		if not Hungerstate then
			addEventHandler("onClientRender", getRootElement(), Hunger)
		end
	end
)