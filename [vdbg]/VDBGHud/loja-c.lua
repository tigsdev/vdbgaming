local screenX, screenY = guiGetScreenSize()

local panelState = false

local bgWidth = 900
local bgHeight = 570

local bgPosX = (screenX / 2) - (bgWidth / 2)
local bgPosY = (screenY / 2) - (bgHeight / 2)

local bgMargin = 3

local titleFont = dxCreateFont("arquivos/opensans.ttf", 12 * 2, false)
local itemFont = dxCreateFont("arquivos/opensans.ttf", 11 * 2, false)

local mainColumnWidth = 300
local mainColumnHeight = bgHeight - 90

local mainColumnPosX = bgPosX + 10
local mainColumnPosY = bgPosY + 40

local mainColumnTitle = "Categorias:"
local selectedColumnTitle = "Detalhes:"

local notificationText = ""
local notificationTick = 0

local selectWidth = 300
local selectHeight = 120

local selectPosX = (screenX / 2) - (selectWidth / 2)
local selectPosY = (screenY / 2) - (selectHeight / 2)

local infoWidth = 600
local infoHeight = 400

local infoPosX = (screenX / 2) - (infoWidth / 2)
local infoPosY = (screenY / 2) - (infoHeight / 2)

local infoText = "#acd373Comprando diamantes#c8c8c8, além de você #4aabd0ajuda os desenvolvedores\n do servidor #c8c8c8 irá #acd373poder comprar coisas extraordinárias como#c8c8c8:\n #F7941DVários cartões, armas, veículos, dinheiro e outros#c8c8c8.\n Clique em loja e veja o que #acd373você pode de comprar com diamantes!\n#c8c8c8Você pode #DC143Ccomprar diamantes#c8c8c8 em nosso #acd373web-site#c8c8c8#c8c8c8\n na seção #4aabd0Loja de Diamantes#c8c8c8 que conta com os recursos do\n #4aabd0Pagseguro#c8c8c8. Acesse: #4aabd0www.vdbg.org"

local visibleItem = 1

local columnHeight = 30

local selectedCategory = false
local selectedItem = 1

local arrowWidth, arrowHeight = 16, 28

local upArrowPosX = mainColumnPosX + mainColumnWidth + 9
local upArrowPosY = mainColumnPosY + 5

local downArrowPosX = upArrowPosX
local downArrowPosY = mainColumnPosY + mainColumnHeight - arrowHeight - 5

local exitButtonPosX = mainColumnPosX + mainColumnWidth + 50
local exitButtonPosY = mainColumnPosY + mainColumnHeight + 10
local exitButtonWidth = bgWidth - 70 - mainColumnWidth
local exitButtonHeight = 30


local itemTitleFont = dxCreateFont("arquivos/opensans.ttf", 24 * 2, false)

local premiumPoints = 0
local premiumTick = 0
local premiumChange = 0


function clicandonomenu()
		if not panelState then
			panelState = "menu"
		end
end

addCommandHandler("diamondshop",
	function ()
		if not panelState then
			panelState = "menu"
		else
			panelState = false
		end
		if panelState then
			showCursor(true)
		else
			showCursor(false)
		end
	end
)


addEventHandler("onClientClick", getRootElement(),
	function (button, state, absoluteX, absoluteY)
		if button == "left" then
			if state == "up" then
				if panelState == "menu" then
					if absoluteX >= selectPosX + 10 and absoluteX <= selectPosX + 10 + selectWidth - 20 and absoluteY >= selectPosY + 10 and absoluteY <= selectPosY + 40 then -- shop
						panelState = "shop"
					elseif absoluteX >= selectPosX + 10 and absoluteX <= selectPosX + 10 + selectWidth - 20 and absoluteY >= selectPosY + 45 and absoluteY <= selectPosY + 75 then -- informations
						panelState = "informations"
					elseif absoluteX >= selectPosX + 10 and absoluteX <= selectPosX + 10 + selectWidth - 20 and absoluteY >= selectPosY + 80 and absoluteY <= selectPosY + 110 then -- exit
						executeCommandHandler("diamondshop")
						
					end
				elseif panelState == "informations" then
					if absoluteX >= infoPosX + 10 and absoluteX <= infoPosX + 10 + infoWidth - 20 and absoluteY >= infoPosY + infoHeight - 40 and absoluteY <= infoPosY + infoHeight - 10 then -- enter to shop
						panelState = "shop"
					end
				elseif panelState == "shop" then
					if absoluteX >= upArrowPosX and absoluteX <= upArrowPosX + arrowWidth and absoluteY >= upArrowPosY and absoluteY <= upArrowPosY + arrowHeight then
						if visibleItem - 1 >= 1 then
							visibleItem = visibleItem - 1
						end
					end
				end
			end
		end
	end
)


