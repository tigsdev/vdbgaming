--This is my first normal script in MTA
--Please do not leech it as made by you
--Regards, NinetyNine a.k.a MiniMini* :D

function GiveMeAPushBabyTop( player , cmd , color , ... )
if ( hasObjectPermissionTo ( player, "function.kickPlayer" ) ) then
	if 
	(tostring(color) == "vermelho")
	or 
	(tostring(color) == "branco")
	or 
	(tostring(color) == "verde") 
	or 
	(tostring(color) == "azul") 
	or 
	(tostring(color) == "amarelo") 
	then
	    name = getElementData(player, "AccountData:Name")
	    local text = {...}
	    triggerClientEvent ( "onAnnouncementComing", getRootElement(),name,text,color)
		else
			outputChatBox("*PM: /tsay cor do texto",player,200,10,10)
			outputChatBox("*PM: cores admitidas são branco, vermelho, verde, azul e amarelo",player,200,10,10)
end
end
end
addCommandHandler("tsay",GiveMeAPushBabyTop)

function GiveMeAPushBabyLeft( player , cmd , color , ... )
if ( hasObjectPermissionTo ( player, "function.kickPlayer" ) ) then
	if 
	(tostring(color) == "vermelho")
	or 
	(tostring(color) == "branco")
	or 
	(tostring(color) == "verde") 
	or 
	(tostring(color) == "azul") 
	or 
	(tostring(color) == "amarelo") 
	then
	    name = string.gsub ( getPlayerName ( player ), "#%x%x%x%x%x%x", "" )
	    local text = {...}
	    triggerClientEvent ( "onAnnouncementComingLeft", getRootElement(),name,text,color)
		else
			outputChatBox("*PM: /tela cor do texto",player,200,10,10)
			outputChatBox("*PM:Cores Admitidas são white , red, green, blue and yellow",player,200,10,10)
end
end
end
addCommandHandler("admintext",GiveMeAPushBabyLeft)