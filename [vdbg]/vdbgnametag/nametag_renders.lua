local playersList = {}
local vehiclesList = {}
local roadblockList = {}
local lPlayer = getLocalPlayer()
local customFont = dxCreateFont ("arquivos/opensans.ttf",20)




addEventHandler ("onClientResourceStart",getResourceRootElement(getThisResource()),
	setTimer ( 
	function ()
		local players = getElementsByType ("player",getRootElement(),true)
		for k,v in ipairs(players) do
			if v ~= lPlayer then
				table.insert(playersList,v)
				playersList[v] = true
				setPlayerNametagShowing (v,false)
			end
		end
	end
	, 1000, 0)
)

local sx,sy = guiGetScreenSize ()
local options = {}
options.scaleMultiplier = (sx+1920)/(1920*2)
options.scale = 1
options.scalemin = 0.17
options.descscale = 0.64
options.descscalemin = 0.1
options.distance = 20
options.aimdistance = options.distance-options.distance*0.15
options.descdistance = 10
options.alpha = 255
options.alphamin = 0
options.alphadistance = 5
options.alphadiff = options.distance - options.alphadistance
options.disabled = false

local optionsVeh = {}
optionsVeh.scaleMultiplier = (sx+1920)/(1920*2)
optionsVeh.scale = 0.64
optionsVeh.scalemin = 0.1
optionsVeh.distance = 20
optionsVeh.alpha = 255
optionsVeh.alphamin = 0
optionsVeh.alphadistance = 5
optionsVeh.alphadiff = optionsVeh.distance - optionsVeh.alphadistance

local optionsRB = {}
optionsRB.scaleMultiplier = (sx+1920)/(1920*2)
optionsRB.scale = 1
optionsRB.scalemin = 0.17
optionsRB.distance = 20
optionsRB.alpha = 255
optionsRB.alphamin = 0
optionsRB.alphadistance = 5
optionsRB.alphadiff = optionsRB.distance - optionsRB.alphadistance

local maxScaleCurve = { {0, 0}, {1.8,1.8}, {2,2} }
local textScaleCurve = { {0, 0.8}, {0.8, 1.2}, {99, 99} }
local textAlphaCurve = { {0, 0}, {25, 100}, {120, 190}, {255, 190} }

local hudX,hudY = sx*0.781,sy*0.227


addEventHandler ("onClientRender",getRootElement(),
	function ()
		local afk = getElementData (getLocalPlayer(),"afk")
		if afk then
			dxDrawRectangle (0,0,sx,sy,tocolor(0,0,0,225),true)
			local width,height = 512,256
			dxDrawImage (sx/2-width/2,sy/2-height/2,width,height,"arquivos/afk2.png",0,0,0,tocolor(255,255,255,255),true)
		end
	end
)

