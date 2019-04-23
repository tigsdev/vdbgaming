screenWidth, screenHeight = guiGetScreenSize()
windowWidth, windowHeight = 512, 512
left = (screenWidth/2) - (windowWidth/2)
local font = dxCreateFont ("arquivos/font.ttf",11)
top = (screenHeight/2) - (windowHeight/2)
local sx,sy = guiGetScreenSize()
local rX, rY = sx/2+232/2, sy/2-82/2
local sw,sy= {guiGetScreenSize()}



 
RTPool = {}
RTPool.list = {}



function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end

local old = 1

local tempCol = createColSphere ( -2502.2744140625, -699.0068359375, 288.125, 3000 )



local lefedett = { [1] = true, [3] = true, [10] = true }



setRadioChannel (0)


function isLefedett(id)

	if lefedett[id] then

		return true

	end

	return false

end



radio = 0

lawVehicles = { [431]=true, [416]=true, [433]=true, [427]=true, [490]=true, [528]=true, [407]=true, [544]=true, [523]=true, [470]=true, [598]=true, [596]=true, [597]=true, [599]=true, [432]=true, [601]=true }



local theTimer

local streams = { }

local totalStreams = 12

streams[1] = {"http://streaming.shoutcast.com/RadioHunter-TheHitzChannel", "VDBGaming - DJ @TIGS98"}

streams[2] = {"http://streaming.shoutcast.com/RadioHunter-TheHitzChannel","Hunter FM"}

streams[3] = {"http://64.31.22.124:80", "Brasil Hits"}

streams[4] = {"http://170.75.145.250:17918/APP", "Rádio Funk Brasil"}

streams[5] = {"http://107.161.118.66:16942/", "Elite Do Funk BH"}

streams[6] = {"http://67.205.74.73:9348", "Mandela Digital"}

streams[7] = {"http://172.82.128.10:19342/", "Sound Pop Brasil"}

streams[8] = {"http://206.190.136.212:7556/Live", "Hot Fm 107.1"}

streams[9] = {"http://170.75.144.154:12500", "Rádio Rap na veia"}

streams[10] = {"http://206.190.136.141:4593/Live", "West Coast Rap"}

streams[11] = {"http://170.75.146.178:18660", "Eletro Mix Brasil"}

streams[12] = {"http://148.251.91.15:7004", "Dubstep Fm"}

local soundElement = nil

local soundElementsOutside = { }

local streamID = getElementData(theVehicle, "vehicle:radio") or 0
local streamName = "Rádio Desligada";
local streamTitle = "Rádio Desligada";			
local urlimg = "naobaixar"


function check(thePlayer)

	outputChatBox(getElementData(getLocalPlayer(), "streams"), 255, 0, 0)

end

function setVolume(commandName, val)

	local theVehicle = getPedOccupiedVehicle(getLocalPlayer())

	local hangero = getElementData(theVehicle, "vehicle:radio:volume") or 25
 
	if tonumber(val) then

		if (tonumber(hangero) ~= tonumber(val)) then

			if (tonumber(val) >= 0 and tonumber(val) <= 100) then

				triggerServerEvent("car:radio:vol", getLocalPlayer(), getLocalPlayer(), tonumber(val))

				outputChatBox("#acd373[VDBGaming - Rádio] #FFFFFFO volume agora está em #acd373" .. tonumber(val) .. " #FFFFFF/ #acd373100", 255, 255, 255, true)

				triggerServerEvent("sendLocalMeAction", localPlayer, localPlayer, "Átállítja a rádió hangerejét " .. tonumber(val) .. "%-ra.")

				

				return

			else

				outputChatBox("#d9534f[VDBGaming - Rádio] #FFFFFFSó é possivel por o volume de #acd3730 #FFFFFFa #acd373100 #FFFFFFTente Novamente!", 255, 255, 255, true)

				

				return

			end

		else

			outputChatBox("#d9534f[VDBGaming - Rádio] #FFFFFFO volume já está em #acd373" .. tonumber(hangero) .. "%#FFFFFF , Por favor tente outro #acd373valor#FFFFFF.", 255, 255, 255, true)

			return

		end

	end

	outputChatBox("#d9534f[AVISO]#FFFFFF Valor incorreto! use /vol , e escolha um valor de #acd3730 #FFFFFF a #acd373100#FFFFFF.", 255, 255, 255, true)

	

