function loadShops ( )
	for i, v in pairs ( shopLocations ) do 
		for k, e in ipairs ( v ) do 
			local x, y, z, _ = unpack ( e )
			local m = createMarker ( x, y, z -1, 'cylinder', 2, 255, 255, 0, 255 )
			setElementData ( m, 'VDBGVehicles:ShopType', i )
			setElementData ( m, 'VDBGVehicles:CameraView', e[4] )
			setElementData ( m, 'VDBGVehicles:SpawnPosition', e[5] )
			addEventHandler ( "onMarkerHit", m, function ( p )
				if ( getElementType ( p ) == 'player' and not isPedInVehicle ( p ) ) then
					local t = getElementData ( source, 'VDBGVehicles:ShopType' )
					local vx, vy, vz, px, py, pz = unpack ( getElementData ( source, 'VDBGVehicles:CameraView' ) ) 
					triggerClientEvent ( p, 'VDBGVehicles:openClientShop', p, vehicleList[t], { px, py, pz }, getElementData ( source, "VDBGVehicles:SpawnPosition" ) )
					setCameraMatrix ( p, vx, vy, vz, px, py, pz )
					
				end
			end )
			
		end
	end
end

addEvent ( "VDBGVehicles:onClientBuyVehicle", true )
addEventHandler ( "VDBGVehicles:onClientBuyVehicle", root, function ( id, pricet, spawn, colors )
 local price, method = unpack ( pricet )
 if isGuestAccount(getPlayerAccount(client)) then return end;
 if #getAllAccountVehicles(getAccountName(getPlayerAccount(client))) + 1 <= (getElementData(client, "maxPlayerVehicleSlots") or 3) then
  
  if method == "diamound" then
		exports.VDBGVIP:takePlayerDiamound (getAccountName(getPlayerAccount(client)),price)
	elseif method == "money" then
		takePlayerMoney ( client, price ) 
  end
  local vID = givePlayerVehicle ( client, id, unpack ( colors ) )
  local car = showVehicle ( vID, true )
  local x, y, z, rz = unpack ( spawn )
  setElementPosition ( car, x, y, z )
  setElementRotation ( car, 0, 0, rz )
  warpPedIntoVehicle ( client, car )
  setElementData ( car, "fuel", 100 )
  triggerClientEvent(client, "playerVehicles:onRequestUpdateVehicleList", client, toJSON({ getVehicleNameFromModel(id), vID }))
 else
  exports['VDBGMessages']:sendClientMessage("Você não tem mais slot disponível.", client, 230, 0, 0)
 end
end )

loadShops ( )