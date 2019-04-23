------------------------------------
-- QUANTUMZ - QUANTUMZ - QUANTUMZ --
------------------------------------
--         2011 - Romania	  	  -- 	    
------------------------------------
-- You can modify this file but   --
-- don't change the credits.      --
------------------------------------
------------------------------------
--  VEHICLECONTROL v1.0 for MTA   --
------------------------------------

GUIEditor_Window = {}
GUIEditor_Button = {}
GUIEditor_Label = {}
GUIEditor_Scrollbar = {}



GUIEditor_Window[1] = guiCreateWindow(709,236,272,288,"Abrir as Portas do Carro",false)
GUIEditor_Scrollbar[1] = guiCreateScrollBar(24,49,225,17,true,false,GUIEditor_Window[1])
GUIEditor_Label[1] = guiCreateLabel(86,30,135,15,"ABRIR CAPÔ",false,GUIEditor_Window[1])
guiSetFont(GUIEditor_Label[1],"default-bold-small")
GUIEditor_Label[2] = guiCreateLabel(74,72,135,15,"Primeira Porta Esquerda",false,GUIEditor_Window[1])
guiSetFont(GUIEditor_Label[2],"default-bold-small")
GUIEditor_Scrollbar[2] = guiCreateScrollBar(24,91,225,17,true,false,GUIEditor_Window[1])
GUIEditor_Label[3] = guiCreateLabel(68,112,135,15,"Primeira Porta Direita",false,GUIEditor_Window[1])
guiSetFont(GUIEditor_Label[3],"default-bold-small")
GUIEditor_Scrollbar[3] = guiCreateScrollBar(24,130,225,17,true,false,GUIEditor_Window[1])
GUIEditor_Label[4] = guiCreateLabel(71,151,135,15,"Segunda Porta Esquerda",false,GUIEditor_Window[1])
guiSetFont(GUIEditor_Label[4],"default-bold-small")
GUIEditor_Scrollbar[4] = guiCreateScrollBar(24,168,225,17,true,false,GUIEditor_Window[1])
GUIEditor_Label[5] = guiCreateLabel(68,189,135,15,"Segunda Porta Direita",false,GUIEditor_Window[1])
guiSetFont(GUIEditor_Label[5],"default-bold-small")
GUIEditor_Scrollbar[5] = guiCreateScrollBar(24,206,225,17,true,false,GUIEditor_Window[1])
GUIEditor_Label[6] = guiCreateLabel(83,226,135,15,"Porta Mala",false,GUIEditor_Window[1])
guiSetFont(GUIEditor_Label[6],"default-bold-small")
GUIEditor_Scrollbar[6] = guiCreateScrollBar(24,243,225,17,true,false,GUIEditor_Window[1])
GUIEditor_Button[1] = guiCreateButton(23,265,230,14,"Fechar janela",false,GUIEditor_Window[1])
guiSetFont(GUIEditor_Button[1],"default-small")
guiWindowSetSizable ( GUIEditor_Window[1], false )
setElementData(GUIEditor_Scrollbar[1], "Type", 0)
setElementData(GUIEditor_Scrollbar[2], "Type", 2)
setElementData(GUIEditor_Scrollbar[3], "Type", 3)
setElementData(GUIEditor_Scrollbar[4], "Type", 4)
setElementData(GUIEditor_Scrollbar[5], "Type", 5)
setElementData(GUIEditor_Scrollbar[6], "Type", 1)
guiSetVisible(GUIEditor_Window[1], false)
showCursor(false)



function enableVehicleControl()
	if guiGetVisible(GUIEditor_Window[1]) == false then
		guiSetVisible(GUIEditor_Window[1], true)
		showCursor(true)
	else
		guiSetVisible(GUIEditor_Window[1], false)
		showCursor(false)
	end
end
addCommandHandler("abrir", enableVehicleControl)

function closeButton()
		guiSetVisible(GUIEditor_Window[1], false)
		showCursor(false)
end
addEventHandler ( "onClientGUIClick", GUIEditor_Button[1], closeButton, false )

function updateRatio(Scrolled)
	local position = guiScrollBarGetScrollPosition(Scrolled)
	local door = getElementData(Scrolled, "Type")
	triggerServerEvent("moveThisShit", getLocalPlayer(), door, position)
end
addEventHandler("onClientGUIScroll", getRootElement(), updateRatio)





	