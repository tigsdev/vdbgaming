local space = nil
local j = false
local sendengine = false
local enginestatedamage = {false,true}
function engineswitch(button, press)
if getPedOccupiedVehicle ( localPlayer ) then
	if button == "space" then
		space = true
	end
		if button == "j" then
			local carro = getPedOccupiedVehicle ( localPlayer )
			local state = getVehicleEngineState ( carro )
				if state == true and sendengine == false then
					triggerServerEvent("engineswitch", localPlayer, localPlayer, false)
					space = false
					sendengine = true
				end
				if state == false and space == true and sendengine == false then
						sendengine = true
						playSound("vehicle-functions/arquivos/motor.mp3")
						setTimer( function() 
							if getElementHealth(carro) < 600 then
								triggerServerEvent("engineswitch", localPlayer, localPlayer, enginestatedamage[math.random(1,2)])
							else
								triggerServerEvent("engineswitch", localPlayer, localPlayer, true)
							end
							space = false
						end, 1000,1) 
				end
				space = false
		end
end
end
addEventHandler("onClientKey", root, engineswitch)



function lightswitch(button, press)
	if getPedOccupiedVehicle ( localPlayer ) then
		if  button == "k" and press == false and  getVehicleController ( getPedOccupiedVehicle ( localPlayer ) ) == localPlayer then
			triggerServerEvent("lightswitch", localPlayer, localPlayer )
			playSound("vehicle-functions/arquivos/farois.mp3")		
		end	
			
	end
end
addEventHandler("onClientKey", root, lightswitch)


addEvent( "sendengine", true )
addEventHandler( "sendengine", getRootElement( ), function(state)
 sendengine = state
end)

addEvent( "soundlockalarme", true )
addEventHandler( "soundlockalarme", getRootElement( ), function(player)
if localPlayer == player then
	playSound("vehicle-functions/arquivos/trava.mp3")	
end
end)

addEvent ( "onPlaySoundNearElement", true )
function playSoundNearElement ( theElement, sound )
--	local sound = 5
	local maxdist = 15.0
	-- valid element
	if ( theElement ) then
		local x,y,z = getElementPosition ( theElement )
		local x2,y2,z2 = getElementPosition ( localPlayer )
		local dist = getDistanceBetweenPoints3D ( x, y, z, x2, y2, z2 ) 
		-- distance is less than parameter maxdist
		if ( dist < maxdist ) then
			-- play parameter sound 
			playSound("vehicle-functions/arquivos/alarme.mp3")	
		--	outputChatBox ( "Som deve jogar" )
		else
		--	outputChatBox ( "Não está no intervalo" )
		end
	else
		-- outputChatBox ( "Elemento inválido" )
	end
end
addEventHandler ( "onPlaySoundNearElement", getRootElement(), playSoundNearElement )
