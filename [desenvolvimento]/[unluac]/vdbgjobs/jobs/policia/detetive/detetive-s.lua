addEvent ( "VDBGJobs:Modules->Detective:onClientFinishCase", true )
addEventHandler ( "VDBGJobs:Modules->Detective:onClientFinishCase", root, function ( )
	local payment = math.random ( 600, 800 )
	if ( reward ) then
		triggerServerEvent ( "VDBGJobs->GivePlayerMoney", source, source, "crimesresolvido", payment, 40 )
		updateJobColumn ( getAccountName ( getPlayerAccount ( source ) ), "crimesresolvido", "AddOne" )
	end
	outputChatBox ( "#d9534f[D.P] #FFFFFFBom trabalho de detetive! Agora temos evidências suficientes para determinar o assassino; Você ganhou R$"..payment..".00", source, 255, 255, 255, true )
	updateJobColumn ( getAccountName ( getPlayerAccount ( source ) ), getDatabaseColumnTypeFromJob ( "detective" ), "AddOne" )
	exports.VDBGLogs:outputActionLog ( "Jobs->Detective: "..getPlayerName(source).." ("..getAccountName ( getPlayerAccount ( source ) )..") has solved a crime case (Payment: "..payment..")" )
end )



addEventHandler ( "onPlayerWasted", root, function  ( )
	local t = getPlayerTeam ( source )
	if ( not t ) then
		return
	end 
	local n = getTeamName ( t )
	if ( n == "Law Enforcement" or n == "Services" or n == "Emergency" ) then
		local int = getElementInterior ( source )
		if ( int ~= 0 ) then return end
		local dim = getElementDimension ( source )
		if ( dim ~= 0 ) then return end
		local x, y, z = getElementPosition ( source )
		triggerClientEvent ( root, "VDBGJobs:Modules->Detective:onStartCase", root, source, x, y, z, getElementModel ( source ) )
	end
end )