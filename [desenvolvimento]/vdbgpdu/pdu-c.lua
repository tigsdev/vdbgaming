local show = false
local hud = {
	ef_1 = 1 ,
	ef_2 = 1 ,
	ef_3 = 1 ,
	ef_4 = 1 ,
	ef_5 = 1
}
local outros = {
	ef_1 = 0 ,
	ef_2 = 0
}
local velocimetro = 0

local shaders = {
	ef_1 = 0 ,
	ef_2 = 0 ,
	ef_3 = 0 ,
	ef_4 = 0 ,
	ef_5 = 0 ,
	ef_6 = 0
}
local menu = 1
local oldal = 1

local Dash = {
	alpha = 0
}

local team = getPlayerTeam(getLocalPlayer())
local civi = getTeamName(team)

local jelenMenuPont = 1

local sc = { guiGetScreenSize() } 
local s = { guiGetScreenSize() }
local Settings = {}

local coricones1 = tocolor(255,255,255,100)
local coricones2 = tocolor(255,255,255,100)
local coricones3 = tocolor(255,255,255,100)
local coricones4 = tocolor(255,255,255,100)

local qmenu1 = {s[1]/2-40/2-(410),s[2]/2-40/2-(350), 80,80}
local qmenu2 = {s[1]/2-40/2-(170),s[2]/2-40/2-(350), 80,80}
local qmenu3 = {s[1]/2-40/2+(75),s[2]/2-40/2-(350), 80,80}
local qmenu4 = {s[1]/2-40/2+(320),s[2]/2-40/2-(350), 80,80}

local Zold_1 = "#ffffff"
local Zold_2 = "#ffffff"
local Zold_3 = "#ffffff"
local Zold_4 = "#ffffff"

local MenuK = {900,600}
local MenuP = {s[1]/2 - MenuK[1]/2,s[2]/2 - MenuK[2]/1.5}

local KicsiMenuK = {900,30}
local KicsiMenuP = {s[1]/2 - KicsiMenuK[1]/2,s[2]/3 - KicsiMenuK[2]/2}

local AvatarK = {40,40}
local AvatarP = {s[1]/2 - AvatarK[1]/2,s[2]/2 - AvatarK[2]/2}

local HouseK = {67,57}
local HouseP = {s[1]/2 - HouseK[1]/2,s[2]/2 - HouseK[2]/2}

local CarK = {97,49}
local CarP = {s[1]/2 - CarK[1]/2,s[2]/2 - CarK[2]/2}

local AnonymK = {92,108}
local AnonymP = {s[1]/2 - AnonymK[1]/2,s[2]/2 - AnonymK[2]/2}

local Eg_Font = dxCreateFont("font.ttf",11)

-- Menu Header
local headerK = { s[1] }

local Menupontok = {-- Neve
 {"Geral"},
 {"Servidor"},
 {"Conta"},
 {"Config"} 
}

function clicandonomenu()
		if (show == false ) then
			KeyState()
		end
end

function KeyState()
if (getElementData(localPlayer,"logado") == false) then return end
if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	if (show == false ) then
		if getElementData ( localPlayer, "opendashboard") == false then
			show = true
			addEventHandler("onClientRender",getRootElement(),draw)
			addEventHandler("onClientClick",getRootElement(),MenuButton)
			toggleControl("change_camera",false)
			toggleElmosas()--Blur
			achievementAdat = 0
			if getElementData ( localPlayer, "paberto") == false then
			setElementData(localPlayer,"opendashboard",true)
			playSound("arquivos/abrir.mp3")
			showChat(false)
			showCursor(true)
			end
			triggerServerEvent ( "VDBGPDU:Modules->Panel:RequestDataJob", localPlayer )
		end
	else
		show = false
		removeEventHandler("onClientRender",getRootElement(),draw)
		removeEventHandler("onClientClick",getRootElement(),MenuButton)
		toggleControl("change_camera",false)
		toggleElmosas()--Blur
		playSound("arquivos/fechar.mp3")
		achievementAdat = 0
		if getElementData ( localPlayer, "paberto") == false then
		showCursor(false)
		setElementData(localPlayer,"opendashboard",false)
		showChat(true)
		end
	end
end
bindKey("Home","down",KeyState)

