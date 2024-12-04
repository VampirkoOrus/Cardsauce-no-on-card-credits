local jokerInfo = {
	name = "Cousin's Club",
	config = {
		extra = {
			chips = 0,
			chip_mod = 1
		}
	},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false
}

function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod} }
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_cousinsclub" })
end

function jokerInfo.calculate(self, card, context)
	if context.individual and context.cardarea == G.play and not card.debuff and context.other_card:is_suit('Clubs') then
		local chip = card.ability.extra.chip_mod
		if get_flush(context.scoring_hand) then
			chip = chip * 2
		end
		card.ability.extra.chips = card.ability.extra.chips + chip
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0,
			 func = function()
				 card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
				 return true
			 end
		}))
		return
	end
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
			chip_mod = card.ability.extra.chips, 
			colour = G.C.CHIPS
		}
	end
end



return jokerInfo
	