end

addCommandHandler("vol", setVolume)



local textShowing = false

addEvent( "onClientGotImage", true )
addEventHandler( "onClientGotImage", resourceRoot,
    function( pixels )
        if radiovdbgthmb then
            destroyElement( radiovdbgthmb )
			radiovdbgthmb = nil
        end
        radiovdbgthmb = dxCreateTexture( pixels )
    end
)

function showStation()
if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
	local screenwidth, screenheight = guiGetScreenSize ()

	
	
	local width = 300

	local height = 100

	local x = (screenwidth - width)/2

	local y = screenheight - (screenheight/8 - (height/8)) 

	local theVehicle = getPedOccupiedVehicle(getLocalPlayer())

	local hangero = getElementData(theVehicle, "vehicle:radio:volume") or 25

	if (theVehicle) then

		local streamID = getElementData(theVehicle, "vehicle:radio")


		--dxDrawImage( left, top, 45, 45, "arquivos/bg1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
		
		if tonumber(streamID) ~= 0 then
			streamTitle = "Recebendo Informações";
			if newSoundElement then
			meta = getSoundMetaTags(newSoundElement);
			music = meta.stream_title  or "";
			streamName = streams[tonumber(streamID)][2] or "";
			streamTitle = music or "N/A";			
			urlimg = music
			end
		else

			streamTitle = "Rádio Desligada"

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
            dxDrawImage(rX, rY, 111, 105, "imagens/radioff.png")
		end

		

		if streamID == 12 then
           
			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
             dxDrawImage(rX, rY, 111, 105, "imagens/dubfm.png")
    
		end



		if streamID == 11 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
            dxDrawImage(rX, rY, 111, 105, "imagens/eletromix.png")
		end

		

		if streamID == 10 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
            dxDrawImage(rX, rY, 111, 105, "imagens/westcoast.png")
		end

		

		if streamID == 9 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
            dxDrawImage(rX, rY, 111, 105, "imagens/rapnaveia.png")
		end

		

		if streamID == 8 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )

		dxDrawImage(rX, rY, 111, 105, "imagens/hot107.png")
		end

		

		if streamID == 7 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
            dxDrawImage(rX, rY, 111, 105, "imagens/soundpop.png")
		end

		

		if streamID == 6 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
            dxDrawImage(rX, rY, 111, 105, "imagens/mandela.png")
		end

		

		if streamID == 5 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
             dxDrawImage(rX, rY, 111, 105, "imagens/funkbh.png")
		end

		

		if streamID == 4 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
            dxDrawImage(rX, rY, 111, 105, "imagens/funkbrasil.png")
		end

		

		if streamID == 3 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )

			dxDrawImage(rX, rY, 111, 105, "imagens/brasilhits.png")
		end

		

		if streamID == 2 then

			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
           
			dxDrawImage(rX, rY, 111, 105, "imagens/hunter.png")
		
		end

		
			if streamID == 1 then
			dxDrawImage( left, top, 512, 512, "arquivos/1.png", 0, 0, 0, tocolor( 255, 255, 255, 255 ) )
			if not radiovdbgthmb then
			outputDebugString("foi")
			triggerServerEvent("onClientGetImage", getLocalPlayer(), getLocalPlayer(), urlimg)
			end
			if radiovdbgthmb then
			dxDrawImage(rX, rY, 111, 105, radiovdbgthmb)			
				else
			dxDrawImage(rX, rY, 111, 105, "imagens/vdbg.png")
			end
		end

		
		local textx = left + (windowWidth / 5.2)

		local texty = (top + (windowHeight / 2)) - 30

		
	
		
		--dxDrawText ("Altere o volume: #0078BE/vol\n#FFFFFFVolume Atual: #77b64c" .. tonumber(hangero) .. "#FFFFFF%", textx+175, texty+30, textx, texty, tocolor ( 255, 255, 255, 255 ), 0.8, font, "center", "top", false, false, false, true )

		
	    --dxDrawText(streamTitle, radarPos[1]+550, radarPos[2]-182, 200, 30, tocolor ( 255, 255, 255 ), 1, font,"left","top",false,false,false,false)
		dxDrawText (streamName, textx + 42, texty+2.3, textx, texty, tocolor ( 255, 255, 255, 255 ), 1, font, "left", "top" )
		dxDrawText (streamTitle, textx, texty+30.0, textx, texty, tocolor ( 255, 255, 255, 255 ), 0.7, font, "left", "top" )
		


	

	end

