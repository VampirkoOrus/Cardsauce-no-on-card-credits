local jokerInfo = {
	name = 'The NEW Joker! [WIP]',
	config = {},
	text = {
		"Played cards with an",
		"{C:attention}Enhancement{} give {C:mult}+#1#{} Mult",
		"when scored",
	},
	rarity = 1,
	cost = 4,
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
	