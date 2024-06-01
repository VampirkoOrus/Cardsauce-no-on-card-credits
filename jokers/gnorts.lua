local jokerInfo = {
	name = 'Rekoj Gnorts [WIP]',
	config = {},
	text = {
		"Allows {C:attention}Straights{} to be made",
		"with {C:attention}Aces{} in the middle",
		"{C:inactive}(ex:{} {C:attention}3 2 A K Q{}{C:inactive}){}",
	},
	rarity = 2,
	cost = 7,
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
	