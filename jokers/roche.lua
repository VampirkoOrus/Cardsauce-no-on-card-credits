local jokerInfo = {
	name = 'Motorcyclist Joker [WIP]',
	config = {},
	text = {
		"If round ends with exactly {C:money}$#1#{},",
		"create a {C:planet}Planet{} card for",
		"your most-used hand",
	},
	rarity = 1,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	