function draw()
	-- Header

	
	dxDrawRectangle(MenuP[1],MenuP[2],MenuK[1],MenuK[2] + 120,tocolor(0,0,0,70),true)
	
	dxDrawRectangle(MenuP[1],MenuP[2]+120,MenuK[1],50,tocolor(0, 0, 0,120),true) -- noticacoes
	
	dxDrawRectangle(MenuP[1]-3,MenuP[2],3,MenuK[2] +120,tocolor(0,0,0,180),true) -- esquerda pra baixo
	
	dxDrawRectangle(MenuP[1] + 900,MenuP[2],3,MenuK[2] + 120,tocolor(0,0,0,180),true) -- direita pra baixo
	
	dxDrawRectangle(MenuP[1]-3,MenuK[2]+104,MenuK[1] + 6,3,tocolor(0,0,0,180),true) -- rodape 
									
	-- Header Texts
	meret = s[1]/4.5 + 15
	if oldal == 1 then
		dxDrawRectangle(qmenu1[1],qmenu1[2],qmenu1[3],qmenu1[4],tocolor(0,0,0,100),true) -- geral
		dxDrawText (Zold_1..Menupontok[1][1], KicsiMenuP[1] + (115), 90, KicsiMenuP[1], 70, tocolor(255,255,255,255), 1, Eg_Font, "center", "center",false,false,true,true )
		dxDrawImage(s[1]/2-40/2-(400),s[2]/2-40/2-(350), 60,60, "icones/geral.png",0,0,0,coricones1,true)

		dxDrawRectangle(qmenu2[1],qmenu2[2],qmenu2[3],qmenu2[4],tocolor(0,0,0,100),true) -- board
		dxDrawText (Zold_2..Menupontok[2][1], KicsiMenuP[1] + (600), 90, KicsiMenuP[1], 70, tocolor(255,255,255,255), 1, Eg_Font, "center", "center",false,false,true,true )
		dxDrawImage(s[1]/2-40/2-(158),s[2]/2-40/2-(350), 60,60, "icones/board.png",0,0,0,coricones2,true)
		
		dxDrawRectangle(qmenu3[1],qmenu3[2],qmenu3[3],qmenu3[4],tocolor(0,0,0,100),true) -- board
		dxDrawText (Zold_3..Menupontok[3][1], KicsiMenuP[1]+ (1090), 90, KicsiMenuP[1], 70, tocolor(255,255,255,255), 1, Eg_Font, "center", "center",false,false,true,true )
		dxDrawImage(s[1]/2-40/2+(85),s[2]/2-40/2-(350), 60,60, "icones/estatisticas.png",0,0,0,coricones3,true)
		
		dxDrawRectangle(qmenu4[1],qmenu4[2],qmenu4[3],qmenu4[4],tocolor(0,0,0,100),true) -- board
		dxDrawText (Zold_4..Menupontok[4][1], KicsiMenuP[1] + (1580), 90, KicsiMenuP[1], 70, tocolor(255,255,255,255), 1, Eg_Font, "center", "center",false,false,true,true )
		dxDrawImage(s[1]/2-40/2+(330),s[2]/2-40/2-(350), 60,60, "icones/config.png",0,0,0,coricones4,true)
	end
	
	-- bordas da base
	
	
	
	-- Text Színezés
	if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*XY[1], cursorY*XY[2]
		if(dobozbaVan(qmenu1[1],qmenu1[2],qmenu1[3],qmenu1[4], cursorX, cursorY)) then
			Zold_1 = "#428BCA"
			coricones1 = tocolor(255,255,255,255)
		else
			Zold_1 = "#ffffff"
			coricones1 = tocolor(255,255,255,100)
		end
		if(dobozbaVan(qmenu2[1],qmenu2[2],qmenu2[3],qmenu2[4], cursorX, cursorY)) then
			Zold_2 = "#428BCA"
			coricones2 = tocolor(255,255,255,255)
		else
			Zold_2 = "#ffffff"
			coricones2 = tocolor(255,255,255,100)
		end
		if(dobozbaVan(qmenu3[1],qmenu3[2],qmenu3[3],qmenu3[4], cursorX, cursorY)) then
			Zold_3 = "#428BCA"
			coricones3 = tocolor(255,255,255,255)
		else
			Zold_3 = "#ffffff"
			coricones3 = tocolor(255,255,255,100)
		end
		if(dobozbaVan(qmenu4[1],qmenu4[2],qmenu4[3],qmenu4[4], cursorX, cursorY)) then
			Zold_4 = "#428BCA"
			coricones4 = tocolor(255,255,255,255)
		else
			Zold_4 = "#ffffff"
			coricones4 = tocolor(255,255,255,100)
		end
	end
	if menu == 1 then
		Zold_1 = "#428BCA"
		coricones1 = tocolor(255,255,255,255)
		
		
	-- notificacoes inicio
	dxDrawRectangle(MenuP[1],MenuP[2]+190,MenuK[1],80,tocolor(0,0,0,140),true) -- topo 
	dxDrawRectangle(MenuP[1],MenuP[2]+189,MenuK[1],3,tocolor(0, 0, 0,120),true) -- borda rodape noticacoes
	dxDrawRectangle(MenuP[1],MenuP[2]+267,MenuK[1],3,tocolor(0, 0, 0,120),true) -- borda topo noticacoes
	dxDrawText ("#FFBF00MENSAGEM DA ADMINISTRAÇÃO:\n\n#428BCAAcesse seu perfil em: #ffffff www.vdbg.org > Login | #428BCAReporte Jogadores, Bugs e Outros em: #ffffffwww.vdbg.org > Fórum",MenuP[1] + 10,MenuP[2]-56, 500, 500, tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		
	-- notificacoes inicio fim
		team = getPlayerTeam(getLocalPlayer())
		civi = getTeamName(team)
		dxDrawImage(s[1]/2-40/2-(115),s[2]/2-40/2+(70), 148, 58, "equipes/criminoso1.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawImage(s[1]/2-40/2+(40),s[2]/2-40/2+(70), 148, 58, "equipes/policial1.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawImage(s[1]/2-40/2-(270),s[2]/2-40/2+(70), 148, 58, "equipes/civilizante1.png",0,0,0,tocolor(255,255,255,255),true)
        
		if civi == "Administração" then
		dxDrawImage(s[1]/2-40/2-(270),s[2]/2-40/2+(70), 148, 58, "equipes/civilizante2.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		if civi == "Civilizante" then
		dxDrawImage(s[1]/2-40/2-(270),s[2]/2-40/2+(70), 148, 58, "equipes/civilizante2.png",0,0,0,tocolor(255,255,255,255),true)
		end
		if civi == "Emergencia" then
		dxDrawImage(s[1]/2-40/2-(270),s[2]/2-40/2+(70), 148, 58, "equipes/civilizante2.png",0,0,0,tocolor(255,255,255,255),true)
		end
		if civi ==  "Desempregado" then
		dxDrawImage(s[1]/2-40/2-(270),s[2]/2-40/2+(70), 148, 58, "equipes/civilizante2.png",0,0,0,tocolor(255,255,255,255),true)
		end
		if civi == "Convidado"  then
		dxDrawImage(s[1]/2-40/2-(270),s[2]/2-40/2+(70), 148, 58, "equipes/civilizante2.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		if civi == "Criminoso" then
		dxDrawImage(s[1]/2-40/2-(115),s[2]/2-40/2+(70), 148, 58, "equipes/criminoso2.png",0,0,0,tocolor(255,255,255,255),true)
		end
		if civi == "Policial" then
		dxDrawImage(s[1]/2-40/2+(40),s[2]/2-40/2+(70), 148, 58, "equipes/policial2.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		
		local procurado = getPlayerWantedLevel(getLocalPlayer())
		local nome = getPlayerName(getLocalPlayer())
		local dinheiro = getPlayerMoney (getLocalPlayer())
		local tempo = getElementData(getLocalPlayer(), "Playtime")
		local diamantes = exports.VDBGVIP:getVdbgDiamantes(getLocalPlayer()) or 0
		
		local id = getElementData ( localPlayer, "accountID")
		dxDrawText ("#5BADFFNome: #ffffff"..nome, KicsiMenuP[1] + (170),KicsiMenuP[2]/5-40/2+(360), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		dxDrawText ("#5BADFFID Da conta: #ffffff"..id, KicsiMenuP[1] + (170),KicsiMenuP[2]/5-40/2+(400), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		
		dxDrawText ("#5BADFFTempo de jogo: #ffffff "..tempo, KicsiMenuP[1] + (170),KicsiMenuP[2]/5-40/2+(440), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		dxDrawText ("#5BADFFNível de Procurado: #ffffff("..procurado..")", KicsiMenuP[1] + (170),KicsiMenuP[2]/5-40/2+(490), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		dxDrawText ("#5BADFFDinheiro: #ffffffR$ "..dinheiro.."", KicsiMenuP[1] + (170),KicsiMenuP[2]/5-40/2+(540), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		dxDrawText ("#5BADFFDiamantes: #ffffff"..diamantes, KicsiMenuP[1] + (170),KicsiMenuP[2]/5-40/2+(600), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		
		local skinID = getElementModel(getLocalPlayer())
		dxDrawRectangle(s[1]/2-40/2-(382),s[2]/2-40/2-(82), 107, 211,tocolor(0,0,0,150),true)
		
		dxDrawImage(s[1]/2-40/2-(380),s[2]/2-40/2-(80), 103, 206, "arquivos/skins/".. skinID ..".jpg",0,0,0,tocolor(255,255,255,255),true)
	
		
		
		dxDrawRectangle(s[1]/2-40/2-(382),s[2]/2-40/2+(170), 828, 150,tocolor(0,0,0,150),true)
		dxDrawText ("#FFBF00ATUALIZAÇÕES:",s[1]/2-40/2-(372),s[2]/2-40/2+(520), 828, 150, tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		dxDrawText ("#428BCAAtualmente, as atualizações do servidor estão disponíveis em: \n\n#ffffff www.vdbg.org > Sobre > Atualizações", s[1]/2-40/2-(372),s[2]/2-40/2+(300), 500, 500, tocolor(255,255,255,255), 1, Eg_Font, "left", "center",true,true,true,true )
		
		
		elseif menu == 2 then
		dxDrawText ("#ffffffNossas Redes Sociais", KicsiMenuP[1] -(450),KicsiMenuP[2]/1.5, KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		
		
		dxDrawRectangle(s[1]/2,s[2]/2-230,3,550,tocolor(0, 0, 0,200),true)
		-- CAIXA 1 Facebook
	
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2-(150)-(7), 430, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2-(150)-(7),39,39,"estatisticas/prisoes.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Facebook VDBGaming: www.vdbg.org/fb",KicsiMenuP[1] - (440),KicsiMenuP[2]/5-40/2+(235), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2-(100)-(7), 430, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2-(100)-(7),39,39,"estatisticas/prisoes.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Twitter VDBGaming: www.vdbg.org/tt",KicsiMenuP[1] - (440),KicsiMenuP[2]/5-40/2+(335), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2-(50)-(7), 430, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2-(50)-(7),39,39,"estatisticas/prisoes.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Fórum VDBGaming: www.vdbg.org/forum",KicsiMenuP[1] - (440),KicsiMenuP[2]/5-40/2+(435), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2-(0)-(7), 430, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2-(0)-(7),39,39,"estatisticas/prisoes.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Team Speak VDBGaming: ts.vdbg.org:9990",KicsiMenuP[1] - (440),KicsiMenuP[2]/5-40/2+(535), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2+(50)-(7), 430, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2+(50)-(7),39,39,"estatisticas/prisoes.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Painel de Controle do usuário: www.vdbg.org",KicsiMenuP[1] - (440),KicsiMenuP[2]/5-40/2+(635), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawText ("#ffffffNovidades", KicsiMenuP[1] +(450),KicsiMenuP[2]/1.5, KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawImage(s[1]/2-40/2+(50),s[2]/2-40/2-(170), 400, 500, "arquivos/advip.png",0,0,0,tocolor(255,255,255,255),true)
		
		dxDrawText ("#ffffffParceiros", KicsiMenuP[1] -(450),KicsiMenuP[2]+519, KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawImage(s[1]/2-40/2-(405),s[2]/2-40/2+(130), 400, 200, "arquivos/advip.png",0,0,0,tocolor(255,255,255,255),true)
	elseif menu == 3 then
		Zold_3 = "#428BCA"
		coricones3 = tocolor(255,255,255,255)
		
		local prisao = getElementData(getLocalPlayer(), "prissoes")	
		local coletas = getElementData(getLocalPlayer(), "coletasdelixo")	
		local viagens = getElementData(getLocalPlayer(), "pontostaxista")	
		local paradas = getElementData(getLocalPlayer(), "paradasbus")	
		local cargas = getElementData(getLocalPlayer(), "viagenscamin")	
		local entregas = getElementData(getLocalPlayer(), "pontospizzas")	
		local acoes = getElementData(getLocalPlayer(), "acoescriminosas")	
		local reparos = getElementData(getLocalPlayer(), "veiculosreparados")	
		local curas = getElementData(getLocalPlayer(), "playerscurado")	
		local ginchou = getElementData(getLocalPlayer(), "TowedVehicles")		
		local peixes = getElementData(getLocalPlayer(), "peixescoletado")		
		local misterios = getElementData(getLocalPlayer(), "crimesresolvido")		
		local voos = getElementData(getLocalPlayer(), "vooscompleto")		
		local manobras = getElementData(getLocalPlayer(), "stunts")		
		local vantagens = getElementData(getLocalPlayer(), "pontosvagabundo")	
		
		-- CAIXA 1 PRETA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2-(200)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2-(200)-(7),39,39,"estatisticas/prisoes.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Prisões: "..prisao,KicsiMenuP[1] - (640),KicsiMenuP[2]/5-40/2+(140), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2-(200)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2-(200)-(7),39,39,"estatisticas/lixocoletado.png",0,0,0,tocolor(255,255,255,255),true)
							
		
		dxDrawText ("Coletas: "..coletas,KicsiMenuP[1] - (200),KicsiMenuP[2]/5-40/2+(140), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		-- CAIXA 2 BRANCA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2-(150)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2-(150)-(7),39,39,"estatisticas/viagenscomotaxista.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Viagens: "..viagens,KicsiMenuP[1] - (640),KicsiMenuP[2]/5-40/2+(240), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2-(150)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2-(150)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Paradas: "..paradas,KicsiMenuP[1] - (200),KicsiMenuP[2]/5-40/2+(240), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		-- CAIXA 3 PRETA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2-(100)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2-(100)-(7),39,39,"estatisticas/engregascaminhoneiro.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Cargas: "..cargas,KicsiMenuP[1] - (640),KicsiMenuP[2]/5-40/2+(340), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2-(100)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2-(100)-(7),39,39,"estatisticas/pizzasentregue.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Entregas: "..entregas,KicsiMenuP[1] - (200),KicsiMenuP[2]/5-40/2+(340), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		-- CAIXA 4 BRANCA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2-(50)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2-(50)-(7),39,39,"estatisticas/acoescriminosa.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Ações: "..acoes,KicsiMenuP[1] - (640),KicsiMenuP[2]/5-40/2+(440), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2-(50)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2-(50)-(7),39,39,"estatisticas/veiculosreparados.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Reparos: "..reparos,KicsiMenuP[1] - (200),KicsiMenuP[2]/5-40/2+(440), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		-- CAIXA 5 PRETA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2+(0.1)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2+(0.1)-(7),39,39,"estatisticas/jogadorescurados.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Curas: "..curas,KicsiMenuP[1] - (640),KicsiMenuP[2]/5-40/2+(540), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2+(0.1)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2+(0.1)-(7),39,39,"estatisticas/veiculosguinchado.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Guinchou: "..ginchou,KicsiMenuP[1] - (200),KicsiMenuP[2]/5-40/2+(540), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		-- CAIXA 6 BRANCA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2+(50)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2+(50)-(7),39,39,"estatisticas/peixes_coletados.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Peixes: "..peixes,KicsiMenuP[1] - (640),KicsiMenuP[2]/5-40/2+(640), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2+(50)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2+(50)-(7),39,39,"estatisticas/crimes_resolvidos.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Mistérios: "..misterios,KicsiMenuP[1] - (200),KicsiMenuP[2]/5-40/2+(640), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		-- CAIXA 7 PRETA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2+(100)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2+(100)-(7),39,39,"estatisticas/vooscompleto.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Vôos: "..voos,KicsiMenuP[1] - (640),KicsiMenuP[2]/5-40/2+(740), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2+(100)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2+(100)-(7),39,39,"estatisticas/manobras.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Manobras: "..manobras,KicsiMenuP[1] - (200),KicsiMenuP[2]/5-40/2+(740), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
	
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2+(150)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2+(150)-(7),39,39,"estatisticas/vagal.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Vantagens: "..vantagens,KicsiMenuP[1] - (640),KicsiMenuP[2]/5-40/2+(840), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		--[[dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2+(150)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2+(150)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		
		-- CAIXA 7 PRETA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2+(200)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2+(200)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2+(200)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2+(200)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		
		-- CAIXA 6 BRANCA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2+(250)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2+(250)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2+(250)-(7), 210, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2+(250)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		
		-- CAIXA 7 PRETA
		dxDrawRectangle(s[1]/2-883/2,s[2]/2-40/2+(300)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-883/2,s[2]/2-40/2+(300)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawRectangle(s[1]/2-430/2,s[2]/2-40/2+(300)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2-430/2,s[2]/2-40/2+(300)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		]]
		dxDrawRectangle(s[1]/2,s[2]/2-230,3,550,tocolor(0, 0, 0,200),true)
		
		
		dxDrawRectangle(s[1]/2+25/2,s[2]/2-40/2-(200)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2+25/2,s[2]/2-40/2-(200)-(7),39,39,"estatisticas/prisoes.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText (getElementData ( localPlayer, "AccountData:Username"),KicsiMenuP[1] + (240),KicsiMenuP[2]/5-40/2+(140), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2+470/2,s[2]/2-40/2-(200)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage(s[1]/2+470/2,s[2]/2-40/2-(200)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("IP:"..getElementData ( localPlayer, "AccountData:IP" ),KicsiMenuP[1] + (690),KicsiMenuP[2]/5-40/2+(140), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2+25/2,s[2]/2-40/2-(150)-(7), 433, 40,tocolor(100, 100, 100, 100),true)
		dxDrawImage(s[1]/2+25/2,s[2]/2-40/2-(150)-(7),39,39,"estatisticas/viagenscomotaxista.png",0,0,0,tocolor(255,255,255,255),true)
		local serial = getElementData ( localPlayer, "AccountData:Serial")
		dxDrawText ("Serial: "..serial,KicsiMenuP[1] + (480),KicsiMenuP[2]/5-40/2+(240), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )		
		
		dxDrawRectangle(s[1]/2+25/2,s[2]/2-40/2-(100)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage    (s[1]/2+25/2,s[2]/2-40/2-(100)-(7),39,39,"estatisticas/viagenscomotaxista.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Matou: "..getElementData ( localPlayer, "VDBGSQL:Kills" ) or 0, KicsiMenuP[1] + (240),KicsiMenuP[2]/5-40/2+(340), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )

		dxDrawRectangle(s[1]/2+470/2,s[2]/2-40/2-(100)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage    (s[1]/2+470/2,s[2]/2-40/2-(100)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Morreu: "..getElementData ( localPlayer, "VDBGSQL:Deaths" ) or 0,KicsiMenuP[1] + (690),KicsiMenuP[2]/5-40/2+(340), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		local infoevento = getElementData(getLocalPlayer(), "infoevento")		
		local questaomatematica = getElementData(getLocalPlayer(), "questaomatematica")		
		local dinheirovipquando = getElementData(getLocalPlayer(), "dinheirovipquando")	
		local vencimento = getElementData(getLocalPlayer(), "VDBGVIP.expDate")	
		local vipplano = getElementData(getLocalPlayer(), "VIP")	

		dxDrawRectangle(s[1]/2+25/2,s[2]/2-40/2-(0)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage    (s[1]/2+25/2,s[2]/2-40/2-(0)-(7),39,39,"estatisticas/viagenscomotaxista.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText (""..questaomatematica,KicsiMenuP[1] + (240),KicsiMenuP[2]/5-40/2+(540), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		dxDrawRectangle(s[1]/2+470/2,s[2]/2-40/2-(0)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage    (s[1]/2+470/2,s[2]/2-40/2-(0)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText (""..infoevento,KicsiMenuP[1] + (690),KicsiMenuP[2]/5-40/2+(540), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
	
		
		dxDrawRectangle(s[1]/2+25/2,s[2]/2-40/2+(100)-(7), 210, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage    (s[1]/2+25/2,s[2]/2-40/2+(100)-(7),39,39,"estatisticas/viagenscomotaxista.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText (""..vipplano, KicsiMenuP[1] + (240),KicsiMenuP[2]/5-40/2+(740), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
	
		dxDrawRectangle(s[1]/2+25/2,s[2]/2-40/2+(150)-(7), 433, 40,tocolor(0, 0, 0, 100),true)
		dxDrawImage    (s[1]/2+25/2,s[2]/2-40/2+(150)-(7),39,39,"estatisticas/paradasdeonibus.png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawText ("Expira em: "..vencimento.." | Peark VIP: "..dinheirovipquando,KicsiMenuP[1] + (480),KicsiMenuP[2]/5-40/2+(840), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
	
	elseif menu == 4 then
		Zold_4 = "#428BCA"
		coricones4 = tocolor(255,255,255,255)
		
		dxDrawRectangle(s[1]/2,s[2]/2-230,3,550,tocolor(0, 0, 0,200),true)
		
		dxDrawRectangle(s[1]/2-40/2-(270),s[2]/2-40/2-(186),155,30,tocolor(0,0,0,150),true)
		dxDrawText ("#ffffffLigar HUD ON/OFF",KicsiMenuP[1] - (425),KicsiMenuP[2]/5-40/2+(170), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		DX_Text("Chat",s[1]/2-870/2, s[2]/2-290/2,20,20)
		if getElementData ( localPlayer, "chatstate") == true then
			dxDrawImage(s[1]/2-260/2,s[2]/2-300/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2-260/2,s[2]/2-300/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		DX_Text("Radar",s[1]/2-870/2, s[2]/2-230/2,20,20)
		if getElementData ( localPlayer, "radarstate") == true then
			dxDrawImage(s[1]/2-260/2,s[2]/2-240/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2-260/2,s[2]/2-240/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		DX_Text("Hud",s[1]/2-870/2, s[2]/2-170/2,20,20)
		if getElementData ( localPlayer, "hudstate") == true then
			dxDrawImage(s[1]/2-260/2,s[2]/2-180/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2-260/2,s[2]/2-180/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		DX_Text("Notificações",s[1]/2-870/2, s[2]/2-110/2,20,20)
		if hud.ef_4 == 0 then
			dxDrawImage(s[1]/2-260/2,s[2]/2-120/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2-260/2,s[2]/2-120/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		DX_Text("Velocimetro",s[1]/2-870/2, s[2]/2-50/2,20,20)
		if getElementData ( localPlayer, "velocimetrostate") == true then
			dxDrawImage(s[1]/2-260/2,s[2]/2-60/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2-260/2,s[2]/2-60/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		dxDrawRectangle(s[1]/2-40/2-(270),s[2]/2-40/2+(70),155,30,tocolor(0,0,0,150),true)
		dxDrawText ("#ffffffSelecione um Avatar",KicsiMenuP[1] - (425),KicsiMenuP[2]/5-40/2+(680), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		

		
		-- # Avatár Váltás
		if getElementData(localPlayer,"avatar") == 100 then
			setElementData(localPlayer,"avatar",1)
		end								
		if getElementData(localPlayer,"avatar") == 0 then
			setElementData(localPlayer,"avatar",1) 
		end	

		
		dxDrawImage(s[1]/2-40/2-(215),s[2]/2-40/2+(130),40,40,":VDBGPDU/avatares/"..getElementData(localPlayer,"avatar")..".png",0,0,0,tocolor(255,255,255,255),true)
		dxDrawImage(s[1]/2-16/2-(165),s[2]/2-28/2+(130),16,28,"arquivos/setas/u2.png",90,0,0,tocolor(255,255,255,255),true)
		dxDrawImage(s[1]/2-16/2-(265),s[2]/2-28/2+(130),16,28,"arquivos/setas/u2.png",270,0,0,tocolor(255,255,255,255),true)
		
		dxDrawRectangle(s[1]/2-40/2-(270),s[2]/2-40/2+(200),155,30,tocolor(0,0,0,150),true)
		dxDrawText ("#ffffffOutros",KicsiMenuP[1] - (425),KicsiMenuP[2]/5-40/2+(940), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		DX_Text("#ffffffTextura em veículos",s[1]/2-870/2, s[2]/2+440/2,20,20)
		if getElementData ( localPlayer, "downloadstate") == true then
			dxDrawImage(s[1]/2-260/2,s[2]/2+450/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2-260/2,s[2]/2+450/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		DX_Text("#ffffffTag dos Jogadores",s[1]/2-870/2, s[2]/2+500/2,20,20)
		if getElementData ( localPlayer, "tagstate") == true then
			dxDrawImage(s[1]/2-260/2,s[2]/2+510/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2-260/2,s[2]/2+510/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		-------- MELHORAR GRÁFICOS
		-------- MELHORAR GRÁFICOS
		-------- MELHORAR GRÁFICOS
		-------- MELHORAR GRÁFICOS
		
		
		dxDrawRectangle(s[1]/2-40/2+150,s[2]/2-40/2-(186),155,30,tocolor(0,0,0,150),true)
		dxDrawText ("#ffffffMelhorar Interface",KicsiMenuP[1] + (425),KicsiMenuP[2]/5-40/2+(170), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
		
		
		
		DX_Text("Refletir Pinturas",s[1]/2+40/2,s[2]/2-300/2,20,20)
		if shaders.ef_1 == 0 then
			dxDrawImage(s[1]/2+620/2,s[2]/2-300/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2+620/2,s[2]/2-300/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		DX_Text("Horizonte FULL",s[1]/2+40/2, s[2]/2-240/2,20,20)
		if shaders.ef_2 == 0 then
			dxDrawImage(s[1]/2+620/2,s[2]/2-240/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2+620/2,s[2]/2-240/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end		
		
		DX_Text("Textura na Rua",s[1]/2+40/2, s[2]/2-180/2,20,20)
		if shaders.ef_3 == 0 then
			dxDrawImage(s[1]/2+620/2,s[2]/2-180/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2+620/2,s[2]/2-180/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end		
		
		
		DX_Text("Contraste",s[1]/2+40/2, s[2]/2-120/2,20,20)
		if shaders.ef_4 == 0 then
			dxDrawImage(s[1]/2+620/2,s[2]/2-120/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2+620/2,s[2]/2-120/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end	
		
		
		DX_Text("Gráfico sofisticado",s[1]/2+40/2, s[2]/2-60/2,20,20)
		if shaders.ef_5 == 0 then
			dxDrawImage(s[1]/2+620/2,s[2]/2-60/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2+620/2,s[2]/2-60/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		DX_Text("Céu realistico",s[1]/2+40/2, s[2]/2-1/2,20,20)
		if shaders.ef_6 == 0 then
			dxDrawImage(s[1]/2+620/2,s[2]/2-1/2,100,30,"arquivos/setas/off.png",0,0,0,tocolor(255,255,255,255),true)
		else
			dxDrawImage(s[1]/2+620/2,s[2]/2-1/2,100,30,"arquivos/setas/on.png",0,0,0,tocolor(255,255,255,255),true)
		end
		
		
		----------- VELOCIMETRO
		
		DX_Text("Selecione um design para o velocímetro",s[1]/2+160/2, s[2]/2+490/2,20,20)
		dxDrawImage(s[1]/2-16/2+(405),s[2]/2-28/2+(280),16,28,"arquivos/setas/u2.png",90,0,0,tocolor(255,255,255,255),true)
		dxDrawImage(s[1]/2-16/2+(45),s[2]/2-28/2+(280),16,28,"arquivos/setas/u2.png",270,0,0,tocolor(255,255,255,255),true)
		dxDrawRectangle(s[1]/2-16/2+(75),s[2]/2-28/2+(280),315,25,tocolor(0,0,0,150),true)
		
		if velocimetro == 2 then
			velocimetro = 0
		end	
		if velocimetro == 0 then
			dxDrawText ("#ffffffClássico",KicsiMenuP[1] + (455),KicsiMenuP[2]/5-40/2+(1110), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
			setElementData(localPlayer,"velo1", true)
			setElementData(localPlayer,"velo2", false)
		else
			dxDrawText ("#ffffffModerno",KicsiMenuP[1] + (455),KicsiMenuP[2]/5-40/2+(1110), KicsiMenuP[1] + KicsiMenuK[1], KicsiMenuP[2]/1.5 + KicsiMenuK[2], tocolor(255,255,255,255), 1, Eg_Font, "center", "center",true,true,true,true )
			setElementData(localPlayer,"velo1", false)
			setElementData(localPlayer,"velo2", true)
		end
		
	end

end	

function MenuButton(gomb,statusz,x,y)
	if gomb == "left" and statusz == "down" then
		if(dobozbaVan(meret*0 + 15, 0, meret*0+meret, 80,x,y)) then
			menu=1
			playSound("arquivos/clica.mp3")
		end		
		if(dobozbaVan(meret*1 + 15, 0, meret*0+meret, 80,x,y)) then
			menu=menu
			playSound("arquivos/clica.mp3")
			-- menu de informações
		end		
		if(dobozbaVan(meret*2 + 15, 0, meret*0+meret, 80,x,y)) then
			menu=3
			playSound("arquivos/clica.mp3")
		end
		if(dobozbaVan(meret*3 + 15, 0, meret*0+meret, 80,x,y)) then
			menu=4
			playSound("arquivos/clica.mp3")
		end
		if menu == 4 then
		-- avatár change
		if(dobozbaVan(s[1]/2-16/2-(165),s[2]/2-28/2+(130),16,28,x,y)) then
			setElementData(localPlayer,"avatar", getElementData(localPlayer,"avatar") + 1)  
			outputDebugString(getElementData(localPlayer,"avatar"))
		playSound("arquivos/clicaop.mp3")
		end		
		if(dobozbaVan(s[1]/2-16/2-(265),s[2]/2-28/2+(130),16,28,x,y)) then
			setElementData(localPlayer,"avatar", getElementData(localPlayer,"avatar") - 1)  
			outputDebugString(getElementData(localPlayer,"avatar"))
		playSound("arquivos/clicaop.mp3")
		end		
		-------- MELHORAR GRÁFICOS
		-------- MELHORAR GRÁFICOS
		-------- MELHORAR GRÁFICOS
		
		-------- Refletir Pinturas
		if(dobozbaVan(s[1]/2+620/2,s[2]/2-300/2,100,30,x,y) and shaders.ef_1 == 0) then-- Kocsi
			shaders.ef_1 = 1
			startCarPaintReflect()
			playSound("arquivos/ativa.mp3")
		elseif(dobozbaVan(s[1]/2+620/2,s[2]/2-300/2,100,30,x,y) and shaders.ef_1 == 1) then
			shaders.ef_1 = 0
			stopCarPaintReflect()
			playSound("arquivos/desativa.mp3")
		end
		-------- Horizonte full
		if(dobozbaVan(s[1]/2+620/2,s[2]/2-240/2,100,30,x,y) and shaders.ef_2 == 0) then -- Látotávolság
			shaders.ef_2 = 1
			togClipDistance(true)
		elseif(dobozbaVan(s[1]/2+620/2,s[2]/2-240/2,100,30,x,y) and shaders.ef_2 == 1) then
			shaders.ef_2 = 0
			togClipDistance(false)
			playSound("arquivos/desativa.mp3")
		end			
		-------- Textura na Rua
		if(dobozbaVan(s[1]/2+620/2,s[2]/2-180/2,100,30,x,y) and shaders.ef_3 == 0) then -- Viz
			shaders.ef_3 = 1
			startWaterRefract()
		elseif(dobozbaVan(s[1]/2+620/2,s[2]/2-180/2,100,30,x,y) and shaders.ef_3 == 1) then
			shaders.ef_3 = 0
			executeCommandHandler("waterrefrectstopfunction")
			playSound("arquivos/desativa.mp3")
		end
		-------- Contraste
		if(dobozbaVan(s[1]/2+620/2,s[2]/2-120/2,100,30,x,y) and shaders.ef_4 == 0) then -- Kontraszt
			shaders.ef_4 = 1
			enableContrast()
		elseif(dobozbaVan(s[1]/2+620/2,s[2]/2-120/2,100,30,x,y) and shaders.ef_4 == 1) then
			shaders.ef_4 = 0
			disableContrast()
			playSound("arquivos/desativa.mp3")
		end		
		--------- Gráfico sofisticado
		if(dobozbaVan(s[1]/2+620/2,s[2]/2-60/2,100,30,x,y) and shaders.ef_5 == 0) then -- HD Textúra
			shaders.ef_5 = 1
			enableDetail()
		elseif(dobozbaVan(s[1]/2+620/2,s[2]/2-60/2,100,30,x,y) and shaders.ef_5 == 1) then
			shaders.ef_5 = 0
			disableDetail()
			playSound("arquivos/desativa.mp3")
		end		
		--------- Céu realistico
		if(dobozbaVan(s[1]/2+620/2,s[2]/2-1/2,100,30,x,y) and shaders.ef_6 == 0) then -- Égbolt
			shaders.ef_6 = 1
			startShaderResource()
		elseif(dobozbaVan(s[1]/2+620/2,s[2]/2-1/2,100,30,x,y) and shaders.ef_6 == 1) then
			shaders.ef_6 = 0
			stopShaderResource()
			playSound("arquivos/desativa.mp3")
		end	
		
		
		-- velocimetro
		if(dobozbaVan(s[1]/2-16/2+(405),s[2]/2-28/2+(280),16,28,x,y)) then
			velocimetro = velocimetro + 1
		playSound("arquivos/clicaop.mp3")
		end		
		if(dobozbaVan(s[1]/2-16/2+(45),s[2]/2-28/2+(280),16,28,x,y)) then
			velocimetro = velocimetro + 1
		playSound("arquivos/clicaop.mp3")
		end	
		
		
		
		-- configuração de hud
		-- chat
		if(dobozbaVan(s[1]/2-260/2,s[2]/2-300/2,100,30,x,y) and getElementData ( localPlayer, "chatstate") == true) then 
		setElementData(localPlayer,"chatstate",false)
		playSound("arquivos/ativa.mp3")
		elseif(dobozbaVan(s[1]/2-260/2,s[2]/2-300/2,100,30,x,y) and getElementData ( localPlayer, "chatstate") == false) then
		setElementData(localPlayer,"chatstate",true)
		playSound("arquivos/desativa.mp3")
		end	
		-- radar
		if(dobozbaVan(s[1]/2-260/2,s[2]/2-240/2,100,30,x,y) and getElementData ( localPlayer, "radarstate") == true) then 
		setElementData(localPlayer,"radarstate",false)
		playSound("arquivos/ativa.mp3")
		elseif(dobozbaVan(s[1]/2-260/2,s[2]/2-240/2,100,30,x,y) and getElementData ( localPlayer, "radarstate") == false) then
		setElementData(localPlayer,"radarstate",true)
		playSound("arquivos/desativa.mp3")
		end	
		-- hud
		if(dobozbaVan(s[1]/2-260/2,s[2]/2-180/2,100,30,x,y) and getElementData ( localPlayer, "hudstate") == true) then 
		setElementData(localPlayer,"hudstate",false)
		playSound("arquivos/ativa.mp3")
		hud.ef_3 = 1
		elseif(dobozbaVan(s[1]/2-260/2,s[2]/2-180/2,100,30,x,y) and getElementData ( localPlayer, "hudstate") == false) then
		setElementData(localPlayer,"hudstate",true)
		playSound("arquivos/desativa.mp3")
		hud.ef_3 = 0
		end	
		-- notificacoes
		if(dobozbaVan(s[1]/2-260/2,s[2]/2-120/2,100,30,x,y) and hud.ef_4 == 0) then 
		playSound("arquivos/ativa.mp3")
		
		hud.ef_4 = 1
		elseif(dobozbaVan(s[1]/2-260/2,s[2]/2-120/2,100,30,x,y) and hud.ef_4 == 1) then
		playSound("arquivos/desativa.mp3")
		
		hud.ef_4 = 0
		end	
		-- barra de acoes
		if(dobozbaVan(s[1]/2-260/2,s[2]/2-60/2,100,30,x,y) and  getElementData ( localPlayer, "velocimetrostate") == true) then 
		setElementData(localPlayer,"velocimetrostate",false)
		playSound("arquivos/ativa.mp3")
		elseif(dobozbaVan(s[1]/2-260/2,s[2]/2-60/2,100,30,x,y) and getElementData ( localPlayer, "velocimetrostate") == false) then
		setElementData(localPlayer,"velocimetrostate",true)
		hud.ef_5 = 0
		playSound("arquivos/desativa.mp3")
		end
		
		
			-- Download
		if(dobozbaVan(s[1]/2-260/2,s[2]/2+450/2,100,30,x,y) and getElementData ( localPlayer, "downloadstate") == true) then 
		setElementData(localPlayer,"downloadstate",false)
		playSound("arquivos/ativa.mp3")
		elseif(dobozbaVan(s[1]/2-260/2,s[2]/2+450/2,100,30,x,y) and getElementData ( localPlayer, "downloadstate") == false) then
		setElementData(localPlayer,"downloadstate",true)
		playSound("arquivos/desativa.mp3")
		end	
		
		
		-- Mensagens privadas
		if(dobozbaVan(s[1]/2-260/2,s[2]/2+510/2,100,30,x,y) and getElementData ( localPlayer, "tagstate") == true) then 
		setElementData(localPlayer,"tagstate",false)
		playSound("arquivos/ativa.mp3")
		elseif(dobozbaVan(s[1]/2-260/2,s[2]/2+510/2,100,30,x,y) and getElementData ( localPlayer, "tagstate") == false) then
		setElementData(localPlayer,"tagstate",true)
		playSound("arquivos/desativa.mp3")
		end	
	end	
	end	
end

function DX_Text(szoveg,x,y,w,h)
	return dxDrawText(szoveg,x,y,w,h,tocolor(255, 255, 255, 225),1,Eg_Font,"left","top",true,true,true,true)
end

function DX_Text1(szoveg,x,y,w,h)
	return dxDrawText(szoveg,x,y,w,h,tocolor(255, 255, 255, 225),1,Eg_Font,"center","center",true,true,true,true)
end
function togClipDistance(tog)
	if tog == true then
		setFarClipDistance(4000)
	else
		resetFarClipDistance()
	end
end
----------------------------------------- DX -----------------------------------------------
function dobozbaVan(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end
----------------------------------------- Blur ---------------------------------------------
local elmosasShader
local kepernyoSource = dxCreateScreenSource(s[1], s[2])

function toggleElmosas( )
	if not elmosasShader then
		if getVersion ().sortable < "1.3.1" then
			outputChatBox("Sua versão do MTA não suporta o efeito.")
			return
		else
			elmosasShader, blurTec = dxCreateShader("blur.fx")
			blurErosseg = 8
			if (not elmosasShader) then
				outputChatBox("Não é possível executar o efeito..")
			end
		end
	else
		elmosasShader = nil
	end
end

addEventHandler("onClientPreRender", root,
function()
    if (elmosasShader) then
        dxUpdateScreenSource(kepernyoSource)
        
        dxSetShaderValue(elmosasShader, "ScreenSource", kepernyoSource);
        dxSetShaderValue(elmosasShader, "BlurStrength", blurErosseg);
		dxSetShaderValue(elmosasShader, "UVSize", s[1]+5, s[2]+5);

        dxDrawImage(0, 0, sc[1], sc[2], elmosasShader)
		
		dxDrawRectangle (-5, -5, sc[1]+10, sc[2]+10, tocolor ( 0, 0, 0, 135 ) )
	end
end)