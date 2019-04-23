--[[function createDeathPickup ( )
camera_heli = createPickup ( 1541.17, -1364.04, 329.8, 2, 43, 1, 5000 )
camera_heli = createPickup ( 1535.85, -1361.45, 329.62, 2, 46, 1, 5000 )
end
addEventHandler ( "onResourceStart", getRootElement(), createDeathPickup ) 
]]