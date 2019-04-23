local maximo = 10
local blips = { }
local warps1 = { }
local warps2 = { }
local interiores = {  

-- Old Venturas Strip - LV
	{"Loja de Armas #d9534f#1",
	--[[pos-x,y,z]]2538.92, 2083.95, 9.82,
	--[[toPos-x,y,z]]286.15, -40.65, 1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]96, --[[BLIP]]18},
	
-- Bone Contry - LV
	{"Loja de Armas #d9534f#2",
	--[[pos-x,y,z]]793.95, 1687.18, 6.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]97, --[[BLIP]]18},	
	
-- Bone Contry Fort carson - LV
	{"Loja de Armas #d9534f#3",
	--[[pos-x,y,z]]-315.74, 830.06, 15.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]98, --[[BLIP]]18},	
	
-- Perto da golden gate
	{"Loja de Armas #d9534f#4",
	--[[pos-x,y,z]]-1508.67, 2610.45, 56.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]99, --[[BLIP]]18},	

-- Ocean Flats - SF    
	{"Loja de Armas #d9534f#5",
	--[[pos-x,y,z]]-2625.95, 208.86, 5.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]100, --[[BLIP]]18},	
	
-- Angel Pine whetstone    
	{"Loja de Armas #d9534f#6",
	--[[pos-x,y,z]]-2093.26, -2464.28, 31.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]101, --[[BLIP]]18},	
	
-- perto do truck job
	{"Loja de Armas #d9534f#7",
	--[[pos-x,y,z]]243.06, -178.43, 2.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]102, --[[BLIP]]18},	

	-- perto dos hospital de ls
	{"Loja de Armas #d9534f#8",
	--[[pos-x,y,z]]1369, -1279.71, 13.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]103, --[[BLIP]]18},	
	
	-- perto dos hospital de ls
	{"Loja de Armas #d9534f#9",
	--[[pos-x,y,z]]2400.66, -1981.99, 13.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]104, --[[BLIP]]18},	
	
-- entre lv ls ( pescador )
	{"Loja de Armas #d9534f#10",
	--[[pos-x,y,z]]2333.56, 61.46, 27.01,
	--[[toPos-x,y,z]]286.15,-40.65,1000.52, 
	--[[cInt]]0, --[[cDim]]0, 
	--[[tInt]]1, --[[tDim]]105, --[[BLIP]]18},	
	
	
}

	for i=0, maximo-1 do
	warps1 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = {  interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+2.0 }, toPos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+1.0 }, cInt = interiores[i+1][8], cDim = interiores[i+1][9], tInt = interiores[i+1][10], tDim = interiores[i+1][11] } )
	warps2 = exports.VDBGWarpManager:makeWarp ( { namewarp = interiores[i+1][1], pos = { interiores[i+1][5],interiores[i+1][6],interiores[i+1][7]+2.0 }, toPos = { interiores[i+1][2],interiores[i+1][3],interiores[i+1][4]+1.0 }, cInt = interiores[i+1][10], cDim = interiores[i+1][11], tInt = interiores[i+1][8], tDim = interiores[i+1][9] } )
	blips = createBlip ( interiores[i+1][2],interiores[i+1][3],interiores[i+1][4], interiores[i+1][12], 2, 255, 255, 255, 255, 0, 450 )
	end