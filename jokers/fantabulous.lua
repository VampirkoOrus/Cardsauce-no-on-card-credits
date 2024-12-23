local jokerInfo = {
	name = 'Fantabulous Joker',
	config = {
		extra = {
			money_mod = 3
		},
	},
	rarity = 1,
	cost = 50,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
	return { vars = {card.sell_cost, card.ability.extra.money_mod} }
end

function jokerInfo.add_to_deck(self, card)
	card.sell_cost = 50
end

function jokerInfo.calculate(self, card, context)
	if context.end_of_round then
		card.sell_cost = card.sell_cost - card.ability.extra.money_mod
		return {
			message = localize('k_val_down'),
			colour = G.C.MONEY
		}
	end
end

return jokerInfo
	