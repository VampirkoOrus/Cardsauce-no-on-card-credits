local jokerInfo = {
	name = 'Depressed Brother',
	config = {
		extra = {
			chips = 0,
			chip_mod = 50
		}
	},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist1", set = "Other"}
	return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod} }
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_sponge" })
end

function jokerInfo.calculate(self, card, context)
	if context.cardarea == G.jokers then
		if G.GAME.blind.triggered and not (context.blueprint or context.repetition or context.individual or context.after or context.before) then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
		end
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
				chip_mod = card.ability.extra.chips,
				colour = G.C.CHIPS
			}
		end
	end
end



return jokerInfo
	