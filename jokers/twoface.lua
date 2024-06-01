local jokerInfo = {
	name = 'Two-Faced Joker [WIP]',
	config = {},
	text = {
		"Each played {C:attention}Ace{} becomes",
		"a {C:attention}2{}, each played {C:attention}2{}",
		"becomes an {C:attention}Ace{}",
	},
	rarity = 1,
	cost = 4,
	canBlueprint = false,
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
	