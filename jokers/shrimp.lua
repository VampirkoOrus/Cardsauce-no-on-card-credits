local jokerInfo = {
	name = 'Shrimp Joker [WIP]',
	config = {},
	text = {
		"{C:attention}Seals{} trigger an",
		"additional time",
	},
	rarity = 2,
	cost = 6,
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
	