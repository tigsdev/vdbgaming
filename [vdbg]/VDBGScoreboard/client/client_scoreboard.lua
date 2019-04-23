
-- All settings
local scoreboardTitle = "VDBGaming - MTA 1.5" -- The title of the scoreboard
local SCOREBOARD_WIDTH	= 980 -- The scoreboard window width
local SCOREBOARD_HEIGHT	= 560 -- The scoreboard window height
local SCOREBOARD_HEADER_HEIGHT = 22 -- Height for the header in what you can see the server info
local SCOREBOARD_TOGGLE_CONTROL = "tab" -- Control/Key to toggle the scoreboard visibility
-- Controls that are disabled when the scoreboard is showing
local SCOREBOARD_DISABLED_CONTROLS = { "next_weapon", "previous_weapon", "aim_weapon", "radio_next", "radio_previous" }
local drawOverGUI = false -- Set to true if it must be drawn over the GUI
local SCOREBOARD_PLAYERCOUNT_COLOR	= { 190,190,190, 230 } -- RGBA color for the server player count text
local SCOREBOARD_BACKGROUND = { 0,0,0, 140} -- RGBA color for the background
local SCOREBOARD_FOREGROUND = { 0,0,0, 210} -- RGBA color for the foreground
local SCOREBOARD_SEPARATOR_COLOR = { 90, 90, 90, 140 } -- RGBA color for the separator line between headers and body content
local SCOREBOARD_ROW_GAP = 3 -- Gap between rows
local MAX_PRIRORITY_SLOT = 100
--
local SCOREBOARD_PGUP_CONTROL		= "mouse_wheel_up"	-- Control/Key to move one page up
local SCOREBOARD_PGDN_CONTROL		= "mouse_wheel_down"-- Control/Key to move one page down

-- Scoreboard colors
SCOREBOARD_PLAYERCOUNT_COLOR = tocolor ( unpack ( SCOREBOARD_PLAYERCOUNT_COLOR ) )
SCOREBOARD_BACKGROUND = tocolor ( unpack ( SCOREBOARD_BACKGROUND ) )
SCOREBOARD_FOREGROUND = tocolor ( unpack ( SCOREBOARD_FOREGROUND ) )
SCOREBOARD_SEPARATOR_COLOR = tocolor ( unpack ( SCOREBOARD_SEPARATOR_COLOR ) )
local infoColumnColor = tocolor(230, 230, 230)

local arialSmall = dxCreateFont("fonts/arialbd.ttf", 8, true)
local arial = dxCreateFont("fonts/arialbd.ttf", 12, true)
local textLength = { dxGetTextWidth(scoreboardTitle,2,"default-bold"), dxGetFontHeight(2,"default-bold") }
local scoreboardRTHeight = SCOREBOARD_HEIGHT - (textLength[2] + 10 + 8)
local scoreRT = dxCreateRenderTarget( SCOREBOARD_WIDTH, scoreboardRTHeight, true )
local rtw,rth = dxGetMaterialSize(scoreRT)
local g_isShowing = false		-- Marks if the scoreboard is showing
local g_scoreboardDummy			-- Will contain the scoreboard dummy element to gather info from.
local sx,sy = guiGetScreenSize()
local g_oldControlStates		-- To save the old control states before disabling them for scrolling
local scoreboardToggleTick = 0

local SCOREBOARD_X = math.floor( ( sx - SCOREBOARD_WIDTH ) / 2 )
local SCOREBOARD_Y = math.floor( ( sy - (SCOREBOARD_HEIGHT + 44) ) / 2 )
local scoreboard = {}
local scrollValue = 15
local scoreboardTotalSize = 0

scoreboard.doScrollPage = false
scoreboard.scrollPos = 0
scoreboard.size = 0

local bottomInfo = "Todos os direitos reservados - www.vdbg.org"
local teamColumnHeight = 25
local teamsPriority = { "Administração", "Criminoso", "Policial", "Civilizante", "Emergencia", "Desempregado", "Convidado" }

-- Default scoreboard columns
local columns = {
	{ name="ID", width=28, priority=1, boundingBox={ 12 } },
	{ name="Nome", width=143, priority=2 },
	{ name="Emprego", width=120, priority=3 },
	{ name="Cargo", width=100, priority=4 },
	{ name="Equipe", width=80, priority=5 },
	{ name="Classe", width=90, priority=6 },
	{ name="Premium", width=90, priority=7 },
	{ name="Dinheiro", width=76, priority=8 },
	{ name="Jogando", width=76, priority=9 },
	{ name="FPS", width=42, priority=10 },
	{ name="Ping", width=35, priority=11 }
}

