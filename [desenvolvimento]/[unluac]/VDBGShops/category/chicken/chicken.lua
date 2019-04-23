local maximo = 11
local blips = { }
local warps1 = { }
local warps2 = { }
local interiores = {  

	{"Cluckin'bell #d9534f#1",
	--[[pos-x,y,z]]172.727, 1176.68, 13.773,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]71, --[[BLIP]]14},
	{"Cluckin'bell #d9534f#2",
	--[[pos-x,y,z]]-2155.03, -2460.28, 29.8484,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]72, --[[BLIP]]14},
	{"Cluckin'bell #d9534f#3",
	--[[pos-x,y,z]]2419.95, -1509.8, 23.1568,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]73, --[[BLIP]]14},
	{"Cluckin'bell #d9534f#4",
	--[[pos-x,y,z]]2397.83, -1898.65, 12.7131,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]74, --[[BLIP]]14},
	{"Cluckin'bell #d9534f#5",
	--[[pos-x,y,z]]928.525, -1352.77, 12.4344,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]75, --[[BLIP]]14},
	{"Cluckin'bell #d9534f#6",
	--[[pos-x,y,z]]-1815.84, 618.678, 34.2989,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]76, --[[BLIP]]14},
	{"Cluckin'bell #d9534f#7",
	--[[pos-x,y,z]]-2671.53, 258.344, 3.64932,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]77, --[[BLIP]]14},
	
	{"Cluckin'bell #d9534f#8",
	--[[pos-x,y,z]]2638.58, 1671.18, 10.0231,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]78, --[[BLIP]]14},
	
	{"Cluckin'bell #d9534f#9",
	--[[pos-x,y,z]]2393.18, 2041.66, 9.8472,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]79, --[[BLIP]]14},
	
	{"Cluckin'bell #d9534f#10",
	--[[pos-x,y,z]]2838.43, 2407.26, 10.061,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]81, --[[BLIP]]14},
	
	{"Cluckin'bell #d9534f#11",
	--[[pos-x,y,z]]2102.69, 2228.76, 10.0579,
	--[[toPos-x,y,z]]365.67, -11.61, 1000.87, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]9, --[[tDim]]82, --[[BLIP]]14},
    
}
	for i=0, maximo-1 do
	warps1 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+2.0 }, toPos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+1.0 }, cInt = interiores[i+1][8], cDim = interiores[i+1][9], tInt = interiores[i+1][10], tDim = interiores[i+1][11] } )
	warps2 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+2.0 }, toPos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+1.0 }, cInt = interiores[i+1][10], cDim = interiores[i+1][11], tInt = interiores[i+1][8], tDim = interiores[i+1][9] } )
	blips = createBlip ( interiores[i+1][2],interiores[i+1][3],interiores[i+1][4], interiores[i+1][12], 2, 255, 255, 255, 255, 0, 450 )
	end