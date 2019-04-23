function useItem(id, slot, item, value, count)
	local vehicle = getPedOccupiedVehicle ( localPlayer )
	local fome = getElementData(getLocalPlayer(), "AccountData.Fome")
	local sede = getElementData(getLocalPlayer(), "AccountData.Sede")
	if(item==1 and count>0)then --Telefone
		exports.VDBGPhone:toggleCelular()
	elseif(item==30 and count>0 and getElementData ( vehicle, "fuel" ) < 100 )then
		if ( getVehicleController ( vehicle ) == localPlayer ) then
			local f = getElementData ( vehicle, "fuel" )
			 local v = getVehicleName ( vehicle )
			if ( f <= 90 ) then
			setElementData ( vehicle, "fuel", f + 10 )
			outputChatBox("#d9534f[VDBG.ORG] #ffffffVocê abasteceu #acd373(10%) #ffffff de #1c8ae8 combustível #ffffff no veículo #1c8ae8 "..v..".", 255, 255, 255, true )
			else 
			outputChatBox("#d9534f[VDBG.ORG] #ffffffSeu combustível deve estar a baixo de #acd373(90%) #ffffff para usar este galão.", 255, 255, 255, true )
			end
			else outputChatBox("#d9534f[VDBG.ORG] #ffffffVocê não é o motorista deste veículo.", 255, 255, 255, true )
		end
	--- Cluckin bell
	elseif(item==31 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==32 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==33 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==34 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==35 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==36 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==37 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==38 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
		
	-- Bebidas
	elseif(item==41 and count>0 and sede < 100 )then
		addHunger(getLocalPlayer(), "sede")	
	elseif(item==42 and count>0 and sede < 100 )then
		addHunger(getLocalPlayer(), "sede")
	elseif(item==43 and count>0 and sede < 100 )then
		addHunger(getLocalPlayer(), "sede")
	elseif(item==44 and count>0 and sede < 100 )then
		addHunger(getLocalPlayer(), "sede")
	elseif(item==45 and count>0 and sede < 100 )then
		addHunger(getLocalPlayer(), "sede")
	elseif(item==46 and count>0 and sede < 100 )then
		addHunger(getLocalPlayer(), "sede")
	elseif(item==47 and count>0 and sede < 100 )then
		addHunger(getLocalPlayer(), "sede")
		
	-- Burger Shot		
	elseif(item==51 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==52 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==53 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==54 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==55 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==56 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==57 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==58 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==59 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==60 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
		
	-- Pizzaria	
	elseif(item==61 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==62 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==63 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==64 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==65 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==66 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==67 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==68 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==69 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
	elseif(item==70 and count>0 and fome < 100 )then
		addHunger(getLocalPlayer(), "fome")
		elseif(item==118 and count>0)then
		triggerServerEvent("addArmour", getLocalPlayer(), getLocalPlayer())

	
	elseif(items[item][5] and count>0)then 
		if (item == 111 and getElementData(getLocalPlayer(), "Job")  ~= "Policial" or "Detective" or "Administração" or "PFederal") then return
		outputChatBox("#d9534f[VDBG.ORG] #ffffffEste item só é permitido para uso de oficiais da lei!", 255, 255, 255, true )
		end
		triggerServerEvent("toggleGun", getLocalPlayer(), getLocalPlayer(), slot, item)		

	elseif(item==107 and count>0)then
		outputChatBox("Munições para ser usada com AK47")
	else
		outputChatBox("#d9534f[VDBG.ORG] #ffffffNenhuma função foi detectada para este item, #d9534fdescarte automático #fffffffoi aplicado.", 255, 255, 255, true )
	end
end

function addHunger(element, hungertype)
local fome = getElementData(element, "AccountData.Fome")
local sede = getElementData(element, "AccountData.Sede")
if hungertype == "fome" then
setElementData ( element, "AccountData.Fome", fome + 25 )
end
if fome > 100 then 
setElementData ( element, "AccountData.Fome", 100 )
end

if hungertype == "sede" then
setElementData ( element, "AccountData.Sede", sede + 25 )
end
if sede > 100 then 
setElementData ( element, "AccountData.Sede", 100 )
end

end