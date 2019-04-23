function fanFunction(thePlayer)
	local ativarjp = false
	local vip = getVipLevelFromName ( getElementData ( thePlayer, "VIP" ) )
	if ( vip ~= 0 ) then ativarjp = true else ativarjp = false 
	--exports.VDBGMessages:sendClientMessage ( "Mochila a jato é só para VIP ( Compre em: www.vdbg.org ) ", thePlayer, 255, 0, 0 )
	end
	if ( ativarjp ~= false ) then
	if ( isPlayerVIP ( thePlayer ) ) then
		 if doesPedHaveJetPack ( thePlayer ) then
            removePedJetPack ( thePlayer )
            return 
        end
		if not doesPedHaveJetPack ( thePlayer ) then
               givePedJetPack ( thePlayer )
         end
	end
end
end

addCommandHandler ( "jetpack", fanFunction )
addCommandHandler ( "jp", fanFunction )