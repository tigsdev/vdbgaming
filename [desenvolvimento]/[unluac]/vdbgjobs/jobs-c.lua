local do3dtextrender = false
setTimer ( function ( )
	do3dtextrender = exports.VDBGLogin:isClientLoggedin ( )
end, 1000, 1 )

addEvent ( "onClientPlayerLogin", true )
addEventHandler ( "onClientPlayerLogin", root, function ( )
	do3dtextrender = true
end )
local openedJob = nil
local s = {guiGetScreenSize()}
local panel = {}
local visibilidade = false	
panel.x, panel.y = (s[1] / 2) - 512, (s[2] /2 ) - 384
local desc = nil
local opensans = dxCreateFont(":VDBGPDU/arquivos/opensans.ttf", 16)
local opensans2 = dxCreateFont(":VDBGPDU/arquivos/opensans.ttf", 13)
local opensans3 = dxCreateFont(":VDBGPDU/arquivos/opensans.ttf", 14.5)


jobDescriptions = { 
	['fisherman'] = "#ffffffComo #4aabd0pescador, #ffffffvocê já deve imaginar o que irá fazer: #4aabd0pescar.\n #ffffffCom um #d9534fbarco você irá percorrer alguns trechos próximos da costa, \n#ffffffe a #d9534fembarcação #ffffffará todo o serviço para você automaticamente \naté o limite de #d9534fcarga pesqueiro. \n#ffffffPara receber o #acd373dinheiro, #ffffffvocê deverá voltar ao #d9534fporto  #ffffffe vender  \n os #d9534fpeixes #ffffffque coletou. \nPara visualizar os #d9534fpeixes coletados #ffffffuse o comando #ffa500/net.",
	['Medico'] = "#ffffffTrabalhando de #4aabd0médico, #ffffffo serviço é simples: você receberá um #d9534fkit médico,\n #ffffffe assim você deverá fazer #d9534fhit-kit #4aabd0( bater com o kit\n médico no jogador). #ffffffDessa maneira, a #d9534fvida #ffffffdos jogadores se \nelevará até a #d9534fsaúde plena. #ffffffCompletando #ffa500100%,\n #ffffffvocê receberá o #acd373pagamento#ffffff.", 
	['Policial'] = "\n\n\n\n#ffffffTrabalhando de #4aabd0policial, #ffffffvocê será capaz de #4aabd0prender #ffffffos\n jogadores que têm #d9534fníveis de procurados. #ffffffPara saber se um #d9534fjogador\n é #d9534fprocurado pela #d9534fpolícia, #ffffffvocê pode procurar por nomes no \n#ffa500F5. #d9534fBandidos #ffffffterão uma #ffa500estrela #fffffflutuando sobre a cabeça.\n Você pode utilizar a #d9534fpistola silenciada #ffffffcomo uma #d9534fteaser, e, \n#ffffffquando você atira, #ffffffquando vai #d9534fimunisar #ffffffo fora da lei; ele irá ser \n#d9534feletrecutado #ffffffpara que você possa batê-lo com o \n#d9534fcassetete, #ffffffe assim #d9534fprendê-lo; #ffffffdepois de bater\n com o #d9534fcassetete, #ffffffleve-o para o \n#ffa500F11 #ffffff= #4aabd0ICONE DE POLICIA NAS DELEGACIAS#ffffff.",
	['Mecanico'] = "#ffffffTrabalhando de #4aabd0mecânico, #ffffffvocê #4aabd0consertara os\n veículos #ffffffdos jogadores. Para #d9534fconsertar um carro, #ffffffvocê só precisa\n pressionar o #ffa500'M' #ffffffem seu teclado,e clicar em cima do #d9534fcarro. \n #ffffffSe o jogador aceitar, você vai concertar o carro\n dele e será #acd373pago #ffffffem seguida.",
	['Caminhoneiro'] = "#ffffffTrabalhando de #4aabd0caminhoneiro, #ffffffvocê irá \n#d9534fentregar cargas #ffffffpelo mapa. Para entregar as #d9534fcargas, \n#ffffffselecione um \nlocal e aparecerá um #d9534ficone #ffffffem seu #d9534fradar #4aabd0( CAMINHÃO ); \n#ffffffleve a #d9534fcarga #ffffffaté o local e,\nchegando lá, você será #acd373pago#ffffff.",
	['Criminoso'] = "#ffffffComo um #d9534fcriminoso, #ffffffvocê pode fazer as #d9534fmissões de #d9534froubos, \n#ffffffPegando #d9534farmas #fffffflivres em #d9534fSan Fierro #ffffffe Turfando\n áreas em #d9534fLas Venturas#ffffff/#d9534fSan Fierro. #ffffffMas tenha cuidado a #d9534fpolícia #ffffffestá \nsempre atrás de você.",
	['detective'] = "\n\n\n#ffffffQuando você é um #4aabd0detetive, #fffffftodos os recursos\n estarão disponíveis, como se fosse um trabalho de um #4aabd0policial #ffffffnormal\n #acd373(painel polícia, rádio chat, prisões)#ffffff, exceto quando você é chamado\n para casos de #d9534fcrime #ffffffquando um companheiro oficial de #4aabd0polícia\n #fffffffé assassinado. Quando você chega na cena do #ffa500crime,\n #fffffffapenas busque ao redor em busca de pistas do #ffa500assassino.\n #fffffffVocê também terá a capacidade \nde gerar veículos mais rápidos.",
	['Piloto'] = "#ffffffQuando você é um #4aabd0piloto, #ffffffvocê vai conduzir uma #4aabd0aeronave\n #ffffffem torno de San Andreas, pegar e entregar os #d9534fpassageiros \n#ffffffde um lugar para outro. Você também será capaz de pegar os outros \n#d9534fjogadores#ffffff.\n Eles serão capazes de definir um ponto de #d9534fpassagem;\n #ffffffquando você  #d9534fentregá-los  #ffffffno lugar você será #ffa500pago",
	['stunter'] = "#ffffffSe você é um #4aabd0stunter,  #ffffffvocê pode ir em torno de #d9534fSan Andreas\n  #fffffffazendo manobras em #d9534fbicicletas #ffffffou\n #d9534fmotocicletas#ffffff. \nPara cada golpe que você faz, você vai ser #ffa500pago#ffffff.",
	['Entregador'] = "#ffffffVá até o spawn de #4aabd0veículo; #ffffffpegue uma #4aabd0van;\n #ffffffvá até o armazem de entrega #d9534f(MARCADOR BRANCO); \n#ffffffpegue os pacotes; faça a entrega \ne assim será #ffa500pago#ffffff.",
	['Motorista'] = "#ffffffComo um motorista de #4aabd0ônibus, #ffffffvocê vai ter suas\n #d9534fparadas #ffffffe o ponto final. Faça todas as \n #d9534fparadas #ffffffe ganhe o #ffa500dinheiro\n #ffffffno ponto final.",
	['PizzaBOY'] = "#ffffffVá até o spawn de #4aabd0veículo; #ffffffpegue a #d9534fmoto\n #ffffffde entrega; vá até o #d9534f'd' #ffffffno mapa; \nsaia da #d9534fmoto#ffffff; vá até o marcador amarelo para #d9534fentregar\n #ffffffa pizza e ser #ffa500pago#ffffff; \nvolte para moto para mais entregas.",
	['Taxista'] = "#ffffffPegue um #4aabd0táxi #ffffffno spawn de veículo;\n Encontre um cliente #d9534f(outro jogador)#ffffff; leve-o ao destino \npreviamente combinado; quando o #d9534fjogador #ffffffsair do\n #d9534fveículo #ffffffvocê será #ffa500pago \n#ffffffpela distância percorrida.",
	['Lixeiro'] = "\n\n\n#ffffffO #4aabd0lixeiro #ffffffganha a vida através da \n#4aabd0coleta de lixo#ffffff. Existem cerca de #d9534f100 #fffffflocais \nna cidade onde você pode parar para pegar #d9534flixo#ffffff. \nVocê pode esvaziar o caminhão de #d9534flixo #ffffffa\n qualquer momento, e assim você poderá r\neceber o seu #ffa500pagamento #ffffffcom base na\n quantidade de #d9534flixo coletado#ffffff.",
}



