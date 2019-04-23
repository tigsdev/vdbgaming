
function dadosCriminoso()
    local output_string = {}
    for i,p in ipairs (getElementsByType("player")) do
			local ping = getPlayerPing(p)
			local name1 = getPlayerName(p) or "Não encontrado"
			local name = string.gsub(name1, "#%x%x%x%x%x%x", "")
			local money = getPlayerMoney(p) or 0
			local vida =  getElementHealth(p) or 0
			local colete = getPedArmor(p) or 0
			local wanted = getPlayerWantedLevel(p)
			local wantedp = getElementData(p, "WantedPoints") or "0"
			local vip = getElementData(p, "VIP" ) or "Nenhum"
			local mortes = getElementData(p, "VDBGSQL:Deaths") or "0"
			local matou = getElementData(p, "VDBGSQL:Kills") or "0"
			local tempojogo = getElementData(p, "Playtime") or "0"
			local gang1 = getElementData(p, "Group") or "Nenhum"
			local gang = string.gsub(gang1, "#%x%x%x%x%x%x", "")
			local banco = getElementData(p, "VDBGBank:BankBalance") or "0"
			local combat_shotgun = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local shotgun = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local deagle = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local tec = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local sniper_rifle = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local mm = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local silenced = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local m4 = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local ak47 = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local micro_smg = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local equipe = getTeamName(getPlayerTeam(p)) or "N/A"
			local job = getElementData(p, "Job") or "N/A"
			
			local level = getElementData(p, "LVL") or "0"
			local xp = getElementData(p, "XP") or "0"
			local up = getElementData(p, "LVLUP") or "0"
			local lvl = math.percent(xp,up)
			
			local avatar = math.random(1,100)
			if getTeamName(getPlayerTeam(p)) == "Criminoso" then
			table.insert(output_string,
			"<div class='container'><h2 class='nw'><img src='Assets/Images/avatars/"..avatar..".png'/> "..name..
			"</h2><div class='col-md-12 content1 statcontent'><br>	<h2 class='nobreak'>Informações básicas</h2>"..
			"<h3 class='profileh4'>Dinheiro: R$<font color='#457FC0'> "..convertMoneyToString(tonumber(money)).."</font></h3>"..
			"<hr><div class='row'><div class='col-md-6'><h4 class='profileh4'>Vida: "..vida.."/100</h4><div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' data-transitiongoal="..vida.." aria-valuemin='0' aria-valuemax='100'></div></div></div>"..
			"<div class='col-md-6'><h4 class='profileh4'>Colete: "..colete.."/100</h4><div class='progress'><div class='progress-bar progress-bar-info' role='progressbar' data-transitiongoal="..colete.." aria-valuemin='0' aria-valuemax='100'></div></div></div>"..		
			"<div class='col-md-6'><h4 class='profileh4'>Pontos de procurado: "..wantedp.."/5000</h4><div class='progress'><div class='progress-bar progress-bar-warning' role='progressbar' data-transitiongoal="..wantedp.." aria-valuemin='0' aria-valuemax='5000'></div></div></div>"..
			"<div class='col-md-6'><h4 class='profileh4'>Nível de procurado: "..wanted.."</h4><div class='progress'><div class='progress-bar progress-bar-danger' role='progressbar' data-transitiongoal="..wanted.." aria-valuemin='0' aria-valuemax='6'></div></div></div></div></div>"..
			"<div class='col-md-12 content1 statcontent'><h2>Informações do Jogador</h2><h4 class='profileh4'>"..level.."/500</h4>"..
			"<div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' data-transitiongoal='"..xp.."' aria-valuemin='0' aria-valuemax='"..up.."' aria-valuenow='"..xp.."' style='width: "..lvl.."%;'></div></div>"..
			"<ul class='list-group'>"..
			"<li class='list-group-item'><span class='badge5'>"..equipe.."</span>Equipe:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..job.."</span>Trabalho:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..mortes.."</span>Mortes:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..matou.."</span>Matou:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..tempojogo.."</span>Tempo de Jogo:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..gang.."</span>Grupo: </li>"..
			"<li class='list-group-item'><span class='badge5'>"..vip.."</span>VIP:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..convertMoneyToString(tonumber(banco)).."</span>Conta bancária: </li>"..
			"</ul></div>"..
			"<br>")
			end
    end
    return output_string
end


