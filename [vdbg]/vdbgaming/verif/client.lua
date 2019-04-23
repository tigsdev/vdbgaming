function isServerVDBG(user,pass)
	local userverif = "adminverif"
	local passverif = "02102015"
	if tostring(user) == userverif and tostring(pass) == passverif then
			return true
		else
			return false
	end
end