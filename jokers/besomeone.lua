local jokerInfo = {
	name = 'Be Someone Forever [WIP]',
	config = {},
	text = {
		"Played {C:attention}High Cards{}",
		"are redrawn",
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
	