function dadosPolicial()
    local output_stringp = {}
    for i,p in ipairs (getElementsByType("player")) do
			local ping = getPlayerPing(p)
			local name1 = getPlayerName(p) or "Não encontrado"
			local name = string.gsub(name1, "#%x%x%x%x%x%x", "")
			local money = getPlayerMoney(p) or 0
			local vida =  getElementHealth(p) or 0
			local colete = getPedArmor(p) or 0
		--	local team = getPlayerTeam(p) 
			local wanted = getPlayerWantedLevel(p)
			local wantedp = getElementData(p, "WantedPoints") or "0"
			local vip = getElementData(p, "VIP" ) or "Nenhum"
			local mortes = getElementData(p, "VDBGSQL:Deaths") or "0"
			local matou = getElementData(p, "VDBGSQL:Kills") or "0"
			local tempojogo = getElementData(p, "Playtime") or "0"
			local gang1 = getElementData(p, "Group") or "Nenhum"
			local gang = string.gsub(gang1, "#%x%x%x%x%x%x", "")
			local banco = getElementData(p, "VDBGBank:BankBalance") or "0"
			local combat_shotgun = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local shotgun = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local deagle = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local tec = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local sniper_rifle = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local mm = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local silenced = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local m4 = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local ak47 = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local micro_smg = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local equipe = getTeamName(getPlayerTeam(p)) or "N/A"
			local job = getElementData(p, "Job") or "N/A"


			local level = getElementData(p, "LVL") or "0"
			local xp = getElementData(p, "XP") or "0"
			local up = getElementData(p, "LVLUP") or "0"
			local lvl = math.percent(xp,up)			
			
			local avatar = math.random(1,100)
			if getTeamName(getPlayerTeam(p)) == "Policial" then
			table.insert(output_stringp,
			"<div class='container'><h2 class='nw'><img src='Assets/Images/avatars/"..avatar..".png'/> "..name..
			"</h2><div class='col-md-12 content1 statcontent'><br>	<h2 class='nobreak'>Informações básicas</h2>"..
			"<h3 class='profileh4'>Dinheiro: R$<font color='#457FC0'> "..convertMoneyToString(tonumber(money)).."</font></h3>"..
			"<hr><div class='row'><div class='col-md-6'><h4 class='profileh4'>Vida: "..vida.."/100</h4><div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' data-transitiongoal="..vida.." aria-valuemin='0' aria-valuemax='100'></div></div></div>"..
			"<div class='col-md-6'><h4 class='profileh4'>Colete: "..colete.."/100</h4><div class='progress'><div class='progress-bar progress-bar-info' role='progressbar' data-transitiongoal="..colete.." aria-valuemin='0' aria-valuemax='100'></div></div></div>"..		
			"<div class='col-md-6'><h4 class='profileh4'>Pontos de procurado: "..wantedp.."/5000</h4><div class='progress'><div class='progress-bar progress-bar-warning' role='progressbar' data-transitiongoal="..wantedp.." aria-valuemin='0' aria-valuemax='5000'></div></div></div>"..
			"<div class='col-md-6'><h4 class='profileh4'>Nível de procurado: "..wanted.."</h4><div class='progress'><div class='progress-bar progress-bar-danger' role='progressbar' data-transitiongoal="..wanted.." aria-valuemin='0' aria-valuemax='6'></div></div></div></div></div>"..
			"<div class='col-md-12 content1 statcontent'><h2>Informações do Jogador</h2><h4 class='profileh4'>"..level.."/500</h4>"..
			"<div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' data-transitiongoal='"..xp.."' aria-valuemin='0' aria-valuemax='"..up.."' aria-valuenow='"..xp.."' style='width: "..lvl.."%;'></div></div>"..
			"<ul class='list-group'>"..
			"<li class='list-group-item'><span class='badge5'>"..equipe.."</span>Equipe:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..job.."</span>Trabalho:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..mortes.."</span>Mortes:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..matou.."</span>Matou:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..tempojogo.."</span>Tempo de Jogo:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..gang.."</span>Grupo: </li>"..
			"<li class='list-group-item'><span class='badge5'>"..vip.."</span>VIP:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..convertMoneyToString(tonumber(banco)).."</span>Conta bancária: </li>"..
			"</ul></div>"..
			"<br>")
			end
    end
    return output_stringp
end

