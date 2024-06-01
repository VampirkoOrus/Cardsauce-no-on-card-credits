local jokerInfo = {
	name = 'That\'s Werewolves [WIP]',
	config = {},
	text = {
		"{X:mult,C:white}X3{} Mult, but",
		"cannot play hands",
		"containing a {C:attention}Flush{}",
	},
	rarity = 2,
	cost = 7,
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
	