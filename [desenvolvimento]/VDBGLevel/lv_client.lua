local levels = {
	[1] = 100,
	[2] = 200,
	[3] = 300,
	[4] = 400,
	[5] = 500,
	[6] = 600,
	[7] = 700,
	[8] = 800,
	[9] = 900,
	[10] = 1000,
	[11] = 1100,
	[12] = 1200,
	[13] = 1300,
	[14] = 1400,
	[15] = 1500,
	[16] = 1600,
	[17] = 1700,
	[18] = 1800,
	[19] = 1900,
	[20] = 2000,
	[21] = 2100,
	[22] = 2200,
	[23] = 2300,
	[24] = 2400,
	[25] = 2500,
	[26] = 2600,
	[27] = 2700,
	[28] = 2800,
	[29] = 2900,
	[30] = 3000,
	[31] = 3100,
	[32] = 3200,
	[33] = 3300,
	[34] = 3400,
	[35] = 3500,
	[36] = 3600,
	[37] = 3700,
	[38] = 3800,
	[39] = 3900,
	[40] = 4000,
	[41] = 4100,
	[42] = 4200,
	[43] = 4300,
	[44] = 4400,
	[45] = 4500,
	[46] = 4600,
	[47] = 4700,
	[48] = 4800,
	[49] = 4900,
	[50] = 5000,
	[51] = 5100,
	[52] = 5200,
	[53] = 5300,
	[54] = 5400,
	[55] = 5500,
	[56] = 5600,
	[57] = 5700,
	[58] = 5800,
	[59] = 5900,
	[60] = 6000,
	[61] = 6100,
	[62] = 6200,
	[63] = 6300,
	[64] = 6400,
	[65] = 6500,
	[66] = 6600,
	[67] = 6700,
	[68] = 6800,
	[69] = 6900,
	[70] = 7000,
	[71] = 7100,
	[72] = 7200,
	[73] = 7300,
	[74] = 7400,
	[75] = 7500,
	[76] = 7600,
	[77] = 7700,
	[78] = 7800,
	[79] = 7900,
	[80] = 8000,
	[81] = 8100,
	[82] = 8200,
	[83] = 8300,
	[84] = 8400,
	[85] = 8500,
	[86] = 8600,
	[87] = 8700,
	[88] = 8800,
	[89] = 8900,
	[90] = 9000,
	[91] = 9100,
	[92] = 9200,
	[93] = 9300,
	[94] = 9400,
	[95] = 9500,
	[96] = 9600,
	[97] = 9700,
	[98] = 9800,
	[99] = 9900,
	[100] = 10000,
	[101] = 10100,
	[102] = 10200,
	[103] = 10300,
	[104] = 10400,
	[105] = 10500,
	[106] = 10600,
	[107] = 10700,
	[108] = 10800,
	[109] = 10900,
	[110] = 11000,
	[111] = 11100,
	[112] = 11200,
	[112] = 11300,
	[113] = 11400,
	[114] = 11500,
	[115] = 11600,
	[116] = 11700,
}



function checkLevel(player)
local playerExp = getElementData(player, "playerExp") or 0
local minExp = 9999
local level, exp = nil
	for i=1, #levels do
		exp = levels[i] - playerExp
		if exp >= 0 and exp < minExp then
			minExp = exp
			level = i
			if exp == 0 then
				level = level + 1			
			end
		end
	end
	setElementData(player, "nextLevel", minExp)
	return level
end

function checkUP(player)
	local playerLevel = checkLevel(player)	
	local expc = levels[playerLevel]
	return expc
end

function checkExp(player)
local playerExp = getElementData(player, "playerExp") or 0
	return playerExp
end

addEventHandler( "onClientElementDataChange", getRootElement(),
    function (dataName)
        if (getElementType ( source ) == "player" and dataName == "playerExp") then
			local level = checkLevel(source)
			if level ~= getElementData(source, "Level") then 
				setElementData(source, "Level", level)
			end
        end
    end
)

				
				
				
function addXP(player, nexp)
	if player and  nexp then
		local expa = (getElementData(player, "playerExp") or 0)
		setElementData(player, "playerExp", expa + nexp)
	end
end