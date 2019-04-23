local netloads =  {
	["Level 1"] = 10,
	["Level 2"] = 20,
	["Level 3"] = 30,
	["Level 4"] = 40,
	["Level 5"] = 50,
	["Level 6"] = 60,
	["Level 7"] = 70,
	["Level 8"] = 80,
	["Level 9"] = 90,
	["Level 10"] = 100
}

local col = getDatabaseColumnTypeFromJob ( "fisherman" )

addEvent ( "VDBGJobs:Fisherman:onClientSellCatch", true )
addEventHandler ( "VDBGJobs:Fisherman:onClientSellCatch", root, function ( t, items, prices )
	if ( t ) then
		triggerEvent ( "VDBGJobs->GivePlayerMoney", source, source, "CaughtFish", t, 30 )
		updateJobColumn ( getAccountName ( getPlayerAccount ( source ) ), "CaughtFish", "AddOne" )
	end
	local totalFish = 0
	for i, v in pairs ( items ) do
		totalFish = totalFish + v
	end
	
	local c = ( getElementData(source,"VDBGJobs:Fisherman:CaughtFish") or 0 ) + totalFish
	
	local cr = getElementData ( source, "Job Rank" )
	updateRank ( source, "fisherman" )
	setElementData ( source, "VDBGJobs:Fisherman:CaughtFish", c )
	
	outputChatBox ( "#d9534f[PESCADOR] #FFFFFFVocê vendeu #acd373R$"..t.."..00 ; #FFFFFF (#4aabd0"..totalFish.." peixes#FFFFFF)!", source, 255, 255, 255, true)
	if ( cr ~= getElementData ( source, "Job Rank" ) ) then
		local netload = netloads [ getElementData ( source, "Job Rank" ) ]
		outputChatBox ( "#d9534f[PESCADOR] #FFFFFFVocê classificou-se no trabalho do pescador: "..tostring(netload)..")!", source, 255, 255, 255, true)
		triggerClientEvent ( source, "VDBGJobs:Fisherman:updateMaxNetCatch", source, netload )
	end
end )


function fisherman_refreshMaxCatch ( source )
	local limit = netloads [ getElementData ( source, "Job Rank" ) ]
	triggerClientEvent ( source, "VDBGJobs:Fisherman:updateMaxNetCatch", source, limit )
end
addEvent ( "VDBGJobs:Fisherman:getClientNetLimit", true )
addEventHandler ( "VDBGJobs:Fisherman:getClientNetLimit", root, fisherman_refreshMaxCatch )


addEvent ( "VDBGJobs:Fisherman:GetClientFisherStatsForInterface", true )
addEventHandler ( "VDBGJobs:Fisherman:GetClientFisherStatsForInterface", root, function ( )
	
	local account_ = getAccountName(getPlayerAccount(source))
	local job_ = getElementData ( source, "Job" )
	local rank_ = getElementData ( source, "Job Rank" )
	local caught = tonumber ( getJobColumnData ( account_, col ) ) or 0
	local nextRank_ = "None"
	local requiredCatchesForNext_ = "No"
	
	local k = 0
	local dn = false
	
	for i, v in pairs ( jobRanks [ 'fisherman' ] ) do
		k = k + 1
		if ( dn ) then
			nextRank_ = v
			requiredCatchesForNext_ = i - caught
		end
		if ( v == rank_ ) then dn = true end
	end
	local d = { job = job_, jobRank = rank_, caughtFish = caught, nextRank = nextRank_, requiredCatchesForNext = requiredCatchesForNext_, account = account_ }
	triggerClientEvent ( source, "VDBGJobs:Fisherman:OnServerSendClientJobInformationForInterface", source, d )
end )

for i, v in ipairs ( getElementsByType ( "player" ) ) do
	local a = getPlayerAccount ( v )
	if ( not isGuestAccount ( a ) ) then
		local catches = getJobColumnData ( getAccountName ( a ), col )
		setElementData ( v, "VDBGJobs:Fisherman:CaughtFish", catches )
	end
end


addEventHandler ( "onPlayerLogin", root, function ( _, acc )
	setTimer ( function ( source, acc )
		local j = getElementData ( source, "Job" )
		if ( job == "Fisherman" ) then
			local d = getJobColumnData ( getAccountName(acc), col )
			setElementData ( source, "VDBGJobs:Fisherman:CaughtFish", tonumber ( d ) )
		end
	end, 500, 1, source, acc )
end )


addEventHandler ( "VDBGJobs:onPlayerJoinNewJob", root, function ( j )
	if ( j == "fisherman" ) then
		local catches = getJobColumnData ( getAccountName ( getPlayerAccount ( source ) ), col )
		setElementData ( source, "VDBGJobs:Fisherman:CaughtFish", catches )
	end
end )