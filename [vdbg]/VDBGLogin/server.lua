function attemptLogin ( client, user, pass )
	local s = getPlayerSerial ( client )
	if ( exports.VDBGBans:isSerialBanned ( s ) ) then
		exports.VDBGBans:loadBanScreenForPlayer ( client )
		triggerClientEvent ( client, "VDBGLogin:hideLoginPanel", client )
	end
		if ( user and pass and type ( user ) == 'string' and type ( pass ) == 'string' ) then

		local account = getAccount ( user )
		if ( account ) then
			if ( not logIn ( client, account, pass ) ) then
				exports.VDBGRadar:showBox(client, "error","#d9534fSenha incorreta")
				return false
			end
			fadeCamera(client, false,1)
			--name = getElementData(client, "AccountData:Name")
			--setPlayerName ( client, name )
			setElementData(client, "logado", true)
			setElementData ( client, "opendashboard", false )
			exports['VDBGLogs']:outputActionLog ( getPlayerName ( client ).." Fez um login na conta "..tostring(user).." (IP: "..getPlayerIP(client).."  || Serial: "..getPlayerSerial(client)..")" )
			triggerClientEvent(client, "destroyGui", client)
			
            exports.VDBGRadar:showBox(client, "info","Finalmente!! Está pronto \n Versão: #428bca3.0.1")
			showCursor(client, false)
		else
			exports.VDBGRadar:showBox(client, "error"," Esta conta não existe! \n#d9534fRegistre-se em www.vdbg.org")
			return false
		end
	end
	return false
end
addEvent ( "Login:onClientAttemptLogin", true )
addEventHandler ( "Login:onClientAttemptLogin", root, attemptLogin )


addEvent ( "VDBGLogin:RequestClientLoginConfirmation", true )
addEventHandler ( "VDBGLogin:RequestClientLoginConfirmation", root, function ( )
	local s = getPlayerSerial ( source )
	if ( exports.VDBGBans:isSerialBanned ( s ) ) then
		exports.VDBGBans:loadBanScreenForPlayer ( source )
		triggerClientEvent(client, "destroyGui", client)
		setCameraMatrix (client, 1359.8466796875, -964.04107666016, 9999.700199127197, 1359.7414550781, -964.99334716797, 41.413646697998, 1338.6286621094)
	end
end )



addEventHandler ( 'onPlayerLogout', root, function ( ) 
kickPlayer ( source, "Você não pode se deslogar com o comando /logout" )
end )

addEventHandler ( "onPlayerJoin", getRootElement(), function ( )
 setElementData(source,"AccountData.Language", "ptbr")
end)

addEventHandler ( "onPlayerJoin", root, function ( )
	setElementData ( source, "Job", "Nenhum" )
	setElementData ( source, "Job Rank", "Nenhum" )
	setElementData ( source, "Gang", "Nenhum" )
	setElementData ( source, "Gang Rank", "Nenhum" )
	setElementData ( source, "Playtime", "" )
	setElementData ( source, "FPS", "0" )
	setElementData ( source, "opendashboard", true )
	
end )

--[[
addEvent( "onRequestSavePassword", true )
addEventHandler( "onRequestSavePassword", root,
	function (pass)
		if type(pass) == "string" then
			local conta = getPlayerAccount(client)
			setAccountData(conta, "dadosdocamposenha", tostring(pass))
		end
	end
)
	]] 


function registroWeb ( userreg, passreg )
        if(passreg ~= "" and passreg ~= nil and userreg ~= "" and userreg ~= nil) then
                local accountAdded = addAccount(userreg,passreg)
                if(accountAdded) then
				outputDebugString ( "[SITE][Novo Registro] Usuário: "..usuario.." Senha: "..senha )
                else
				outputDebugString ( "Erro ao criar uma conta pelo site" )
                end
        else
                outputDebugString ( "Erro ao criar uma conta pelo site, não recebeu os dados certo." )
        end
end

function trocasenha(logado, senhareg)

	local usuario = getAccount( logado )
	local senha = tostring ( senhareg )
	
	setAccountPassword(usuario,senha)
	outputDebugString ( "conta: "..usuario.." senha:"..senha.."" )
end

function nickChangeHandler(oldNick, newNick)
    if getAccount(newNick) then
        cancelEvent()
    end
end
addEventHandler("onPlayerChangeNick", getRootElement(), nickChangeHandler)