end



function removeTheEvent()

	removeEventHandler("onClientPreRender", getRootElement(), showStation)

	textShowing = false

end



function saveRadio(station)

	cancelEvent()

	local radios = 0

	if (station == 0) then

		return

	end



	

	

	local vehicle = getPedOccupiedVehicle(getLocalPlayer())

	

	if (vehicle) then

		if getVehicleOccupant(vehicle) == getLocalPlayer() or getVehicleOccupant(vehicle, 1) == getLocalPlayer() then

			if (station == 12) then	

				if (radio == 0) then

					radio = totalStreams + 1

				end

				

				if (streams[radio - 1]) then

					radio = radio - 1

				else

					radio = 0

				end

			elseif (station == 0) then

				if (streams[radio+1]) then

					radio = radio+1

				else

					radio = 0

				end

			end

			if not textShowing then

				addEventHandler("onClientPreRender", getRootElement(), showStation)

				if (isTimer(theTimer)) then

					resetTimer(theTimer)

				else

					theTimer = setTimer(removeTheEvent, 20000, 1)

				end

				textShowing = true

			else

				removeEventHandler("onClientPreRender", getRootElement(), showStation)

				addEventHandler("onClientPreRender", getRootElement(), showStation)

				if (isTimer(theTimer)) then

					resetTimer(theTimer)

				else

					theTimer = setTimer(removeTheEvent, 20000, 1)

				end

			end

			triggerServerEvent("car:radio:sync", getLocalPlayer(), radio)

		end

	end

end



addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), function()

	cancelEvent()

end)





function exitingVehicle()

	removeTheEvent()

end

addEventHandler("onClientVehicleStartExit", getRootElement(), exitingVehicle)



function playerPressedKey(button, press)

	local vehicle = getPedOccupiedVehicle(getLocalPlayer())

    if vehicle then

        if getVehicleOccupant(vehicle) == getLocalPlayer() or getVehicleOccupant(vehicle, 1) == getLocalPlayer() then

			if button == "r" then
			if not textShowing then

					addEventHandler("onClientPreRender", getRootElement(), showStation)

				

					textShowing = true

				else

					removeEventHandler("onClientPreRender", getRootElement(), showStation)

					textShowing = false

				end
				end
			
			
			if button == "mouse_wheel_up" then

				if textShowing == false then return end
				
				if getKeyState( "tab" ) == true then return false end

				setRadioChannel(0)

				if (radio == 0) then

					radio = totalStreams + 1

				end

				

				if (streams[radio - 1]) then

					radio = radio - 1

					selectSound = playSound ( "arquivos/click.mp3", false )

					setSoundVolume(selectSound, 0.2)

				else

					radio = 0

					selectSound = playSound ( "arquivos/click.mp3", false )

					setSoundVolume(selectSound, 0.2)

				end

			

				triggerServerEvent("car:radio:sync", getLocalPlayer(), radio)

			elseif button == "mouse_wheel_down" then

				if textShowing == false then return end

				setRadioChannel(0)

				if (streams[radio + 1]) then

					radio = radio + 1

					selectSound = playSound ( "arquivos/click.mp3", false )

					setSoundVolume(selectSound, 0.2)

				else

					radio = 0

					selectSound = playSound ( "arquivos/click.mp3", false )

					setSoundVolume(selectSound, 0.2)

				end

				

				triggerServerEvent("car:radio:sync", getLocalPlayer(), radio)

			end

		end

    end

end

addEventHandler("onClientKey", root, playerPressedKey)

	



addEventHandler("onClientPlayerVehicleEnter", getLocalPlayer(),

	function(theVehicle)
		setRadioChannel(0)

		radio = getElementData(theVehicle, "vehicle:radio") or 0

		setElementData(theVehicle, "vehicle:radio", radio)

		updateLoudness(theVehicle)

	end

)



addEventHandler("onClientPlayerVehicleExit", getLocalPlayer(),

	function(theVehicle)

		setRadioChannel(0)

		radio = getElementData(theVehicle, "vehicle:radio") or 0

		updateLoudness(theVehicle)

	end

)



