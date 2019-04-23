local sx,sy = guiGetScreenSize()
local adGuiState = false
local adGui = {}
local countdown = false
local timer = 5
function showAdGui ()
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	
	if isElement ( adGui.window ) then return end
	guiSetInputEnabled ( true )
	local width, height = 950*0.6, 715*0.6
	adGui.window = guiCreateStaticImage( sx/2-width/2,sy/2-height/2,width,height, "fundo.png", false )

	
	edit = guiCreateMemo(56, 140, 456, 125, "", false, adGui.window)
	guiSetEnabled (edit,true)
	guiSetAlpha(edit, 0.4)

	adGui.amoutInfo = guiCreateLabel(400, 270, 140, 25, "Preço: R$0", false,adGui.window)
	
	adGui.receiveButton = guiCreateButton(215, 280, 140, 25, "Anunciar", false,adGui.window)
	adGui.closeButton = guiCreateButton (215, 310, 140, 25, "Fechar", false,adGui.window)
	guiSetFont(adGui.closeButton, "default-bold-small")
	guiSetFont(adGui.receiveButton, "default-bold-small")
	guiSetAlpha(adGui.closeButton, 0)--Bezárás
	guiSetAlpha(adGui.receiveButton, 0)--Hirdetés Feladás
	
	addEventHandler("onClientGUIChanged", edit, function()
		if source == edit then
			guiSetText(adGui.amoutInfo, "Preço: R$"..(tonumber(#guiGetText ( edit ))*10.50))
		end
	end)
	
	function guiEvents ( butt, state )
		if butt == "left" and state == "up" then
			if source == adGui.closeButton then
				
				destroyElement ( adGui.window )
				showCursor ( false )
				removeEventHandler ("onClientGUIClick", getResourceRootElement ( getThisResource()), guiEvents )
				guiSetInputEnabled ( false )
			elseif source == adGui.receiveButton and guiGetText ( edit ) ~= "" then
				if tonumber(#guiGetText ( edit )) < 71 then 
				local trigger = triggerServerEvent("onClientCallForAdData", localPlayer, localPlayer, guiGetText ( edit ), (tonumber(#guiGetText ( edit ))*10.50) )
				countdown = true
				destroyElement ( adGui.window )
				showCursor ( false )
				removeEventHandler ("onClientGUIClick", getResourceRootElement ( getThisResource()), guiEvents )
				guiSetInputEnabled ( false )
				else
				limite = tonumber(#guiGetText ( edit )) - 70
				outputChatBox("#d9534f[VDBG.ORG] #ffffffO limite de caracteres é de #acd373(70)#ffffff, você colocou "..limite.." além do limite.",255,255,255,true)
				end
			end
		end
	end
	
	addEventHandler ("onClientGUIClick", getResourceRootElement ( getThisResource()), guiEvents )
		
	showCursor (true)
	adGuiState = true
	

end
addEvent("onAdvertise", true)
addEventHandler("onAdvertise", getRootElement(), showAdGui)


function abre()
if (countdown == false) then 
  showAdGui() 
else 
outputChatBox("#d9534f[VDBG.ORG] #ffffffAguarde #acd373("..timer..") minutos(s) #ffffffpara usar o sistema de anúncio novamente.",255,255,255,true)
end
end
addCommandHandler("ads", abre )



addEventHandler("onClientRender", root, function()
	if (countdown == true) then

	
	setTimer(function() 
	timer = timer - 1
	end,100000,1)
	setTimer(function() 
	timer = timer - 1
	end,200000,1)
	setTimer(function() 
	timer = timer - 1
	end,300000,1)
	setTimer(function() 
	timer = timer - 1
	end,400000,1)
	setTimer(function() 
	timer = timer - 1
	countdown = false 
	timer = 5
	end,500000,1)
	end
end
)