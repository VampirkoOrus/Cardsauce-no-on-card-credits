local jokerInfo = {
	name = 'Disturbed Joker',
	config = {extra = 1},
	--[[text = {
		"Draw {C:attention}+1{} card each {C:mult}discard{}",
	},]]--
	rarity = 1,
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist4", set = "Other"}
	return { vars = {card.ability.draw} }
end

function jokerInfo.init(card)
	card.ability.extra = G.GAME.current_round.hands_played + 1
end

function jokerInfo.calculate(self, card, context)
	if context.setting_blind and not self.getting_sliced and not context.blueprint then
		card.ability.extra = 1
	end
end

return jokerInfo
	