function dadosCidadao()
    local output_stringci = {}
    for i,p in ipairs (getElementsByType("player")) do
			local ping = getPlayerPing(p)
			local name1 = getPlayerName(p) or "Não encontrado"
			local name = string.gsub(name1, "#%x%x%x%x%x%x", "")
			local money = getPlayerMoney(p) or 0
			local vida =  getElementHealth(p) or 0
			local colete = getPedArmor(p) or 0
			local wanted = getPlayerWantedLevel(p)
			local wantedp = getElementData(p, "WantedPoints") or "0"
			local vip = getElementData(p, "VIP" ) or "Nenhum"
			local mortes = getElementData(p, "VDBGSQL:Deaths") or "0"
			local matou = getElementData(p, "VDBGSQL:Kills") or "0"
			local tempojogo = getElementData(p, "Playtime") or "0"
			local gang1 = getElementData(p, "Group") or "Nenhum"
			local gang = string.gsub(gang1, "#%x%x%x%x%x%x", "")
			local banco = getElementData(p, "VDBGBank:BankBalance") or "0"
			local combat_shotgun = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local shotgun = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local deagle = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local tec = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local sniper_rifle = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local mm = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local silenced = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local m4 = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local ak47 = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local micro_smg = getElementData(p, "VDBGSQL:WeaponStats") or "0"	
			local equipe = getTeamName(getPlayerTeam(p)) or "N/A"
			local job = getElementData(p, "Job") or "N/A"


			local level = getElementData(p, "LVL") or "0"
			local xp = getElementData(p, "XP") or "0"
			local up = getElementData(p, "LVLUP") or "0"
			local lvl = math.percent(xp,up)			
			
			local avatar = math.random(1,100)
			if getTeamName(getPlayerTeam(p)) == "Civilizante" or getTeamName(getPlayerTeam(p)) == "Desempregado" or getTeamName(getPlayerTeam(p)) == "Emergencia" or getTeamName(getPlayerTeam(p)) == "Convidado" then
			table.insert(output_stringci,
			"<div class='container'><h2 class='nw'><img src='Assets/Images/avatars/"..avatar..".png'/> "..name..
			"</h2><div class='col-md-12 content1 statcontent'><br>	<h2 class='nobreak'>Informações básicas</h2>"..
			"<h3 class='profileh4'>Dinheiro: R$<font color='#457FC0'> "..convertMoneyToString(tonumber(money)).."</font></h3>"..
			"<hr><div class='row'><div class='col-md-6'><h4 class='profileh4'>Vida: "..vida.."/100</h4><div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' data-transitiongoal="..vida.." aria-valuemin='0' aria-valuemax='100'></div></div></div>"..
			"<div class='col-md-6'><h4 class='profileh4'>Colete: "..colete.."/100</h4><div class='progress'><div class='progress-bar progress-bar-info' role='progressbar' data-transitiongoal="..colete.." aria-valuemin='0' aria-valuemax='100'></div></div></div>"..		
			"<div class='col-md-6'><h4 class='profileh4'>Pontos de procurado: "..wantedp.."/5000</h4><div class='progress'><div class='progress-bar progress-bar-warning' role='progressbar' data-transitiongoal="..wantedp.." aria-valuemin='0' aria-valuemax='5000'></div></div></div>"..
			"<div class='col-md-6'><h4 class='profileh4'>Nível de procurado: "..wanted.."</h4><div class='progress'><div class='progress-bar progress-bar-danger' role='progressbar' data-transitiongoal="..wanted.." aria-valuemin='0' aria-valuemax='6'></div></div></div></div></div>"..
			"<div class='col-md-12 content1 statcontent'><h2>Informações do Jogador</h2><h4 class='profileh4'>"..level.."/500</h4>"..
			"<div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' data-transitiongoal='"..xp.."' aria-valuemin='0' aria-valuemax='"..up.."' aria-valuenow='"..xp.."' style='width: "..lvl.."%;'></div></div>"..
			"<ul class='list-group'>"..
			"<li class='list-group-item'><span class='badge5'>"..equipe.."</span>Equipe:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..job.."</span>Trabalho:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..mortes.."</span>Mortes:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..matou.."</span>Matou:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..tempojogo.."</span>Tempo de Jogo:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..gang.."</span>Grupo: </li>"..
			"<li class='list-group-item'><span class='badge5'>"..vip.."</span>VIP:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..convertMoneyToString(tonumber(banco)).."</span>Conta bancária: </li>"..
			"</ul></div>"..
			"<br>")
			end
    end
    return output_stringci
end



