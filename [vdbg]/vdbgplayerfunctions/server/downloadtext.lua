local text_ = textCreateDisplay ( )
local text = textCreateTextItem ( "VDBG:RPG - 3.0.1 | \nCARREGANDO RESOURCES\n\n VDBGaming - www.vdbg.org", 0.5, 0.5, "default-bold", 255, 255, 255, 255, 2, "center", "center", 2 ) 
textDisplayAddText ( text_, text )

addEventHandler ( "onPlayerJoin", root, function ( )
	textDisplayAddObserver ( text_, source )
end )

addEventHandler ( "onResourceStart", resourceRoot, function ( )
	for i, source in ipairs ( getElementsByType ( 'player' ) ) do
		textDisplayAddObserver ( text_, source )
	end
end )

addEvent ( "VDBGPlayerFunctions:DownloadText.onPlayerFinishDownload", true )
addEventHandler ( "VDBGPlayerFunctions:DownloadText.onPlayerFinishDownload", root, function ( )
	textDisplayRemoveObserver ( text_, source )
end )
