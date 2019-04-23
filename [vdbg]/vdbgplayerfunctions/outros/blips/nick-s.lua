addEventHandler("onPlayerJoin", getRootElement(),
function()
local name = getPlayerName(source)
local nick = string.gsub(name, "#%x%x%x%x%x%x", "")
setPlayerName (source, nick)
end)