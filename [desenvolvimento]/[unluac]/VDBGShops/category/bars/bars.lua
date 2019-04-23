local maximo = 6
local blips = { }
local warps1 = { }
local warps2 = { }
local interiores = {  

	
	
	{ "Alhambra #d9534f#1",
	--[[pos-x,y,z]]1836.9, -1681.75, 12.3635,
	--[[toPos-x,y,z]]493.39, -24.92, 999.69,
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]17, --[[tDim]]13, --[[BLIP]]49},
	
	{ "Gaydar Station #d9534f#1",
	--[[pos-x,y,z]]-2551.79, 193.778, 5.21905,
	--[[toPos-x,y,z]]493.39, -24.92, 999.69,
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]17, --[[tDim]]14, --[[BLIP]]49},
	
	{ "Striker's Station #d9534f#1",
	--[[pos-x,y,z]]2507.44, 1242.31, 9.83339,
	--[[toPos-x,y,z]]493.39, -24.92, 999.69,
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]17, --[[tDim]]15, --[[BLIP]]49},

	{ "Ten Green Bottles #d9534f#1",
	--[[pos-x,y,z]]2309.62, -1643.63, 13.8385,
	--[[toPos-x,y,z]]501.98, -67.75, 997.84,
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]11, --[[tDim]]16, --[[BLIP]]49},
	
	{ "Tigs's Station #d9534f#1",
	--[[pos-x,y,z]]-2242.69, -88.2558, 34.3578,
	--[[toPos-x,y,z]]501.98, -67.75, 997.84,
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]11, --[[tDim]]17, --[[BLIP]]49},
	
	{ "The Craw Bar #d9534f#1",
	--[[pos-x,y,z]]2441.15, 2065.15, 9.8472,
	--[[toPos-x,y,z]]501.98, -67.75, 997.84,
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]11, --[[tDim]]18, --[[BLIP]]49},
    
}
	for i=0, maximo-1 do
	warps1 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+2.0 }, toPos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+1.0 }, cInt = interiores[i+1][8], cDim = interiores[i+1][9], tInt = interiores[i+1][10], tDim = interiores[i+1][11] } )
	warps2 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+2.0 }, toPos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+1.0 }, cInt = interiores[i+1][10], cDim = interiores[i+1][11], tInt = interiores[i+1][8], tDim = interiores[i+1][9] } )
	blips = createBlip ( interiores[i+1][2],interiores[i+1][3],interiores[i+1][4], interiores[i+1][12], 2, 255, 255, 255, 255, 0, 450 )
	end