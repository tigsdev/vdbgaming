function appFunctions.bank:onPanelLoad ( )
	guiSetText ( pages['bank'].bank_balance, "Seu saldo bancário é R$"..tostring(getElementData(localPlayer,"VDBGBank:BankBalance") or 0) )
	guiGridListClear ( pages['bank'].bank_log )
	
	local r = guiGridListAddRow ( pages['bank'].bank_log )
	guiGridListSetItemText ( pages['bank'].bank_log, r, 1, "Carregando LOG...", true, true )
	triggerServerEvent ( "VDBGPhone:App->Bank:getClientBankLog", localPlayer )
end

addEvent ( "VDBGPhone:App->Bank:sendClientBankLog", true )
addEventHandler ( "VDBGPhone:App->Bank:sendClientBankLog", root, function ( query )
	guiGridListClear ( pages['bank'].bank_log )
	
	if ( #query == 0 ) then
		local r = guiGridListAddRow ( pages['bank'].bank_log )
		guiGridListSetItemText ( pages['bank'].bank_log, r, 1, "Sem transações", true, true )
	else
		for i=#query, 1, -1 do
			local v = query [ i ]
			local r = guiGridListAddRow ( pages['bank'].bank_log )
			local l = "["..v['thetime'].."] "..v['log']
			guiGridListSetItemText ( pages['bank'].bank_log, r, 1, l, false, false )
			guiGridListSetItemText ( pages['bank'].bank_log, r, 2, v['serial'], false, false )
			guiGridListSetItemText ( pages['bank'].bank_log, r, 3, v['ip'], false, false )
		end
	end
end )