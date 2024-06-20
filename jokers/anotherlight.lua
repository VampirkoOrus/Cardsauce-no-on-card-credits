local jokerInfo = {
	name = 'Another Light [WIP]',
	config = {},
	text = {
		"If {C:attention}poker hand{} is a {C:attention}Flush{},",
		"create a {C:purple}Tarot{} card for that suit",
		"{C:inactive}(Must have room){}",
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
	