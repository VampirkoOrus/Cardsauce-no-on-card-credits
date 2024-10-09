local jokerInfo = {
	name = 'The NEW Joker!',
	config = {
		extra = {
			mult = 4
		}
	},
	--[[text = {
		"Played cards with an",
		"{C:attention}Enhancement{} give {C:mult}+#1#{} Mult",
		"when scored",
	},]]--
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}


function jokerInfo.loc_vars(self, info_queue, card)
	return {vars = {card.ability.extra.mult}}
end

--[[
function jokerInfo.set_ability(self, card, initial, delay_sprites)

end
]]--

function jokerInfo.calculate(self, card, context)
	if context.individual and context.cardarea == G.play and not self.debuff then
		if context.other_card.ability.effect ~= 'Base'
		then
			return {
				mult = card.ability.extra.mult,
				card = self
			}
		end
	end
end



return jokerInfo
	