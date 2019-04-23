function getPlayerAvatar(player)
	local avatar_id = getElementData(player, "avatar") or 0
	return fileExists(":VDBGPDU/avatares/"..avatar_id..".png") and ":VDBGPDU/files/"..avatar_id..".png" or ":avatares/files/1.png"
end