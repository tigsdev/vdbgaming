local screenX, screenY = guiGetScreenSize()

local panelState = false

local bgWidth = 900
local bgHeight = 570

local bgPosX = (screenX / 2) - (bgWidth / 2)
local bgPosY = (screenY / 2) - (bgHeight / 2)

local bgMargin = 3

local titleFont = false
local itemFont = false

local mainColumnWidth = 300
local mainColumnHeight = bgHeight - 90

local mainColumnPosX = bgPosX + 10
local mainColumnPosY = bgPosY + 40

local mainColumnTitle = "Categorias:"
local selectedColumnTitle = "Descrição:"

local notificationText = ""
local notificationTick = 0

local selectWidth = 400
local selectHeight = 120

local selectPosX = (screenX / 2) - (selectWidth / 2)
local selectPosY = (screenY / 2) - (selectHeight / 2)

local infoWidth = 600
local infoHeight = 400



local infoPosX = (screenX / 2) - (infoWidth / 2)
local infoPosY = (screenY / 2) - (infoHeight / 2)

local infoText = ""

local availableCategories = {
    [1] = {
        ["name"] = "Primeiros Passos",
        ["imagePath"] = "arquivos/imagens/18.png",
        ["subCategories"] = {
			[1] = {
				["name"] = "Regras Gerais",
				["imagePath"] = false,
				["description"] = "#d9534fLínguagem principal do servidor é o Português#ffffff, o que significa\
que é a única língua que você pode usar na caixa de mensagens.\
No entanto, você pode usar qualquer língua ao enviar mensagens\
privadas\
\
#d9534fOfenças e xingamentos é proíbido#ffffff\
\
Falta de conhecimento sobre as regras não significa que você\
não vá cumprilas.\
\
#2F7CCCVocê pode encontrar todas as regras em: www.vdbg.org"
			},
        [2] = {
				["name"] = "Controles",
				["imagePath"] = false,
				["description"] = "Os #2F7CCCcomandos#ffffff do servidor você pode encontrar\
em nosso #2F7CCCfórum#ffffff, até porque temos um monte de comandos\
e binds vínculadas e personalizadas.\
\
#d9534fAlém dos comandos você encontra muitos outros recursos.#ffffff\
\
@ #2F7CCCwww.vdbg.org"
			},
		[3] = {
				["name"] = "Estilos de Chat",
				["imagePath"] = false,
				["description"] = "VDBGaming tem diferentes tipos de #2F7CCCbate-papos#ffffff com várias finalidades.\
\
Pressione 'T' para usar o #2F7CCCchat principal#ffffff.\
O #2F7CCCbate-papo mais monitorado#ffffff onde  é forçado a ser falado #2F7CCCportuguês.#ffffff\
#d9534fSpams, inundações e publicidade #ffffffsão totalmente proíbidos,\
Pressione 'o' para usar o #FFBF00Chat local#ffffff. Este chat foi criado para que \
os jogadores seria capaz de conversar com #2F7CCCoutros jogadores nas\
proximidades.#ffffff\
Pressione Y para usar o #FFBF00bate papo de equipe#ffffff\
Equipe de bate-papo foi criado para que você e os outros #2F7CCCjogadores\
da mesma equipe#ffffff '#d9534fCriminoso, #428bcaCidadão, #4aabd0Policial#ffffff' e etc.\
O #FFBF00Bate-papo do veículo#ffffff fica disponível com: /cc [texto] para usá-lo.\
Se você estiver em um veículo, você pode usar este \
bate-papo para falar com os ocupantes do veículo.\
"
			},
        [4] = {
				["name"] = "Selecionar uma Equipe",
				["imagePath"] = false,
				["description"] = "Temos #FFBF00Três grupos principais#ffffff em nosso servidor\
\
#d9534fCriminoso\
#428bcaCidadão\
#4aabd0Policial\
\
#ffffffCada grupo tem um papel diferente, \
a maioria pode ser adivinhado pelo nome dele \
Você pode #428bcadescobrir mais sobre os grupos#ffffff \
se você ler sobre, ou visitar o nosso site \
\
VDBGaming #428bca @ www.vdbg.org"
			},
			
		[5] = {
				["name"] = "HUD",
				["imagePath"] = false,
				["description"] = "#d9534fO artigo a seguir ainda não fui adicionado ao banco de dados."
				--["price"] = 1000,
				--["amount"] = 1
			},	
        
		[6] = {
				["name"] = "Player Stats",
				["imagePath"] = false,
				["description"] = "Este sistema está incluído no #d9534fpainel do usuário."
			},
			
		[7] = {
				["name"] = "O painel do usuário",
				["imagePath"] = false,
				["description"] = "Estamos projetando um #428bca painel do usuário#ffffff\
				baseada em' dxDraw ' Este painel inclui as informações \
				do usuário informações como: #428bca Equipe, Dinheiro, ID da conta, \
				Configurações de Interface, Escolher Avatar#ffffff e outros \
				\
				Lembrando que este painel está estruturado, porém está sendo\
				feito aos poucos, pois	não temos todo o tempo do mundo, \
				e além disso temos outras #d9534fpendências#ffffff do servidor.\
				"
			},	
		
		[8] = {
				["name"] = "Inventário",
				["imagePath"] = false,
				["description"] = "O #428bcainventário#ffffff é uma das partes mais #d9534fimportantes#ffffff da jogabilidade.\
Você pode ver o painel pressionando a #428bcatecla 'i'.\
\
Você pode ver todos	os seus #428bcaitens no painel#ffffff, você pode vender\
na #428bcafeira do rolo#ffffff e #d9534fjogar fora#ffffff, qualquer item.\
"
			},
		
		[9] = {
				["name"] = "Criação de Armas",
				["imagePath"] = false,
				["description"] = "text\ntext"
			},
		
		[10] = {
				["name"] = "Painél do veículo",
				["imagePath"] = false,
				["description"] = "O paínel do veículo é uma das principais\
				atividades do servidor. Você pode ver o painel precionando\
				'F2'. Você pode ver todos os veículos nesse painél\
				\
				Caso você perca seu veículo, use o botão asseguradora\
				e automaticamente seu veículo será recuperado\
				Note que após assegurar o seu veículo, ele irá para o seguro\
				que fica no centro do mapa.\
				"
			},		
		},
	},
    [2] = {
         ["name"] = "Cidadão",
        ["imagePath"] = "arquivos/imagens/18.png",
        ["subCategories"] = {
		[1] = {
				["name"] = "Recursos Básicos",
				["imagePath"] = false,
				["description"] = "A equipe #428bcaVDBGaming #FFFFFFse empenhou muito, criando diversos trabalhos.\
				Entre eles estão os trabalhos civis, que são os\
				trabalho que geralmente não envolvem armas.\
				*Taxista, Mecânico, caminhoneiro e muito mais!\
				* Para uma descrição mais detalhada leia a sessão: Cidadãos\
				Há também trabalhos que podem envolver armas, como os\
				criminosos ou agentes da lei.\
				Criminosos: Fazem ações criminosas, como o nome já diz.\
				\
				Ações criminosas:\
				- Hacker, Ladrão de Carros, traficante de drogas entre outros\
				* Para uma descrição mais detalhada leia a sessão: 'criminosos'.\
				Policiais: Combatem as ações dos criminosos.\
				* Para uma descrição mais detalhada leia a sessão: 'Policiais'."
			},
		[2] = {
				["name"] = "Trabalhos",
				["imagePath"] = false,
				["description"] = "Como policial, seu trabalho sempre será prender criminosos\
				- Encontrando criminosos:\
				Uma algema acima da cabeça do jogador\
				Você pode acessar o computador policial precionando'F5',\
				Pegue uma algema e bata no criminoso que está com algema na\
				cabeça, assim você irá algema-lo. Logo depois leve-o até a prisão,\
				irá ter um check-point azul te esperando"
			},
        [3] = {
				["name"] = "Mecânico",
				["imagePath"] = false,
				["description"] = "Um mecânico realiza reparos em veículos.\
				Para reparar um veículo apenas fique parado ao lado do veículo e pressione\
				'M' do seu teclado, em seguida, clique no carro que você deseja reparar\
				Reboque os carros para a asseguradora que fica na oficina de SF\
				com isso você ganhe R$ 1000,00 por veículo.\
				\
				Perk trabalho: N/A\
				"
			},
        [4] = {
				["name"] = "Motorista",
				["imagePath"] = false,
				["description"] = "Um motorista faz viagens de ônibus pela cidade.\
									As cidades disponíveis para rotas são:\
									- SF\
									- LS\
									\
									Ambas as cidades tem dois tipos de ônibus para realizar esta tarefa.\
									O dinheiro é pago em cada parada, além disso você ganha pontos em #428bcaXP#ffffff.\
									\
									Esses pontos de #428bcaXP#FFFFFF aumenta seu nível de jogo.\
									\
									Perk trabalho: N/A\
				"
				--["price"] = 1000,
				--["amount"] = 1
			},
			
		[5] = {
				["name"] = "Stunter",
				["imagePath"] = false,
				["description"] = "Um Stunter realiza manobras com motos.\
				Em qualquer lugar do mapa, realize uma manobra com uma:\
				\
				- MOTO\
				-BICICLETA\
				\
				Cidades disponíveis:\
				- SF\
				- LS\
				- LV\
				\
				Ambas as cidades tem mais que dois tipos de motocicletas para realizar esta tarefa.\
				O dinheiro é pago a cada manobra, além disso você ganha pontos em #428bcaXP#ffffff.\
				Esses pontos de #428bcaXP#FFFFFF aumenta seu nível de jogo.\
				\
				Perk trabalho: N/A\
				"
				--["price"] = 1000,
				--["amount"] = 1
			},	
        
		[6] = {
				["name"] = "Moto-BOY",
				["imagePath"] = false,
				["description"] = "Um Moto-BOY realiza entregas de pizzas.\
				Veículos disponíveis para realizar esta tarefa:\
				\
				- PIZZABOY\
				\
				Cidades disponíveis:\
				- SF\
				- LS\
				\
				Ambas as cidades tem mais que vinte lugares para realizar esta tarefa.\
				O dinheiro é pago a cada entrega, além disso você ganha pontos em #428bcaXP#ffffff.\
				Esses pontos de #428bcaXP#FFFFFF aumenta seu nível de jogo.\
				\
				Perk trabalho: N/A\
				"
				--["price"] = 1000,
				--["amount"] = 1
			},
			
		[7] = {
				["name"] = "Criminoso",
				["imagePath"] = false,
				["description"] = "Como um criminoso, você é o verdadeiro protagonista do VDBG!\
				Mas cuidado, o trabalho de policial, é somente para irritar você,\
				principalmente em sua ascensão ao poder. \
				Algumas ações criminosas:\
				\
				-Você Pode vender drogas.\
				-Você Pode entregar drogas com uma van\
				-Você Pode criar armas.\
				-Você Pode controlar um território e ganhar dinheiro.\
				-Você Pode hackear um caixa eletrônico.\
				-Você Pode roubar um banco, um casino,\
				-Você Pode roubar um carro escondido no mapa.\
				-Você pode assaltar todas as lojas do mapa.\
				\
				Perk trabalho: Usar drogas.\
				"
				--["price"] = 1000,
				--["amount"] = 1
			},	
		
		[8] = {
				["name"] = "Vagabundo",
				["imagePath"] = false,
				["description"] = "O vagabundo não tem um emprego\
				por isso ganha dinheiro vagando pelo mapa a busca de\
				dinheiro e comida.\
				\
				Você vai encontrar aleatoriamente:\
				\
				- Dinheiro\
				- Alimentos\
				- Armas.\
				Alguns alimentos pode aumentar a sua saúde\
				* outrospouco de comida pode abaixá-lo.\
				\
				Perk trabalho: Recuperar a saúde com / sono.\
				"
				--["price"] = 1000,
				--["amount"] = 1
			},
		
		[9] = {
				["name"] = "Lixeiro",
				["imagePath"] = false,
				["description"] =  "Um Lixeiro realiza limpeza de rua.\
				Veículos disponíveis para realizar esta tarefa:\
				\
				- Caminhão de lixo\
				- Carro de limpeza de rua\
				\
				Cidades disponíveis:\
				- LS\
				\
				A cidade tem mais que vinte lugares para realizar esta tarefa.\
				O dinheiro é pago a cada entrega, além disso você ganha pontos em #428bcaXP#ffffff.\
				Esses pontos de #428bcaXP#FFFFFF aumenta seu nível de jogo.\
				\
				Perk trabalho: N/A\
				"
				--["price"] = 1000,
				--["amount"] = 1
			},
		
		[10] = {
				["name"] = "Entregador",
				["imagePath"] = false,
				["description"] = "Um Entregador realiza entregas de encomendas.\
				Veículos disponíveis para realizar esta tarefa:\
				\
				- VAN'S\
				\
				Cidades disponíveis:\
				- SF\
				- LS\
				\
				Ambas as cidades tem mais que vinte lugares para realizar esta tarefa.\
				O dinheiro é pago a cada entrega, além disso você ganha pontos em #428bcaXP#ffffff.\
				Esses pontos de #428bcaXP#FFFFFF aumenta seu nível de jogo.\
				\
				Perk trabalho: N/A\
				"
				--["price"] = 1000,
				--["amount"] = 1
			},
		
		[11] = {
				["name"] = "Piloto",
				["imagePath"] = false,
				["description"] = "O piloto pode voar levando jogadores em torno\
				do mapa com uma taxa, você também pode ganhar dinheiro entregando os\
				passageiros	pré definidos pelo servidor nos aeroportos.\
				\
				*  Veículos disponíveis para realizar esta tarefa:\
				- Aeronaves\
				*  Cidades disponíveis:\
				- Todas\
				\
				Ambas as cidades automaticamente coordena a cidade mais longe\
				para realizar esta tarefa.\
				O dinheiro é pago a cada entrega, além disso você ganha pontos em #428bcaXP#ffffff.\
				Esses pontos de #428bcaXP#FFFFFF aumenta seu nível de jogo.\
				\
				Perk trabalho: N/A\
				"
				--["price"] = 1000,
				--["amount"] = 1
			},		
		},
	},
	[3] = {
        ["name"] = "Agente da Lei",
        ["imagePath"] = "arquivos/imagens/17.png",
        ["subCategories"] = {
			[1] = {
				["name"] = "Introdução",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[2] = {
				["name"] = "Informações Básicas",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			
			},
			[3] = {
				["name"] = "A prisão",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			
			},
			[4] = {
				["name"] = "Ações especiais",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			
			},
         
		},
    	
		},
	[4] = {
        ["name"] = "Criminoso",
        ["imagePath"] = "arquivos/imagens/21.png",
        ["subCategories"] = {
			[1] = {
				["name"] = "Informações Básicas",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[2] = {
				["name"] = "Roubo de Lojas",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[3] = {
				["name"] = "Roubo de Lojas",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[4] = {
				["name"] = "Roubo de Banco",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[5] = {
				["name"] = "Roubo de Carros",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[5] = {
				["name"] = "Transporte de Drogas",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			
			},
        
		},
	[5] = {
        ["name"] = "Locais",
        ["imagePath"] = "arquivos/imagens/22.png",
        ["subCategories"] = {
			[1] = {
				["name"] = "",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[2] = {
				["name"] = "Staff",
				["imagePath"] = false,
				["description"] = "Dono/Administrador: Galego\nConsole: Strikergfx\nConsole: N/A\nAdministrador: N/A\nAdministrador: N/A\nAdministrador: N/A\nAdministrador: N/A\nAdministrador: N/A"
				--["price"] = 1000,
				--["amount"] = 1
			
			
			},		
		},
	},	
	
[6] = {
        ["name"] = "Doações",
        ["imagePath"] = "arquivos/imagens/23.png",
        ["subCategories"] = {
			[1] = {
				["name"] = "Site Interativo",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[2] = {
				["name"] = "Forum",
				["imagePath"] = false,
				["description"] = "N/A\nN/A"
				--["price"] = 1000,
				--["amount"] = 1
			},
		},
	},
	[7] = {
        ["name"] = "Perguntas e Respostas",
        ["imagePath"] = "arquivos/imagens/23.png",
        ["subCategories"] = {
			[1] = {
				["name"] = "Site Interativo",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[2] = {
				["name"] = "Forum",
				["imagePath"] = false,
				["description"] = "N/A\nN/A"
				--["price"] = 1000,
				--["amount"] = 1
				},
		},
	},
	[8] = {
        ["name"] = "Site",
        ["imagePath"] = "arquivos/imagens/23.png",
        ["subCategories"] = {
			[1] = {
				["name"] = "Site Interativo",
				["imagePath"] = false,
				["description"] = "text\ntext"
				--["price"] = 1000,
				--["amount"] = 1
			},
			[2] = {
				["name"] = "Forum",
				["imagePath"] = false,
				["description"] = "N/A\nN/A"
				--["price"] = 1000,
				--["amount"] = 1
				},
		},
	},
	}


local visibleItem = 1

local columnHeight = 30

local selectedCategory = false
local selectedItem = 1

local setaWidth, setaHeight = 16, 28

local upsetaPosX = mainColumnPosX + mainColumnWidth + 9
local upsetaPosY = mainColumnPosY + 5

local downsetaPosX = upsetaPosX
local downsetaPosY = mainColumnPosY + mainColumnHeight - setaHeight - 5

local exitButtonPosX = mainColumnPosX + mainColumnWidth + 50
local exitButtonPosY = mainColumnPosY + mainColumnHeight + 10
local exitButtonWidth = bgWidth - 70 - mainColumnWidth
local exitButtonHeight = 30

local amountEditBox = false

local premiumPoints = 0
local premiumTick = 0
local premiumChange = 0

function createFonts()
    destroyFonts()

    titleFont = dxCreateFont("arquivos/opensans.ttf", 14.5 * 2, true)
    itemFont = dxCreateFont("arquivos/opensans.ttf", 9 * 3, false)
end

function destroyFonts()
    if isElement(titleFont) then
        destroyElement(titleFont)
    end
    if isElement(itemFont) then
        destroyElement(itemFont)
    end
end

addEventHandler("onClientResourceStop", getResourceRootElement(),
    function ()
        if panelState then
        end
    end
)

addEventHandler("onClientKey", root, function(k,v)
    if (getElementData(localPlayer,"logado") == false) then return end;
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	if k == "F1" and v then
         if not panelState then
			if getElementData(localPlayer, "opendashboard") == true then return end
			setElementData(localPlayer, "opendashboard", true)
			playSound(":VDBGPanelSound/abre.mp3")
            createFonts()
            panelState = "shop"
        else
            panelState = false
			setElementData(localPlayer, "opendashboard", false)
			playSound(":VDBGPanelSound/fecha.mp3")
        end
        --panelState = not panelState

        destroyGUI()

        selectedItem = 1
        selectedCategory = false

        if panelState then
            premiumPoints = getElementData(localPlayer, "char.artpoint")
            showCursor(true)
            showChat(false)
        else
            showCursor(false)
			showChat(true)
            playSound(":VDBGPanelSound/fecha.mp3", false)
            destroyFonts()
			setElementData(localPlayer, "opendashboard", false)
            end
            end
end)

addEventHandler("onClientElementDataChange", getRootElement(),
    function (dataName, oldValue)
        if panelState then
            if source == localPlayer then
                if dataName == "char.artpoint" then
                    local newValue = getElementData(source, "char.artpoint")
                    if newValue then
                        premiumTick = getTickCount() + 5000
                        premiumChange = newValue - oldValue

                        premiumPoints = newValue
                    end
                end
            end
        end

    end
)

function destroyGUI()
      --  destroyElement(amountEditBox)
		showChat(true)
		
end

function createGUI()
    --destroyGUI()

   --amountEditBox = guiCreateEdit(exitButtonPosX, mainColumnPosY + 410, exitButtonWidth, exitButtonHeight, "", false)
end


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
                        --executeCommandHandler("diamondshop")
                    end
                elseif panelState == "informations" then
                    if absoluteX >= infoPosX + 10 and absoluteX <= infoPosX + 10 + infoWidth - 20 and absoluteY >= infoPosY + infoHeight - 40 and absoluteY <= infoPosY + infoHeight - 10 then -- enter to shop
                        panelState = "shop"
                    end
                elseif panelState == "shop" then
                    if absoluteX >= upsetaPosX and absoluteX <= upsetaPosX + setaWidth and absoluteY >= upsetaPosY and absoluteY <= upsetaPosY + setaHeight then
                        if visibleItem - 1 >= 1 then
                            visibleItem = visibleItem - 1
                        end
                    elseif absoluteX >= downsetaPosX and absoluteX <= downsetaPosX + setaWidth and absoluteY >= downsetaPosY and absoluteY <= downsetaPosY + setaHeight then
                        if selectedCategory then
                            if availableCategories[selectedCategory]["subCategories"][visibleItem + 16] then
                                visibleItem = visibleItem + 1
                            end
                        else
                            if availableCategories[visibleItem + 16] then
                                visibleItem = visibleItem + 1
                            end
                        end
                    elseif absoluteX >= exitButtonPosX and absoluteX <= exitButtonPosX + exitButtonWidth and absoluteY >= exitButtonPosY - exitButtonHeight - 10 and absoluteY <= exitButtonPosY - 10 then -- buy
                        if selectedCategory then
                            if availableCategories[selectedCategory] then
                                if availableCategories[selectedCategory]["subCategories"] then
                                    if selectedItem then
                                        if availableCategories[selectedCategory]["subCategories"][selectedItem] then
                                                if selectedCategory == 1 then -- bankpénz
                                                    
                                                elseif selectedCategory == 2 then -- money
                                                    local premiumPoints = getElementData(localPlayer, "char.artpoint")
                                                  
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    
)

bindKey("mouse_wheel_up", "down",
    function ()
        if panelState then
            if absX >= mainColumnPosX and absX <= mainColumnPosX + mainColumnWidth and absY >= mainColumnPosY and absY <= mainColumnPosY + mainColumnHeight then
                if visibleItem - 1 >= 1 then
                    visibleItem = visibleItem - 1
                end
            end
        end
    end
)

bindKey("mouse_wheel_down", "down",
    function ()
        if panelState then
            if absX >= mainColumnPosX and absX <= mainColumnPosX + mainColumnWidth and absY >= mainColumnPosY and absY <= mainColumnPosY + mainColumnHeight then
                if selectedCategory then
                    if availableCategories[selectedCategory]["subCategories"][visibleItem + 16] then
                        visibleItem = visibleItem + 1
                    end
                else
                    if availableCategories[visibleItem + 16] then
                        visibleItem = visibleItem + 1
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
			


     --[[   elseif panelState == "informations" then
            absX, absY = 0, 0
            if isCursorShowing() then
                local relX, relY = getCursorPosition()

                absX = relX * screenX
                absY = relY * screenY
            end
   -- ** Háttér
            dxDrawRectangle(infoPosX, infoPosY, infoWidth, infoHeight, tocolor(0, 0, 0, 140))

            -- ** Keret
            dxDrawRectangle(infoPosX - bgMargin, infoPosY - bgMargin, infoWidth + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- felső
            dxDrawRectangle(infoPosX - bgMargin, infoPosY + infoHeight, infoWidth + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- alsó
            dxDrawRectangle(infoPosX - bgMargin, infoPosY, bgMargin, infoHeight, tocolor(0, 0, 0, 200)) -- bal
            dxDrawRectangle(infoPosX + infoWidth, infoPosY, bgMargin, infoHeight, tocolor(0, 0, 0, 200)) -- jobb

           
	
            local entrarcor = tocolor(0, 0, 0, 140)
            if absX >= infoPosX + 10 and absX <= infoPosX + 10 + infoWidth - 20 and absY >= infoPosY + infoHeight - 40 and absY <= infoPosY + infoHeight - 10 then
                entrarcor = tocolor(171, 211, 115, 140)
            end
            dxDrawRectangle(infoPosX + 280, infoPosY + infoHeight - 300, infoWidth - 300, 40, entrarcor)
			
			local vendercomprarcor = tocolor(0, 0, 0, 140)
            if absX >= infoPosX + 10 and absX <= infoPosX + 10 + infoWidth - 20 and absY >= infoPosY + infoHeight - 40 and absY <= infoPosY + infoHeight - 10 then
                vendercomprarcor = tocolor(171, 211, 115, 140)
            end
			dxDrawRectangle(infoPosX + 280, infoPosY + infoHeight - 250, infoWidth - 300, 40, vendercomprarcor)
			
			   local empresacor = tocolor(0, 0, 0, 140)
            if absX >= infoPosX + 10 and absX <= infoPosX + 10 + infoWidth - 20 and absY >= infoPosY + infoHeight - 40 and absY <= infoPosY + infoHeight - 10 then
                empresacor = tocolor(171, 211, 115, 140)
            end
			dxDrawRectangle(infoPosX + 280, infoPosY + infoHeight - 200, infoWidth - 300, 40, empresacor)
			
			local fecharcor = tocolor(0, 0, 0, 140)
            if absX >= infoPosX + 280 and absX <= infoPosX + 10 + infoWidth - 300 and absY >= infoPosY + infoHeight - 40 and absY <= infoPosY + infoHeight - 10 then
                fecharcor = tocolor(171, 211, 115, 140)
            end
			dxDrawRectangle(infoPosX + 280, infoPosY + infoHeight - 150, infoWidth - 300, 40, fecharcor)
			
			 local fecharcor = tocolor(0, 0, 0, 140)
            if absX >= infoPosX + 10 and absX <= infoPosX + 10 + infoWidth - 20 and absY >= infoPosY + infoHeight - 40 and absY <= infoPosY + infoHeight - 10 then
                fecharcor = tocolor(171, 211, 115, 140)
            end
            dxDrawRectangle(infoPosX + 10, infoPosY + infoHeight - 40, infoWidth - 20, 30, fecharcor)
            dxDrawText("Fechar", infoPosX + 10, infoPosY + infoHeight - 40, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
    
            dxDrawText("Fechar", infoPosX + 10, infoPosY + infoHeight - 40, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
    
            -- ** Estrutura
			
			dxDrawText("#2F7CCCVDB #ffffffGaming - Minhas propriedades.", infoPosX - 300,  infoPosY - 425, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			dxDrawText("PROPRIEDADES DISPONÍVEIS (1/2)", infoPosX + 300,  infoPosY - 360, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			
			dxDrawRectangle(infoPosX + 10, infoPosY + 30, infoWidth - 350, (infoPosY + infoHeight - 50) - (infoPosY + 40), tocolor(0, 0, 0, 140))
		
			dxDrawText("ID da propriedade 01", infoPosX - 330,  infoPosY - 300, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			dxDrawText("Localização: Galton", infoPosX - 330,  infoPosY - 250, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			dxDrawText("Dono: tiaguinhods", infoPosX - 330,  infoPosY - 200, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			dxDrawText("Preço: 1.000,000", infoPosX - 330,  infoPosY - 150, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			dxDrawText("Empresa: Não", infoPosX - 330,  infoPosY - 100, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			dxDrawText("Lucro da Empresa: R$ 0,00", infoPosX - 330,  infoPosY - 50, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			dxDrawText("Garagem: Sim", infoPosX - 330,  infoPosY, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			dxDrawText("Carros na Garagem: (1/2)", infoPosX - 330,  infoPosY + 50, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 10, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
			

            -- ** Content
            --dxDrawRectangle(infoPosX + 10, infoPosY + 140, infoWidth - 20, (infoPosY + infoHeight - 50) - (infoPosY + 140), tocolor(255, 255, 255, 40))
            dxDrawText(infoText, infoPosX + 10, infoPosY + 140, infoPosX + 10 + infoWidth - 20, infoPosY + infoHeight - 50, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "center", false, false, true, true, true)
]]
        elseif panelState == "shop" then
            absX, absY = 0, 0
            if isCursorShowing() then
                local relX, relY = getCursorPosition()

                absX = relX * screenX
                absY = relY * screenY
            end

            -- ** Háttér
            dxDrawRectangle(bgPosX, bgPosY, bgWidth, bgHeight, tocolor(0, 0, 0, 140))

            -- ** Keret
            dxDrawRectangle(bgPosX - bgMargin, bgPosY - bgMargin, bgWidth + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- felső
            dxDrawRectangle(bgPosX - bgMargin, bgPosY + bgHeight, bgWidth + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- alsó
            dxDrawRectangle(bgPosX - bgMargin, bgPosY, bgMargin, bgHeight, tocolor(0, 0, 0, 200)) -- bal
            dxDrawRectangle(bgPosX + bgWidth, bgPosY, bgMargin, bgHeight, tocolor(0, 0, 0, 200)) -- jobb

           
            -- ** Content
            dxDrawText("#4aabd0" .. mainColumnTitle, mainColumnPosX + 5, mainColumnPosY - 28, 0, 0, tocolor(255, 255, 255, 255), 0.5, titleFont, "left", "top", false, false, true, true, true)

            dxDrawRectangle(mainColumnPosX, mainColumnPosY, mainColumnWidth, mainColumnHeight, tocolor(0, 0, 0, 140))
            dxDrawRectangle(mainColumnPosX + mainColumnWidth, mainColumnPosY, 30, mainColumnHeight, tocolor(0, 0, 0, 140))

            dxDrawRectangle(mainColumnPosX + mainColumnWidth, mainColumnPosY, bgMargin, mainColumnHeight, tocolor(0, 0, 0, 200))

            dxDrawRectangle(mainColumnPosX - bgMargin, mainColumnPosY - bgMargin, mainColumnWidth + 30 + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- felső
            dxDrawRectangle(mainColumnPosX - bgMargin, mainColumnPosY + mainColumnHeight, mainColumnWidth + 30 + (bgMargin * 2), bgMargin, tocolor(0, 0, 0, 200)) -- alsó
            dxDrawRectangle(mainColumnPosX - bgMargin, mainColumnPosY, bgMargin, mainColumnHeight, tocolor(0, 0, 0, 200)) -- bal
            dxDrawRectangle(mainColumnPosX + mainColumnWidth + 30, mainColumnPosY, bgMargin, mainColumnHeight, tocolor(0, 0, 0, 200)) -- jobb

            if notificationTick >= getTickCount() then
                dxDrawText(notificationText, exitButtonPosX, bgPosY + 10, exitButtonPosX + exitButtonWidth, 0, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "top", false, false, true, true, true)
            end

            if absX >= upsetaPosX and absX <= upsetaPosX + setaWidth and absY >= upsetaPosY and absY <= upsetaPosY + setaHeight then
                dxDrawImage(upsetaPosX, upsetaPosY, setaWidth, setaHeight, "arquivos/setas/upsetaon.png")
            else
                dxDrawImage(upsetaPosX, upsetaPosY, setaWidth, setaHeight, "arquivos/setas/upsetaoff.png")
            end
            if absX >= downsetaPosX and absX <= downsetaPosX + setaWidth and absY >= downsetaPosY and absY <= downsetaPosY + setaHeight then
                dxDrawImage(downsetaPosX, downsetaPosY, setaWidth, setaHeight, "arquivos/setas/downsetaon.png")
            else
                dxDrawImage(downsetaPosX, downsetaPosY, setaWidth, setaHeight, "arquivos/setas/downsetaoff.png")
            end

            -- ** Back
            local backTextColor = tocolor(255, 255, 255, 255)
            local backBoxColor = tocolor(0, 0, 0, 140)
            if not selectedCategory then
                backTextColor = tocolor(100, 100, 100, 100)
            else
                if absX >= mainColumnPosX - bgMargin and absX <= mainColumnPosX - bgMargin + mainColumnWidth + 30 + (bgMargin * 2) and absY >= mainColumnPosY + mainColumnHeight + 10 and absY <= mainColumnPosY + mainColumnHeight + 10 + columnHeight then
                    backBoxColor = tocolor(74, 171, 208, 140)

                    if getKeyState("mouse1") then
                        selectedItem = false
                        selectedCategory = false
                        visibleItem = 1
                    --    destroyGUI()

                        playSound(":VDBGPanelSound/fecha.mp3", false)
                    end
                end
            end
            dxDrawRectangle(mainColumnPosX - bgMargin, mainColumnPosY + mainColumnHeight + 10, mainColumnWidth + 30 + (bgMargin * 2), columnHeight, backBoxColor)
            dxDrawText("Voltar", mainColumnPosX - bgMargin, mainColumnPosY + mainColumnHeight + 10, mainColumnPosX - bgMargin + mainColumnWidth + 30 + (bgMargin * 2), mainColumnPosY + mainColumnHeight + 10 + columnHeight, backTextColor, 0.5, titleFont, "center", "center", false, false, true, true, true)

            -- ** Buy
            local buyTextColor = tocolor(255, 255, 255, 255)
            local buyBoxColor = tocolor(0, 0, 0, 140)
            if not selectedCategory then
                buyTextColor = tocolor(100, 100, 100, 100)
            else
                if absX >= exitButtonPosX and absX <= exitButtonPosX + exitButtonWidth and absY >= exitButtonPosY - exitButtonHeight - 10 and absY <= exitButtonPosY - 10 then
                    buyBoxColor = tocolor(172, 211, 115, 140)
                end
            end
            --dxDrawRectangle(exitButtonPosX, exitButtonPosY - exitButtonHeight - 10, exitButtonWidth, exitButtonHeight, buyBoxColor)
            --dxDrawText("Vásárlás!", exitButtonPosX, exitButtonPosY - exitButtonHeight - 10, exitButtonPosX + exitButtonWidth, exitButtonPosY - exitButtonHeight - 10 + exitButtonHeight, buyTextColor, 0.5, titleFont, "center", "center", false, false, true, true, true)

            -- ** Exit
            local exitTextColor = tocolor(255, 255, 255, 255)
            local exitBoxColor = tocolor(0, 0, 0, 140)
            if absX >= exitButtonPosX and absX <= exitButtonPosX + exitButtonWidth and absY >= exitButtonPosY and absY <= exitButtonPosY + exitButtonHeight then
                exitBoxColor = tocolor(220, 20, 60, 140)

                if getKeyState("mouse1") then
                    --executeCommandHandler("diamondshop")
					panelState = false
					showCursor(false)
					showChat(true)
					
					setElementData(localPlayer, "opendashboard", false)
					playSound(":VDBGPDU/arquivos/fechar.mp3")
                end
            end
            dxDrawRectangle(exitButtonPosX, exitButtonPosY, exitButtonWidth, exitButtonHeight, exitBoxColor)
            dxDrawText("Sair", exitButtonPosX, exitButtonPosY, exitButtonPosX + exitButtonWidth, exitButtonPosY + exitButtonHeight, exitTextColor, 0.5, titleFont, "center", "center", false, false, true, true, true)

            local loopTable = {}
            if not selectedCategory then
                loopTable = availableCategories
            else
                if availableCategories[selectedCategory] then
                    loopTable = availableCategories[selectedCategory]["subCategories"]
                end
            end

            local categoryCount = 0
            for k,v in ipairs(loopTable) do
                if k >= visibleItem and k <= visibleItem + 15 then
                    if categoryCount % 2 ~= 0 then
                        dxDrawRectangle(mainColumnPosX, mainColumnPosY + (categoryCount * columnHeight), mainColumnWidth, columnHeight, tocolor(255, 255, 255, 40))
                    end

                    if absX >= mainColumnPosX and absX <= mainColumnPosX + mainColumnWidth and absY >= mainColumnPosY + (categoryCount * columnHeight) and absY <= mainColumnPosY + (categoryCount * columnHeight) + columnHeight then
                        dxDrawRectangle(mainColumnPosX, mainColumnPosY + (categoryCount * columnHeight), mainColumnWidth, columnHeight, tocolor(35, 158, 240, 140))

                        if not selectedCategory then
                            if getKeyState("mouse1") then
                                selectedCategory = k
                                visibleItem = 1
                                playSound(":VDBGPanelSound/navegacao.mp3", false)

                                if selectedCategory == 1 or selectedCategory == 2 or selectedCategory == 4 or selectedCategory == 5 then
                                    createGUI()
                                end
                            end
                        else
                            if selectedItem ~= k then
                                if getKeyState("mouse1") then
                                    selectedItem = k
                                    playSound(":VDBGPanelSound/navegacao.mp3", false)
                                end
                            end
                        end
                    end

                    dxDrawText(v["name"], mainColumnPosX, mainColumnPosY + (categoryCount * columnHeight), mainColumnPosX + mainColumnWidth, mainColumnPosY + (categoryCount * columnHeight) + columnHeight, tocolor(255, 255, 255, 255), 0.5, itemFont, "center", "center", false, false, true, true, true)

                    categoryCount = categoryCount + 1
                end
            end

            if selectedCategory then
                if availableCategories[selectedCategory] then
                    if selectedItem then
                        if availableCategories[selectedCategory]["subCategories"][selectedItem] then

                            if availableCategories[selectedCategory]["subCategories"][selectedItem]["imagePath"] then
                                dxDrawImage(exitButtonPosX, mainColumnPosY, exitButtonWidth, 160, availableCategories[selectedCategory]["subCategories"][selectedItem]["imagePath"] )
                            elseif availableCategories[selectedCategory]["imagePath"] then
                                dxDrawImage(exitButtonPosX, mainColumnPosY, exitButtonWidth, 160, availableCategories[selectedCategory]["imagePath"])
                            end

                            dxDrawText("#3B95DA" .. availableCategories[selectedCategory]["subCategories"][selectedItem]["name"], exitButtonPosX, mainColumnPosY + 170, exitButtonPosX + 10 + exitButtonWidth, 0, tocolor(255, 255, 255, 255), 0.5, titleFont, "center", "top", false, false, true, true, true)
                            if selectedCategory == 6 then
                            --    dxDrawText("Ár: #acd373" .. availableCategories[selectedCategory]["subCategories"][selectedItem]["amount"] .. " ArtPont #FFFFFF| #4aabd0(1 ArtPont = $" .. math.floor(availableCategories[selectedCategory]["subCategories"][selectedItem]["amount"] / availableCategories[selectedCategory]["subCategories"][selectedItem]["amount"]) .. ")", exitButtonPosX, mainColumnPosY + 190, exitButtonPosX + 10 + exitButtonWidth, 0, tocolor(255, 255, 255, 255), 0.5, titleFont, "left", "top", false, false, true, true, true)
                            else
                                --dxDrawText("Ár: #acd373" .. availableCategories[selectedCategory]["subCategories"][selectedItem]["amount"] .. " ArtPont", exitButtonPosX, mainColumnPosY + 190, exitButtonPosX + 10 + exitButtonWidth, 0, tocolor(255, 255, 255, 255), 0.5, titleFont, "left", "top", false, false, true, true, true)
                            end
                            if availableCategories[selectedCategory]["subCategories"][selectedItem]["description"] then -- járművek
                                dxDrawText(availableCategories[selectedCategory]["subCategories"][selectedItem]["description"], exitButtonPosX, mainColumnPosY + 210, exitButtonPosX + 10 + exitButtonWidth, 0, tocolor(255, 255, 255, 255), 0.45, titleFont, "center", "top", false, false, true, true, true)
                            end
                        end
                    end
                end
            end
		end
	end
)

function createNotification(text)
    notificationText = text
    notificationTick = getTickCount() + 5000
end