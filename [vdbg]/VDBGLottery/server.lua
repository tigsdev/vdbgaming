local lottery = nil
local winningNum = nil

addEvent ( "VDBGLottery->onClientAttemptToBuyLotteryTicket", true )
addEventHandler ( "VDBGLottery->onClientAttemptToBuyLotteryTicket", root, function ( number ) 
	local a = getPlayerAccount ( source )
	if ( isGuestAccount ( a ) ) then
		return exports.VDBGMessages:sendClientMessage ( "#d9534f[VDBG.ORG] #ffffffPor favor, faça o login para poder usar a loterica.", source, 255, 0, 0 )
	end

	if ( lottery [ getAccountName ( a ) ] ) then
		return exports.VDBGMessages:sendClientMessage ( "#d9534f[VDBG.ORG] #ffffffVocê já comprou um bilhete na loterica \""..tostring(lottery[getAccountName(a)]).."\"", source, 255, 255, 0 )
	end

	for i, v in pairs ( lottery ) do
		if ( v == number ) then
			return exports.VDBGMessages:sendClientMessage ( "#d9534f[VDBG.ORG] #ffffffEste número já foi comprado.", source, 255, 255, 0 )
		end
	end

	if ( getPlayerMoney ( source ) < 100 ) then
		return exports.VDBGMessages:sendClientMessage ( "#d9534f[VDBG.ORG] #ffffffVocê não tem dinheiro suficiente para comprar um bilhete de loteria", 255, 0, 0 )
	end

	takePlayerMoney ( source, 100 )
	exports.VDBGMessages:sendClientMessage ( "#d9534f[VDBG.ORG] #ffffffVocê comprou bilhete de loteria n° #0078BE#"..tostring ( number ).."!", source, 0, 255, 0)
	lottery[getAccountName(a)] = number
end )

function winLottery ( )
	local winAccount = nil
	local winner = nil
	local num = getLotteryWinningNumber ( )
	for i, v in pairs ( lottery ) do
		if ( v == num ) then
			winAccount = i
		end
	end
	if ( winAccount ) then
		for i, v in pairs ( getElementsByType ( "player" ) ) do 
			local a = getPlayerAccount ( v )
			if ( not isGuestAccount ( a ) and getAccountName ( a ) == winAccount ) then
				winner = v
			end
		end
	end
	if ( winAccount and not winner ) then
		winner = winaccount.." #ff0000(offline)"
	elseif ( not winAccount ) then
		winner = nil
	end
	outputChatBox ( " ", root, 255, 255, 255, true )
	outputChatBox ( "#acd373Ganhador: #FFFFFF"..tostring(winer or "Nínguem"), root, 255, 255, 255, true)
	outputChatBox ( "#acd373Número premiado: #FFFFFF: "..tostring ( num ), root, 255, 255, 255, true)
	outputChatBox ( "#0078BEDinheiro: #FFFFFFR$ "..tostring ( prize )..",00", root, 255, 255, 255, true )
	outputChatBox ( "#d9534f========================= / SORTEIOS / =========================", root, 255, 255, 255, true )
	outputChatBox ( " ", root, 255, 255, 255, true )

	if ( winner ~= nil and getElementType ( winner ) == "player" ) then
		exports.VDBGMessages:sendClientMessage("#d9534f[VDBG.ORG] #ffffffVocê ganhou R$"..tostring(prize)..",00 do Sorteios VDBGaming!", winner, 0, 255, 0)
		givePlayerMoney ( winner, prize )
	end

	generateNextLottery ( )
end 

function generateNextLottery ( )
	lottery = { }
	winningNum = math.random ( 1, 80 )
	prize = math.random ( 7000, 10000 )
	if ( isTimer ( lotTImer ) ) then
		killTimer ( lotTImer )
		lotTImer = nil
	end
	lotTImer = setTimer ( winLottery, 1800000, 1)
end 

function getLotteryWinningNumber ( )
	return winningNum
end

function getLotteryTimer ( )
	return lotTImer 
end

generateNextLottery ( )




addEvent ( "VDBGLotter->onClientRequestTimerDetails", true )
addEventHandler ( "VDBGLotter->onClientRequestTimerDetails", root, function ( ) 
	triggerClientEvent ( source, "VDBGLottery->onServerSendClientTimerDetails", source, convertMilSecsToTimer ( getTimerDetails ( getLotteryTimer ( ) ) ))
end )


function convertMilSecsToTimer ( mil )
	local h = 0
	local m = 0
	local s = 0

	while ( mil > 1000 ) do
		s = s + 1
		mil = mil - 1000
	end

	while ( s > 60 ) do
		s = s - 60
		m = m + 1
	end 

	while ( m > 60 ) do
		m = m - 60
		h = h + 1
	end

	return tostring ( h ).."h "..tostring(m).."m "..tostring (s).."s"
end 