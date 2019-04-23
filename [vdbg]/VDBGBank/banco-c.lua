local maximo = 3
local blips = { }
local warps1 = { }
local warps2 = { }
local interiores = {  


	{"Agência Bancária #d9534f#1",
	--[[pos-x,y,z]]595.37, -1250.33, 18.00,
	--[[toPos-x,y,z]]389.84, 173.79, 1008.00, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]3, --[[tDim]]196, --[[BLIP]]52},

	{"Agência Bancária #d9534f#1",
	--[[pos-x,y,z]]2474.67, 1024.08, 10.00,
	--[[toPos-x,y,z]]389.84, 173.79, 1007.00, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]3, --[[tDim]]197, --[[BLIP]]52},

	{"Agência Bancária #d9534f#1",
	--[[pos-x,y,z]]-1704.39, 785.8, 25.00,
	--[[toPos-x,y,z]]389.84, 173.79, 1008.00, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]3, --[[tDim]]198, --[[BLIP]]52},
	
	
	
}

	for i=0, maximo-1 do
	warps1 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = {  interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+2.0 }, toPos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+1.0 }, cInt = interiores[i+1][8], cDim = interiores[i+1][9], tInt = interiores[i+1][10], tDim = interiores[i+1][11] } )
	warps2 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+2.0 }, toPos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+1.0 }, cInt = interiores[i+1][10], cDim = interiores[i+1][11], tInt = interiores[i+1][8], tDim = interiores[i+1][9] } )
	blips = createBlip ( interiores[i+1][2],interiores[i+1][3],interiores[i+1][4], interiores[i+1][12], 2, 255, 255, 255, 255, 0, 250 )
	end

--



local bank = {
    button = {},
    radio = {},
    label = {}
}
local sx, sy = guiGetScreenSize ( )
bank['window'] = guiCreateWindow( ( sx / 2 - 446 / 2 ), ( sy / 2 - 363 / 2 ), 446, 363, "Conta bancária - N/A", false)
bank['amount'] = guiCreateEdit(9, 239, 214, 23, "", false, bank['window'])
bank['progress'] = guiCreateProgressBar(233, 236, 203, 26, false, bank['window'])
bank.label[1] = guiCreateLabel(0, 25, 446, 49, string.rep ( "_", 85 ).."\nInformações do cliente\n"..string.rep ( "_", 85 ), false, bank['window'])
bank.label[2] = guiCreateLabel(10, 84, 213, 20, "Nome da Conta: N/A", false, bank['window'])
bank.label[3] = guiCreateLabel(10, 114, 213, 20, "Saldo em conta: $0", false, bank['window'])
bank.label[4] = guiCreateLabel(0, 159, 446, 49, string.rep ( "_", 85 ).."\nExtrato\n"..string.rep ( "_", 85 ), false, bank['window'])
bank.label[5] = guiCreateLabel(10, 218, 81, 19, "Quantia:", false, bank['window'])
bank.label[6] = guiCreateLabel(0, 3, 203, 18, "Solicitação do processo...", false, bank['progress'])
bank.radio['deposit'] = guiCreateRadioButton(9, 272, 101, 20, "Depositar", false, bank['window'])
bank.radio['withdraw'] = guiCreateRadioButton(110, 272, 113, 20, "Sacar", false, bank['window'])
bank.button['go'] = guiCreateButton(233, 272, 203, 30, "Processar", false, bank['window'])
bank.button['exit'] = guiCreateButton(233, 312, 203, 30, "Sair", false, bank['window'])

guiSetVisible ( bank['window'], false )
guiSetVisible ( bank['progress'], false )
guiWindowSetMovable ( bank['window'], false )
guiWindowSetSizable(bank['window'], false)
guiLabelSetHorizontalAlign(bank.label[1], "center", false)
guiLabelSetHorizontalAlign(bank.label[4], "center", false)
guiLabelSetColor(bank.label[6], 255, 0, 0)
guiLabelSetHorizontalAlign(bank.label[6], "center", false)
guiRadioButtonSetSelected(bank.radio['deposit'], true)

for i, v in pairs ( bank.label ) do 
	guiSetFont ( v, 'default-bold-small' )
end

