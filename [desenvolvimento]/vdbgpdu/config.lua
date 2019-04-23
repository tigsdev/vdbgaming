
function dashboard()
   if  getElementData ( localPlayer, "opendashboard") == true then 
	showChat(false)
 end
 if  getElementData ( localPlayer, "opendashboard") == true then return end
 

 
 if getElementData ( localPlayer, "hidechat") == true then
	showChat(false)
 end
 
 if getElementData ( localPlayer, "hidechat") == false then
	showChat(true)
 end
 
 
 
 
end
addEventHandler("onClientRender",getRootElement(),dashboard)

function hud()
 if getElementData ( localPlayer, "hidehud") == true then
 --
 end
 
 if getElementData ( localPlayer, "hidehud") == false then
 --
 end
end
addEventHandler("onClientRender",getRootElement(),hud)


function velocimetro()
 if getElementData ( localPlayer, "hidevelocimetro") == true then
 --
 end
 
 if getElementData ( localPlayer, "hidevelocimetro") == false then
 --
 end
end
addEventHandler("onClientRender",getRootElement(),velocimetro)


function velocimetro()
 if getElementData ( localPlayer, "hideradar") == true then
--
 end
 
 if getElementData ( localPlayer, "hideradar") == false then
 --
 end
end
addEventHandler("onClientRender",getRootElement(),velocimetro)