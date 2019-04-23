addEvent("giveMoney",true)
addEventHandler("giveMoney",getRootElement(),
	function (amount, price)
	exports.art_main:giveMoney(source, amount)
--	exports.art_main:takeArtPoint(playerSource, price)
	end
)

function getMoney(playerSource)
	return getElementData(playerSource, "char.bankMoney") or 0
end

addEvent("giveBankMoney", true)
addEventHandler("giveBankMoney", getRootElement(),
	function(amount, price)
	setElementData(source, "char.bankMoney", getMoney(source) + amount)
	end)

addCommandHandler("asd1",
	function(source)
	local bankMoney = getElementData(source, "char.bankMoney")
	outputChatBox(bankMoney)
	end)