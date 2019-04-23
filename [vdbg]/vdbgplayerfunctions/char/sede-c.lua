local Headquartersstate = false
local textsede = ""

addCommandHandler("sede",
	function()
		if getElementData(localPlayer,"AccountData.Sede") <= 50 then 
			textsede = "#428bca VÁ ATÉ UMA LANCHONETE."
		else
			textsede = "#428bca VOCÊ NÃO ESTÁ COM SEDE."
		end		
		exports.VDBGRadar:showBox(getLocalPlayer(), "aviso","#d9534f[ATENÇÃO]#ffffff Sua sede é de: \n "..getElementData(localPlayer,"AccountData.Sede").."% \n \n "..textsede..textFome)
	end
)



function Headquarters()
	if getElementData(localPlayer, "logado") == false then 
		return 
	end
		if getElementData(localPlayer, "AccountData.Sede") <= 0 then
			removeEventHandler("onClientRender", getRootElement(), Headquarters)
			warnThePlayerAboutHeadquartersLoss()
		end

	Headquartersstate = true
	
	if not isTimer(HeadquartersTimer) and getElementData(localPlayer, "AccountData.Sede") > 0 and getElementData(localPlayer, "logado") then
		HeadquartersTimer = setTimer(
			function()
				local currentHeadquarters = getElementData(localPlayer, "AccountData.Sede")
				setElementData(localPlayer, "AccountData.Sede", currentHeadquarters - 5)
				killTimer(HeadquartersTimer)
			end
		, 100000, 1)
	end
end

function checkHeadquarters()
	if getElementData(localPlayer, "AccountData.Sede") > 10 then
		exports.VDBGRadar:showBox(getLocalPlayer(), "aviso","#d9534f[ATENÇÃO]#fffff Você está com sede!")
		if isTimer(timer) then
			killTimer(timer)
		end
		setGameSpeed(1)
		removeEventHandler("onClientRender", getRootElement(), checkHeadquarters)
		addEventHandler("onClientRender", getRootElement(), Headquarters)
	end
end

function warnThePlayerAboutHeadquartersLoss()
		exports.VDBGRadar:showBox(getLocalPlayer(), "aviso","#d9534f[ATENÇÃO]#fffff Você está com sede!")
	if not isTimer(timer) then
		setGameSpeed(0.9)
		exports.VDBGRadar:showBox(getLocalPlayer(), "aviso","#d9534f[ATENÇÃO]#fffff Você está com muita sede!!")
	end
	addEventHandler("onClientRender", getRootElement(), checkHeadquarters)
end

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		if not Headquartersstate then
			addEventHandler("onClientRender", getRootElement(), Headquarters)
		end
	end
)