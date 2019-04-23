local attackTargetState = false
local attackStartTick = 0
local currentAttackerPosX,currentAttackerPosY = 0,0
local duration = 3500
local fadeTime = 1000
local width = 256
local height = 64
local offset = 182
local sx,sy = guiGetScreenSize ()
local centerX,centerY = sx/2,sy/2

addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), 
	function ( attacker, weapon, bodypart, loss )
		if attacker and getElementType(attacker) == "player" then
			if weapon and weapon > 9 then
				currentAttackerPosX,currentAttackerPosY = getElementPosition (attacker)
				attackStartTick = getTickCount ()
				if attackTargetState == false then
					attackTargetState = true
					addEventHandler ("onClientRender",getRootElement(),renderAttackerCircle)
				end
			end
		end
	end
)

function renderAttackerCircle ()
	local cTick = getTickCount ()
	local delay = cTick - attackStartTick
	if delay <= (duration+fadeTime) then
		local alpha = 255
		if delay > duration then
			local delay = delay - duration
			local progress = delay / fadeTime
			alpha = interpolateBetween (
				255,0,0,
				0,0,0,
				progress,"Linear"
			)
		end
		local angle = calculateAttackerImageAngle ()
		if angle then
			local rot = math.rad(angle)
			local x1 = (offset+height)*math.sin(rot)
			local y1 = (offset+height)*math.cos(rot)
			local x2 = x1-(0.5*width*math.cos(rot))
			local y2 = y1 + (0.5*width*math.sin(rot))
			local x,y = centerX+x2,centerY-y2
			if x and y then
				dxDrawImage (x,y,width,height,"arquivos/dano.png",angle,-128,-32,tocolor(255,255,255,alpha),true)
			end
		end
	else
		attackTargetState = false
		removeEventHandler ("onClientRender",getRootElement(),renderAttackerCircle)
	end
end

function calculateAttackerImageAngle ()
	local px,py = getElementPosition (getLocalPlayer())
	local angle1 =  findRotation(px,py,currentAttackerPosX,currentAttackerPosY)
	local x,y,z,tx,ty,tz = getCameraMatrix ()
	local angle2 =  findRotation(x,y,tx,ty)
	if angle1 and angle2 then
		local imgAngle = angle1 - angle2
		return -imgAngle
	end
end

function findRotation(x1,y1,x2,y2)
	if x1 and y1 and x2 and y2 then
 
		local t = -math.deg(math.atan2(x2-x1,y2-y1))
		if t < 0 then t = t + 360 end;
		return t;
		
	end
end