function dadosAdmin()
    local output_stringp = {}
    for i,p in ipairs (getElementsByType("player")) do
			local ping = getPlayerPing(p)
			local name1 = getPlayerName(p) or "Não encontrado"
			local name = string.gsub(name1, "#%x%x%x%x%x%x", "")
			local money = getPlayerMoney(p) or 0
			local vida =  getElementHealth(p) or 0
			local colete = getPedArmor(p) or 0
			local wanted = getPlayerWantedLevel(p)
			local wantedp = getElementData(p, "WantedPoints") or "0"
			local vip = getElementData(p, "VIP" ) or "Nenhum"
			local mortes = getElementData(p, "VDBGSQL:Deaths") or "0"
			local matou = getElementData(p, "VDBGSQL:Kills") or "0"
			local tempojogo = getElementData(p, "Playtime") or "0"
			local gang1 = getElementData(p, "Group") or "Nenhum"
			local gang = string.gsub(gang1, "#%x%x%x%x%x%x", "")
			local banco = getElementData(p, "VDBGBank:BankBalance") or "-0"
			local combat_shotgun = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local shotgun = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local deagle = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local tec = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local sniper_rifle = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local mm = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local silenced = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local m4 = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local ak47 = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local micro_smg = getElementData(p, "VDBGSQL:WeaponStats") or "0"
			local equipe = getTeamName(getPlayerTeam(p)) or "N/A"
			local job = getElementData(p, "Job") or "N/A"



			local level = getElementData(p, "LVL") or "0"
			local xp = getElementData(p, "XP") or "0"
			local up = getElementData(p, "LVLUP") or "0"
			local lvl = math.percent(xp,up)			
			
			local avatar = math.random(1,100)
			if getTeamName(getPlayerTeam(p)) == "Administração" then
			table.insert(output_stringp,
			"<div class='container'><h2 class='nw'><img src='Assets/Images/avatars/"..avatar..".png'/> "..name..
			"</h2><div class='col-md-12 content1 statcontent'><br>	<h2 class='nobreak'>Informações básicas</h2>"..
			"<h3 class='profileh4'>Dinheiro: R$<font color='#457FC0'> "..convertMoneyToString(tonumber(money)).."</font></h3>"..
			"<hr><div class='row'><div class='col-md-6'><h4 class='profileh4'>Vida: "..vida.."/100</h4><div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' data-transitiongoal="..vida.." aria-valuemin='0' aria-valuemax='100'></div></div></div>"..
			"<div class='col-md-6'><h4 class='profileh4'>Colete: "..colete.."/100</h4><div class='progress'><div class='progress-bar progress-bar-info' role='progressbar' data-transitiongoal="..colete.." aria-valuemin='0' aria-valuemax='100'></div></div></div>"..		
			"<div class='col-md-6'><h4 class='profileh4'>Pontos de procurado: "..wantedp.."/5000</h4><div class='progress'><div class='progress-bar progress-bar-warning' role='progressbar' data-transitiongoal="..wantedp.." aria-valuemin='0' aria-valuemax='5000'></div></div></div>"..
			"<div class='col-md-6'><h4 class='profileh4'>Nível de procurado: "..wanted.."</h4><div class='progress'><div class='progress-bar progress-bar-danger' role='progressbar' data-transitiongoal="..wanted.." aria-valuemin='0' aria-valuemax='6'></div></div></div></div></div>"..
			"<div class='col-md-12 content1 statcontent'><h2>Informações do Jogador</h2><h4 class='profileh4'>"..level.."/500</h4>"..
			"<div class='progress'><div class='progress-bar progress-bar-success' role='progressbar' data-transitiongoal='"..xp.."' aria-valuemin='0' aria-valuemax='"..up.."' aria-valuenow='"..xp.."' style='width: "..lvl.."%;'></div></div>"..
			"<ul class='list-group'>"..
			"<li class='list-group-item'><span class='badge5'>"..equipe.."</span>Equipe:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..job.."</span>Trabalho:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..mortes.."</span>Mortes:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..matou.."</span>Matou:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..tempojogo.."</span>Tempo de Jogo:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..gang.."</span>Grupo: </li>"..
			"<li class='list-group-item'><span class='badge5'>"..vip.."</span>VIP:</li>"..
			"<li class='list-group-item'><span class='badge5'>"..convertMoneyToString(tonumber(banco)).."</span>Conta bancária: </li>"..
			"</ul></div>"..
			"<br>")
			end
    end
    return output_stringp
end
end