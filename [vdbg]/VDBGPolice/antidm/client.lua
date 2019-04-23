local paineldm = { }
local sx, sy = guiGetScreenSize ( )
local screenW,screenH = guiGetScreenSize()

function abrepaineldm ( theKiller )
	if ( isElement ( paineldm.janela ) ) then
		destroyBuyWindow ( )
	end 
	paineldm.janela = guiCreateWindow((sx/2-359/2), (sy/2-193/2), 359, 193, "Punir Jogador", false)
	guiWindowSetSizable(paineldm.janela, false)
	paineldm.texto = guiCreateLabel(128, 28, 215, 85, "Você deseja punir o jogador que te matou em Los Santos ?", false, paineldm.janela)
	guiLabelSetHorizontalAlign ( paineldm.texto, "left", true )
	paineldm.punir = guiCreateButton(249, 134, 94, 36, "Punir", false, paineldm.janela)
	paineldm.fechar = guiCreateButton(149, 134, 94, 36, "Fechar", false, paineldm.janela)
	showCursor(true)

	addEventHandler( "onClientGUIClick", paineldm.fechar, destroyBuyWindow, false )
	addEventHandler( "onClientGUIClick", paineldm.punir,
		function()
			triggerServerEvent ( "VDBGAntiDM->Modulos->Punicao", localPlayer, theKiller )
			destroyBuyWindow()
		end, false
	)
end

addEvent("DMPanel:OnRequestPunishWindow", true)
addEventHandler( "DMPanel:OnRequestPunishWindow", root,
	function (killer)
		if isElement(killer) then
			abrepaineldm( killer )
		end
	end
)

function destroyBuyWindow ()
	removeEventHandler ( "onClientGUIClick", paineldm.fechar, destroyBuyWindow )
	destroyElement ( paineldm.janela )
	showCursor ( false )
end 

 
