addEvent ( "VDBGPolice:Modules->Panel:RequestData", true )
addEventHandler ( "VDBGPolice:Modules->Panel:RequestData", root, function ( )
	local user = getAccountName ( getPlayerAccount ( source ) )
	local jobData = exports.VDBGJobs:getJobRankTable ( )['policial']
	
	if ( getElementData ( source, "Job" ):lower( ) == "detective" ) then
		jobData = exports.VDBGJobs:getJobRankTable ( )['detective']
	end
	
	if ( getElementData ( source, "Job" ):lower( ) == "policial" ) then
		jobData = exports.VDBGJobs:getJobRankTable ( )['policial']
	end
	
	local data = { }
	data.mystats = { }
	data.mystats.arrests = exports.VDBGJobs:getJobColumnData ( user, "prissoes" )
	data.mystats.solvedCrims = exports.VDBGJobs:getJobColumnData ( user, "crimesresolvido" )
	data.mystats.rank = getElementData ( source, "Job Rank" )	
	
	local ranks = { }
	local ranks_ = { }
	for i, v in pairs ( jobData ) do table.insert ( ranks, { i, v } ) end
	table.sort ( ranks, function ( a, b, x ) return a[1] > b[1] end )
	for i=#ranks, 1, -1 do table.insert ( ranks_, ranks [ i ] ) end
	local ranks = ranks_
	local nextRank = "Cargo Alto"
	local nextRankArrests = "Cargo Alto"
	local isNext = false
	
	for i, v in ipairs ( ranks ) do
		if ( isNext ) then
			nextRank = v[2]
			nextRankArrests=v[1]
			break
		end
		if ( v[2] == data.mystats.rank ) then
			isNext = true
		end
	end
	
	data.mystats.nextRank = nextRank
	data.mystats.nextRankArrests = nextRankArrests
	data.criminals = { }
	for i, v in ipairs ( getElementsByType ( "player" ) ) do
		if ( getPlayerWantedLevel ( v ) > 0 ) then
			local wl = tostring ( getPlayerWantedLevel ( v ) )
			local wp = tostring ( getElementData ( v, "WantedPoints" ) )
			local x, y, z = getElementPosition ( v )
			local loc = getZoneName ( x, y, z )..", "..getZoneName(x,y,z,true)
			local d = {
				nam = getElementData(v, "AccountData:Name"),
				loc = loc,
				WL = wl,
				WP = wp
			}
			table.insert(data.criminals,d)
		end
	end
	triggerClientEvent ( source, "VDBGPolice:Modules->Panel:OnServerSendClientData", source, data )
end )

addEvent ( "VDBGPolice:Modules->Panel:onClientSendLawMessage", true )
addEventHandler ( "VDBGPolice:Modules->Panel:onClientSendLawMessage", root, function ( m )
	executeCommandHandler ( "r", source, m )
end )





function outputDispatchMessage ( msg )
	for i, v in pairs ( getElementsByType ( "player" ) ) do
		local t = getPlayerTeam ( v )
		if t and exports.VDBGPlayerFunctions:isTeamLaw ( getTeamName ( t ) ) then
			outputChatBox ( "#d9534f[D.P][F5] #ffffff Nova mensagem no departamento -> Expedição", v, 255, 255, 255 )
		end
		triggerClientEvent ( root, "VDBGPolice:Modules->Dispatch:onDispatchMessage", root, msg )
	end
	return true
end