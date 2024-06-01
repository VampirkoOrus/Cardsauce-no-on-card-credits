local jokerInfo = {
	name = 'Cryberries [WIP]',
	config = {},
	text = {
		"idfk",
	},
	rarity = 1,
	cost = 0,
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
	