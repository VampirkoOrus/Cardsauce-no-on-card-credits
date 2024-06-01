local jokerInfo = {
	name = 'Speed Joker [WIP]',
	config = {},
	text = {
		"Draw {C:attention}+1{} card each {C:chips}hand{}",
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
	