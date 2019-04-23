addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
	function()
		exports.scoreboard:scoreboardAddColumn ( "FPS", root, 20 )
	end
)