for i, rowt in ipairs(columns) do
	if (i == 1) then
		rowt.boundingBox[2] = 12 + rowt.width
	else
		local right = columns[i - 1].boundingBox[2]
		rowt.boundingBox = { right, right + rowt.width }
	end
end

local top = 0
local isEventHandled = false

bindKey( SCOREBOARD_TOGGLE_CONTROL, "both",
	function(key, state)
	
	if(getElementData(getLocalPlayer(), "logado") == false ) then return end
	if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
		if not g_scoreboardDummy then
			local elementTable = getElementsByType ( "scoreboard" )
			if #elementTable > 0 then
				g_scoreboardDummy = elementTable[1]
			else
				return
			end
		end
		
		if state == "down" then
			if ( (getTickCount() - scoreboardToggleTick) > 200 ) then			
				addEventHandler("onClientRender", root, drawScoreboard)
				setElementData(localPlayer,"opendashboard", true)
				g_isShowing = true
				g_oldControlStates = {}
				for k, control in ipairs ( SCOREBOARD_DISABLED_CONTROLS ) do
					g_oldControlStates[k] = isControlEnabled ( control )
					toggleControl ( control, false )
				end
			end
		elseif state == "up" then
			if g_isShowing then
				removeEventHandler("onClientRender", root, drawScoreboard)
				setElementData(localPlayer,"opendashboard", false)
				scoreboardToggleTick = getTickCount()
				g_isShowing = false		
				for k, control in ipairs ( SCOREBOARD_DISABLED_CONTROLS ) do
					toggleControl ( control, g_oldControlStates[k] )
				end
				g_oldControlStates = nil
			end
		end
	end
)

local function drawRowBounded( player, colors, font, top, type )
	local bottom = top + dxGetFontHeight ( 1, font )
	for i,value in ipairs(columns) do
		local text = (type == "info") and value.name
			or (getPlayerData(player, value.name) or (getElementData(player, value.name) or ""))
			
		local left = value.boundingBox[1]
		local right = value.boundingBox[2]
		local color = (value.name == "Nome") and tocolor(colors[1], colors[2], colors[3]) or infoColumnColor
		drawShadowText( text, left+25, top, right+25, bottom, color, 1, font, "left", "top", true, false, drawOverGUI, false, true )
	end
	if player then
	local avatarID = getElementData(player, "avatar")
	if avatarID then
	dxDrawImage ( 13, top-3, 20, 20, ":VDBGPDU/avatares/"..avatarID..".png", 0, 0, 0, tocolor(255,255,255,255))
	end
	end
end

local function drawTeamColumn(posy, name, memberCount, colors)
	local x, y, width, height = 0, posy, SCOREBOARD_WIDTH, teamColumnHeight
	local playersStr = (tonumber(memberCount) > 1) and "Jogadores" or "Jogador"
	local offset = 13
	dxDrawRectangle(x, y, width, height, tocolor(0,0,0), drawOverGUI)
	
	-- Team name
	drawShadowText(name, x + offset, y, (x + offset) + width, height + y,
		tocolor(colors[1],colors[2],colors[3]), 1.3, "arial", "left", "center",
		true, false, drawOverGUI, false, true)
	-- Team member count
	local membersLength = dxGetTextWidth( memberCount.." "..playersStr,1,"default-bold" )
	drawShadowText(memberCount.." "..playersStr, (x + width) - (membersLength + offset), y, x + width, y + height,
		tocolor(190,190,190), 1, "default-bold", "left", "center",
		true, false, drawOverGUI, false, true)
end

local renderEntry = function ( player, top )
	local colors = { getPlayerNametagColor( player ) }

	-- Render it!
	drawRowBounded( player, colors, "default-bold", top + 10 )
end

function getPlayerData(player, data)
	local scoreboardValues = {
		["ID"] = tostring(getElementData( player, "id" ) or "0"),
		["Nome"] = tostring(getPlayerName( player )):gsub( "_", " " ),
		["Emprego"] = tostring(getElementData( player, "Job" ) or "Nenhum" ),
		["Cargo"] = tostring(getElementData( player, "Job Rank" ) or "Nenhum " ),
		["Equipe"] = tostring(getElementData( player, "Group" ) or "Nenhum" ),
		["Classe"] = tostring(getElementData( player, "Group Rank" ) or "Nenhum " ),
		["Dinheiro"] = tostring(getElementData( player, "Money" ) or "0" ),
		["Premium"] = tostring(getElementData( player, "VIP" ) or "Nenhum"),
		["Jogando"] = tostring(getElementData( player, "Playtime" ) or "0H:0M"),
		["FPS"] = tostring(getElementData( player, "FPS" ) or "0"),
		["Ping"] = tostring(math.ceil(getPlayerPing( player ) /1.3))
	}
	return scoreboardValues[tostring(data)] or false
