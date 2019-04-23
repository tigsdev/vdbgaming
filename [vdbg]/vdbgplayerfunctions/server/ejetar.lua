function print ( msg, p, r, g, b )
	return outputChatBox ( msg, p, 255, 255, 255, true )
end


function ejectPlayer ( p, _, nab )
	if nab	then
		if isPedInVehicle ( p )	then
			if getPedOccupiedVehicleSeat ( p ) == 0	then
			local ej = getPlayerFromNamePart ( nab )
			local veh = getPedOccupiedVehicle ( p )
				if ej	then
					if ej ~= p	then
						if getPedOccupiedVehicle ( ej ) == veh	then
						removePedFromVehicle ( ej )
						print ( "#d9534f[VDBG.ORG] #FFFFFFVocê ejetou #428bca"..getPlayerName(ej).." #FFFFFFde seu veículo!", p, 255, 255, 0, true, 8 )
						print ( "#d9534f[VDBG.ORG] #FFFFFFVocê foi ejetado do veículo por: #428bca"..getPlayerName(p), ej, 255, 255, 0, true, 8 )
						else print ( "#d9534f[VDBG.ORG] #428bca"..nab.." #FFFFFFvocê não está em um veículo", p, 255, 255, 0, true, 8 )
						end
					else print ( "#d9534f[VDBG.ORG] #FFFFFFVocê não pode ejetar-se.", p, 255, 255, 0, true, 8 )
					end
				else print ( "#d9534f[VDBG.ORG] #428bca"..nab.." #FFFFFFeste não é seu veículo.", p, 255, 255, 0, true, 8 )
				end
			else print ( "#d9534f[VDBG.ORG] #FFFFFFVocê não é o condutor deste veículo", p, 255, 255, 0, true, 8 )
			end
		else print ( "#d9534f[VDBG.ORG] #FFFFFFVocê não está em um veículo", p, 255, 255, 0, true, 8 )
		end
	else print ( "#d9534f[VDBG.ORG] #FFFFFF/ejetar #428bca[nomedojogador]", p, 255, 255, 0, true, 8 )
	end
end
addCommandHandler ( "ejetar", ejectPlayer )