addEventHandler ("onClientRender",getRootElement(),
	function ()
		if not options.disabled then
				local x,y,z = getCameraMatrix ()
				local weapon = getPedWeapon(getLocalPlayer())
				local target = false
				if weapon == 34 or weapon == 43 then
					target = getPedTarget (getLocalPlayer())
				end
				for i,v in pairs(playersList) do
					if i and isElement(i) then
						local alpha = getElementAlpha (i)
						if (getElementData (localPlayer, "tagstate") == false) then 
						if (exports.VDBGaming:isServerVDBG("adminverif","02102015") == false) then return end
								local px,py,pz = getElementPosition (i)
								local dist = getDistanceBetweenPoints3D (x,y,z,px,py,pz)
								if target and target == i and dist > options.aimdistance then
									dist = options.distance*0.2
								end
								local notModifitedDist = dist
								if notModifitedDist < options.distance then
									local headPosX,headPosY,headPosZ = getPedBonePosition (i,4) -- pozycja glowy
									if headPosX and headPosY and headPosZ then
										local clear = isLineOfSightClear (x,y,z,headPosX,headPosY,headPosZ,true,false,false,true,false,false,false)
										if clear then
											headPosZ = headPosZ+0.38
											local sx,sy = getScreenFromWorldPosition (headPosX,headPosY,headPosZ,25,false)
											if sx then
												local sx,sy = math.floor(sx),math.floor(sy)
												local name = getElementData(i, "AccountData:Name")
												if name then
													
													local scale = 1/(options.scale * (dist / options.distance))
													local progress = dist/options.distance
													local scale = interpolateBetween (
														options.scale,0,0,
														options.scalemin,0,0,
														progress,"OutQuad"
													)
													local scale = scale * options.scaleMultiplier
													local dist = dist-(options.distance/3)
													local opdist = options.distance-(options.distance/3)
													if dist < 0 then
														dist = 0
													end
													local progress2 = dist/opdist
													local textalpha = interpolateBetween (
														options.alpha,0,0,
														options.alphamin,0,0,
														progress2,"Linear"
													)
													
													
													
													local team = getTeamName(getPlayerTeam(i)) or "DESEMPREGADO"
													local teamText = ""
													if team == "Administração" then
														teamText = " #FFFFFF[" .. team .. "]"
													elseif team == "Criminoso" then
														teamText = " #d9534f[" .. team .. "]"
													elseif team == "Policial" then
														teamText = " #4aabd0[" .. team .. "]"
													elseif team == "Civilizante" then
														teamText = " #2F7CCC[" .. team .. "]"
													elseif team == "Emergencia" then
														teamText = " #00ffff[" .. team .. "]"
													elseif team == "Desempregado" then
														teamText = " #2F7CCC[" .. team .. "]"
													elseif team == "Convidado" then
														teamText = " #2F7CCC[" .. team .. "]"
													end
													
													local id = getElementData(i,"id")
													local idText = ""
													if id then
														idText = "#2F7CCC(" .. id .. ")#ffffff "
													end
														
													local gang = getElementData (i,"Group") or ""
													if gang then
														gangtext = " #d9534f[" .. gang .. "]"
													end
													
													local mutado = getElementData (i,"mutado.admin") or false
													if mutado = true then
														mutetext = " #ffa500[MUTADO]"
													end
													
													local text = idText .. name .. teamText .. gangtext .. mutetext
													local font = customFont
													
													local textWidth = dxGetTextWidth (text,scale,font)
													local textNameWidth = dxGetTextWidth(text,scale,font)
													local textHeight = dxGetFontHeight (scale,font)
													local posX = sx-textWidth/3.5
													local posY = sy-textHeight+30
													dxDrawText (text,posX,posY - 30,0,0,baseColor,scale,font,"left","top",false,false,false,true,true)
													if getElementData (i,"afk") then
															if progress < 1 then
																local by = posY-5
																local scale = interpolateBetween (
																	0.7,0,0,
																	0,0,0,
																	progress,"OutQuad"
																)
																local width,height = 256*scale,128*scale
																local ix,iy = sx-width/2,by-height
																dxDrawImage (ix,iy - 45,width,height,"arquivos/afk.png",0,0,0,tocolor(255,255,255,textalpha))
															end
													end					
													local estrelas = getElementData(i,"Wanted") or "0"
													if estrelas == 1 then
																if progress < 1 then
																local by = posY-5
																local scale = interpolateBetween (
																	0.7,0,0,
																	0,0,0,
																	progress,"OutQuad"
																)
																local ewidth,eheight = 291*scale,28*scale
																local ix,iy = sx-ewidth/2,by-eheight
																dxDrawImage (ix,iy - 30,ewidth,eheight,"arquivos/1.png",0,0,0,tocolor(255,255,255,textalpha))
															end
													end	
													if estrelas == 2 then
																if progress < 1 then
																local by = posY-5
																local scale = interpolateBetween (
																	0.7,0,0,
																	0,0,0,
																	progress,"OutQuad"
																)
																local ewidth,eheight = 291*scale,28*scale
																local ix,iy = sx-ewidth/2,by-eheight
																dxDrawImage (ix,iy - 30,ewidth,eheight,"arquivos/2.png",0,0,0,tocolor(255,255,255,textalpha))
															end
													end	
													if estrelas == 3 then
																if progress < 1 then
																local by = posY-5
																local scale = interpolateBetween (
																	0.7,0,0,
																	0,0,0,
																	progress,"OutQuad"
																)
																local ewidth,eheight = 291*scale,28*scale
																local ix,iy = sx-ewidth/2,by-eheight
																dxDrawImage (ix,iy - 30,ewidth,eheight,"arquivos/3.png",0,0,0,tocolor(255,255,255,textalpha))
															end
													end	
													if estrelas == 4 then
																if progress < 1 then
																local by = posY-5
																local scale = interpolateBetween (
																	0.7,0,0,
																	0,0,0,
																	progress,"OutQuad"
																)
																local ewidth,eheight = 291*scale,28*scale
																local ix,iy = sx-ewidth/2,by-eheight
																dxDrawImage (ix,iy - 30,ewidth,eheight,"arquivos/4.png",0,0,0,tocolor(255,255,255,textalpha))
															end
													end	
													if estrelas == 5 then
																if progress < 1 then
																local by = posY-5
																local scale = interpolateBetween (
																	0.7,0,0,
																	0,0,0,
																	progress,"OutQuad"
																)
																local ewidth,eheight = 291*scale,28*scale
																local ix,iy = sx-ewidth/2,by-eheight
																dxDrawImage (ix,iy - 30,ewidth,eheight,"arquivos/5.png",0,0,0,tocolor(255,255,255,textalpha))
															end
													end	
													if estrelas == 6 then
																if progress < 1 then
																local by = posY-5
																local scale = interpolateBetween (
																	0.7,0,0,
																	0,0,0,
																	progress,"OutQuad"
																)
																local ewidth,eheight = 291*scale,28*scale
																local ix,iy = sx-ewidth/2,by-eheight
																dxDrawImage (ix,iy - 30,ewidth,eheight,"arquivos/6.png",0,0,0,tocolor(255,255,255,textalpha))
															end
													end	
												else
													outputDebugString ("nick ta bugado",3)
												end
											end
										end
									end
								end
						end
					else
						playersList[i] = nil
					end
				end
		end
	end
)

function togNames (state)
	outputChatBox (tostring(state) .. ", " .. tostring(options.disabled))
	if state == options.disabled then
		options.disabled = not state
	end
end

addCommandHandler ("tognames",
	function ()
		options.disabled = not options.disabled
	end
)

addCommandHandler ("drawd",
	function (cname,dist)
		local dist = tonumber(dist)
		if dist and dist >= 10 and dist <= 6000 then
			setFarClipDistance (dist)
		else
			exports.box:showBox ("info","Musisz podać wartość z przedziału 10 do 6000, standardowa wartość to 800.")
		end
	end
)

hitTimers = {}
hitPlayers = {}

addEventHandler ("onClientPlayerDamage",getRootElement(),
	function (att,weapon,part,loss)
		local player = source
		hitPlayers[player] = true
		if hitTimers[player] and isTimer(hitTimers[player]) then
			killTimer(hitTimers[player])
		end
		hitTimers[player] = setTimer (
			function ()
				hitPlayers[player] = false
			end
		,3000,1)
	end
)

function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end
