local maximo = 13
local blips = { }
local warps1 = { }
local warps2 = { }
local interiores = {  

	{"Loja de Diversos #d9534f#1",
	--[[pos-x,y,z]]1833.54, -1843.38, 12.5595,
	--[[toPos-x,y,z]]-30.95, -91.71, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]18, --[[tDim]]84, --[[BLIP]]17},
	{"Loja de Diversos #d9534f#2",
	--[[pos-x,y,z]]1315.49, -897.843, 38.571,
	--[[toPos-x,y,z]]-30.95, -91.71, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]18, --[[tDim]]85, --[[BLIP]]17},
	{"Loja de Diversos #d9534f#3",
	--[[pos-x,y,z]]2546.71, 1972.28, 9.822,
	--[[toPos-x,y,z]]-30.95, -91.71, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]18, --[[tDim]]86, --[[BLIP]]17},
	{"Loja de Diversos #d9534f#4",
	--[[pos-x,y,z]]2884.83, 2453.28, 10.061,
	--[[toPos-x,y,z]]-30.95, -91.71, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]18, --[[tDim]]87, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#5",
	--[[pos-x,y,z]]-181.004, 1034.83, 18.8298,
	--[[toPos-x,y,z]]-26.69, -57.81, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]6, --[[tDim]]88, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#6",
	--[[pos-x,y,z]]-1562.63, -2732.98, 47.7435,
	--[[toPos-x,y,z]]-26.69, -57.81, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]6, --[[tDim]]89, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#7",
	--[[pos-x,y,z]]1352.31, -1758.3, 12.5149,
	--[[toPos-x,y,z]]-26.69, -57.81, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]6, --[[tDim]]90, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#8",
	--[[pos-x,y,z]]2247.66, 2396.26, 9.8218,
	--[[toPos-x,y,z]]-26.69, -57.81, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]6, --[[tDim]]91, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#9",
	--[[pos-x,y,z]]2452.47, 2065.15, 9.8472,
	--[[toPos-x,y,z]]-26.69, -57.81, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]6, --[[tDim]]92, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#10",
	--[[pos-x,y,z]]2194.38, 1991.02, 11.301,
	--[[toPos-x,y,z]]-26.69, -57.81, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]6, --[[tDim]]93, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#11",
	--[[pos-x,y,z]]2097.76, 2224.2, 10.0579,
	--[[toPos-x,y,z]]-26.69, -57.81, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]6, --[[tDim]]94, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#12",
	--[[pos-x,y,z]]1937.25, 2307.17, 9.82222,
	--[[toPos-x,y,z]]-26.69, -57.81, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]6, --[[tDim]]95, --[[BLIP]]17},
	
	{"Loja de Diversos #d9534f#13",
	--[[pos-x,y,z]]1000.33, -919.924, 41.2368,
	--[[toPos-x,y,z]]-27.31, -31.38, 1002.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]4, --[[tDim]]96, --[[BLIP]]17},
	
    
}
	for i=0, maximo-1 do
	warps1 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+2.0 }, toPos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+1.0 }, cInt = interiores[i+1][8], cDim = interiores[i+1][9], tInt = interiores[i+1][10], tDim = interiores[i+1][11] } )
	warps2 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+2.0 }, toPos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+1.0 }, cInt = interiores[i+1][10], cDim = interiores[i+1][11], tInt = interiores[i+1][8], tDim = interiores[i+1][9] } )
	blips = createBlip ( interiores[i+1][2],interiores[i+1][3],interiores[i+1][4], interiores[i+1][12], 2, 255, 255, 255, 255, 0, 450 )
	end