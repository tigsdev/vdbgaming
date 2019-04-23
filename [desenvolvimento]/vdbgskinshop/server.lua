
function JsonSkinSet(source,skin)
	
	takePlayerMoney ( source, 10000 )
	exports.VDBG_infobox:showBox(client,"info","Você Comprou uma Nova Skin!")
	local cur = tonumber ( getElementData ( source, "VDBGUser.UnemployedSkin" ) ) or 28
	setElementData ( source, "VDBGUser.UnemployedSkin", skin )
	local t = getPlayerTeam ( source )
	if ( getElementModel ( source ) == cur ) then
		setElementModel ( source, skin )
	else
		-- exports.VDBG_infobox:showBox(client,"aviso","Para Trocar sua skin , Você tem que sair do seu trabalho.")               
	end
end
addEvent("eg_skinsetS",true)
addEventHandler("eg_skinsetS", resourceRoot, JsonSkinSet)

