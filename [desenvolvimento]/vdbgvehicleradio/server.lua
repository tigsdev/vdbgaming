function syncRadio(station)
	local vehicle = getPedOccupiedVehicle(source)
	setElementData(vehicle, "vehicle:radio", station)
end
addEvent("car:radio:sync", true)
addEventHandler("car:radio:sync", getRootElement(), syncRadio)

function syncRadio(client,vol)
	local vehicle = getPedOccupiedVehicle(client)
	setElementData(vehicle, "vehicle:radio:volume", vol)
end
addEvent("car:radio:vol", true)
addEventHandler("car:radio:vol", getRootElement(), syncRadio)

function startImageDownload( playerToReceive, nomedamusica )
	if nomedamusica == "naobaixar" then return end
		fetchRemote( "http://localhost/search/index.php?musica="..nomedamusica, function(data)
		if data then
		if data == data2 then return end
		data2 = data
		urlimg = string.gsub(tostring(data), "\\", "/")
		end		
	end, nil, true )
	if data == data2 then return end
    fetchRemote ( urlimg, myCallback, "", false, playerToReceive )
end
addEvent( "onClientGetImage", true )
addEventHandler( "onClientGetImage", getRootElement(), startImageDownload)
 
function myCallback( responseData, errno, playerToReceive )
    if errno == 0 then
        triggerClientEvent( playerToReceive, "onClientGotImage", resourceRoot, responseData )
    end
end
