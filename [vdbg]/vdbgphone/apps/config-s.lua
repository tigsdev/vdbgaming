addEvent ( "VDBGPhone:Modules->Apps:Settings->DownloadUserImage", true )
addEventHandler ( "VDBGPhone:Modules->Apps:Settings->DownloadUserImage", root, function ( u )
	fetchRemote ( u, function ( d, _, p, url )
		if ( not isElement ( p ) ) then
			return
		end
		
		exports.VDBGMessages:sendClientMessage ( "Image downloaded to phone... Sending it your way.", p, 0, 255, 0 )
		triggerClientEvent ( p, "VDBGPhone:Modules->Apps:Settings->SendClientNewBackground", p, d, url )
	end, "", false, source, u )
end )