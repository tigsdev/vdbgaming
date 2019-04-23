function slotsServer( )
    return {
		slots = getMaxPlayers(),
  
    }
end

function onlinePlayers( )
    return {
		online = getPlayerCount ( ),
  
    }
end

--[[
addEventHandler ( "onPlayerQuit", root, function ( ) 
	callRemote ( "http://www.vdbg.org/conecta/atualizadados.php", getElementsByType ( "player" ) )
end ) 

addEventHandler ( "onPlayerLogin", root, function ( ) 
	callRemote ( "http://www.vdbg.org/conecta/atualizadados.php", getElementsByType ( "player" ) )
end ) 

addEventHandler ( "onPlayerJoin", root, function ( ) 
	callRemote ( "http://www.vdbg.org/conecta/atualizadados.php", getElementsByType ( "player" ) )
end ) 
]]
 
 
function getStatsForWebsite( )

	local pTable = { }
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		local data = getAllElementData ( v )
		pTable [ getPlayerName ( v ) ] = data
	end 

    return {
    	players = pTable
    }
end



function contasServer()
    local playerslist = {}
    for i,p in ipairs (getElementsByType("player")) do
        local thep = string.gsub(getPlayerName(p), "#%x%x%x%x%x%x", "")
        table.insert(playerslist,tostring(thep))
    end
    return playerslist
end


function teamcr()
  local alivePlayers = { }
  for i,p in ipairs (getElementsByType("player")) do
  local thep = string.gsub(getPlayerName(p), "#%x%x%x%x%x%x", "")
  local login = getAccountName (getPlayerAccount(p)) or "tiaguinhods"
	if getTeamName(getPlayerTeam(p)) == "Criminoso" then
      table.insert(alivePlayers,"<span class='badge5clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..login.."'>"..thep.."</a></span>&nbsp;")
    end 
end
  return alivePlayers
end

function teamad()
  local alivePlayersa = { }
  for i,p in ipairs (getElementsByType("player")) do
  local thep = string.gsub(getPlayerName(p), "#%x%x%x%x%x%x", "")
  local login = getAccountName (getPlayerAccount(p)) or "tiaguinhods"
	if getTeamName(getPlayerTeam(p)) == "Administração" then
      table.insert(alivePlayersa,"<span class='badge4clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..login.."'>"..thep.."</a></span>&nbsp;")
    end 
  end
  return alivePlayersa
end

function teampo()
  local alivePlayersp = { }
  for i,p in ipairs (getElementsByType("player")) do
  local thep = string.gsub(getPlayerName(p), "#%x%x%x%x%x%x", "")
  local login = getAccountName (getPlayerAccount(p)) or "tiaguinhods"
	if getTeamName(getPlayerTeam(p)) == "Policial" then
      table.insert(alivePlayersp,"<span class='badge6clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..login.."'>"..thep.."</a></span>&nbsp;")
    end 
  end
  return alivePlayersp
end

function teamci()
  local alivePlayersc = { }
  for i,p in ipairs (getElementsByType("player")) do
  local thep = string.gsub(getPlayerName(p), "#%x%x%x%x%x%x", "")
  local login = getAccountName (getPlayerAccount(p)) or "tiaguinhods"
	if getTeamName(getPlayerTeam(p)) == "Civilizante" or getTeamName(getPlayerTeam(p)) == "Desempregado" or getTeamName(getPlayerTeam(p)) == "Emergencia" or getTeamName(getPlayerTeam(p)) == "Convidado" then
      table.insert(alivePlayersc,"<span class='badge3clan'><a class='linkprofile' href='?pagina=p/perfil.php&consulta="..login.."'>"..thep.."</a></span>&nbsp;")
    end 
  end
  return alivePlayersc
end


function convertMoneyToString(money)
	local formatted = money
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
		if k==0 then break end
	end
	formatted = tostring(formatted)..",00"
	return formatted
end

function math.percent(percent,maxvalue)
    if tonumber(percent) and tonumber(maxvalue) then
        local x = (maxvalue*percent)/100
        return x
    end
    return false
end