--[[

	How does the script work?
	When the admin types /makeevent [id] the server will create the event if there isn't an event currently running.
	The timer will begin and announce to players to join the event. Once the countdown is over, it checks to see if
	there are enough players in the event to continue. If there are then it calls the function:
	eventStartFunctions [ eventID ] ( )
	For example, the Sanchez race, it would call:
	eventStartFunctions [ 1 ] ( )
	The "eventStartFunctions" functions are defined in other files inside the events folder.
	



	How to make the eventStartFunctions function?
	First of all, you cannot name the function eventStartFunctions[int]( ). You have to make a temporary function
	and then define eventStartFunctions[int] with the _G variable. Example:
	function onClientStartRace ( )
		outputChatBox ( "Let the race begin!", root )
	end
	eventStartFunctions[2] = _G["onClientStartRace"]




	CURRENT EVENT ID'S:
		[1] = Sanchez race (Up the mountain)
		[2] = One in the chamber
		[3] = Los santos street race




	GLOBAL VARIABLES:
		eventStartFunctions
			Type: Table
			For: Storing the event start functions
		playersInEvent
			Type: Table
			For: Storing the players that are in the event
		eventInfo
			Type: Table
			For: Storing all of the event information
		eventObjects
			Type: Table
			For: Storing event objects. Player vehicles are defined with their element
		events
			Type: Table
			For: Storing all of the events and their settings
		EventCore
			Type: Table
			For: Holding all of the core functions




	RESOURCE EVENTS:
		VDBGEvents:onEventCreated 			- Triggers when an event is created
		VDBGEvents:onPlayerJoinEvent 			- Triggers when a player successfully joins an event
		VDBGEvents:onEventStarted 			- Triggers when the event countdown is over
		VDBGEvents:onEventEnded				- Triggers when the event ends (forced or not)
		VDBGEvents:onPlayerRemovedFromEvent	- Triggers when a player gets removed from an event
		
]]


eventStartFunctions = { }
playersInEvent = nil
eventInfo = nil
eventObjects = nil
events = { }
EventCore = { }

