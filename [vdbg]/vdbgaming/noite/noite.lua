local maxDarkness = 0.4
local speed = 0.01


local b = 1
local shaderList = {}
local fading = false


local removables = {
	'tx*',
	'coronastar',
	'shad_exp*',
	'radar*',
	'*icon',
	'font*',
	'lampost_16clr',
	'headlight',
	'vehiclegeneric256',
}

function night_init()
	if getVersion ().sortable < '1.1.0' then
		outputChatBox('O recurso para deixar a noite mais real não é compativel com sua versão do MTA')
		return false
	end

	local testShader, tec = dxCreateShader('noite/noite.fx')
	if not testShader then
		outputChatBox('Não foi possível criar a textura de noite realistica! (DEBUG3)')
	else
		for c=65,96 do
			local clone = dxCreateShader('noite/noite.fx')
			engineApplyShaderToWorldTexture(clone, string.format('%c*', c + 32))
			for i,v in pairs(removables) do
				engineRemoveShaderFromWorldTexture(clone, v)
			end
			table.insert(shaderList, clone)
		end
	end

	addEventHandler('onClientHUDRender', root, night_render)
	nightTimer = setTimer(night_check, 1000, 0)
	end

function night_check()
	local hours, minutes = getTime()
	if hours >= 5 and hours < 12 then
		fading = false
	elseif hours >= 12 and hours < 15 then
		fading = false
	elseif hours >= 15 and hours < 21 then
		fading = false
	elseif hours >= 21 and hours < 5 then
		fading = false
	else
		fading = true
	end
end

function night_render()
	local int, dim = getElementInterior(localPlayer), getElementDimension(localPlayer)
	if fading then
		if b > maxDarkness then
			b = b - speed
		elseif b <= maxDarkness then
			b = maxDarkness
		end
	else
		if b < 1.0 then
			b = b + speed
		elseif b >= 1.0 then
			b = 1.0
		end
	end
	for _,shader in ipairs(shaderList) do
		if int == 0 and dim == 0 then
			dxSetShaderValue(shader, 'NIGHT', b, b, b)
		else
			dxSetShaderValue(shader, 'NIGHT', 1.0, 1.0, 1.0)
		end
	end
end

night_init()