end

local function isServerTeam(v)
	for _,teamName in pairs(teamsPriority) do
		if teamName == v then
			return true
		end
	end
	return false
end

function getServerTeams()
	local teams = {}
	for _,team in ipairs( getElementsByType("team") ) do
		if not isServerTeam( getTeamName(team) ) then
			teams[ #teams + 1 ] = team
		end
	end
	return teams
end

function getNoPlayerTeams()
	local teams = {}
	for _,team in ipairs( getServerTeams() ) do
		if countPlayersInTeam(team) < 1 then
			teams[ #teams + 1 ] = team
		end
	end
	return teams
end

function getPlayersWithoutTeam()
	local players = {}
	for i,player in ipairs( getElementsByType("player") ) do
		if not getPlayerTeam(player) then
			players[ #players + 1 ] = player
		end
	end
	return players
end

local function onScrollKey( key, keyState, direction )
	if g_isShowing then
		if (keyState == "down") and isEventHandled == false then
			if ( direction and (top < 0) )
			 or ( direction==false ) and (scoreboard.size > scoreboardRTHeight) then
				scoreboard.doScrollPage = direction and "Down" or "UP"
				scoreboard.tickStart = getTickCount()
				addEventHandler("onClientRender", root, renderInterpolation)
				scoreboard.scrollPos = top
				isEventHandled = true
			end
		end
	end
end
bindKey( SCOREBOARD_PGUP_CONTROL, "both", function (key, keyState) onScrollKey(key, keyState, false)  end )
bindKey( SCOREBOARD_PGDN_CONTROL, "both", function (key, keyState) onScrollKey(key, keyState, true)  end )

function stopScrolling()
	removeEventHandler("onClientRender", root, renderInterpolation)
	isEventHandled = false
	scoreboard.tickStart = nil
	scoreboard.doScrollPage = false
	scoreboard.scrollPos = top
end

function renderInterpolation()
	local tick = getTickCount() - scoreboard.tickStart
	local time = 200
	local progress = tick/time
	if scoreboard.doScrollPage == "Down" then
		local scrollDownValue = top + scrollValue
		if scrollDownValue > 0 then
			scrollDownValue = 0
		end
		top = interpolateBetween(scoreboard.scrollPos,0,0, scrollDownValue,0,0,progress,"Linear")
	else
		local scrollUPValue = scoreboard.scrollPos - scrollValue
		if scoreboard.size - scrollValue < scoreboardRTHeight then
			local endv = (scoreboardTotalSize + scoreboard.scrollPos) - scoreboardRTHeight
			scrollUPValue = scoreboard.scrollPos - endv
		end
		top = interpolateBetween(scoreboard.scrollPos,0,0, scrollUPValue,0,0,progress,"Linear")
	end
	if (tick > time) then
		stopScrolling()
	end
end

function renderContent()
	local rowHeight = dxGetFontHeight( 1, "default-bold" )
	local curTop = top
	
	dxSetRenderTarget(scoreRT, true)
	
	for i,teamName in ipairs(teamsPriority) do
		drawTeamColumn( curTop, teamName, tostring( countPlayersInTeam(getTeamFromName(teamName)) ),
				{ getTeamColor( getTeamFromName(teamName) ) } )
		curTop = curTop + teamColumnHeight
		
		if countPlayersInTeam(getTeamFromName(teamName)) > 0 then
			drawRowBounded( false, {230, 230, 230}, "default-bold", curTop + 4, "info" )
			curTop = curTop + rowHeight + 8
		
			dxDrawLine( 13, curTop + 3, ( SCOREBOARD_WIDTH) - 13, curTop + 3, tocolor(90,90,90), 2, drawOverGUI )
			for i,player in ipairs( getPlayersInTeam(getTeamFromName(teamName)) ) do	
				renderEntry( player, curTop )
				curTop = curTop + (rowHeight + SCOREBOARD_ROW_GAP)
			end
			curTop = curTop + 10
		end
	end
	for i,team in ipairs( getServerTeams() ) do
		if countPlayersInTeam(team) > 0 then
			drawTeamColumn( curTop, getTeamName(team), tostring( countPlayersInTeam(team) ),
					{ getTeamColor( team ) } )
			curTop = curTop + teamColumnHeight
		
			drawRowBounded( false, {230, 230, 230}, "default-bold", curTop + 4, "info" )
			curTop = curTop + rowHeight + 8
			
			dxDrawLine( 13, curTop + 3, (SCOREBOARD_WIDTH) - 13, curTop + 3, tocolor(90,90,90), 2, drawOverGUI )
			
			for i,player in ipairs(getPlayersInTeam(team)) do
				renderEntry( player, curTop )
				curTop = curTop + (rowHeight + SCOREBOARD_ROW_GAP)
			end
			curTop = curTop + 10
		end
	end
	
	for i,team in ipairs( getNoPlayerTeams() ) do
		drawTeamColumn( curTop, getTeamName(team), tostring( countPlayersInTeam(team) ),
				{ getTeamColor( team ) } )
		curTop = curTop + teamColumnHeight
	end
	
	if #getPlayersWithoutTeam() > 0 then
		drawRowBounded( false, {230, 230, 230}, "default-bold", curTop + 4, "info" )
		curTop = curTop + rowHeight + 8
	
		dxDrawLine( 13, curTop + 3, (SCOREBOARD_WIDTH) - 13, curTop + 3, tocolor(90,90,90), 2, drawOverGUI )
	end
	for i,player in ipairs( getPlayersWithoutTeam() ) do
		renderEntry( player, curTop )
		curTop = curTop + (rowHeight + SCOREBOARD_ROW_GAP)
	end
	if #getPlayersWithoutTeam() > 0 then
		curTop = curTop + 10
	end
	dxSetRenderTarget()
	dxDrawImage(SCOREBOARD_X, SCOREBOARD_Y + ( textLength[2] + 10 + 8 ), rtw, rth, scoreRT, 0,0,0,tocolor(255,255,255,190))
	scoreboard.size = curTop
	scoreboardTotalSize = curTop - top
end

-- Scoreboard functions
function getNextFreePrioritySlot( startAt )
	startAt = tonumber( startAt ) or 1
	local priorities = {}
	for key, value in ipairs(columns) do
		priorities[tonumber(value.priority)] = true
	end
	local freePriority = startAt
	while ( priorities[freePriority] ) do
		freePriority = freePriority + 1
	end
	return freePriority
end

function isPrioritySlotFree( slot )
	if type( slot ) == "number" then
		if not (slot > MAX_PRIRORITY_SLOT or slot < 1) then
			local priorities = {}
			for key, value in ipairs(columns) do
				priorities[tonumber(value.priority)] = true
			end
			return not priorities[slot]
		end
	end
	return false
end

function fixPrioritySlot( slot )
	local priorities = {}
	for key, value in ipairs(columns) do
		priorities[tonumber(value.priority)] = key
	end
	if priorities[slot] then
		local freeSlot = getNextFreePrioritySlot( slot )
		if freeSlot ~= slot then
			for i=freeSlot-1, slot, -1 do
				local key = priorities[i]
				if key then
					columns[key].priority = columns[key].priority + 1
				end
			end
		end
	end
end

function scoreboardGetColumnPriority( name )
	if type(name) == "string" then
		for key, value in ipairs(columns) do
			if name == value.name then
				return value.priority
			end
		end
	end
	return false
end

function scoreboardGetColumnIDByPriority( slot )
	if type(slot) == "number" then
		for key, value in ipairs(columns) do
			if value.priority == slot then
				return key
			end
		end
		return false
	end
	return false
end

function scoreboardAddColumn(columnName, columnWidth, prioritySlot)
	if not type(name) == "string" then return false end;
	
	columnWidth = tonumber(columnWidth) or 70
	prioritySlot = tonumber(prioritySlot) or getNextFreePrioritySlot( scoreboardGetColumnPriority( "Nome" ) )
	fixPrioritySlot( prioritySlot )
	
	if not (prioritySlot > MAX_PRIRORITY_SLOT or prioritySlot < 1) then
		for key, value in ipairs(columns) do
			if columnName == value.name then
				return false
			end
		end
		
		columns[ #columns + 1 ] = {
				["name"] = columnName,
				["width"] = columnWidth,
				["priority"] = prioritySlot
		}
		table.sort( columns, function ( a, b ) return a.priority < b.priority end )
		
		local id = scoreboardGetColumnIDByPriority( prioritySlot )
		local prevColumnRight
		if id - 1 > 0 then
			prevColumnRight = columns[ id - 1 ].boundingBox[2]
		else
			prevColumnRight = 12
		end
		columns[ id ].boundingBox = { prevColumnRight, prevColumnRight + columnWidth }
		
		-- update columns bounding box
		if (id + 1) <= #columns then
			for i = (id + 1), #columns do
				local prevcolumn = i - 1
				local prevRight = columns[ prevcolumn ].boundingBox[2]
				local width = columns[i].width
				columns[i].boundingBox = { prevRight, prevRight + width  }
			end
		end
		return true
	end
	return false
end
addEvent( "DNLScoreboard:scoreboardAddColumn", true )
addEventHandler( "DNLScoreboard:scoreboardAddColumn", root, scoreboardAddColumn )

function drawScoreboard()
	drawBackground()
	
	local maxPlayers = tonumber(getElementData( g_scoreboardDummy, "maxPlayers" )) or 0
	
	-- Calculate the bounding box for the header texts
	local left, top, right, bottom = SCOREBOARD_X + 16, SCOREBOARD_Y + 8, SCOREBOARD_X + SCOREBOARD_WIDTH - 2, SCOREBOARD_Y + SCOREBOARD_HEADER_HEIGHT - 2
	
	drawShadowText( scoreboardTitle, left, top, textLength[1] + left, textLength[2] + top,
				 tocolor(240,240,240,240), 2, "default-bold", "left", "top",
				 true, false, drawOverGUI, true )
	
	--local usagePercent = (#g_players / maxPlayers) * 100
	local strPlayerCount = "Jogadores online: " .. tostring(#getElementsByType("player")) .. " / " .. tostring(maxPlayers) .. ""
	
	-- Make sure of that it needs to be rendered now
	local pCountLength = { dxGetTextWidth(strPlayerCount,1,arialSmall), dxGetFontHeight(1,arialSmall) }
	local playerCountX = (SCOREBOARD_X + SCOREBOARD_WIDTH) - (pCountLength[1] + 8)
	local playerCountY = (SCOREBOARD_Y + 9)
	drawShadowText( strPlayerCount, playerCountX, playerCountY, playerCountX + pCountLength[1], playerCountY + pCountLength[2],
					SCOREBOARD_PLAYERCOUNT_COLOR, 1, arialSmall, "left", "top",
					true, false, drawOverGUI )
	
	-- Update the bounding box.
	left, top, bottom = SCOREBOARD_X, SCOREBOARD_Y + (textLength[2] + 10), SCOREBOARD_Y + SCOREBOARD_HEIGHT - 2
	
	-- Draw the separator
	dxDrawLine( SCOREBOARD_X + 5, top, (SCOREBOARD_X + SCOREBOARD_WIDTH) - 5, top, SCOREBOARD_SEPARATOR_COLOR, 2, drawOverGUI )
	
	renderContent()
end

function drawBackground()
	dxDrawBackgroundRectangle( SCOREBOARD_X, SCOREBOARD_Y,
								SCOREBOARD_WIDTH, SCOREBOARD_HEIGHT,
								SCOREBOARD_BACKGROUND, SCOREBOARD_FOREGROUND, drawOverGUI )
	drawShadowText( bottomInfo, SCOREBOARD_X, SCOREBOARD_Y + SCOREBOARD_HEIGHT,
					SCOREBOARD_X + SCOREBOARD_WIDTH, (SCOREBOARD_Y + SCOREBOARD_HEIGHT) + 35,
					tocolor(240,240,240,240), 1.4, "default-bold", "center", "center",
					true, false, drawOverGUI, true )
end

function dxDrawBackgroundRectangle( startX,startY,width,height,color,foregroundColor,postGUI )
	-- Main rectangle
	dxDrawRectangle(startX, startY, width, height, color, postGUI)
	-- Border rectangles
	dxDrawRectangle(startX-4, startY, 4, height, foregroundColor, postGUI)
	dxDrawRectangle(startX+width, startY, 4, height, foregroundColor, postGUI)
	dxDrawRectangle(startX-4, startY-4, width+8, 4, foregroundColor, postGUI)
	dxDrawRectangle(startX-4, startY+height, width+8, 35, foregroundColor, postGUI)
end

function getColorAlpha(color)
   return bitExtract(color,24,8)
end

function drawShadowText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning)
	dxDrawText(text, left + 1, top + 1, right + 1, bottom + 1, tocolor(0, 0, 0, getColorAlpha(color)), scale, font, alignX, alignY, clip, wordBreak, postGUI, false, subPixelPositioning)
	dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning)
end

