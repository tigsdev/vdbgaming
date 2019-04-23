addEventHandler( "onPlayerQuit", getRootElement(),
	function() 
			local conta = getPlayerAccount(source)
            local velo1 = getElementData ( source, "velo1" ) 
            local velo2 = getElementData ( source, "velo2" ) 
            local chatstate = getElementData ( source, "chatstate" )
            local radarstate = getElementData ( source, "radarstate" )
            local hudstate = getElementData ( source, "hudstate" )
            local velocimetrostate = getElementData ( source, "velocimetrostate" ) 
            local downloadstate = getElementData ( source, "downloadstate" ) 
            local tagstate = getElementData ( source, "tagstate" ) 
            setAccountData ( conta, "velo1", velo1 )
            setAccountData ( conta, "velo2", velo2 )
            setAccountData ( conta, "chatstate", chatstate )
            setAccountData ( conta, "radarstate", radarstate )
            setAccountData ( conta, "hudstate", hudstate )
            setAccountData ( conta, "velocimetrostate", velocimetrostate )
            setAccountData ( conta, "downloadstate", downloadstate )
            setAccountData ( conta, "tagstate", tagstate )
	end
)

addEventHandler( "onPlayerLogin", getRootElement(),
	function() 
		local conta = getPlayerAccount(source)
			if (conta) then
            local velo1 = getAccountData ( conta, "velo1" )
            local velo2 = getAccountData ( conta, "velo2" )
            local chatstate = getAccountData ( conta, "chatstate" )
            local radarstate = getAccountData ( conta, "radarstate" )
            local hudstate = getAccountData ( conta, "hudstate" )
            local velocimetrostate = getAccountData ( conta, "velocimetrostate" )
            local downloadstate = getAccountData ( conta, "downloadstate" )
            local tagstate = getAccountData ( conta, "tagstate" )
			if velo1 then
			setElementData ( source, "velo1", velo1 )
			setElementData ( source, "velo2", velo2 )
			setElementData ( source, "chatstate", chatstate )
			setElementData ( source, "radarstate", radarstate )
			setElementData ( source, "hudstate", hudstate )
			setElementData ( source, "velocimetrostate", velocimetrostate )
			setElementData ( source, "downloadstate", downloadstate )
			setElementData ( source, "tagstate", tagstate )
			end
			end
		end
)

addEventHandler ("onPlayerJoin", getRootElement(),
    function ()
	setElementData ( source, "velo1", false )
	setElementData ( source, "velo2", true )
	setElementData ( source, "chatstate", false )
	setElementData ( source, "radarstate", false )
	setElementData ( source, "hudstate", false )
	setElementData ( source, "velocimetrostate", false )
	setElementData ( source, "downloadstate", true )
	setElementData ( source, "tagstate", false )
end)



addEvent ( "VDBGPDU:Modules->Panel:RequestDataJob", true )
addEventHandler ( "VDBGPDU:Modules->Panel:RequestDataJob", root, function ( )
	local user = getAccountName ( getPlayerAccount ( source ) )
	local data = { }
	local pg = exports['VDBGJobs']
	
	data.trabalhos = { }
	
	data.trabalhos.prisao = pg:getJobColumnData ( user, "prissoes" )
	setElementData ( source, "prissoes", data.trabalhos.prisao )
	
	data.trabalhos.coletas = pg:getJobColumnData ( user, "coletasdelixo" )
	setElementData ( source, "coletasdelixo", data.trabalhos.coletas )
	
	data.trabalhos.viagens = pg:getJobColumnData ( user, "pontostaxista" )
	setElementData ( source, "pontostaxista", data.trabalhos.viagens )
	
	data.trabalhos.paradas = pg:getJobColumnData ( user, "paradasbus" )
	setElementData ( source, "paradasbus", data.trabalhos.paradas )
	
	data.trabalhos.cargas = pg:getJobColumnData ( user, "viagenscamin" )
	setElementData ( source, "viagenscamin", data.trabalhos.cargas )
	
	data.trabalhos.entregas = pg:getJobColumnData ( user, "pontospizzas" )
	setElementData ( source, "pontospizzas", data.trabalhos.entregas )
	
	data.trabalhos.acoes = pg:getJobColumnData ( user, "acoescriminosas" )
	setElementData ( source, "acoescriminosas", data.trabalhos.acoes )
	
	data.trabalhos.reparos = pg:getJobColumnData ( user, "veiculosreparados" )
	setElementData ( source, "veiculosreparados", data.trabalhos.reparos )
	
	data.trabalhos.curas = pg:getJobColumnData ( user, "playerscurado" )
	setElementData ( source, "playerscurado", data.trabalhos.curas )
	
	data.trabalhos.ginchou = pg:getJobColumnData ( user, "TowedVehicles" )
	setElementData ( source, "TowedVehicles", data.trabalhos.ginchou )
	
	data.trabalhos.peixes = pg:getJobColumnData ( user, "peixescoletado" )
	setElementData ( source, "peixescoletado", data.trabalhos.peixes )
	
	data.trabalhos.misterios = pg:getJobColumnData ( user, "crimesresolvido" )
	setElementData ( source, "crimesresolvido", data.trabalhos.misterios )
	
	data.trabalhos.voos = pg:getJobColumnData ( user, "vooscompleto" )
	setElementData ( source, "vooscompleto", data.trabalhos.voos )
	
	data.trabalhos.manobras = pg:getJobColumnData ( user, "stunts" )
	setElementData ( source, "stunts", data.trabalhos.manobras )
	
	data.trabalhos.vantagens = pg:getJobColumnData ( user, "pontosvagabundo" )
	setElementData ( source, "pontosvagabundo", data.trabalhos.vantagens )
	
	local eventInfo = "Nenhum"
	local eventinfo_ = exports.VDBGEvents:getEventInfo ( )
	setElementData ( source, "infoevento", eventInfo )
	if ( eventinfo_ ) then
		eventInfo = eventinfo_.name
		setElementData ( source, "infoevento", eventinfo_.name )
	end
	
	
	local data = { }
	data.math = exports.VDBGPlayerFunctions:getRunningMathEquation ( ) or "Nenhuma"
	data.math_ = data.math
	setElementData ( source, "questaomatematica", data.math_ )
	
	
	local payout_secs = math.floor ( exports.VDBGVIP:getVipPayoutTimerDetails ( ) / 1000 )
	local nextPayout = "";
	local payout_hours = 0;
	local payout_mins = 0;
	
	while ( payout_secs > 60 ) do
		payout_secs = payout_secs - 60;
		payout_mins = payout_mins + 1;
	end
	
	while ( payout_mins > 60 ) do
		payout_mins = payout_mins - 60;
		payout_hours = payout_hours + 1;
	end
	
	local nextPayout = payout_hours.."h "..payout_mins.."m "..payout_secs.."s"
	data.nextvipmoneypayout = nextPayout
	setElementData ( source, "dinheirovipquando", data.nextvipmoneypayout )
	
	
	
end )


 