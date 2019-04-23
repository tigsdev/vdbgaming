	function startWaterRefract()
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Nem kompatibilis a shader." )
			return
		end

		-- Letrehozza a shadert
		local myShader, tec = dxCreateShader ( "arquivos/efeitos/agua/water.fx" )

		if not myShader then
			--outputChatBox( "Nemlehet betolteni a viz shadert. #ERROR" )
		else
			--outputChatBox( " " .. tec )

			-- Textura Beallitasa
			local textureVol = dxCreateTexture ( "arquivos/efeitos/agua/images/smallnoise3d.dds" );
			local textureCube = dxCreateTexture ( "arquivos/efeitos/agua/images/cube_env256.dds" );
			dxSetShaderValue ( myShader, "sRandomTexture", textureVol );
			dxSetShaderValue ( myShader, "sReflectionTexture", textureCube );

			-- Globalis TXD Betoltese
			engineApplyShaderToWorldTexture ( myShader, "waterclear256" )

			-- Frissites
			timer = setTimer(
			function()
			if myShader then
				local r,g,b,a = getWaterColor()
				dxSetShaderValue ( myShader, "sWaterColor", r/255, g/255, b/255, a/255 );
			end
		end,100,0 )
		
		addCommandHandler("waterrefrectstopfunction",function() 	
		destroyElement(myShader)
		myShader = nil 
		end)

	end
	end