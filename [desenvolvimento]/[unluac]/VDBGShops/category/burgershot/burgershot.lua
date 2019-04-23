local maximo = 10
local blips = { }
local warps1 = { }
local warps2 = { }
local interiores = {  

	{"Burger Shot #d9534f#1",
	--[[pos-x,y,z]]811.982, -1616.02, 12.618,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]61, --[[BLIP]]10},	
	{"Burger Shot #d9534f#2",
	--[[pos-x,y,z]]1199.13, -918.071, 42.3243,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]62, --[[BLIP]]10},	
	{"Burger Shot #d9534f#3",
	--[[pos-x,y,z]]-1912.27, 828.025, 34.5615,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]63, --[[BLIP]]10},	
	{"Burger Shot #d9534f#4",
	--[[pos-x,y,z]]-2336.95, -166.646, 34.3573,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]64, --[[BLIP]]10},		
	{"Burger Shot #d9534f#5",
	--[[pos-x,y,z]]-2356.48, 1008.01, 49.9036,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]65, --[[BLIP]]10},	
	{"Burger Shot #d9534f#6",
	--[[pos-x,y,z]]2366.74, 2071.02, 9.8218,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]66, --[[BLIP]]10},		
	{"Burger Shot #d9534f#7",
	--[[pos-x,y,z]]2472.68, 2033.88, 9.822,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]67, --[[BLIP]]10},		
	{"Burger Shot #d9534f#8",
	--[[pos-x,y,z]]2169.86, 2795.79, 9.89528,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]68, --[[BLIP]]10},		
	{"Burger Shot #d9534f#9",
	--[[pos-x,y,z]]1872.24, 2072.07, 9.82222,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]69, --[[BLIP]]10},	
	{"Burger Shot #d9534f#10",
	--[[pos-x,y,z]]1158.43, 2072.02, 9.82222,
	--[[toPos-x,y,z]]363.11, -74.88, 1000.55, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]10, --[[tDim]]70, --[[BLIP]]10},	
    
}
	for i=0, maximo-1 do
	warps1 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = {  interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+2.0 }, toPos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+1.0 }, cInt = interiores[i+1][8], cDim = interiores[i+1][9], tInt = interiores[i+1][10], tDim = interiores[i+1][11] } )
	warps2 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+2.0 }, toPos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+1.0 }, cInt = interiores[i+1][10], cDim = interiores[i+1][11], tInt = interiores[i+1][8], tDim = interiores[i+1][9] } )
	blips = createBlip ( interiores[i+1][2],interiores[i+1][3],interiores[i+1][4], interiores[i+1][12], 2, 255, 255, 255, 255, 0, 450 )
	end