function isPlayerStaff ( p )
	if ( p and getElementType ( p ) == 'player' ) then
		if ( isPlayerInACL ( p, "Level 1" ) or isPlayerInACL ( p, "Level 2" ) or isPlayerInACL ( p, "Level 3" ) or isPlayerInACL ( p, "Level 4" ) or isPlayerInACL ( p, "Level 5" ) or isPlayerInACL ( p, "Level 6" ) or isPlayerInACL ( p, "Level 7" ) or isPlayerInACL ( p, "Level 8" ) or isPlayerInACL ( p, "Level 9" ) or isPlayerInACL ( p, "Level 10" ) or isPlayerInACL ( p, "Admin" ) ) then
			return true
		end
		return false
	end
end

function getPlayerStaffLevel ( p, var )
	if ( isPlayerStaff ( p ) ) then
		local str = nil
		local num = nil
		for i=1,10 do
			if ( isPlayerInACL ( p, 'Level '..tostring ( i ) ) ) then
				num = i
				str = 'Level '..tostring ( i )
				break 
			end
		end
		if ( var == 'string' ) then
			return str
		elseif ( var == 'int' ) then
			return num
		else
			return str, num
		end
		
	end
	return 0,0
end

function getAllStaff ( )
	local staff = { 
		['Level 1'] = { },
		['Level 2'] = { },
		['Level 3'] = { },
		['Level 4'] = { },
		['Level 5'] = { },
		['Level 6'] = { },
		['Level 7'] = { },
		['Level 8'] = { },
		['Level 9'] = { },
		['Level 10'] = { },
		['Admin'] = { },
	}
	
	for i=1,10 do
		for k, v in ipairs ( aclGroupListObjects ( aclGetGroup ( "Level "..tostring ( i ) ) ) ) do
			if ( string.find ( tostring ( v ), 'user.' ) ) then
				local name = tostring ( v:gsub ( "user.", "" ) )
				staff['Level '..tostring ( i )][#staff['Level '..tostring ( i )]+1] = name
			end
		end
	end
	
	return staff
end

function isPlayerInACL ( player, acl )
 local account = getPlayerAccount ( player )
 if type(acl) ~= "string" or ( isGuestAccount ( account ) ) then
  return false
 end
 local group = aclGetGroup ( acl )
 if type(group) ~= "boolean" then
   return isObjectInACLGroup ( "user."..getAccountName ( account ), group )
 end
 return group
end

function getOnlineStaff ( )
	local online = { }
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		if ( isPlayerStaff ( v ) ) then
			table.insert ( online, v )
		end
	end
	return online
end



function consoleSetPlayerPosition ( source, commandName, posX, posY, posZ )
	if ( isPlayerStaff ( source ) ) then
	setElementPosition ( source, posX, posY, posZ )
	end
end
addCommandHandler ( "sp", consoleSetPlayerPosition  )