addEventHandler("onClientElementDestroy", getRootElement(), function ()

	local radio = getElementData(source, "vehicle:radio") or 0

	if getElementType(source) == "vehicle" and radio ~= 0 then

		destroyElement(newSoundElement)

		setElementData(source, "vehicle:radio", 0)

	end

end)



function stopStupidRadio()

	setRadioChannel(0)

end



addEventHandler ( "onClientElementDataChange", getRootElement(),

	function ( dataName )

		if getElementType ( source ) == "vehicle" and dataName == "vehicle:radio" then

			-- local enableStreams = getElementData(getLocalPlayer(), "streams")

			-- if enableStreams == 1 then

				local newStation =  getElementData(source, "vehicle:radio") or 0

				if (isElementStreamedIn (source)) then

					if newStation ~= 0 then

						if (soundElementsOutside[source]) then

							stopSound(soundElementsOutside[source])

						end

						local x, y, z = getElementPosition(source)

						local song = streams[newStation][4]

						--if isElementWithinColShape(source, tempCol) or isLefedett(newStation) then

						song = streams[newStation][1]

						

						newSoundElement = playSound3D(song, x, y, z, true)

						soundElementsOutside[source] = newSoundElement

						updateLoudness(source)

						setElementDimension(newSoundElement, getElementDimension(source))

						setElementDimension(newSoundElement, getElementDimension(source))

					else

						if (soundElementsOutside[source]) then

							stopSound(soundElementsOutside[source])

							soundElementsOutside[source] = nil

						end

					end

				end

			-- end

		elseif getElementType(source) == "vehicle" and dataName == "vehicle:windowstat" then

			if (isElementStreamedIn (source)) then

				if (soundElementsOutside[source]) then

					updateLoudness(source)

				end

			end

		elseif getElementType(source) == "vehicle" and dataName == "vehicle:radio:volume" then

			if (isElementStreamedIn (source)) then

				if (soundElementsOutside[source]) then

					updateLoudness(source)

				end

			end

		end

		

		--

	end 

)



addEventHandler( "onClientPreRender", getRootElement(),

	function()

		if soundElementsOutside ~= nil then

			for element, sound in pairs(soundElementsOutside) do

				if (isElement(sound) and isElement(element)) then

					local x, y, z = getElementPosition(element)

					setElementPosition(sound, x, y, z)

					setElementInterior(sound, getElementInterior(element))

					getElementDimension(sound, getElementDimension(element))

				end

			end

		end

	end	

)



addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),

	function()	

		local vehicles = getElementsByType("vehicle")
		for _, theVehicle in ipairs(vehicles) do
			if (isElementStreamedIn(theVehicle)) then
				setElementData(theVehicle, "vehicle:radio", 0)	
				spawnSound(theVehicle)	
			end
	end
end

)



addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),

	function()	

		local vehicles = getElementsByType("vehicle")

		for _, theVehicle in ipairs(vehicles) do

			if (isElementStreamedIn(theVehicle)) then

				spawnSound(theVehicle)

			end

		end

	end

)



function spawnSound(theVehicle)

	local newSoundElement = nil

    if getElementType( theVehicle ) == "vehicle" then

		-- local enableStreams = getElementData(getLocalPlayer(), "streams")

		-- if enableStreams == 1 then

			local radioStation = getElementData(theVehicle, "vehicle:radio") or 0

			if radioStation ~= 0 then

				if (soundElementsOutside[theVehicle]) then

					stopSound(soundElementsOutside[theVehicle])

				end

				local x, y, z = getElementPosition(theVehicle)

				--if isElementWithinColShape(theVehicle, tempCol) or isLefedett(newStation) then

				song = streams[radioStation][1]

				--else

					--song = "radio.wav"

				--end

				newSoundElement = playSound3D(song, x, y, z, true)

				soundElementsOutside[theVehicle] = newSoundElement

				setElementDimension(newSoundElement, getElementDimension(theVehicle))

				setElementDimension(newSoundElement, getElementDimension(theVehicle))

				updateLoudness(theVehicle)

			end

		-- end

    end

end



