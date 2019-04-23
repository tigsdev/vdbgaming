local sx,sy = guiGetScreenSize()

addEventHandler ("onClientResourceStart",getResourceRootElement(getThisResource()),
	function()
		local players = getElementsByType( "player" )
		versao = guiCreateLabel(-20,sy-25, sx-72, 24, "VDBGaming - www.vdbg.org 3.0.1 |", false)
		guiLabelSetVerticalAlign (versao,"bottom")
		guiLabelSetHorizontalAlign (versao,"right")
		guiSetAlpha(versao, 0.5)
	end
)