ClientMarker = nil
balance = nil
account = nil
addEvent ( "VDBGBank:onClientEnterBank", true )
addEventHandler ( "VDBGBank:onClientEnterBank", root, function ( money, account, marker )
	guiSetVisible ( bank['window'], true )
	guiSetText ( bank['window'], "Conta bancária - ".. tostring ( account ) )
	guiSetText ( bank['amount'], "" )
	guiSetText ( bank.label[2], "Nome da conta: "..tostring ( account ) )
	guiSetText ( bank.label[3], "Saldo em Conta: R$"..convertNumber ( money ) )
	guiSetText ( bank.label[6], "Processando - 0%" )
	guiProgressBarSetProgress ( bank['progress'], 0 )
	
	ClientMarker = marker
	balance = money
	account = account
	showCursor ( true )
	addEventHandler ( "onClientMarkerLeave", ClientMarker, CloseWindow_Marker )
	addEventHandler ( "onClientGUIClick", root, bankClicking )
	addEventHandler ( "onClientGUIChanged", root, bankEditing )
end )

function CloseBankWindow ( )
	guiSetText ( bank['window'], "conta bancária - ".. tostring ( account ) )
	guiSetVisible ( bank['window'], false )
	guiSetVisible ( bank['progress'], false )
	guiSetText ( bank['amount'], "" )
	guiSetText ( bank.label[2], "Nome da conta: N/A" )
	guiSetText ( bank.label[3], "Saldo em Conta: R$0" )
	guiSetText ( bank.label[6], "Processando - 0%" )
	guiProgressBarSetProgress ( bank['progress'], 0 )
	removeEventHandler ( "onClientMarkerLeave", ClientMarker, CloseWindow_Marker )
	ClientMarker = nil
	balance = nil
	account = nil
	showCursor ( false )
	removeEventHandler ( "onClientGUIClick", root, bankClicking )
	removeEventHandler ( "onClientGUIChanged", root, bankEditing )
end

function bankClicking ( )
	if ( isPedDead ( localPlayer ) ) then
		CloseBankWindow ( )
	end
	if ( source == bank.button['exit'] ) then
		CloseBankWindow ( )
	elseif ( source == bank.button['go'] ) then
		if ( guiGetText ( bank['amount'] ) ~= "" ) then
			setAllEnabled ( false )
			guiSetVisible ( bank['progress'], true )
			guiProgressBarSetProgress ( bank['progress'], 0 )
			progressTimer = setTimer ( function ( )
				guiProgressBarSetProgress ( bank['progress'], guiProgressBarGetProgress ( bank['progress'] ) + 2 )
				guiSetText ( bank.label[6], "Processando - "..tostring ( guiProgressBarGetProgress ( bank['progress'] ) ).."%" )
				if ( guiProgressBarGetProgress ( bank['progress'] ) >= 100 and guiGetVisible ( bank['window'] ) ) then
					if ( isTimer ( progressTimer ) ) then
						killTimer ( progressTimer )
					end
					setAllEnabled ( true )
					guiSetText ( bank.label[6], "Processo concluído" )
					
					local mode = nil
					if ( guiRadioButtonGetSelected ( bank.radio['deposit'] ) ) then
						mode = 'deposit'
					else
						mode = 'withdraw'
					end
					triggerServerEvent ( "VDBGBank:ModifyAccount", localPlayer, tostring ( mode ), tonumber ( guiGetText ( bank['amount'] ) ) )
					
					setTimer ( function ( )
						if ( not isTimer ( progressTimer ) ) then
							guiProgressBarSetProgress ( bank['progress'], 0 )
							guiSetVisible ( bank['progress'], false )
							guiSetText ( bank.label[6], "Processando - 0%" )
						end
					end, 2500, 1 )
				end
			end, 60+math.random ( -10, 80 ), 100 )
		else
			outputChatBox ( "#d9534f[VDBG.ORG] #ffffffDigite uma quantia", 200, 200, 200 )
		end
	end
end

function bankEditing ( )
	if ( source == bank['amount'] ) then
		guiSetText ( source, guiGetText(source):gsub ( "%p", "" ) )
		guiSetText ( source, guiGetText(source):gsub ( "%s", "" ) )
		guiSetText ( source, guiGetText(source):gsub ( "%a", "" ) )
	end
end

function CloseWindow_Marker ( p )
	if ( p == localPlayer ) then
		CloseBankWindow ( )
	end
end

function setAllEnabled ( s )
	guiSetEnabled ( bank.button['go'], s )
	guiSetEnabled ( bank.button['exit'], s )
	guiSetEnabled ( bank.radio['deposit'], s )
	guiSetEnabled ( bank.radio['withdraw'], s )
	guiSetEnabled ( bank['amount'], s )
end

addEvent ( "VDBGBanks:resfreshBankData", true )
addEventHandler ( "VDBGBanks:resfreshBankData", root, function ( amount ) 
	guiSetText ( bank.label[3], "Saldo em Conta: $"..convertNumber ( amount ) )
end )

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end
