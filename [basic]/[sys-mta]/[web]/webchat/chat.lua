ilosc = 20
wiadomosci = {}
rootElement = getRootElement ()

function getAll()
	return wiadomosci
end

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function getTime ()
	local time = getRealTime ()
	if time.hour < 10 then time.hour = "0"..time.hour end
	if time.minute < 10 then time.minute = "0"..time.minute end
	if time.second < 10 then time.second = "0"..time.second end
	local czas = time.hour..":"..time.minute..":"..time.second
	
	return czas
end

function addMessage ( array )
	if table.size(wiadomosci) > ilosc then
		table.remove(wiadomosci, 1)
		table.insert(wiadomosci, array)
	else
		table.insert(wiadomosci, array)
	end
end

function newMessage ( gracz, tekst, typ )
	if ( gracz ) and ( tekst ~= nil ) and ( typ ~= nil ) then
		local r, g, b = getPlayerNametagColor ( gracz )
		local msg = {[0]=getTime(), [1]=getPlayerName(gracz), [2]=tekst, [3]=r, [4]=g, [5]=b, [6]=typ}
		addMessage ( msg )
		return true
	end
	return false
end

function sendMessageToAllPlayers ( nick, message )
	local wiadomosc = "#FFFF00"..nick.." (web): #FFFFFF"..message
	outputServerLog ( "CHAT: "..nick.." (web): "..message )
	outputChatBox ( wiadomosc, rootElement, 255, 255, 255, true )
	addMessage ( {[0]=getTime(), [1]=nick.." (web)", [2]=message, [3]=0, [4]=0, [5]=0, [6]="WEB"} )
    return wiadomosc
end

function onPlayerChat ( msg, typ )
	local styp = "" if typ == 1 then styp = "ME" elseif typ == 2 then styp ="TEAM" else styp = "CHAT" end
	newMessage ( source, msg, styp )
end

function onPlayerJoin ( )
	newMessage ( source, "Player ("..getPlayerName(source)..") join server.", "JOIN" )
end

function onPlayerQuit ( quitType )
	newMessage ( source, "Player ("..	(source)..") quit server ("..quitType..").", "QUIT" )
end

function onPlayerWasted ( Ammo, killer, killerWeapon, bodypart )
	if ( killer ) and ( source ) then
		newMessage ( killer, "Player ("..getPlayerName(killer)..") kill player ("..getPlayerName(source)..") using weapon ("..getWeaponNameFromID(killerWeapon)..").", "KILL"	)
	else
		newMessage ( source, "Player ("..getPlayerName(source)..") die.", "KILL" )
	end
end

function onPlayerChangeNick ( oldNick, newNick )
	newMessage ( source, "Player ("..getPlayerName(source)..") change nick. Old (".. oldNick .."). New (".. newNick ..").", "NICK" )
end

--[[ Export function 
	+ params
		required
		- player or string, 
		- string - message, 
		- string - type of message, 
		
		optional
		*  red, green, blue int if player is string 
			if r,g,b is nil then r=0, g=0, b=0
		
	+ return
		true or false
		
	Using 
		* calling
			call(getResourceFromname("webchat"), "addChatMsg", player/string, message, type, [r, g, b])
			
		* event	
			- server side: 
				triggerEvent("addChatMsg", getRootElement(), player/string, message, type, [r, g, b])
				
			- client side
				triggerServerEvent("addChatMsg", getRootElement(), player/string, message, type, [r, g, b])
]]
function addChatMsg ( player, msg, type, r, g, b )
	if player ~= nil and msg ~= nil and type ~= nil then
		if type(player) == "userdata" then
			newMessage ( player, msg, type )
		else
			if r == nil then r = 0 end
			if g == nil then g = 0 end
			if b == nil then b = 0 end
			
			addMessage ( {[0]=getTime(), [1]=player, [2]=msg, [3]=r, [4]=g, [5]=b, [6]=type} )
			return true
		end
	else
		return false
	end
end

addEvent ( "addChatMsg", true )
addEventHandler ( "addChatMsg", rootElement, addChatMsg )


addEventHandler ( "onPlayerChat", rootElement, onPlayerChat )
addEventHandler ( "onPlayerJoin", rootElement, onPlayerJoin )
addEventHandler ( "onPlayerQuit", rootElement, onPlayerQuit )
addEventHandler ( "onPlayerWasted", rootElement, onPlayerWasted )
addEventHandler ( "onPlayerChangeNick", rootElement, onPlayerChangeNick )