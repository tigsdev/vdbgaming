local maximo = 12
local blips = { }
local warps1 = { }
local warps2 = { }
local interiores = {  

	{"The W.S Pizza Co. #d9534f#1", 
	--[[pos-x,y,z]]1367.27, 248.388, 18.6229,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]83, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#2",
	--[[pos-x,y,z]]2333.43, 75.0488, 25.7342,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]84, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#3",
	--[[pos-x,y,z]]2333.43, 75.0488, 25.7342,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]85, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#4",
	--[[pos-x,y,z]]1367.27, 248.388, 18.6229,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]86, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#5",
	--[[pos-x,y,z]]203.334, -202.532, 0.600709,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]87, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#6",
	--[[pos-x,y,z]]2083.49, 2224.2, 10.0579,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]88, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#7",
	--[[pos-x,y,z]]2105.32, -1806.49, 12.6941,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]89, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#8",
	--[[pos-x,y,z]]-1808.69, 945.863, 23.8648,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]90, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#9",
	--[[pos-x,y,z]]-1721.13, 1359.01, 6.19634,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]91, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#10",
	--[[pos-x,y,z]]2638.58, 1849.97, 10.0231,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]92, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#11",
	--[[pos-x,y,z]]2756.01, 2477.05, 10.061,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]93, --[[BLIP]]29},
	
	{"The W.S Pizza Co. #d9534f#12",
	--[[pos-x,y,z]]2351.89, 2532.19, 9.82217,
	--[[toPos-x,y,z]]372.35, -133.55, 1000.45, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]5, --[[tDim]]94, --[[BLIP]]29},
	    
}
	for i=0, maximo-1 do
	warps1 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+2.0 }, toPos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+1.0 }, cInt = interiores[i+1][8], cDim = interiores[i+1][9], tInt = interiores[i+1][10], tDim = interiores[i+1][11] } )
	warps2 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+2.0 }, toPos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+1.0 }, cInt = interiores[i+1][10], cDim = interiores[i+1][11], tInt = interiores[i+1][8], tDim = interiores[i+1][9] } )
	blips = createBlip ( interiores[i+1][2],interiores[i+1][3],interiores[i+1][4], interiores[i+1][12], 2, 255, 255, 255, 255, 0, 450 )
	end