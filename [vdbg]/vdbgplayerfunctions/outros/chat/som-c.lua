function playSonido()
local sound = playSound("outros/chat/chat.mp3",false)
setSoundVolume(sound, 0.9)
end
addEvent("sonido",true)
addEventHandler("sonido",getRootElement(),playSonido)