function appFunctions.settings:onSettingsLoad ( )
	exports.VDBGMessages:sendClientMessage ( "Carregando configurações do usuário...", 0, 255, 0 )
	for i, v in pairs ( pages['settings'] ) do
		if ( doesSettingExist ( i ) ) then
			guiCheckBoxSetSelected ( v, getSetting ( i ) )
		end
	end
end


function onSettingButtonClick( )
	if ( source == pages['settings']['background_download_btn'] ) then
		local url = guiGetText ( pages['settings']['background_download_url'] )
		local form = string.sub ( url, string.len(url)-3, string.len(url) ):lower();
		
		if ( string.sub ( url, 1, 7 ):lower() ~= "http://" and string.sub ( url, 1, 8 ):lower() ~= "https://" ) then
			return exports.VDBGMessages:sendClientMessage ( "url inválido", 255, 0, 0 )
		end
		
		if ( form ~= ".png" and form ~= ".jpg" ) then
			return exports.VDBGMessages:sendClientMessage ( "O formato do arquivo deve ser .png ou .jpg", 255, 0, 0 )
		end
		exports.VDBGMessages:sendClientMessage ( "Nós vamos tentar baixar essa imagem ... Por favor, aguarde ....", 255, 255, 0 )
		triggerServerEvent ( "VDBGPhone:Modules->Apps:Settings->DownloadUserImage", localPlayer, url )
		guiSetEnabled ( pages['settings']['background_download_btn'], false )
		
	elseif ( source == pages['settings']['background_download_del'] ) then
		if ( fileExists ( "custombg.png" ) ) then
			fileDelete ( "custombg.png" )
		end if ( fileExists ( "custombg.jpg" ) ) then
			fileDelete ( "custombg.jpg" )
		end
		
		exports.VDBGMessages:sendClientMessage ( "File removed. Reconnect to restore the background", 255, 255, 0 )
		guiSetEnabled ( source, false )
	end
end
--addEventHandler ( "onClientGUIClick", pages['settings']['background_download_btn'], onSettingButtonClick )
--addEventHandler ( "onClientGUIClick", pages['settings']['background_download_del'], onSettingButtonClick )

addEvent ( "VDBGPhone:Modules->Apps:Settings->SendClientNewBackground", true )
addEventHandler ( "VDBGPhone:Modules->Apps:Settings->SendClientNewBackground", root, function ( data, url )
	if ( fileExists ( "custombg.png" ) ) then
		fileDelete ( "custombg.png" )
	end
	
	local f = fileCreate ( "custombg.png" )
	fileWrite ( f, data )
	fileClose ( f )
	
	exports.VDBGMessages:sendClientMessage ( "The file has been downloaded. To enable it, please reconnect.", 0, 255, 0 )
	guiSetEnabled ( pages['settings']['background_download_btn'], true )
end )