local sound = {}

addEventHandler('onClientResourceStart', resourceRoot, 
	function()
		sound[1] = playSound3D("sounds-place/sons/cidade_1.mp3", 1506.1831054688, -1273.5694580078, 293.546874, true)
		setSoundMaxDistance(sound[1], 4000)

		sound[2] = playSound3D("sounds-place/sons/cachorro_1.mp3", 2408.734375, -1670.412109375, 13.56620788574, true)
		setSoundMaxDistance(sound[2], 55)
		setSoundVolume(sound[2], 0.1)

		sound[3] = playSound3D("sounds-place/sons/1.mp3", -952.14385986328, -2548.1184082031, 120.9098663330, true)
		setSoundMaxDistance(sound[3], 700)

		sound[4] = playSound3D("sounds-place/sons/2.mp3", -767.41430664063, -1789.3596191406, 125.6828155517, true)
		setSoundMaxDistance(sound[4], 700)
	end
)
