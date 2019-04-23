local client = getLocalPlayer()
local theDriver

addEvent("sendTaxiRequest",true)
addEventHandler("sendTaxiRequest",root,
function (dr)
	theDriver = dr
	outputChatBox ( "#d9534f[TAXI] #FFFFFFVocê quer pagar por este serviço de táxi?",51,255,51)
	outputChatBox ( "#d9534f[TAXI] #FFFFFFTecle #428bca1 #FFFFFFpara aceitar. Tecle #d9534f2 #FFFFFFpara recusar.",0,255,0)	
	bindKey("1","down",taxiAccept)
	bindKey("2","down",taxiDecline)
end)

addEvent("removeTaxiRequest",true)
addEventHandler("removeTaxiRequest",root,
function ()
	unbindKey("1","down",taxiAccept)
	unbindKey("2","down",taxiDecline)	
end)

function taxiAccept()
	triggerServerEvent("requestTaxiAccept",client,client,true,theDriver)
	unbindKey("1","down",taxiAccept)
	unbindKey("2","down",taxiDecline)		
end

function taxiDecline()
	triggerServerEvent("requestTaxiAccept",client,client,false,theDriver)
	unbindKey("1","down",taxiAccept)
	unbindKey("2","down",taxiDecline)		
end