addEventHandler("onClientRender", getRootElement(),
	function ()
		if panelState == "menu" then
			absX, absY = 0, 0
			if isCursorShowing() then
				local relX, relY = getCursorPosition()

				absX = relX * screenX
				absY = relY * screenY
			end

			-- ** Cím
			dxDrawText("#3690ECVDB #ffffffGaming - #5BC649Loja de Diamantes", selectPosX + 5, selectPosY - 25, 0, 0, tocolor(255, 255, 255, 255), 0.5, titleFont, "left", "top", false, false, true, true, true)

			-- ** Háttér
			dxDrawRectangle(selectPosX, selectPosY, selectWidth, selectHeight, tocolor(0, 0, 0, 140))

			-- ** Keret
			dxDrawRectangle(selectPosX - bgMargin, selectPosY - bgMargin, selectWidth + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- felső
			dxDrawRectangle(selectPosX - bgMargin, selectPosY + selectHeight, selectWidth + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- alsó
			dxDrawRectangle(selectPosX - bgMargin, selectPosY, bgMargin, selectHeight, tocolor(0, 0, 0, 200)) -- bal
			dxDrawRectangle(selectPosX + selectWidth, selectPosY, bgMargin, selectHeight, tocolor(0, 0, 0, 200)) -- jobb

			-- ** Shop
			local shopColor = tocolor(0, 0, 0, 140)
			if absX >= selectPosX + 10 and absX <= selectPosX + 10 + selectWidth - 20 and absY >= selectPosY + 10 and absY <= selectPosY + 40 then
				shopColor = tocolor(171, 211, 115, 140)
			end
			dxDrawRectangle(selectPosX + 10, selectPosY + 10, selectWidth - 20, 30, shopColor)
			dxDrawText("Shop", selectPosX + 10, selectPosY + 10, selectPosX + 10 + selectWidth - 20, selectPosY + 40, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)

			-- ** Informations
			local infoColor = tocolor(0, 0, 0, 140)
			if absX >= selectPosX + 10 and absX <= selectPosX + 10 + selectWidth - 20 and absY >= selectPosY + 45 and absY <= selectPosY + 75 then
				infoColor = tocolor(74, 171, 208, 140)
			end
			dxDrawRectangle(selectPosX + 10, selectPosY + 45, selectWidth - 20, 30, infoColor)
			dxDrawText("Informações", selectPosX + 10, selectPosY + 45, selectPosX + 10 + selectWidth - 20, selectPosY + 75, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)

			-- ** Exit
			local exitColor = tocolor(0, 0, 0, 140)
			if absX >= selectPosX + 10 and absX <= selectPosX + 10 + selectWidth - 20 and absY >= selectPosY + 80 and absY <= selectPosY + 110 then
				exitColor = tocolor(220, 20, 60, 140)
			end
			dxDrawRectangle(selectPosX + 10, selectPosY + 80, selectWidth - 20, 30, exitColor)
			dxDrawText("Sair", selectPosX + 10, selectPosY + 80, selectPosX + 10 + selectWidth - 20, selectPosY + 110, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)

		elseif panelState == "informations" then
			absX, absY = 0, 0
			if isCursorShowing() then
				local relX, relY = getCursorPosition()

				absX = relX * screenX
				absY = relY * screenY
			end

			-- ** Cím
			dxDrawText("#3690ECVDB #ffffffGaming - #5BC649Loja de Diamantes", infoPosX + 5, infoPosY - 25, 0, 0, tocolor(255, 255, 255, 255), 0.5, titleFont, "left", "top", false, false, true, true, true)

			-- ** Háttér
			dxDrawRectangle(infoPosX, infoPosY, infoWidth, infoHeight, tocolor(0, 0, 0, 140))

			-- ** Keret
			dxDrawRectangle(infoPosX - bgMargin, infoPosY - bgMargin, infoWidth + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- felső
			dxDrawRectangle(infoPosX - bgMargin, infoPosY + infoHeight, infoWidth + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- alsó
			dxDrawRectangle(infoPosX - bgMargin, infoPosY, bgMargin, infoHeight, tocolor(0, 0, 0, 200)) -- bal
			dxDrawRectangle(infoPosX + infoWidth, infoPosY, bgMargin, infoHeight, tocolor(0, 0, 0, 200)) -- jobb
			local enterColor = tocolor(0, 0, 0, 140)
			if absX >= infoPosX + 10 and absX <= infoPosX + 10 + infoWidth - 20 and absY >= infoPosY + infoHeight - 40 and absY <= infoPosY + infoHeight - 10 then
				enterColor = tocolor(171, 211, 115, 140)
			end
			dxDrawRectangle(infoPosX + 10, infoPosY + infoHeight - 40, infoWidth - 20, 30, enterColor)
			dxDrawText("Loja", infoPosX + 10, infoPosY + infoHeight - 40, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			-- ** Kép
			dxDrawText(infoText, infoPosX + 10, infoPosY + 140, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 50, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)

		end
	end
)

function createNotification(text)
	notificationText = text
	notificationTick = getTickCount() + 5000
end