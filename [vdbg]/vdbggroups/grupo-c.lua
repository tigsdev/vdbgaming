------------------------------
-- Gui Elements				--
------------------------------
sx_, sy_ = guiGetScreenSize ( )
sx, sy = sx_ / 1280, sy_ / 720
local group = nil 
local gList = nil

function createGroupGui ( )
	--outputChatBox ( "#FFA500[G.E] #ffffffCarregando interface do clã", 255, 255, 0 );

	gui = { 
		main ={ }, 
		info = { create = { }, invites = { }, motd = { } }, 
		list = { }, 
		my = { 
			basic = { },
			logs_ = { },
			bank_ = { },
			members_ = { },
			ranks_ = { },
			motd = { }
		} 
	}

	-- main
	local sx__, sy__ = sx, sy
	local sx, sy = 1, 1
	gui.main.window = guiCreateWindow((sx_/2-(sx*660)/2), (sy_/2-(sy*437)/2), sx*660, sy*437, "CLÃ", false)
	gui.main.info = guiCreateButton(sx*10, sy*26, sx*128, sy*40, "Informações", false, gui.main.window)
	gui.main.list = guiCreateButton(sx*148, sy*26, sx*128, sy*40, "Lista de clãs", false, gui.main.window)
	gui.main.my = guiCreateButton(sx*286, sy*26, sx*128, sy*40, "Meu clã", false, gui.main.window)
	gui.main.line = guiCreateLabel(0, 74, sx*660, 24, string.rep ( "_", 200 ), false, gui.main.window)  
	guiWindowSetSizable(gui.main.window, false)

	-- information
	gui.info.account = guiCreateLabel(sx*42, sy*136, sx*269, sy*20, "Conta: N/A", false, gui.main.window)
	gui.info.group = guiCreateLabel(sx*42, sy*156, sx*269, sy*20, "Nome do clã: N/A", false, gui.main.window)
	gui.info.rank = guiCreateLabel(sx*42, sy*176, sx*269, sy*20, "Sua patente no clã: N/A", false, gui.main.window)
	gui.info.create_ = guiCreateButton ( sx*42, sy*280, sx*130, sy*40, "Criar um clã", false, gui.main.window )

	
	gui.info.mInvites = guiCreateButton ( 180, 280, 130, 40, "Meus convites", false, gui.main.window )
	gui.info.gMotd = guiCreateButton ( 318, 280, 130, 40, "Anúncio do clã", false, gui.main.window )  
		-- info -> create

		gui.info.create.window = guiCreateWindow(sx*383, sy*227, sx*500, sy*400, "Criar um clã por R$ 200.000,00", false)
		guiWindowSetSizable(gui.info.create.window, false)
		gui.info.create.l1 = guiCreateLabel(sx*22, sy*40, sx*184, sy*20, "NOME / TAG:", false, gui.info.create.window)
		gui.info.create.name = guiCreateEdit(sx*207, sy*40, sx*109, sy*20, "VDBGAMING", false, gui.info.create.window)
		gui.info.create.tag = guiCreateEdit(sx*325, sy*40, sx*109, sy*20, "VDBG", false, gui.info.create.window)
		guiEditSetMaxLength ( gui.info.create.name, 12 )
		guiEditSetMaxLength ( gui.info.create.tag, 4 )
		gui.info.create.l2 = guiCreateLabel(sx*22, sy*78, sx*184, sy*20, "Cor do clã:", false, gui.info.create.window)
		gui.info.create.cr = guiCreateEdit(sx*207, sy*78, sx*54, sy*20, "0", false, gui.info.create.window)
		gui.info.create.cg = guiCreateEdit(sx*261, sy*78, sx*54, sy*20, "0", false, gui.info.create.window)
		gui.info.create.cb = guiCreateEdit(sx*315, sy*78, sx*54, sy*20, "0", false, gui.info.create.window)
		gui.info.create.cpick = guiCreateButton(sx*370, sy*78, sx*56, sy*20, "Cores", false, gui.info.create.window)
		gui.info.create.l3 = guiCreateLabel(sx*23, sy*122, sx*184, sy*20, "Tipos de clã:", false, gui.info.create.window)
		gui.info.create.l4 = guiCreateLabel(sx*23, sy*160, sx*184, sy*20, "Logo de clã:", false, gui.info.create.window)
		
		gui.info.create.picselect = guiCreateComboBox(sx*23, sy*189, sx*150, sy*170, "", false, gui.info.create.window)
		
		guiComboBoxAddItem(gui.info.create.picselect, "annony_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "band_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "danger_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "fire_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "forca_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "fox_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "gat_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "grove_steet_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "ilumi_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "le_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "leao_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "los_aztecas")
		guiComboBoxAddItem(gui.info.create.picselect, "monkey_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "monster_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "past_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "pcc_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "shark_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "skull_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "smoke_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "soldier_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "taliban_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "terrorist_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "tig_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "tigre_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "wolve_logo")
		guiComboBoxAddItem(gui.info.create.picselect, "yakuza_logo")
		-- info -> my invites		
		
		gui.info.create.type = guiCreateComboBox(sx*204, sy*122, sx*216, sy*93, "", false, gui.info.create.window)
		gui.info.create.create = guiCreateButton(sx*113, sy*350, sx*87, sy*27, "Criar", false, gui.info.create.window)
		gui.info.create.close = guiCreateButton(sx*23, sy*350, sx*87, sy*27, "Fechar", false, gui.info.create.window)
		guiEditSetReadOnly(gui.info.create.cb, true)
		guiEditSetReadOnly(gui.info.create.cr, true)
		guiEditSetReadOnly(gui.info.create.cg, true)
		guiComboBoxAddItem(gui.info.create.type, "Clan")
		guiComboBoxAddItem(gui.info.create.type, "Gang")
		-- info -> my invites
		gui.info.invites.window = guiCreateWindow(345, 146, 640, 378, "Convites", false)
		guiWindowSetSizable(gui.info.invites.window, false)
		gui.info.invites.label = guiCreateLabel(38, 33, 504, 21, "Minhas solicitações de clã", false, gui.info.invites.window)
		gui.info.invites.list = guiCreateGridList(21, 54, 599, 267, false, gui.info.invites.window)
		guiGridListAddColumn(gui.info.invites.list, "Clã", 0.3)
		guiGridListAddColumn(gui.info.invites.list, "Hora", 0.3)
		guiGridListAddColumn(gui.info.invites.list, "De", 0.3)
		guiGridListSetSortingEnabled ( gui.info.invites.list, false )
		gui.info.invites.accept = guiCreateButton(21, 331, 117, 31, "Aceitar", false, gui.info.invites.window)
		gui.info.invites.deny = guiCreateButton(140, 331, 117, 31, "Recusar", false, gui.info.invites.window)
		gui.info.invites.close = guiCreateButton(503, 331, 117, 31, "Fechar", false, gui.info.invites.window )
		-- info -> motd
		gui.info.motd.window = guiCreateWindow(392, 169, 528, 410, "Anúncio", false)
		guiWindowSetSizable(gui.info.motd.window, false)
		gui.info.motd.motd = guiCreateMemo(9, 26, 509, 340, "", false, gui.info.motd.window)
		gui.info.motd.cancel = guiCreateButton(374, 370, 144, 30, "Fechar", false, gui.info.motd.window)

	-- list
	gui.list.list = guiCreateGridList(sx*10, sy*108, sx*640, sy*319, false, gui.main.window)
	guiGridListAddColumn(gui.list.list, "Clã", 0.32)
	guiGridListAddColumn(gui.list.list, "Fundador", 0.32)
	guiGridListAddColumn(gui.list.list, "Tipo do clã", 0.15)
	guiGridListAddColumn(gui.list.list, "Membros", 0.1)
	guiGridListSetSortingEnabled ( gui.list.list, false )

	-- my
	gui.my.info = guiCreateButton(10, 120, 128, 40, "Informações Básicas", false, gui.main.window)
	gui.my.members = guiCreateButton(147, 122, 128, 40, "Membros", false, gui.main.window)
	gui.my.ranks = guiCreateButton(285, 122, 128, 40, "Patente", false, gui.main.window)
	gui.my.bank = guiCreateButton(424, 122, 128, 40, "Banco", false, gui.main.window)
	gui.my.logs = guiCreateButton(10, 170, 128, 40, "Ações/Log", false, gui.main.window)   
	gui.my.modColor = guiCreateButton(147, 170, 128, 40, "Alterar cor", false, gui.main.window) 
	gui.my.modMotd = guiCreateButton(285, 170, 128, 40, "Anúncio", false, gui.main.window)  
	gui.my.leave = guiCreateButton(10, 270, 128, 40, "Sair do clã", false, gui.main.window) 
	gui.my.delete = guiCreateButton(147, 270, 128, 40, "Deletar clã", false, gui.main.window) 
		-- my -> Basic information
		gui.my.basic.window = guiCreateWindow(509, 233, 317, 160, "Informações do clã", false)
		guiWindowSetSizable(gui.my.basic.window, false)
		gui.my.basic.group = guiCreateLabel(15, 31, 241, 19, "Clã: N/A", false, gui.my.basic.window)
		gui.my.basic.founder = guiCreateLabel(15, 51, 241, 19, "Fundador: N/A", false, gui.my.basic.window)
		gui.my.basic.founded = guiCreateLabel(15, 71, 241, 19, "Fundado em: N/A", false, gui.my.basic.window)
		gui.my.basic.close = guiCreateButton(15, 100, 91, 32, "Fechar", false, gui.my.basic.window)
		-- my -> Logs
		gui.my.logs_.window = guiCreateWindow(341, 142, 634, 392, "Ações/Log do CLÃ", false)
		guiWindowSetSizable(gui.my.logs_.window, false)
		gui.my.logs_.list = guiCreateGridList(9, 25, 615, 311, false, gui.my.logs_.window)
		guiGridListAddColumn(gui.my.logs_.list, "Hora", 0.28)
		guiGridListAddColumn(gui.my.logs_.list, "Conta", 0.2)
		guiGridListAddColumn(gui.my.logs_.list, "Log", 0.7)
		guiGridListSetSortingEnabled ( gui.my.logs_.list, false )
		gui.my.logs_.close = guiCreateButton(488, 346, 136, 33, "Fechar", false, gui.my.logs_.window)
		gui.my.logs_.clear = guiCreateButton(342, 346, 136, 33, "Limpar", false, gui.my.logs_.window)
		-- my -> Bank
		gui.my.bank_.window = guiCreateWindow(481, 270, 306, 141, "Banco do Grupo", false)
		guiWindowSetSizable(gui.my.bank_.window, false)
		gui.my.bank_.balance = guiCreateLabel(14, 26, 372, 24, "Dinheiro: R$0", false, gui.my.bank_.window)
		gui.my.bank_.amount = guiCreateEdit(14, 55, 120, 23, "0", false, gui.my.bank_.window)
		gui.my.bank_.dep = guiCreateRadioButton(144, 40, 75, 23, "Depositar", false, gui.my.bank_.window)
		guiRadioButtonSetSelected(gui.my.bank_.dep, true)
		gui.my.bank_.go = guiCreateButton(16, 88, 120, 28, "Proceder", false, gui.my.bank_.window)
		gui.my.bank_.close = guiCreateButton(140, 88, 120, 28, "Fechar", false, gui.my.bank_.window)
		gui.my.bank_.with = guiCreateRadioButton(144, 63, 75, 23, "Sacar", false, gui.my.bank_.window)
		-- my -> Ranks
		gui.my.ranks_.window = guiCreateWindow(551, 195, 378, 387, "Gerenciar Patente", false)
		guiWindowSetSizable(gui.my.ranks_.window, false)
		gui.my.ranks_.lbl_1 = guiCreateLabel(21, 30, 220, 22, "Nome da patente:", false, gui.my.ranks_.window)
		gui.my.ranks_.name = guiCreateEdit(21, 55, 282, 25, "", false, gui.my.ranks_.window)
		gui.my.ranks_.name.setMaxLength = 35
		gui.my.ranks_.scroll = guiCreateScrollPane(28, 93, 313, 238, false, gui.my.ranks_.window)
		gui.my.ranks_.lbl_2 = guiCreateLabel(8, 9, 248, 17, "Membros", false, gui.my.ranks_.scroll)
		guiSetFont(gui.my.ranks_.lbl_2, "default-bold-small")
		gui.my.ranks_['perm_member_invite'] = guiCreateCheckBox(17, 28, 273, 15, "Convidar Membros", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_['perm_member_kick'] = guiCreateCheckBox(17, 43, 273, 15, "Kikar Membro", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_['perm_member_setrank'] = guiCreateCheckBox(17, 58, 273, 15, "Alterar patentes", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_['perm_member_viewlog'] = guiCreateCheckBox(17, 73, 273, 15, "Ações do Membros", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_.lbl_3 = guiCreateLabel(10, 88, 248, 17, "Banco do CLÃ", false, gui.my.ranks_.scroll)
		guiSetFont(gui.my.ranks_.lbl_3, "default-bold-small")
		gui.my.ranks_['perm_bank_withdraw'] = guiCreateCheckBox(17, 105, 273, 15, "Sacar", false, false, gui.my.ranks_.scroll )
		gui.my.ranks_['perm_bank_deposit'] = guiCreateCheckBox(17, 120, 273, 15, "Depositar", true, false, gui.my.ranks_.scroll)
		gui.my.ranks_.lbl_4 = guiCreateLabel(10, 135, 248, 17, "Ações/Log", false, gui.my.ranks_.scroll )
		guiSetFont(gui.my.ranks_.lbl_4, "default-bold-small")
		gui.my.ranks_['perm_logs_view'] = guiCreateCheckBox(17, 152, 273, 15, "Ver ações", true, false, gui.my.ranks_.scroll)
		gui.my.ranks_['perm_logs_clear'] = guiCreateCheckBox(17, 167, 273, 15, "Limpar ações", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_.lbl_5 = guiCreateLabel(10, 182, 248, 17, "Patentes do Clã", false, gui.my.ranks_.scroll)
		guiSetFont(gui.my.ranks_.lbl_5, "default-bold-small")
		gui.my.ranks_['perm_ranks_create'] = guiCreateCheckBox(17, 199, 273, 15, "Criar Patente", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_['perm_ranks_delete'] = guiCreateCheckBox(17, 214, 273, 15, "Deletar Patente", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_.lbl_6 = guiCreateLabel(10, 229, 248, 17, "Configurações do clã", false, gui.my.ranks_.scroll)
		guiSetFont(gui.my.ranks_.lbl_6, "default-bold-small")
		gui.my.ranks_['perm_group_modify_color'] = guiCreateCheckBox(20, 246, 273, 15, "Modificar Anúncio", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_['perm_group_modify_motd'] = guiCreateCheckBox(20, 261, 273, 15, "Modificar Cor", false, false, gui.my.ranks_.scroll)
		gui.my.ranks_.add = guiCreateButton(241, 341, 99, 28, "Adicionar Patente", false, gui.my.ranks_.window)
		gui.my.ranks_.close = guiCreateButton(132, 341, 99, 28, "Cancelar", false, gui.my.ranks_.window)
		-- my -> Membros
		gui.my.members_.window = guiCreateWindow(345, 146, 640, 378, "Membros do meu clã", false)
		guiWindowSetSizable(gui.my.members_.window, false)
		gui.my.members_.label = guiCreateLabel(38, 33, 504, 21, "Membros do meu clã", false, gui.my.members_.window)
		gui.my.members_.list = guiCreateGridList(21, 54, 599, 267, false, gui.my.members_.window)
		guiGridListAddColumn(gui.my.members_.list, "Usuário", 0.3)
		guiGridListAddColumn(gui.my.members_.list, "Patente", 0.3)
		guiGridListAddColumn(gui.my.members_.list, "Status", 0.3)
		guiGridListSetSortingEnabled ( gui.my.members_.list, false )
		gui.my.members_.log = guiCreateButton(21, 331, 117, 31, "Ações dele", false, gui.my.members_.window)
		gui.my.members_.srank = guiCreateButton(140, 331, 117, 31, "Definir Patente", false, gui.my.members_.window)
		gui.my.members_.kick = guiCreateButton(259, 331, 117, 31, "Kickar", false, gui.my.members_.window)
		gui.my.members_.invite = guiCreateButton(378, 331, 117, 31, "Convidar", false, gui.my.members_.window)
		gui.my.members_.close = guiCreateButton(503, 331, 117, 31, "Fechar", false, gui.my.members_.window )
			--> my -> Membros -> Player Log
			gui.my.members_.lWindow = guiCreateWindow(341, 142, 634, 392, "Ação", false)
			guiWindowSetSizable(gui.my.members_.window, false)
			gui.my.members_.lList = guiCreateGridList(9, 25, 615, 311, false, gui.my.members_.lWindow)
			guiGridListAddColumn(gui.my.members_.lList, "Hora", 0.28)
			guiGridListAddColumn(gui.my.members_.lList, "Conta", 0.2)
			guiGridListAddColumn(gui.my.members_.lList, "Log", 0.7)
			guiGridListSetSortingEnabled ( gui.my.members_.lList, false )
			gui.my.members_.lClose = guiCreateButton(488, 346, 136, 33, "Fechar", false, gui.my.members_.lWindow)
			-- my -> Membros -> Set rank
			gui.my.members_.rWindow = guiCreateWindow(502, 128, 266, 414, "Definir Patente", false)
			guiWindowSetSizable(gui.my.members_.rWindow, false)
			gui.my.members_.rRanks = guiCreateComboBox(14, 66, 236, 304, "", false, gui.my.members_.rWindow)
			gui.my.members_.rUpdate = guiCreateButton(18, 35, 113, 25, "Definir", false, gui.my.members_.rWindow)
			gui.my.members_.rClose = guiCreateButton(137, 35, 113, 25, "Cancelar", false, gui.my.members_.rWindow)
			-- my -> Membros -> Invite
			gui.my.members_.iWindow = guiCreateWindow(339, 162, 611, 296, "Convidar Jogador", false)
			guiWindowSetSizable(gui.my.members_.iWindow, false)
			gui.my.members_.iList = guiCreateGridList(9, 22, 592, 223, false, gui.my.members_.iWindow)
			guiGridListAddColumn(gui.my.members_.iList, "Player", 0.9)
			gui.my.members_.iLabel = guiCreateLabel(16, 254, 102, 27, "Procurar Jogador:", false, gui.my.members_.iWindow)
			guiLabelSetVerticalAlign(gui.my.members_.iLabel, "center")
			gui.my.members_.iFilter = guiCreateEdit(118, 253, 184, 28, "", false, gui.my.members_.iWindow)
			gui.my.members_.iClose = guiCreateButton(531, 255, 70, 25, "Fechar", false, gui.my.members_.iWindow)
			gui.my.members_.iInvite = guiCreateButton(451, 256, 70, 25, "Convidar", false, gui.my.members_.iWindow)
		-- my -> change motd
		gui.my.motd.window = guiCreateWindow(392, 169, 528, 410, "", false)
		guiWindowSetSizable(gui.my.motd.window, false)
		gui.my.motd.motd = guiCreateMemo(9, 26, 509, 340, "", false, gui.my.motd.window)
		gui.my.motd.update = guiCreateButton(374, 370, 144, 30, "Atualizar", false, gui.my.motd.window)
		gui.my.motd.cancel = guiCreateButton(220, 370, 144, 30, "Cancelar", false, gui.my.motd.window)


	local sx, sy = sx__, sy__
	local doElements = { }
	for i, v in pairs ( gui ) do 
		if ( type ( v ) ~= "table" ) then
			table.insert ( doElements, v )
		else 
			for i, v in pairs ( v ) do 
				if ( type ( v ) ~= "table" ) then
					table.insert ( doElements, v )
				else
					for i, v in pairs ( v ) do
						if ( type ( v ) ~= "table" ) then
							table.insert ( doElements, v )
						end
					end
				end
			end
		end
	end

	-- Window Visiblilities
	guiSetVisible ( gui.my.basic.window , false )
	guiSetVisible ( gui.my.logs_.window, false )
	guiSetVisible ( gui.info.create.window, false )
	guiSetVisible ( gui.my.bank_.window, false )
	guiSetVisible ( gui.my.members_.window, false )
	gui.my.members_.lWindow.visible = false
	gui.my.members_.rWindow.visible = false
	gui.my.members_.iWindow.visible = false
	gui.info.invites.window.visible = false
	gui.my.ranks_.window.visible = false
	gui.my.motd.window.visible = false
	gui.info.motd.window.visible = false

	-- repos and resize
	for i, v in pairs ( doElements ) do 
		local t = getElementType ( v )
		local x, y = guiGetPosition ( v, false )
		local w, h = guiGetSize ( v, false )
		--guiSetSize ( v, sx*w, sx*h, false )
		local w, h = guiGetSize ( v, false )
		if ( t == "gui-window" ) then 
			x, y = ( sx_/2-w/2 ), ( sy_/2-h/2 )
		end
		guiSetPosition ( v, x, y, false )
		x, y, w, h, t = nil, nil, nil, nil, nil
	end

	showCursor ( true )
	doElements = nil
	triggerServerEvent ( "VDBGGroups->Events:onClientRequestGroupList", localPlayer )
	guiSetInputMode ( "no_binds_when_editing" )
end

function isset ( f ) 
	if ( f ) then
		return true
	end
	return false
end 

function loadGroupPage ( p, AllowElementsToStay )
	if ( not AllowElementsToStay ) then
		if ( not gui ) then 
			return --outputChatBox ( "#FFA500[G.E] #ffffffEspere o servidor processar a lista de clãs...", 255, 255, 0 );
		end 
	
		for i, t in pairs ( gui ) do 
			for _, v in pairs ( t ) do 
				if ( type ( v ) ~= "table" ) then
					if ( i ~= "main" and isElement ( v ) ) then 
						guiSetVisible ( v, false )
					end
				end
			end
		end
	end

	-- core features
	if ( p == "core.info" ) then 
		for i, v in pairs ( gui.info ) do 
			if ( v and isElement ( v ) ) then
				guiSetVisible ( v, true )
			end
		end

		local acc = tostring ( getElementData ( localPlayer, "AccountData:Username" ) or "nenhum" )
		guiSetText ( gui.info.account, "Conta: "..acc )
		guiSetText ( gui.info.group, "Nome do clã: "..tostring ( group or "N/A" ) )
		guiSetText ( gui.info.rank, "Sua patente: "..tostring ( rank or "N/A" ) )
	
		
		local group = tostring ( group )
		if ( group and gList and gList [ group ] ) then
		else
			if ( group and group:lower() ~= "nenhum" ) then
				setElementData ( localPlayer, "Group", "Nenhum" )
				setElementData ( localPlayer, "Group Rank", "Nenhum")
				group = nil
				rank = nil
			end 
		end

		-- Button locked permissions
		guiSetEnabled ( gui.main.my, isset ( group ) )
		gui.info.gMotd.enabled = isset ( group )
		guiSetEnabled ( gui.info.create_, not isset ( group ) )
		if ( group and group:lower() ~= "nenhum" ) then
			guiSetEnabled ( gui.my.members_.kick, gList[group].ranks[rank].member_kick or false )
			guiSetEnabled ( gui.my.members_.srank, gList[group].ranks[rank].member_setrank or false )
			guiSetEnabled ( gui.my.members_.log, gList[group].ranks[rank].member_viewlog or false )
			gui.my.members_.invite.enabled = gList[group].ranks[rank].member_invite or false
			gui.my.delete.enabled = ( rank == "Fundador" )
			gui.my.leave.enabled = ( rank ~= "Fundador" )
			gui.my.logs.enabled = gList[group].ranks[rank].logs_view or false
			gui.my.logs_.clear.enabled = gList[group].ranks[rank].logs_clear or false
			gui.my.modColor.enabled = gList[group].ranks[rank].group_modify_color or false
			gui.my.modMotd.enabled = gList[group].ranks[rank].group_modify_motd or false
		end
	elseif ( p == "core.list" ) then 
		guiGridListClear ( gui.list.list )
		guiSetVisible ( gui.list.list, true )
		local total = 0
		for name, v in pairs ( gList ) do
			if ( table.len ( v.members ) ~= 0 ) then
				local r, g, b = v.info.color.r, v.info.color.g, v.info.color.b
				local ro = guiGridListAddRow ( gui.list.list )
				guiGridListSetItemText ( gui.list.list, ro, 1, tostring ( name ), false, false )
				guiGridListSetItemText ( gui.list.list, ro, 2, tostring ( v.info.founder ), false, false )
				guiGridListSetItemText ( gui.list.list, ro, 3, tostring ( v.info.type ), false, false )
				guiGridListSetItemText ( gui.list.list, ro, 4, tostring ( table.len ( v.members ) ), false, false  )
				for i=1, 4 do
					guiGridListSetItemColor ( gui.list.list, ro, i, r, g, b )
				end 
				r, g, b, ro = nil, nil, nil, nil
				total = 1
			else
				triggerServerEvent ( "VDBGGroups->Modules->Gangs->Force->DeleteGroup", resourceRoot, tostring ( name ) )
			end 
		end 

		if ( total == 0 ) then
			guiGridListSetItemText ( gui.list.list, guiGridListAddRow ( gui.list.list ), 1, "Atualmente não existe grupos.", true, true )
		end 
	elseif ( p == "core.my" ) then 
		for i, v in pairs ( gui.my ) do
			if ( type ( v ) ~= "table"  and isElement ( v ) ) then
				guiSetVisible ( v, true ) 
			end
		end
	elseif ( p == "core.myInvites" ) then
		gui.info.invites.window.visible = true
		guiBringToFront(  gui.info.invites.window )
		guiGridListClear ( gui.info.invites.list )
		
		for i, v in pairs ( gList ) do 
			if ( #v.pendingInvites > 0 ) then
				for index, info in pairs ( v.pendingInvites ) do 
					if ( info.to == getElementData ( localPlayer, "AccountData:Username" ) ) then
						local r = guiGridListAddRow ( gui.info.invites.list )
						guiGridListSetItemText ( gui.info.invites.list, r, 1, tostring ( i ), false, false )
						guiGridListSetItemText ( gui.info.invites.list, r, 2, tostring ( info.time ), false, false )
						guiGridListSetItemText ( gui.info.invites.list, r, 3, tostring ( info.inviter ), false, false )
					end
				end
			end 
		end 
		

	elseif ( p == "my.basicInfo" ) then
		guiSetVisible ( gui.my.basic.window, true )
		guiBringToFront ( gui.my.basic.window )
		guiSetText ( gui.my.basic.group, "Clã: ".. tostring ( group or "nenhum" ) )
		if ( gList and group and gList[group] ) then
			guiSetText ( gui.my.basic.founder, "Fundador: "..tostring ( gList[group].info.founder or "nenhum" ) )
			guiSetText ( gui.my.basic.founded, "Fundado em: "..tostring ( gList[group].info.founded_time or "desconhecido" ))
		else
			guiSetText ( gui.my.basic.founder, "Fundador: N/A" )
			guiSetText ( gui.my.basic.founded, "Fundado em: N/A")
		end
	elseif ( p == "my.logs" ) then
		guiSetVisible ( gui.my.logs_.window, true )
		guiBringToFront ( gui.my.logs_.window )
		guiGridListClear ( gui.my.logs_.list )

		for i, v in ipairs ( gList[group].log ) do 
			local r = guiGridListAddRow ( gui.my.logs_.list )
			guiGridListSetItemText ( gui.my.logs_.list, r, 1, tostring ( v.time ), false, false  )
			guiGridListSetItemText ( gui.my.logs_.list, r, 2, tostring ( v.account ), false, false )
			guiGridListSetItemText ( gui.my.logs_.list, r, 3, tostring ( v.log ), false, false )
		end 
	elseif ( p == "my.bank" ) then
		guiSetVisible ( gui.my.bank_.window, true )
		guiSetEnabled ( gui.my.bank_.amount, false )
		guiSetEnabled ( gui.my.bank_.go, false )
		guiSetEnabled ( gui.my.bank_.with, false )
		guiSetEnabled ( gui.my.bank_.dep, false )
		guiSetText ( gui.my.bank_.balance, "Carregando saldo do banco..." )
		triggerServerEvent ( "VDBGGroups:Module->Bank:returnBankBalanceToClient", localPlayer, group )
		guiBringToFront ( gui.my.bank_.window )
	elseif ( p == "core.create" ) then
		guiSetVisible ( gui.info.create.window, true )
		guiBringToFront ( gui.info.create.window )
	elseif ( p == "my.members" ) then
		gui.my.members_.window.visible = true
		gui.my.members_.list.clear ( gui.my.members_.list )
		for i, v in pairs ( gList [ group ].members ) do 
			local r = guiGridListAddRow ( gui.my.members_.list )
			gui.my.members_.list.setItemText ( gui.my.members_.list, r, 1, tostring ( i ), false, false )
			gui.my.members_.list.setItemText ( gui.my.members_.list, r, 2, tostring ( v.rank ), false, false )
			local online = "Offline"
			for _, k in pairs ( getElementsByType ( "player" ) ) do 
				local acc = getElementData ( k, "AccountData:Username" )
				if ( acc and acc == i ) then
					online = "Online"
					break
				end
			end 
			gui.my.members_.list.setItemText ( gui.my.members_.list, r, 3, tostring ( online ), false, false )
			for k=1, 3 do 
				local r, g, b = 0, 255, 0
				if ( online == "Offline" ) then
					r, g, b = 255, 0, 0
				end
				guiGridListSetItemColor ( gui.my.members_.list, r, k, r, g, b )
			end 
		end 
	end
end

function onClientGuiClick ( )
	-- core buttons
	if ( source == gui.main.info ) then 
		loadGroupPage ( "core.info" )
	elseif ( source == gui.main.list ) then 
		loadGroupPage ( "core.list" )
	elseif ( source == gui.main.my ) then
		loadGroupPage ( "core.my" ) 

	-- my buttons
	elseif ( source == gui.my.info ) then 
		loadGroupPage ( "my.basicInfo", true )
	elseif ( source == gui.my.basic.close ) then
		guiSetVisible ( gui.my.basic.window, false )

	elseif ( source == gui.my.logs ) then
		loadGroupPage ( "my.logs", true )
	elseif ( source == gui.my.logs_.close ) then
		guiSetVisible ( gui.my.logs_.window, false )
	elseif ( source == gui.my.logs_.clear ) then
		askConfirm ( "Tem certeza que deseja limpar os registros do clã?", function ( v )
			if ( not v ) then return end
			triggerServerEvent ( "VDBGGroups->GEvents:onPlayerClearGroupLog", localPlayer, group )
			gui.my.logs_.window.visible = false
		end )

	-- Create window
		guiSetEnabled ( gui.info.create_, false )
		
	
	elseif ( source == gui.info.create_ ) then
	if (getPlayerMoney ( ) > 200000) then
	loadGroupPage ( "core.create", true )
	end
	if ( getPlayerMoney ( ) < 200000 ) then
		outputChatBox ( "#FFA500[G.E] #ffffffVocê não tem #acd373 R$ 200.000 #ffffffpara criar um clã", 255, 255, 255, true )
	end
	elseif ( source == gui.info.create.close ) then
		guiSetVisible ( gui.info.create.window, false )
	elseif ( source == gui.info.create.cpick ) then
		exports.cpicker:openPicker ( "GroupColorPicker", { 
			r=tonumber(guiGetText(gui.info.create.cr)),
			g=tonumber(guiGetText(gui.info.create.cg)),
			b=tonumber(guiGetText(gui.info.create.cb)),
			a=255
		}, "Selecione a cor do seu clã" )
		
	elseif ( source == gui.info.create.picselect ) then
		local item = guiComboBoxGetSelected(gui.info.create.picselect)
		local logo = guiComboBoxGetItemText(gui.info.create.picselect, item)
		guiSetVisible ( gui.info.create.pic, false )
		gui.info.create.pic = guiCreateStaticImage( sx*270, sy*160, sx*260, sx*260, ":VDBGGroups/clanlogos/"..logo..".png", false, gui.info.create.window)
	elseif ( source == gui.info.create.create ) then
		local name = tostring ( guiGetText ( gui.info.create.name ) )
		local tag = tostring ( guiGetText ( gui.info.create.tag ) )
		local r=tonumber(guiGetText(gui.info.create.cr))
		local g=tonumber(guiGetText(gui.info.create.cg))
		local b=tonumber(guiGetText(gui.info.create.cb))
		local tp = tostring ( guiGetText ( gui.info.create.type ) )
		local logoitem = guiComboBoxGetSelected(gui.info.create.picselect)
		local logotipo = ( guiComboBoxGetItemText(gui.info.create.picselect, logoitem) )

		if ( name:gsub ( " ", "" ) == "" ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffVocê precisa digitar um nome", 255, 255, 255, true )
		end
		
		if ( tag:gsub ( " ", "" ) == "" ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffVocê precisa digitar uma tag", 255, 255, 255, true )
		end
		
		if ( logotipo:gsub ( " ", "" ) == "" ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffVocê precisa selecionar uma logo", 255, 255, 255, true )
		end

		if ( tp:gsub ( " ", "" ) == "" ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffSelecione um tipo de clã", 255, 255, 255, true )
		end

		if ( not r or not g or not b ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffPor favor, selecione uma cor para o clã", 255, 255, 255, true )
		end

		local color = { 
			r = r, 
			g = g, 
			b = b 
		}

		triggerServerEvent ( "VDBGGroups->GEvents:onPlayerAttemptGroupMake", localPlayer, { name=name, type = tp, color=color, logotipo=logotipo, tag=tag } )
	-- invites 
	elseif ( source == gui.info.mInvites ) then
		loadGroupPage ( "core.myInvites", true )
	elseif ( source == gui.info.invites.close ) then
		gui.info.invites.window.visible = false
	elseif ( source == gui.info.invites.deny ) then
		local r, c = guiGridListGetSelectedItem ( gui.info.invites.list )
		if ( r == -1 ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffNenhum clã selecionado", 255, 255, 255, true )
		end
		exports.vdbgmessages:sendClientMessage("Você negou o convite para "..guiGridListGetItemText ( gui.info.invites.list, r, 1 ) )
		triggerServerEvent ( "VDBGGroups->Modules->Groups->Invites->OnPlayerDeny", localPlayer, guiGridListGetItemText ( gui.info.invites.list, r, 1 ) )
	elseif ( source == gui.info.invites.accept ) then
		local r, c = guiGridListGetSelectedItem ( gui.info.invites.list )
		if ( r == -1 ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffNenhum clã selecionado", 255, 255, 255, true )
		elseif ( group and group:lower() ~= "nenhum" ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffVocê precisa deixar seu clã antes de se juntar a um outro.", 255, 255, 255, true )
		end 
		triggerServerEvent ( "VDBGGroups->Modules->Groups->Invites->OnPlayerAccept", localPlayer, guiGridListGetItemText ( gui.info.invites.list, r, 1 ) )

	-- bank
	elseif ( source == gui.my.bank ) then
		loadGroupPage ( "my.bank", true );
	elseif ( source == gui.my.bank_.close ) then
		gui.my.bank_.window.visible = false
	elseif ( source == gui.my.bank_.go ) then
		local a = tonumber ( gui.my.bank_.amount.text );
		if ( not a ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffQuantia em dinheiro inválido", 255, 255, 255, true )
		end

		local a = math.floor ( a )
		if ( a <= 0 ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffPor favor insira um número maior que 0", 255, 255, 255, true )
		end

		-- run this to check if they have access
		if ( gui.my.bank_.with.selected ) then
			triggerServerEvent ( "VDBGGroups:Modules->BankSys:onPlayerAttemptWithdawl", localPlayer, group, a )
			gui.my.bank_.window.visible = false
		elseif ( gui.my.bank_.dep.selected ) then
			triggerServerEvent ( "VDBGGroups:Modules->BankSys:onPlayerAttemptDeposit", localPlayer, group, a )
			gui.my.bank_.window.visible = false
		else
			return outputChatBox ( "#FFA500[G.E] #ffffffSelecione um método (Depositar/Sacar)", 255, 255, 255, true )
		end

	-- delete
	elseif ( source == gui.my.delete ) then
		askConfirm ( "Tem certeza de que quer apagar seu clã? Você não será capaz de recuperá-lo.", function ( x )
			if ( not x ) then return end
			triggerServerEvent ( "VDBGGroups->gEvents:onPlayerDeleteGroup", localPlayer, group, a )
		end )
	-- leave
	 elseif ( source == gui.my.leave ) then
	 	askConfirm ( "Tem certeza de que deseja sair do clã "..tostring(group).."?", function ( x )
	 		if ( not x ) then return end
	 		triggerServerEvent ( "VDBGGroups->Modules->Groups->OnPlayerLeave", localPlayer,  group )
	 	end )


	-- Membros window
	elseif ( source == gui.my.members ) then
		loadGroupPage ( "my.members", true )
		gui.main.window.visible = false
	elseif ( source == gui.my.members_.close ) then
		gui.my.members_.window.visible = false
		gui.main.window.visible = true
		if ( gui.my.members_.lWindow.visible ) then
			gui.my.members_.lWindow.visible = false
		end if ( isElement( gui.my.members_.iWindow ) ) then
			destroyElement ( gui.my.members_.iWindow )
		end
	elseif ( source == gui.my.members_.log ) then
		local r, c = guiGridListGetSelectedItem ( gui.my.members_.list )
		if ( r == -1 ) then 
			return outputChatBox ( "#FFA500[G.E] #ffffffVocê precisa selecionar uma conta", 255, 255, 255, true )
		end
		guiGridListClear ( gui.my.members_.lList )
		gui.my.members_.viewingPlayer = guiGridListGetItemText ( gui.my.members_.list, r, 1 )
		gui.my.members_.lWindow.visible = true;
		gui.my.members_.lWindow.text = "Log de Ações do Membro - ".. tostring ( gui.my.members_.viewingPlayer )
		gui.my.members_.lWindow.bringToFront ( gui.my.members_.lWindow )
		local sum = 0
		for i, v in ipairs ( gList [ group ].log ) do
			if ( v.account == gui.my.members_.viewingPlayer ) then
				sum = sum + 1
				local r = guiGridListAddRow ( gui.my.members_.lList )
				guiGridListSetItemText ( gui.my.members_.lList, r, 1, v.time, false, false )
				guiGridListSetItemText ( gui.my.members_.lList, r, 2, v.account, false, false )
				guiGridListSetItemText ( gui.my.members_.lList, r, 3, v.log, false, false )
			end 
		end 
		if ( sum == 0 ) then
			guiGridListSetItemText ( gui.my.members_.lList, guiGridListAddRow ( gui.my.members_.lList ), 1, "Este jogador não tem ações registadas", true, true )
		end 
	elseif ( source == gui.my.members_.lClose ) then
		gui.my.members_.viewingPlayer = nil
		gui.my.members_.lWindow.visible = false
		gui.my.members_.rWindow.visible = false
	elseif ( source == gui.my.members_.kick ) then
		local r, c = guiGridListGetSelectedItem ( gui.my.members_.list )
		if ( r == -1 ) then 
			return outputChatBox ( "#FFA500[G.E] #ffffffVocê precisa selecionar uma conta", 255, 255, 255, true )
		end
		local a = guiGridListGetItemText ( gui.my.members_.list, r, 1 )
		askConfirm ( "Tem certeza de que quer kickar \"".. a .."\"?", function ( x )
			if ( not x ) then return end

			if ( gList [ group ].members [ a ].rank == "Fundador" ) then
				return outputChatBox ( "#FFA500[G.E] #ffffffVocê não pode kickar o fundador do clã.", 255, 255, 255, true )
			elseif( a == getElementData ( localPlayer, "AccountData:Username" ) ) then
				return outputChatBox ( "#FFA500[G.E] #ffffffVocê não pode se remover do seu proprio clã.", 255, 255, 255, true )
			end

			triggerServerEvent ( "VDBGGroups->Modules->Gangs->kickPlayer", localPlayer, group, a )
		end )
	elseif ( source == gui.my.members_.srank ) then
		local r, c = guiGridListGetSelectedItem ( gui.my.members_.list )
		if ( r == -1 ) then 
			return outputChatBox ( "#FFA500[G.E] #ffffffVocê precisa selecionar uma conta", 255, 255, 255, true )
		end
		local a = guiGridListGetItemText ( gui.my.members_.list, r, 1 )
		gui.my.members_.viewingPlayer1 = a
		gui.my.members_.rWindow.visible = true
		guiBringToFront ( gui.my.members_.rWindow )
		guiComboBoxClear ( gui.my.members_.rRanks )
		for i, v in pairs ( gList[group].ranks ) do
			local f = guiComboBoxAddItem ( gui.my.members_.rRanks, tostring ( i ) )
			if ( tostring ( i ) == gList[group].members[a].rank ) then
				guiComboBoxSetSelected  ( gui.my.members_.rRanks, f )
			end
		end 
	elseif ( source == gui.my.members_.rUpdate ) then
		local nrank =  guiComboBoxGetItemText (  gui.my.members_.rRanks, guiComboBoxGetSelected ( gui.my.members_.rRanks ) )
		askConfirm ( "Tem certeza de que deseja alterar a patente do: "..gui.my.members_.viewingPlayer1.." de "..gList[group].members[gui.my.members_.viewingPlayer1].rank.." para "..nrank.."?", function ( x, nrank )
			if ( not x ) then return end

			gui.my.members_.rWindow.visible = false
			if ( gui.my.members_.viewingPlayer1 == getElementData ( localPlayer, "AccountData:Username" ) ) then
				return outputChatBox ( "#FFA500[G.E] #ffffffVocê não pode mudar sua propria patente.", 255, 255, 255, true )
			elseif ( gList[group].members[gui.my.members_.viewingPlayer1].rank == "Fundador" ) then
				return outputChatBox ( "#FFA500[G.E] #ffffffVocê não pode mudar a patente dos fundadores", 255, 255, 255, true )
			elseif ( nrank:lower ( ) == "founder" ) then
				return outputChatBox ( "#FFA500[G.E] #ffffffVocê não pode definir membros como um 'fundador'", 255, 255, 255, true )
			end

			triggerServerEvent ( "VDBGGroups->Modules->Gangs->Ranks->UpdatePlayerrank", localPlayer, group, gui.my.members_.viewingPlayer1, nrank );
			gui.my.members_.viewingPlayer1 = false
		end, nrank )
	elseif ( source == gui.my.members_.rClose ) then
		gui.my.members_.rWindow.visible = false


	-- Invite Window
	elseif ( source == gui.my.members_.invite ) then
		gui.my.members_.iWindow.visible = true
		guiBringToFront ( gui.my.members_.iWindow )
		guiGridListClear ( gui.my.members_.iList )
		gui.my.members_.iFilter.text = "";
		for i,v in ipairs ( getElementsByType ( "player" ) ) do
			guiGridListSetItemText ( gui.my.members_.iList, guiGridListAddRow ( gui.my.members_.iList ), 1, v.name, false, false )
		end 
	elseif ( source == gui.my.members_.iClose ) then
		gui.my.members_.iWindow.visible = false
	elseif ( source == gui.my.members_.iInvite ) then 
		local r, c = guiGridListGetSelectedItem ( gui.my.members_.iList )
		if ( r == -1 ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffNenhum jogador selecionado", 255, 255, 255, true )
		end

		local name = guiGridListGetItemText ( gui.my.members_.iList, r, 1 )
		if ( not getPlayerFromName ( name ) ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffDesculpe, este jogador não está no servidor, ou mudou seu nick", 255, 255, 255, true )
		end

		local plr = getPlayerFromName ( name )
		if ( tostring ( plr.getData ( plr, "Group" ) ):lower ( ) == group:lower ( ) ) then
			return outputChatBox ( "#FFA500[G.E] #ffffffEste jogador já está em seu clã", 255, 255, 255, true )
		end

		triggerServerEvent ( "VDBGGroups->Modules->Groups->InvitePlayer", localPlayer, group, plr )
		gui.my.members_.iWindow.visible = false;
	
	-- Ranks
	elseif ( source == gui.my.ranks ) then
		gui.my.ranks_.window.visible = true
		guiBringToFront ( gui.my.ranks_.window )
		guiSetInputMode ( "no_binds_when_editing" )
	elseif ( source == gui.my.ranks_.close) then
		gui.my.ranks_.window.visible = false
	elseif ( source == gui.my.ranks_.add ) then
		local name = gui.my.ranks_.name.text;

		if ( name:gsub ( " ", "" ) == "") then
			return outputChatBox ( "#FFA500[G.E] #ffffffNome da patente inválida.", 255, 255, 255, true )
		end

		for i, v in pairs ( gList[group].ranks ) do
			if ( tostring ( i ):lower ( ) == name:lower ( ) ) then
				return outputChatBox ( "#FFA500[G.E] #ffffffEssa patente já existe no seu grupo", 255, 255, 255, true )
			end 
		end 

		askConfirm ( "Você deseja adicionar '"..name.."' ao clã?", function ( x, name )
			if ( not x ) then return end 

			local permTable = { }
			for i, v in pairs ( gui.my.ranks_ ) do
				if ( tostring ( i ):sub ( 0, 5 ) == "perm_" ) then
					permTable [ tostring(i):sub(6,tostring(i):len()) ] = v.selected
				end 
			end 

			triggerServerEvent ( "VDBGGroups->Modules->Groups->Ranks->AddRank", localPlayer, group, name, permTable )
		end, name )

		-- change group color
	elseif ( source == gui.my.modColor ) then
		exports.cpicker:openPicker ( "changeGroupColorPicker", { 
			r = 0, g = 0, b = 0, a = 0
		}, "Selecione a cor do seu clã" )
	elseif ( source == gui.my.modMotd ) then
		guiSetInputMode ( "no_binds_when_editing" )
		gui.my.motd.window.visible = true
		gui.my.motd.motd.text = gList[group].info.desc or ""
		guiBringToFront( gui.my.motd.window )
		guiSetInputMode(  "no_binds_when_editing" )
	elseif ( source == gui.my.motd.cancel ) then
		gui.my.motd.window.visible = false
	elseif( source == gui.my.motd.update ) then
		askConfirm ( "Você deseja redefinir o anúncio do seu clã?", function ( x )
			if not x then return end
			local t = gui.my.motd.motd.text;
			triggerServerEvent ( "VDBGGroups->Modules->Groups->MOTD->Update", localPlayer, group, t )
		end )

	-- motd window
	elseif ( source == gui.info.gMotd ) then
		gui.info.motd.window.visible = true
		local desk = gList[group].info.desc
		if ( not desk or desk:gsub ( " ", "" ) == "" ) then
			desk = "None"
		end
		gui.info.motd.motd.text = tostring ( desk )
		guiBringToFront ( gui.info.motd.window )
	elseif ( source == gui.info.motd.cancel ) then
		gui.info.motd.window.visible = false
	end
end

function onClientGuiChanged ( )
	if ( gui and gui.my and gui.my.members_ and gui.my.members_.iFilter and source == gui.my.members_.iFilter ) then
		local t = source.text:lower();
		guiGridListClear ( gui.my.members_.iList )
		for i, v in ipairs ( getElementsByType ( "player" ) ) do 
			if ( v.name:lower():find ( t ) ) then
				guiGridListSetItemText ( gui.my.members_.iList, guiGridListAddRow ( gui.my.members_.iList ), 1, v.name, false, false )
			end 
		end 
	elseif ( gui and gui.my and gui.my.name_ and gui.my.ranks_.name ) then
		local t = source.text();
		if ( t ~= "" ) then
			local tmp = t
			tmp = tmp:gsub ( "%p", "" );
			source.text = tmp
		end 
	end 
end 

addEvent ( "onColorPickerOK", true )
addEventHandler ( "onColorPickerOK", root, function ( id, _, r, g, b )
	if ( id == "GroupColorPicker" ) then
		guiSetText ( gui.info.create.cr, tostring ( r ) )
		guiSetText ( gui.info.create.cg, tostring ( g ) )
		guiSetText ( gui.info.create.cb, tostring ( b ) )
	elseif ( id == "changeGroupColorPicker" ) then
		askConfirm ( "Você deseja redefinir a cor do seu clã?", function ( x, r, g, b )
			if ( not x ) then return x end
			triggerServerEvent ( "VDBGGroups->Modules->Groups->Colors->UpdateColor", localPlayer, group, r, g, b )
		end, r, g, b )
	end 
end )


function onPlayerOpenPanel ( )
	if ( not exports.vdbglogin:isClientLoggedin ( ) ) then return end
	
	if ( gui and isElement ( gui.main.window ) ) then

		if ( isElement ( gui.my.members_.window ) and guiGetVisible ( gui.my.members_.window ) ) then
			return false
		end

		removeEventHandler ( "onClientGUIClick", root, onClientGuiClick )
		removeEventHandler ( "onClientGUIChanged", root, onClientGuiChanged )

		destroyElement ( gui.main.window ) 
		setElementData(localPlayer,"opendashboard", false)
		if ( isElement ( gui.my.info_window ) ) then
			destroyElement ( gui.my.info_window )
		end if ( isElement ( gui.my.basic.window ) ) then
			destroyElement ( gui.my.basic.window )
		end if ( isElement ( gui.my.logs_.window ))  then
			destroyElement ( gui.my.logs_.window )
		end if ( isElement ( gui.info.create.window ) ) then
			destroyElement ( gui.info.create.window )
		end if ( isElement ( gui.my.bank_.window ) ) then
			destroyElement ( gui.my.bank_.window )
		end if ( isElement ( gui.my.members_.window ) ) then
			destroyElement ( gui.my.members_.window )
		end if ( isElement ( gui.my.members_.rWindow ) ) then
			destroyElement ( gui.my.members_.rWindow )
		end if ( isElement ( gui.my.members_.lWindow ) ) then
			destroyElement ( gui.my.members_.lWindow )
		end if ( isElement ( gui.my.members_.iWindow ) ) then
			destroyElement ( gui.my.members_.iWindow )
		end if ( isElement ( gui.info.invites.window ) ) then
			destroyElement ( gui.info.invites.window )
		end if ( isElement ( gui.my.ranks_.window ) ) then
			destroyElement( gui.my.ranks_.window )
		end if ( isElement ( gui.my.motd.window ) ) then
			destroyElement ( gui.my.motd.window )
		end if ( isElement ( gui.info.motd.window ) ) then
			destroyElement ( gui.info.motd.window )
		end
		
		showCursor ( false )
		gui = nil
	else
		group = getElementData ( localPlayer, "Group" ) or nil
		rank = getElementData ( localPlayer, "Group Rank" ) or nil
		if ( tostring ( group ):lower ( ) == "nenhum" ) then
			group = nil
			rank = nil
		end
		createGroupGui ( )
		setElementData(localPlayer,"opendashboard", true)
	end
end
bindKey ( "F5", "down", onPlayerOpenPanel )




addEvent ( "VDBGGroups->onServerSendClientGroupList", true )
addEventHandler ( "VDBGGroups->onServerSendClientGroupList", root, function ( g ) 
	gList = g
	loadGroupPage ( "core.info" ) 
	
	addEventHandler ( "onClientGUIClick", root, onClientGuiClick )
	addEventHandler ( "onClientGUIChanged", root, onClientGuiChanged )

	--[[ Make sure the users group is valid
	if ( group and not gList [ group ] ) then
		group = nil
		rank = nil
		setElementData ( localPlayer, "Group", "None" )
		setElementData ( localPlayer, "Group Rank", "None")
		onPlayerOpenPanel ( )
		onPlayerOpenPanel ( )
		return false;
	elseif ( group and not gList [ group ].members [ getElementData(localPlayer,"AccountData:Username") ] ) then
		group = nil
		rank = nil
		setElementData ( localPlayer, "Group", "None" )
		setElementData ( localPlayer, "Group Rank", "None")
		onPlayerOpenPanel ( )
		onPlayerOpenPanel ( )
		return false
	end ]]


end )

function table.len ( t ) 
	local c = 0
	for i, v in pairs ( t ) do 
		c = c + 1
	end
	return c
end

addEvent ( "VDBGGroups->pEvents:onPlayerRefreshPanel", true )
addEventHandler ( "VDBGGroups->pEvents:onPlayerRefreshPanel", root, function ( )
	if ( gui and isElement ( gui.main.window ) ) then
		gui.my.members_.window.visible  = false

		onPlayerOpenPanel ( )
		onPlayerOpenPanel ( )
	end
end )

addEvent ( "VDBGGroups:Module->Bank:onServerSendClientBankLevel", true )
addEventHandler ( "VDBGGroups:Module->Bank:onServerSendClientBankLevel", root, function ( m )
	guiSetText ( gui.my.bank_.balance, "Group Balance: $"..tostring ( m ) )
	guiSetEnabled ( gui.my.bank_.amount, true )
	guiSetEnabled ( gui.my.bank_.go, true )
	guiSetEnabled ( gui.my.bank_.with, gList[group].ranks[rank].bank_withdraw )
	guiSetEnabled ( gui.my.bank_.dep, gList[group].ranks[rank].bank_deposit )
end )
