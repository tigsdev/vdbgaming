max_wanted = {
    community = 2,
    law = 1,
    Criminoso = 7
}
jobRanks = {
    ['criminoso'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
        [50000] = "Chefe",
    },
    ['policial'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
    ['medico'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
    ['mecanico'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
    ['fisherman'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
	['detective'] = {
		[0] = "Investigador",
		[1000] = "C.Investigador",
		[10000] = "C.Crime",
	},
	['caminhoneiro'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
	},
	['piloto'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
	},
	['stunter'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
	},
	['motorista'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [425] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
	['entregador'] = {	
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
	['pizzaboy'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
	['vagabundo'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
	['taxista'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
	
	['lixeiro'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    },
	['taliban'] = {
        [0] = "Level 1",
        [50] = "Level 2",
        [75] = "Level 3",
        [120] = "Level 4",
        [200] = "Level 5",
        [310] = "Level 6",
        [499] = "Level 7",
        [999] = "Level 8",
        [2099] = "Level 9",
        [4099] = "Level 10",
    }
}

function getJobRankTable ( )
	return jobRanks
end

--exports['Scoreboard']:scoreboardAddColumn  ( "Job", root, 85, "Emprego", 4 )
--exports['Scoreboard']:scoreboardAddColumn  ( "Job Rank", root, 90, "Cargo", 5 )


function createJob ( name, x, y, z, rz )
    if ( name == 'Criminoso' ) then
        exports.VDBG3DTEXT:create3DText ( 'Criminoso', { x, y, z }, { 255, 0, 0 }, { nil, true },  { }, "Criminoso", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 109 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local crim = createBlip ( x, y, z, 59, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(crim, "job-namevdbg1", "Criminoso")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.Criminoso ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.Criminoso )..".", p, 255, 255, 255, true )
                end 
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Criminoso' )
            end
        end )
        
    ----------------------------------
	-- Law Jobs						--
	----------------------------------    
    elseif ( name == 'Policial' ) then  
        exports.VDBG3DTEXT:create3DText ( 'Policial', { x, y, z }, { 0, 100, 255 }, { nil, true },  { }, "Policial", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 280 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local pol = createBlip ( x, y, z, 61, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(pol, "job-namevdbg1", "Policial")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.law ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.law )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Policial' )
            end
        end )
		
	elseif ( name == 'Detective' ) then
        exports.VDBG3DTEXT:create3DText ( 'Detective', { x, y, z }, { 0, 120, 255 },  { }, "Detective", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 17 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local dete = createBlip ( x, y, z, 61, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(dete, "job-namevdbg1", "Detetive")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.law ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.law )..".", p, 255, 255, 255, true )
                end
				
				local arrests = getJobColumnData ( getAccountName ( getPlayerAccount ( p ) ), getDatabaseColumnTypeFromJob ( "Policial" ) )
				if ( arrests < 150 ) then
					return outputChatBox ( "Este trabalho requer que você faça 150 detenções", p, 255, 255, 255, true )
				end
				
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'detective' )
            end
        end )
		
		
	----------------------------------
	-- Emergencia Jobs				--
	----------------------------------
    elseif ( name == 'Medico' ) then
        exports.VDBG3DTEXT:create3DText ( 'Medico', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Medico", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 274 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local medi = createBlip ( x, y, z, 58, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(medi, "job-namevdbg1", "Medico")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Medico' )
            end
        end )
		
    ----------------------------------
	-- Community Jobs				--
	----------------------------------
	elseif ( name == 'Mecanico' ) then
        exports.VDBG3DTEXT:create3DText ( 'Mecanico', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Mecanico", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 30 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local mec = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(mec, "job-namevdbg1", "Mecanico")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Mecanico' )
            end
        end )
	----------------------------------
	-- Community Jobs				--
	----------------------------------
	elseif ( name == 'Taxista' ) then
        exports.VDBG3DTEXT:create3DText ( 'Taxista', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Taxista", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 78 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local mec = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(mec, "job-namevdbg1", "Taxista")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Taxista' )
            end
        end )
	----------------------------------
	-- Community Jobs				--
	----------------------------------
	elseif ( name == 'Lixeiro' ) then
        exports.VDBG3DTEXT:create3DText ( 'Lixeiro', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Lixeiro", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 260 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local mec = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(mec, "job-namevdbg1", "Lixeiro")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Lixeiro' )
            end
        end )
		
	----------------------------------
	-- Community Jobs				--
	----------------------------------
	elseif ( name == 'Vagabundo' ) then
        exports.VDBG3DTEXT:create3DText ( 'Vagabundo', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Vagabundo", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 78 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local mec = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(mec, "job-namevdbg1", "Vagabundo")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Vagabundo' )
            end
        end )
		
	----------------------------------
	-- Community Jobs				--
	----------------------------------
	elseif ( name == 'PizzaBOY' ) then
        exports.VDBG3DTEXT:create3DText ( 'PizzaBOY', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "PizzaBOY", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 30 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local mec = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(mec, "job-namevdbg1", "PizzaBOY")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'PizzaBOY' )
            end
        end )
	---------------------------------
	-- Community Jobs				--
	----------------------------------
	elseif ( name == 'Entregador' ) then
        exports.VDBG3DTEXT:create3DText ( 'Entregador', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Entregador", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 20 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local mec = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(mec, "job-namevdbg1", "Entregador")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Entregador' )
            end
        end )
	elseif ( name == 'Caminhoneiro' ) then
        exports.VDBG3DTEXT:create3DText ( 'Caminhoneiro', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Caminhoneiro", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 202 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local cam = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(cam, "job-namevdbg1", "Caminhoneiro")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Caminhoneiro' )
            end
        end )		
	elseif ( name == 'Motorista' ) then
        exports.VDBG3DTEXT:create3DText ( 'Motorista', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Motorista", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 255 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local cam = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(cam, "job-namevdbg1", "Motorista")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Motorista' )
            end
        end )
   elseif ( name == 'Pesqueiro' ) then
        exports.VDBG3DTEXT:create3DText ( 'Pesqueiro', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Pesqueiro", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 45 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local pesca = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(pesca, "job-namevdbg1", "Pescador")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'fisherman' )
            end
        end )
	elseif ( name == "Piloto" ) then
        exports.VDBG3DTEXT:create3DText ( 'Piloto', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Piloto", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 61 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local pilo = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(pilo, "job-namevdbg1", "Piloto")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'Piloto' )
            end
        end )
	elseif ( name == 'Stunter' ) then
        exports.VDBG3DTEXT:create3DText ( 'Stunter', { x, y, z }, { 255, 255, 0 }, { nil, true },  { }, "Stunter", "JOB")
        local p = createElement ( "GodmodePed" )
        setElementData ( p, "Model", 23 )
        setElementData ( p, "Position", { x, y, z, rz } )
        local stun = createBlip ( x, y, z, 60, 2, 255, 255, 255, 255, 0, 450 )
		setElementData(stun, "job-namevdbg1", "Stunter")
        addEventHandler ( 'onMarkerHit', createMarker ( x, y, z - 1, 'cylinder', 2, 0, 0, 0, 0 ), function ( p )
            if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) and not isPedDead ( p ) ) then
                if ( getPlayerWantedLevel ( p ) > max_wanted.community ) then
                    return outputChatBox ( "#d9534f[JOB] #FFFFFFLamentamos, seu nível de procurado está elevado. #ffa500MÍNIMO: "..tostring ( max_wanted.community )..".", p, 255, 255, 255, true )
                end
                triggerClientEvent ( p, 'VDBGJobs:OpenJobMenu', p, 'stunter' )
            end
        end )
		
    end
end
createJob ( 'Criminoso', 1625.92, -1508.65, 13.6, 180 )
createJob ( 'Criminoso', 2141.75, -1733.94, 17.28, 0 )
createJob ( 'Criminoso', 2460.31, 1324.94, 10.82, -90 )
createJob ( 'Criminoso', 1042.26, 2154.03, 10.82, -90 )
createJob ( 'Criminoso', -1832.49, 584.03, 35.16, 0 )
createJob ( 'Criminoso', 2124.29, 889.1, 11.18, -90 )
createJob ( 'Criminoso', -2530.02, -624.22, 132.75, 0 )
createJob ( 'Criminoso', 1048.77, 1559.27, 5.82, 0 )


createJob ( 'Mecanico', 2276.12, -2359.67, 13.55, 318 )
createJob ( 'Mecanico', -1710.16, 403.56, 7.42, 140.4 )
createJob ( 'Mecanico', 1658.34, 2199.65, 10.82, 180 )
createJob ( 'Mecanico', -2032.12, 161.43, 29.05, 0 )
createJob ( 'Mecanico', -75.08, -361.48, 5.43, -110 )
createJob ( 'Mecanico', 1353.81, -1541.2, 13.62, -90 )
createJob ( 'Piloto', 2003.13, -2294.49, 13.55, 90 )
createJob ( 'Piloto', 1651.48, 1614.14, 10.82, -90 )
createJob ( 'Piloto', -1253.7, 16.99, 14.15, 131 )
createJob ( 'Policial', 1576.59, -1634.24, 13.56, 90 )
createJob ( 'Policial', -1614.66, 682.42, 7.19, 90 )
createJob ( 'Policial', 2297.12, 2463.87, 10.82, 90 )
createJob ( 'Medico', 1177.88, -1329.2, 14.08, 0 )
createJob ( 'Medico', 1615.18, 1819.67, 10.83, 0 )
createJob ( 'Medico', 2024.16, -1403.99, 17.2, 90 )
createJob ( 'Pesqueiro', 2158.27, -98.15, 2.81, 27.44 )
createJob ( 'Pesqueiro',162.72, -1873.91, 2.83, 0 )
createJob ( "Detective", 1559.69, -1690.48, 5.89, 180 )
createJob ( "Detective",-1573.45, 653.08, 7.19, 90 )
createJob ( "Detective", 2297.12, 2455.66, 10.82, 90 )
createJob ( "Stunter", 1948.64, -1364.5, 18.58, 90 )
createJob ( "Caminhoneiro", 123.06, -298.43, 1.58, 90 )
createJob ( "Caminhoneiro", 2156.13, -2234.5, 13.41, 220 )
createJob ( "Caminhoneiro", -1622.98, -2694.24, 48.74, 150 )


createJob ( "Motorista", 1743.24, -1863.59, 13.57, 0 )
createJob ( "Motorista", -1980.62, 108.4, 27.68, 90 )
-- ls 
createJob ( "Entregador", 2302.41, -2335.61, 13.55, 90 )
createJob ( "PizzaBOY", 2106.6069335938, -1822.6779785156, 13.557731628418, 90 )
createJob ( "Vagabundo", 1967.2095947266, -1175.5089794922, 20.030742645264, 90 )
createJob ( "Taxista", 1673.85, -1133.10, 23.9, 0 )
createJob ( "Lixeiro", 2176, -2259, 14.77, 225 )

-- sf
createJob ( "Entregador", -1816.0390625, -174.32479858398, 9.3984375, 90 )
createJob ( "PizzaBOY", -2331.6687011719, -164.5546875, 35.5546875, 272 )
createJob ( "Vagabundo", -2016.5189208984, 1109.3885498047, 53.2890625, 231 )
createJob ( "Taxista", -1943.0610351563, 571.796875, 35.315952301025, 348 )
createJob ( "Lixeiro", -1625.0554199219, 1291.130859375, 7.1834831237793, 260 )




createJob ( "Taliban", 1243.98, -2030.05, 70.99, 0 )





function setPlayerJob ( p, job, prtyJob )
    if ( isGuestAccount ( getPlayerAccount ( p ) ) ) then
        return outputChatBox ( "#d9534f[JOB] #FFFFFFVocê precisa estar logado em uma conta para poder se empregar.", p, 255, 255, 255, true )
    end

    exports['VDBGLogs']:outputActionLog ( getPlayerName ( p ).." Agora, é empregue como um "..tostring ( job ) )
    addPlayerToJobDatabase ( p )

    local weapons = { }
	for i=1,12 do 
		weapons[i] = { 
			weap = getPedWeapon ( source, i ),
			ammo = getPedTotalAmmo ( source, i ) 
		} 
	end

    if ( job == 'Criminoso' ) then
        setElementData ( p, 'Job', 'Criminoso' )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Criminoso" )
        setElementModel ( p, 109 )
        job = "Criminoso"
		
    elseif ( job == 'Mecanico' ) then
        setElementData ( p, 'Job', 'Mecanico' )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
        setElementModel ( p, 30 )
        job = "Mecanico"
		
	elseif ( job == 'Caminhoneiro' ) then
        setElementData ( p, 'Job', 'Caminhoneiro' )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
        setElementModel ( p, 202 )
        job = "Caminhoneiro"
		
	elseif ( job == 'Motorista' ) then
        setElementData ( p, 'Job', 'Motorista' )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
        setElementModel ( p, 255 )
        job = "Motorista"
		
    elseif ( job == 'Policial' ) then
        setElementData ( p, 'Job', 'Policial' )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Policial" )
        setElementModel ( p, 280 )
        job = "Policial"
       weapons[1] = { weap=3, ammo=2 }
	   
    elseif ( job == "Medico" ) then
        job = "Medico"
        setElementData ( p, "Job", "Medico" )
        setElementModel ( p, 274 )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Emergencia" )
		
    elseif ( job == "fisherman" ) then
        job = "Fisherman"
        setElementData ( p, "Job", "Fisherman" )
        setElementModel ( p, 45 )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
		
	elseif ( job == "detective" ) then
		job = "Detective"
        setElementData ( p, "Job", "Detective" )
        setElementModel ( p, 17 )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Policial" )
        weapons[1] = { weap=3, ammo=2 }
		
	elseif ( job == "Piloto" ) then
		job = "Piloto"
        setElementData ( p, "Job", "Piloto" )
        setElementModel ( p, 20 )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
		
	elseif ( job == "Entregador" ) then
		job = "Entregador"
        setElementData ( p, "Job", "Entregador" )
        setElementModel ( p, 20 )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
		
	elseif ( job == "PizzaBOY" ) then
		job = "PizzaBOY"
        setElementData ( p, "Job", "PizzaBOY" )
        setElementModel ( p, 155 )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
		
	elseif ( job == "Taxista" ) then
		job = "Taxista"
        setElementData ( p, "Job", "Taxista" )
        setElementModel ( p, 142 )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
		
	elseif ( job == "Lixeiro" ) then
		job = "Lixeiro"
        setElementData ( p, "Job", "Lixeiro" )
        setElementModel ( p, 260 )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
		
	elseif ( job == "Vagabundo" ) then
		job = "Vagabundo"
		local skin = tonumber ( getElementData ( p, "VDBGUser.UnemployedSkin" ) ) or 78
        setElementData ( p, "Job", "Vagabundo" )
        setElementModel ( p, skin )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
		
    elseif ( job == 'stunter' ) then
		job = "Stunter"
		local skin = tonumber ( getElementData ( p, "VDBGUser.UnemployedSkin" ) ) or 23
        setElementData ( p, "Job", "Stunter" )
        setElementModel ( p, skin )
        exports['VDBGPlayerFunctions']:setTeam ( p, "Civilizante" )
		
	end
    if ( prtyJob ) then
        job = prtyJob 
    end

   	takeAllWeapons ( p )
   	for i, v in pairs ( weapons ) do
   		giveWeapon ( p, v.weap, v.ammo )
   	end 

    outputChatBox ( "#d9534f[JOB] #FFFFFFAgora você trabalha como: #ffa500"..tostring ( job ).."!", p, 255, 255, 255, true )
    updateRank ( p, job )
	
	triggerEvent ( "VDBGJobs:onPlayerJoinNewJob", p, tostring ( job ):lower ( ) )
	weapons = nil
end
addEvent ( 'VDBGJobs:SetPlayerJob', true )
addEventHandler ( 'VDBGJobs:SetPlayerJob', root, function ( j ) setPlayerJob ( source, j ) end )

function getJobType ( job )
    local job = string.lower ( tostring ( job ) )
    if ( job == "Criminoso" or job == "Desempregado" ) then
        return "Criminoso"
    elseif ( job == "Medico" or job == "Mecanico" or job == "fisherman" or job == 'Piloto' or job == "stunter" or job == "Caminhoneiro" or job == "Motorista" or job == "Entregador" or job =="PizzaBOY"  or job =="Vagabundo"   or job =="Taxista"   or job =="Lixeiro"  ) then
        return "community"
    elseif ( job == "Policial" or job == "Detective" ) then
        return "law" 
    end
end

function updateRank ( p, job )
    local job = tostring ( job ):lower ( )
    local rank = "Nenhum"
    local current = 0
    local column = getDatabaseColumnTypeFromJob ( job )
    local data = getJobColumnData ( getAccountName(getPlayerAccount(p)), column or "" )
    if ( jobRanks[job] ) then
        for i, v in pairs ( jobRanks[job] ) do 
            if ( data >= i and i >= current ) then
                rank = v
                current = i
            end
        end
    end
    setElementData ( p, "Job Rank",tostring ( rank ) )
    if ( job == "fisherman" ) then
        fisherman_refreshMaxCatch ( p )
    end
end

function getDatabaseColumnTypeFromJob ( job )
    local column = ""
    local job = tostring ( job ):lower ( )
    if ( job == "criminoso" ) then
        column="acoescriminosas"
	elseif ( job == "policial" ) then
        column = "prissoes"
	elseif ( job == "lixeiro" ) then
		column = "coletasdelixo"
	elseif ( job == "taxista" ) then
		column = "pontostaxista"
	elseif ( job == "vagabundo" ) then
		column = "pontosvagabundo"
	elseif ( job == "motorista" ) then
        column = "paradasbus"
	elseif ( job == "caminhoneiro" ) then
        column = "viagenscamin"
	elseif ( job == "pizzaboy" ) then
		column = "pontospizzas"
    elseif ( job == "mecanico" ) then
        column = "veiculosreparados"
    elseif ( job == "medico" ) then
        column = "playerscurado"
    elseif ( job == "fisherman" ) then
        column = "peixescoletado"
	elseif ( job == "detective" ) then
		column = "crimesresolvido"
	elseif ( job == "entregador" ) then
		column = "caixasentregue"	
	elseif ( job == "piloto" ) then
		column = "vooscompleto"
	elseif ( job == "stunter" ) then
		column = "stunts"
    end
    return column
end

function addPlayerToJobDatabase ( p )
    local acc = getPlayerAccount ( p )
    if ( isGuestAccount ( acc ) ) then
        return false
    end
    local data = exports['VDBGSQL']:db_query ( "SELECT * FROM jobdata WHERE Username=? LIMIT 1", getAccountName ( acc ) )
    if ( type ( data ) ~= "table" or #data < 1 ) then
        exports['VDBGSQL']:db_exec ( "INSERT INTO jobdata ( `Username`, `prissoes`, `TimesArrested`, `viagenscamin`, `caixasentregue`, `pontospizzas`, `paradasbus`, `coletasdelixo`, `pontostaxista`, `pontosvagabundo`, `acoescriminosas`, `veiculosreparados`, `playerscurado`, `TowedVehicles`, `peixescoletado`, `crimesresolvido`, `vooscompleto`, `stunts` ) VALUES ( '"..getAccountName ( acc ) .."', '0', '0', '0', '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0',  '0', '0', '0', '0', '0', '0' );" )
        return true
    end
    return false
end


exports['VDBGSQL']:db_exec ( "CREATE TABLE IF NOT EXISTS jobdata ( Username TEXT, prissoes INT, TimesArrested INT, viagenscamin INT, caixasentregue INT, pontospizzas INT, paradasbus INT, coletasdelixo INT, pontostaxista INT, pontosvagabundo INT, acoescriminosas INT, veiculosreparados INT, playerscurado INT, TowedVehicles INT, peixescoletado INT, crimesresolvido INT, vooscompleto INT, stunts INT )" )
function updateJobColumn ( user, col, to ) 
    if ( user and col and to ) then
        if ( type ( user ) == 'string' and type ( col ) == 'string' ) then
            if ( to ~= "AddOne" ) then
                exports['VDBGSQL']:db_exec ( "UPDATE jobdata SET "..tostring ( col ).."='"..to.."' WHERE Username='"..user.."'" )
                return true
            elseif ( to == "AddOne" ) then
                local q = exports['VDBGSQL']:db_query ( "SELECT "..tostring ( col ).." FROM jobdata WHERE Username='"..user.."'" )
                local to = q[1][col]+1
                exports['VDBGSQL']:db_exec ( "UPDATE jobdata SET "..tostring ( col ).."='"..to.."' WHERE Username='"..user.."'" )
                return true
            end
        end
    end
    return false
end

function getJobColumnData ( user, col )
    if user and col then
        local user, col = tostring ( user ), tostring ( col )
        local q = exports['VDBGSQL']:db_query ( "SELECT * FROM jobdata WHERE Username=?", user )
        if ( q and q[1] ) then
        	return q[1][col] or 0
        else
        	return 0
        end
    end
end

function outputTeamMessage ( msg, team, r, g, b )
    for i, v in ipairs ( getPlayersInTeam ( getTeamFromName ( team ) ) ) do
        outputChatBox ( "#d9534f[JOB] #FFFFFF"..msg, v, r, g, b )
    end
    return true
end

function resignPlayer ( player, forced )
    if ( player and isElement ( player ) and getElementType ( player ) == 'player' ) then
		if ( forced == nil ) then
			forced = true
		end
		
		local j = getElementData ( player, "Job" )
		local r = getElementData ( player, "Job Rank" )
        setElementData ( player, "Job", "Desempregado" )
        exports['VDBGPlayerFunctions']:setTeam ( player, "Desempregado" )
        setElementData ( player, "Job Rank", "Nenhum" )
		if ( isPedInVehicle ( player ) ) then removePedFromVehicle ( player ) end
		local skin = tonumber ( getElementData ( player, "VDBGUser.UnemployedSkin" ) )
		if ( not skin ) then
			setElementData ( player, "VDBGUser.UnemployedSkin", 28 )
			skin = 28
		end
		
		triggerClientEvent ( player, "onPlayerResign", player, j, r, skin )
        setPedSkin ( player, skin )
    end
end

addCommandHandler ( "demitir", function ( player )
	if ( isPedInVehicle ( player ) ) then
		return outputChatBox ( "#d9534f[JOB] #FFFFFF SAIA DO VEÍCULO PARA SE DEMITIR.", player, 255, 255, 255, true )
	end
	resignPlayer ( player )
end )


function createJobPickup ( x, y, z, id, jobs )
    local e = createPickup ( x, y, z, 2, id, 50, 1 )
    setElementData ( e, "VDBGJobs:pickup.jobLock", jobs )
    addEventHandler ( "onPickupHit", e, function ( p )
        if ( getElementType ( p ) ~= "player" or isPedInVehicle ( p ) ) then return end
        local jobs = getElementData ( source, "VDBGJobs:pickup.jobLock" )
        local job = getElementData ( p, "Job" ) or ""
        local done = false
        for i, v in ipairs ( jobs ) do
            if ( v == job ) then
                done = true
                break
            end
        end 
        if ( not done or isPedInVehicle ( p ) ) then
            if ( not isPedInVehicle ( p ) ) then
                outputChatBox ( "#d9534f[JOB] #FFFFFFVOCÊ NÃO PODE PEGAR ESTE ITEM.", p, 255, 255, 255, true )
            end
            cancelEvent ( )
        end
    end )
end
createJobPickup ( 1576.18, -1620.43, 13.55, 3, { "Policial", "Detective" } )
createJobPickup ( 1177.97, -1319.01, 14.1, 14, { "Medico" } )
createJobPickup ( 2027.39, -1403.95, 17.23, 14, { "Medico" } )





function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function table.nextIndex ( tab, i2 )
    local isTHis = false
    for i, v in pairs ( tab ) do
        if ( isThis ) then
            return i
        end
        if ( i == i2 ) then
            isThis = true
        end
    end
end


addEvent ( "VDBGJobs->GivePlayerMoney", true )
addEventHandler ( "VDBGJobs->GivePlayerMoney", root, function ( player, job, amount, xp ) 
	givePlayerMoney ( player, amount )
	local j = tostring ( getElementData ( player, "Job" ):lower ( ) )
	updateRank ( player, j )
	if ( xp ) then
	 if j == "stunter" then return end
		exports.VDBGLevel:addXP(player,xp)
	end
end )


addEvent ( "VDBGJobs->SQL->UpdateColumn", true )
addEventHandler ( "VDBGJobs->SQL->UpdateColumn", root, function ( player, column, to )
	updateJobColumn ( getAccountName ( getPlayerAccount ( player ) ), tostring(column), tostring(to) )
	
	local j = tostring ( getElementData ( player, "Job" ):lower ( ) )
	updateRank ( player, j )
end )

addEvent ( "VDBGJobs:onPlayerJoinNewJob", true )


function getPlayerJob(player)
	return getElementData(player,"Job")
end

function foreachinorder(t, f, cmp)
    local keys = {}
    for k,_ in pairs(t) do
        keys[#keys+1] = k
    end
    table.sort(keys,cmp)
    local data = { }
    for _, k in ipairs ( keys ) do 
    	table.insert ( data, { k, t[k] } )
    end 
    return data
end


function getPlayersByJob(job)
	local jobPlayers = {}
	for index, player in pairs(getElementsByType("player")) do
		if getPlayerJob(player) == tostring(job) then
			table.insert(jobPlayers, player)
		end
	end
	return jobPlayers
end