function EventCore.StartEvent ( id )
	if ( not events [ id ] or eventInfo ) then
		return false
	end
	
	local text_ = textCreateDisplay ( )
	local text = textCreateTextItem ( "*Evento iniciando em: 50 segundos", 0.6, 0.65, "hight", 255, 255, 0, 255, 2, "right", "bottom", 2 ) 
	textDisplayAddText ( text_, text )
	local timer = setTimer ( EventCore.BeginTheEvent, 50000, 1 )	
	
	local dim = math.random ( 5, 59565 )
	
	eventInfo = { 
		id 								= id, 
		name 							= events[id].name, 
		maxSlots 						= events[id].maxSlots, 
		minSlots 						= events[id].minSlots, 
		warps 							= events[id].warpPoses, 
		text 							= text_, 
		timer 							= timer, 
		dispText 						= text,
		disableWeapons 					= events[id].disableWeapons,
		godmode 						= events[id].useGodmode,
		dim 							= dim,
		vehicleID 						= events[id].warpVehicle,
		allowedVehicleExit 				= events[id].allowedVehicleExit,
		allowLeaveCommand 				= events[id].allowLeaveCommand,
		onlyOnePersonPerWarp 			= events[id].onlyOnePersonPerWarp,
		hiddenHud						= events[id].hideHud or { },
		originalPlayerCount 			= 0,
	}
	
	if ( eventInfo.onlyOnePersonPerWarp ) then
		if ( eventInfo.maxSlots > #eventInfo.warps ) then
			eventInfo.maxSlots = #eventInfo.warps
		end
		eventInfo.usedWarps = { }
	end
	
	
	DummyTimer1 = setTimer ( function ( )
		if ( not isTimer ( eventInfo.timer ) ) then
			killTimer ( DummyTimer1 )
			return
		end
		--textDisplayRemoveText ( eventInfo.text, eventInfo.dispText ) 
		--eventInfo.dispText = textCreateTextItem ( "Event starting in "..math.floor(getTimerDetails(eventInfo.timer)/1000).." seconds...", 0.98, 0.98, "hight", 0, 255, 255, 255, 2, "right", "bottom", 2 ) 
		--textDisplayAddText ( eventInfo.text, eventInfo.dispText )
		textItemSetText ( eventInfo.dispText, "*Evento iniciando em: "..math.floor(getTimerDetails(eventInfo.timer)/1000) )
	end, 1000, 0 )
	
	playersInEvent = { }
	eventObjects = {
		playerItems = { }
	}
	outputChatBox ( " ", root, 255, 255, 255, true )
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Evento: #4aabd0"..tostring(events[id].name)..".", root, 255, 255, 255, true )
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffff #4aabd0/goevento #ffffffpara participar.", root, 255, 255, 255, true )
	outputChatBox ( " ", root, 255, 255, 255, true )
	addCommandHandler ( "goevento", EventCore.PlayerJoinEventCommand )
	triggerEvent ( "VDBGEvents:onEventCreated", resourceRoot, eventInfo )
end

function EventCore.PlayerJoinEventCommand ( p )
	if ( playersInEvent [ p ] ) then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Você já está no evento", p,255, 255, 255, true )
	end
	
	local rSlots = eventInfo.maxSlots-table.len(playersInEvent)
	if ( getElementData ( p, "VDBGPolice:JailTime" ) ) then 
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê não pode participar de um evento enquanto estava na prisão", p, 255, 255, 255, true )
		end
	if ( isPedInVehicle ( p ) ) then 
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Saia do seu veículo primeiro.", p,255, 255, 255, true )
		end
	if ( getPlayerWantedLevel ( p ) > 0 and EventCore.GetDistanceToNearestCop ( p ) <= 170 ) then 
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Jogadores com níveis de procurado elevado não podem participar do evento.", p,255, 255, 255, true ) 
		end
	if ( getElementInterior ( p ) ~= 0 ) then 
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Por favor, vá para fora deste interior para participar do evento", p,255, 255, 255, true ) 
		end
	if ( rSlots <= 0 ) then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Lamentamos, este evento está cheio, você precisa ser mais rápido!", p, 255, 255, 255, true )
		end
	local px, py, pz = getElementPosition ( p )
	playersInEvent[p] = { 
		int = getElementInterior ( p ),
		dim = getElementDimension ( p ),
		x=px,
		y=py,
		z=pz,
		health = getElementHealth ( p ),
		weapons = { }
	}
	
	eventInfo.originalPlayerCount = table.len ( playersInEvent )
	
	for i=1,12 do
		table.insert ( playersInEvent [ p ].weapons, { getPedWeapon ( p, i ), getPedTotalAmmo ( p, i ) } )
	end
	--takeAllWeapons ( p )

	if ( rSlots > 0 ) then outputChatBox ( "#d9534f[VDBG.ORG] #ffffff "..getPlayerName(p).." juntou-se ao evento. Existem #4aabd0"..rSlots.."#ffffff vagas.", root, 255, 255, 255, true )
	else outputChatBox ( "#d9534f[VDBG.ORG] #ffffff #4aabd0"..getPlayerName(p).."#ffffff foi o último a se juntar ao evento. ", root, 255, 255, 255, true ) end
	
	local warps = eventInfo.warps
	local x, y, z, r = unpack ( warps [ math.random ( table.len ( warps ) ) ] )
	if ( eventInfo.onlyOnePersonPerWarp ) then
		while ( eventInfo.usedWarps[table.concat({x,y,z},",")] ) do
			x, y, z, r = unpack ( warps [ math.random ( table.len ( warps ) ) ] )
		end
	end
	
	setElementInterior ( p, 0 )
	setElementDimension ( p, eventInfo.dim )
	
	local x = x + ( math.random ( -0.7, 0.7 ) )
	local y = y + ( math.random ( -0.7, 0.7 ) )
	setElementPosition ( p, x, y, z + 0.3 )
	if ( not isPedInVehicle ( p ) ) then
		setPedRotation ( p, r )
	else
		setPedRotation ( getPedOccupiedVehicle ( p ), r )
	end
	setElementAlpha ( p, 200 )
	textDisplayAddObserver ( eventInfo.text, p )
	setElementData ( p, "isGodmodeEnabled", true )
	toggleControl ( p, "fire", false )
	toggleControl ( p, "next_weapon", false )
	toggleControl ( p, "previous_weapon", false )
	toggleControl ( p, "forwards", false )
	toggleControl ( p, "backwards", false )
	toggleControl ( p, "left", false )
	toggleControl ( p, "right", false )
	setPedWeaponSlot ( p, 0 )
	setElementData ( p, "VDBGEvents:IsPlayerInEvent", true )
	addEventHandler ( "onPlayerWasted", p, EventCore.RemovePlayerByWasted )
	triggerEvent ( "VDBGEvents:onPlayerJoinEvent", p )
	
	
	if ( eventInfo.vehicleID ) then
		eventObjects.playerItems[p] = createVehicle ( eventInfo.vehicleID, x, y, z, 0, 0, r )
		setElementData ( eventObjects.playerItems[p], "VOwner", p )
		setElementDimension ( eventObjects.playerItems[p], eventInfo.dim )
		warpPedIntoVehicle ( p, eventObjects.playerItems[p] )
		setVehicleDamageProof(getPedOccupiedVehicle( p ),true)
		setCameraTarget ( p, p ) 
		toggleControl ( p, "vehicle_fire", false )
		toggleControl ( p, "vehicle_secondary_fire", false )
		toggleControl ( p, "vehicle_left", false )
		toggleControl ( p, "vehicle_right", false )
		toggleControl ( p, "vehicle_right", false )
		toggleControl ( p, "vehicle_forward", false )
		toggleControl ( p, "vehicle_backward", false )
		toggleControl ( p, "accelerate", false )
		toggleControl ( p, "brake_reverse", false )
		setElementFrozen ( eventObjects.playerItems[p], true )
		if ( not eventInfo.allowedVehicleExit ) then
			addEventHandler ( "onVehicleStartExit", eventObjects.playerItems[p], function ( p )
				cancelEvent ( )
			end )
		end
	end
end

function EventCore.GetDistanceToNearestCop ( p )
	if ( p and isElement ( p ) ) then
		local dist = 9999999
		local x, y, z = getElementPosition ( p )
		for i, v in pairs ( getElementsByType ( 'player' ) ) do
			local t = getPlayerTeam ( v )
			if t then
				local n = getTeamName ( t )
				if ( exports.VDBGPlayerFunctions:isTeamLaw ( n ) ) then
					local px, py, pz = getElementPosition ( v )
					local d = getDistanceBetweenPoints3D ( x, y, z, px, py, pz )
					if ( d < dist ) then
						dist = d
					end
				end
			end
		end
		return dist
	end
	return false
end


function EventCore.BeginTheEvent ( )
	if ( isTimer ( DummyTimer1 ) ) then
		killTimer ( DummyTimer1 )
	end
	removeCommandHandler ( "joinevent", _G['EventCore.PlayerJoinEventCommand'] )
	
	if ( not eventInfo ) then
		return
	end
	
	textDestroyDisplay ( eventInfo.text )
	eventInfo.text = nil
	
	if ( #EventCore.GetPlayersInEvent ( ) < eventInfo.minSlots ) then
		EventCore.EndEvent ( )
		return outputChatBox ( "#d9534f[VDBG.ORG] #fffffffoi cancelado devido a baixa quantidade de participantes.", root, 255, 255, 255, true )
	end
	
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffff QUE COMECE OS JOGOS", root, 255, 255, 255, true )
	eventStartFunctions [ eventInfo.id ] ( )
	for i, p in pairs ( EventCore.GetPlayersInEvent ( ) ) do
		setElementData ( p, "isGodmodeEnabled", eventInfo.godmode )
		toggleControl ( p, "fire", not eventInfo.disableWeapons )
		toggleControl ( p, "next_weapon", not eventInfo.disableWeapons )
		toggleControl ( p, "previous_weapon", not eventInfo.disableWeapons )
		toggleControl ( p, "forwards", true )
		toggleControl ( p, "backwards", true )
		toggleControl ( p, "left", true )
		toggleControl ( p, "right", true )
		toggleControl ( p, "vehicle_fire", true )
		toggleControl ( p, "vehicle_secondary_fire", true )
		toggleControl ( p, "vehicle_left", true )
		toggleControl ( p, "vehicle_right", true )
		toggleControl ( p, "vehicle_right", true )
		toggleControl ( p, "vehicle_forward", true )
		toggleControl ( p, "vehicle_backward", true )
		toggleControl ( p, "accelerate", true )
		toggleControl ( p, "brake_reverse", true )
		setElementAlpha ( p, 255 )
		if ( isElement ( eventObjects.playerItems[p] ) ) then
			setElementFrozen ( eventObjects.playerItems[p], false )
		end
	end
	triggerEvent ( "VDBGEvents:onEventStarted", resourceRoot )
	setTimer ( function ( ) 
		for i, v in pairs ( EventCore.GetPlayersInEvent ( ) ) do
			if ( getElementAlpha ( v ) == 200  ) then
				outputChatBox ( "#d9534f[VDBG.ORG] #ffffff bug no evento foi detectado, evento cancelado.", root, 255, 255, 255, true )
				EventCore.EndEvent ( )
				break
			end
		end
	end, 800, 1 )
	
end

function table.len ( tb )
	local c = 0
	for i, v in pairs ( tb ) do
		c = c + 1
	end
	return c
end

addEventHandler ( "onResourceStop", resourceRoot, function ( )
	if ( eventInfo ) then
		for i, v in pairs ( playersInEvent ) do
			if ( isElement ( i ) ) then
				outputChatBox("#d9534f[VDBG.ORG] #ffffff Desculpe a morte inesperada. O recurso de eventos foi interrompido durante a sua execução.", i, 255, 255, 255, true )
			end
		end
	end
end )


function EventCore.GetPlayersInEvent ( )
	local c = { }
	for i, v in pairs ( playersInEvent ) do
		if ( isElement ( i ) ) then
			table.insert ( c, i )
		else
			playersInEvent[i] = nil
		end
	end
	return c
end

function EventCore.RemovePlayerByWasted ( )
	EventCore.RemovePlayerFromEvent ( source, false )
	outputChatBox ( "#d9534f[VDBG.ORG] #4aabd0"..getPlayerName ( source ).." #fffffffoi morto no evento!", root,255, 255, 255, true )
end

function EventCore.EndEvent ( )
	for i, v in ipairs ( EventCore.GetPlayersInEvent ( ) ) do
		EventCore.RemovePlayerFromEvent ( v, true )
	end
	
	setTimer ( function ( ) 
		if ( isTimer ( DummyTimer1 ) ) then
			killTimer ( DummyTimer1 )
		end if ( eventInfo and eventInfo.text ) then
			textDestroyDisplay ( eventInfo.text )
		end
		removeCommandHandler ( "joinevent", _G['EventCore.PlayerJoinEventCommand'] )
		triggerEvent ( "VDBGEvents:onEventEnded", resourceRoot, eventInfo )
		playersInEvent = nil
		eventInfo = nil
	end, 700, 1 )
end

function EventCore.RemovePlayerFromEvent ( p, reset )
	if ( not playersInEvent [ p ] ) then
		return false
	end
	removeEventHandler ( "onPlayerWasted", p, EventCore.RemovePlayerByWasted )
	toggleControl ( p, "fire", true )
	toggleControl ( p, "next_weapon", true )
	toggleControl ( p, "previous_weapon", true )
	setElementData ( p, "isGodmodeEnabled", false )
	toggleControl ( p, "forwards", true )
	toggleControl ( p, "backwards", true )
	toggleControl ( p, "left", true )
	toggleControl ( p, "right", true )
	toggleControl ( p, "vehicle_fire", true )
	toggleControl ( p, "vehicle_secondary_fire", true )
	toggleControl ( p, "vehicle_left", true )
	toggleControl ( p, "vehicle_right", true )
	toggleControl ( p, "vehicle_right", true )
	toggleControl ( p, "vehicle_forward", true )
	toggleControl ( p, "vehicle_backward", true )
	toggleControl ( p, "accelerate", true )
	toggleControl ( p, "brake_reverse", true )
	setElementAlpha ( p, 255 )
	setElementDimension ( p, 0 )
	setElementData ( p, "VDBGEvents:IsPlayerInEvent", false )
	if ( isElement ( eventObjects.playerItems[p] ) ) then
		destroyElement ( eventObjects.playerItems[p] )
		eventObjects.playerItems[p] = nil
	end

	if reset then
		setTimer ( function ( p, pData )
			local x, y, z = tonumber ( pData.x ), tonumber ( pData.y ), tonumber ( pData.z )
		--	takeAllWeapons ( p )
			setElementInterior ( p, pData.int )
			setElementDimension ( p, pData.dim )
			setElementPosition ( p, x, y, z + 0.5 )
			setCameraTarget ( p, p )
			setElementHealth ( p, pData.health )
			
			
			for i, v in pairs ( pData.weapons ) do
				giveWeapon ( p, v [ 1 ], v [ 2 ] )
			end
			
		end, 500, 1, p, playersInEvent [ p ] )
	else
		killPed ( p )
	end
	
	triggerEvent ( "VDBGEvents:onPlayerRemovedFromEvent", p )
	playersInEvent[p] = nil
	
	local c = EventCore.GetPlayersInEvent ( )
	if ( #c == 0 ) then
		EventCore.EndEvent ( );
	elseif( #c == 1 ) then
		for i, v in pairs ( c ) do
			EventCore.WinPlayerEvent ( i )
			break
		end
	end
	
end

function isPlayerInEvent ( p )
	if playersInEvent [ p ] then
		return true
	else
		return false
	end
end

function getEventInfo ( )
	return eventInfo
end

function EventCore.WinPlayerEvent ( p )
	if ( isElement ( p ) ) then
		local a = math.random ( 500, 800 ) * eventInfo.originalPlayerCount
		outputChatBox ( "#d9534f[VDBG.ORG] #ffffff "..getPlayerName(p).." ganhou R$"..a..".00 por ganhar o evento "..eventInfo.name.."!", root, 255, 255, 255, true )
		givePlayerMoney ( p, a )
		EventCore.EndEvent( )
		return true
	end
	return false
end




function isPlayerInACL ( player, acl )
	local account = getPlayerAccount ( player )
	if ( isGuestAccount ( account ) ) then
		return false
	end
        return isObjectInACLGroup ( "user."..getAccountName ( account ), aclGetGroup ( acl ) )
end

addCommandHandler ( "criarevento", function ( p, cmd, id )
	if ( isPlayerInACL ( p, 'Admin' ) ) then
		if ( not tonumber ( id ) ) then
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffUse: /"..cmd.." [#FFA500ID: #4aabd0(1 à"..table.len(events)..")#ffffff]", p,255, 255, 255, true )
		end
		local id = tonumber ( id )
		if ( not events [ id ] ) then
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffID invalido. Números de #4aabd01 à "..table.len ( events )..".", p,255, 255, 255, true )
		end
		if ( eventInfo ) then
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffJá existe um evento rolando", p,255, 255, 255, true )
		end
		EventCore.StartEvent ( id )
	end
end )

addCommandHandler ( "pararevento",  function ( p )
	if ( isPlayerInACL ( p, 'Admin' ) ) then
	if ( not eventInfo ) then
		return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffNão há eventos em execução no momento.", p,255, 255, 255, true )
	end
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffffEvento cancelado pelo "..getPlayerName(p)..".", root, 255, 255, 255, true )
	EventCore.EndEvent ( )
	end
end )

addCommandHandler ( "sairevento", function ( p )
	if ( isPlayerInEvent ( p ) ) then
		if ( not eventInfo.allowLeaveCommand ) then
			return outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê não tem permissão para sair deste evento.", p, 255, 255, 255, true )
		end
		EventCore.RemovePlayerFromEvent ( p, true )
		outputChatBox ( "*#d9534f[VDBG.ORG] #ffffff "..getPlayerName(p).." saiu do evento", root,255, 255, 255, true )
	else
		outputChatBox ( "#d9534f[VDBG.ORG] #ffffffVocê não está em um evento", p, 255, 255, 255, true )
	end
end )

addCommandHandler ( "eventos", function ( p )
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffff == / AJUDA / == ", p, 255, 255, 255, true )
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Entrar no evento: #4aabd0 /evento", p, 255, 255, 255, true )
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Sair do evento: #4aabd0 /sairevento", p, 255, 255, 255, true )
	if ( isPlayerInACL ( p, 'Admin' ) ) then
		outputChatBox ( "#d9534f[ADMIN] #ffffff == / STATUS / == ", p, 255, 255, 255, true )
		outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Criar evento: #4aabd0 /criarevento", p, 255, 255, 255, true )
		for i, v in pairs ( events ) do
			outputChatBox ( "        "..tostring ( i ).." -> "..tostring ( v.name ), p, 255, 255, 255, true )
		end
		outputChatBox ( "#d9534f[VDBG.ORG] #ffffff Parar evento: #4aabd0 /pararevento.", p, 255, 255, 255, true )
	end
	outputChatBox ( "#d9534f[VDBG.ORG] #ffffff == / AJUDA / == ", p, 255, 255, 255, true )
end )


addEvent ( "VDBGEvents:onEventCreated", true )
addEvent ( "VDBGEvents:onPlayerJoinEvent", true )
addEvent ( "VDBGEvents:onEventStarted", true )
addEvent ( "VDBGEvents:onEventEnded", true )
addEvent ( "VDBGEvents:onPlayerRemovedFromEvent", true )







local lastRanEvent = nil
setTimer ( function ( )
	local id = math.random ( table.len ( events ) )
	while ( lastRanEvent == id or ( not events [ id ] ) ) do
		id = math.random ( table.len ( events ) )
	end
	
	EventCore.StartEvent ( id )
end, 750000, 0 )