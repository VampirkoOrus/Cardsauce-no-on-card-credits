local jokerInfo = {
	name = 'Disturbed Joker [WIP]',
	config = {},
	text = {
		"Draw {C:attention}+1{} card each {C:mult}discard{}",
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
	if context.discard then
		G.FUNCS.draw_from_deck_to_hand(1)
		--draw_card(G.deck, G.hand, 100/2, 'up', true)
	end
end



return jokerInfo
	