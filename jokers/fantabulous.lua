local jokerInfo = {
	name = 'Fantabulous Joker',
	config = {
		money_mod = 3,
		sell_val = 50
	},
	rarity = 1,
	cost = 50,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
	return { vars = {card.ability.sell_val, card.ability.money_mod} }
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_fantabulous" })
	card.sell_cost = card.ability.sell_val
end

function jokerInfo.calculate(self, card, context)
	if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
		card.ability.sell_val = card.ability.sell_val - card.ability.money_mod
		card.sell_cost = card.ability.sell_val
		return {
			message = localize('k_val_down'),
			colour = G.C.MONEY,
			card = card
		}
	end
end

return jokerInfo
	