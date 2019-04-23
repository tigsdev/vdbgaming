addEventHandler ( "onPlayerWasted", root,
	function ( _, killer, weapon, _, stealth )
		if ( stealth ) then
				outputChatBox ( "#d9534f[VDBG.ORG] #FFFFFFVocê matou de faca, isso é proíbido e como punição você foi preso.", killer, 255, 255, 255, true )
				exports['VDBGPolice']:jailPlayer ( killer, 200, false, source, "Police Arrest" )
			end
		end
);