function onClientColShapeLeave( theElement, matchingDimension )

    if ( theElement == getLocalPlayer() ) and isPedInVehicle(getLocalPlayer()) then

		local theVehicle = getPedOccupiedVehicle ( theElement )

		local radioStation = getElementData(theVehicle, "vehicle:radio") or 0

		if ((soundElementsOutside[theVehicle]) and radioStation ~= 0) and not isLefedett(radioStation) then

			stopSound(soundElementsOutside[theVehicle])

			outputChatBox( "",255,0,0 )

			local x, y, z = getElementPosition(theVehicle)

			song = "radio.wav"

			newSoundElement = playSound3D(song, x, y, z, true)

			soundElementsOutside[theVehicle] = newSoundElement

			setElementDimension(newSoundElement, getElementDimension(theVehicle))

			setElementDimension(newSoundElement, getElementDimension(theVehicle))

			updateLoudness(theVehicle)

		end

    end

end

--addEventHandler("onClientColShapeLeave",tempCol,onClientColShapeLeave)



function onClientColShapeHit( theElement, matchingDimension )

    if ( theElement == getLocalPlayer() ) and isPedInVehicle(getLocalPlayer()) then

		local theVehicle = getPedOccupiedVehicle ( theElement )

		local theVehicle = getPedOccupiedVehicle ( theElement )

		local radioStation = getElementData(theVehicle, "vehicle:radio") or 0

		if ((soundElementsOutside[theVehicle]) and radioStation ~= 0) and not isLefedett(radioStation) then

			stopSound(soundElementsOutside[theVehicle])

			outputChatBox( "",0,255,0 )

			local x, y, z = getElementPosition(theVehicle)

			song = streams[radioStation][1]

			newSoundElement = playSound3D(song, x, y, z, true)

			soundElementsOutside[theVehicle] = newSoundElement

			setElementDimension(newSoundElement, getElementDimension(theVehicle))

			setElementDimension(newSoundElement, getElementDimension(theVehicle))

			updateLoudness(theVehicle)

		end

    end

end

--addEventHandler("onClientColShapeHit",tempCol,onClientColShapeHit)



function updateLoudness(theVehicle)

	if (soundElementsOutside[theVehicle]) then

		local windowState = getElementData(theVehicle, "vehicle:windowstat") or 1

		local carVolume = getElementData(theVehicle, "vehicle:radio:volume") or 25

		

		carVolume = carVolume / 100

		

		--  ped is inside

		if (getPedOccupiedVehicle( getLocalPlayer() ) == theVehicle) then

			setSoundMinDistance(soundElementsOutside[theVehicle], 8)

			setSoundMaxDistance(soundElementsOutside[theVehicle], 70)

			setSoundVolume(soundElementsOutside[theVehicle], 0.6775*carVolume)

		elseif (getVehicleType(theVehicle) == "Boat") then

			setSoundMinDistance(soundElementsOutside[theVehicle], 25)

			setSoundMaxDistance(soundElementsOutside[theVehicle], 50)

			setSoundVolume(soundElementsOutside[theVehicle], 0.6725*carVolume)

		elseif (windowState == 1) then 

			setSoundMinDistance(soundElementsOutside[theVehicle], 5)

			setSoundMaxDistance(soundElementsOutside[theVehicle], 15.5)

			setSoundVolume(soundElementsOutside[theVehicle], 0.6725*carVolume)

		

			setSoundMinDistance(soundElementsOutside[theVehicle], 15)

			setSoundMaxDistance(soundElementsOutside[theVehicle], 20)

			setSoundVolume(soundElementsOutside[theVehicle], 0.7*carVolume)

		elseif (windowState == 0) then 

			setSoundMinDistance(soundElementsOutside[theVehicle], 3)

			setSoundMaxDistance(soundElementsOutside[theVehicle], 7.5)

			setSoundVolume(soundElementsOutside[theVehicle], 0.6725*carVolume)

		else

			setSoundMinDistance(soundElementsOutside[theVehicle], 3)

			setSoundMaxDistance(soundElementsOutside[theVehicle], 10)

			setSoundVolume(soundElementsOutside[theVehicle], 0.3*carVolume)

		end

	end

end



addEventHandler( "onClientElementStreamIn", getRootElement( ),

    function ( )

		spawnSound(source)

    end

)



addEventHandler( "onClientElementStreamOut", getRootElement( ),

    function ( )

		local newSoundElement = nil

        if getElementType( source ) == "vehicle" then

			if (soundElementsOutside[source]) then

				stopSound(soundElementsOutside[source])

				soundElementsOutside[source] = nil

			end

        end

    end

)