addEventHandler( "onClientRender", getRootElement(),
	function( )	
		
	 if visibilidade then
		-- <ESTRUTURA>
		dxDrawText("#428bcaVDB#FFFFFF Gaming - JOB@#ffa500"..openedJob, panel.x + 220, panel.y + 154, 605, 456, tocolor(255, 255, 255, 255), 1, opensans, "left", "top", true, true, true, true, true)
		dxDrawRectangle(panel.x + 206, panel.y + 154, 605, 456, tocolor(0, 0, 0, 200), false)
		dxDrawRectangle(panel.x + 203, panel.y + 154, 3, 456, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 203, panel.y + 151, 608, 3, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 811, panel.y + 151, 3, 459, tocolor(0, 0, 0, 255), false)
		dxDrawRectangle(panel.x + 203, panel.y + 610, 611, 3, tocolor(0, 0, 0, 255), false)
        dxDrawLine(panel.x + 210, panel.y + 187, panel.x + 795, panel.y + 188, tocolor(100, 100, 100, 100), 1.5, false)
		-- </ESTRUTURA>
		-- <CONTEUDO>
			dxDrawImage(panel.x + 470, panel.y + 197, 87, 85, "arquivos/formjob.png",0,0,0,tocolor(255,255,255,200),false)
			dxDrawText(desc, s[1]/2-15, panel.y + 490, s[1]/2, 220, tocolor(254, 254, 254, 255), 1.00, opensans3, "center", "center", false, false, false, true, false)
		

		if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 682, panel.y + 557, 108, 33, cursorX, cursorY)) then
				dxDrawRectangle(panel.x + 682, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
				dxDrawText("Fechar", panel.x + 711, panel.y + 563, 108, 33, tocolor(217, 83, 79, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)		
			else
				dxDrawRectangle(panel.x + 682, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
				dxDrawText("Fechar", panel.x + 711, panel.y + 563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		
			end
		end	
		if( not isCursorShowing()) then
		dxDrawRectangle(panel.x + 682, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
		dxDrawText("Fechar", panel.x + panel.y + 711, 563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		
		end
		
		
		
		
		
		if(isCursorShowing()) then
		XY = {guiGetScreenSize()}
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*s[1], cursorY*s[2]
			if(locMouse(panel.x + 226, panel.y + 557, 108, 33, cursorX, cursorY)) then
				dxDrawRectangle(panel.x + 226, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
				dxDrawText("Aceitar", panel.x + 254, panel.y + 563, 108, 33, tocolor(66, 139, 202, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)		
			else
				dxDrawRectangle(panel.x + 226, panel.y + 557, 108, 33, tocolor(0, 0, 0, 96), false)
				dxDrawText("Aceitar", panel.x + 254, panel.y + 563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		
			end
		
		if( not isCursorShowing()) then
		dxDrawRectangle(panel.x + 226, panel.y +557, 108, 33, tocolor(0, 0, 0, 96), false)
		dxDrawText("Aceitar", panel.x + 254, panel.y +563, 108, 33, tocolor(255, 255, 255, 255), 1.00, opensans2, "left", "top", false, false, false, false, false)
		end
		end
		
	end
end
)


local peds = { }
function refreshGodmodePeds ( )
	for i, v in ipairs ( peds ) do
		destroyElement ( v )
	end
	
	for i, v in ipairs ( getElementsByType ( 'GodmodePed' ) ) do 
		local id = getElementData ( v, "Model" )
		local x, y, z, rz = unpack ( getElementData ( v, "Position" ) )
		peds[i] = createPed ( id, x, y, z, rz )
		setElementFrozen ( peds[i], true )
		addEventHandler ( 'onClientPedDamage', peds[i], function ( ) cancelEvent ( ) end )
	end
	
end
refreshGodmodePeds ( )
setTimer ( refreshGodmodePeds, 30000, 0 )


addEvent ( 'VDBGJobs:OpenJobMenu', true )
addEventHandler ( 'VDBGJobs:OpenJobMenu', root, function ( job )
	openedJob = job
	visibilidade = true
	showCursor ( true )
	desc = jobDescriptions [ openedJob ]
	
end )

addEventHandler ( 'onClientPlayerWasted', root, function ( )
	if ( source == localPlayer ) then
		visibilidade = false
		showCursor(false)
		toggleControl("all",false)
		desc = nil
		openedJob = nil
	end
end )



addEvent ( "onPlayerResign", true )





function locMouse(dX, dY, dSZ, dM, eX, eY)
	if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
		return true
	else
		return false
	end
end


function MenuButton(botao,status,x,y)
	if botao == "left" and status == "down" then
	
	if visibilidade then 
	
		
		if(locMouse(panel.x + 682, panel.y + 557, 108, 33,x,y)) then
			visibilidade = false
			showCursor(false)
			toggleControl("all",false)
			desc = nil
			openedJob = nil
		elseif(locMouse(panel.x + 226, panel.y + 557, 108, 33,x,y)) then		
			triggerServerEvent ( "VDBGJobs:SetPlayerJob", localPlayer, openedJob )
			desc = nil
			openedJob = nil
			showCursor ( false )
			visibilidade = false
		end	
		
		end	
	end	
end	
addEventHandler("onClientClick",getRootElement(),MenuButton)


function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY)
  bx, by, color, scale, font = bx or ax, by or ay, color or tocolor(255,255,255,255), scale or 1, font or "default"
  if alignX then
    if alignX == "center" then
      ax = ax + (bx - ax - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font))/2
    elseif alignX == "right" then
      ax = bx - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
    end
  end
  if alignY then
    if alignY == "center" then
      ay = ay + (by - ay - dxGetFontHeight(scale, font))/2
    elseif alignY == "bottom" then
      ay = by - dxGetFontHeight(scale, font)
    end
  end
   local clip = false
   if dxGetTextWidth(str:gsub("#%x%x%x%x%x%x","")) > bx then clip = true end
  local alpha = string.format("%08X", color):sub(1,2)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  local text = ""
  local broke = false
  while s do
    if cap == "" and col then color = tocolor(getColorFromString("#"..col..alpha)) end
    if s ~= 1 or cap ~= "" then
      local w = dxGetTextWidth(cap, scale, font)
           if clip then
                local text_ = ""
                 for i = 1,string.len(cap) do
                  if dxGetTextWidth(text,scale,font) < bx then
                  text = text..""..string.sub(cap,i,i)
                  text_ = text_..""..string.sub(cap,i,i)
                  else
                  broke = true
                   break
                  end
                 end
                 cap = text_
                end
      dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
      ax = ax + w
      color = tocolor(getColorFromString("#"..col..alpha))
    end
    last = e + 1
    s, e, cap, col = str:find(pat, last)
  end
  if last <= #str and not broke then
    cap = str:sub(last)
                   if clip then
                local text_ = ""
                 for i = 1,string.len(cap) do
                  if dxGetTextWidth(text,scale,font) < bx then
                  text = text..""..string.sub(cap,i,i)
                  text_ = text_..""..string.sub(cap,i,i)
                  else
                  broke = true
                   break
                  end
                 end
                 cap = text_
                end
    dxDrawText(cap, ax, ay, ax + dxGetTextWidth(cap, scale, font), by, color, scale, font)
  end
end