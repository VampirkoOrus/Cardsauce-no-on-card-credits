local jokerInfo = {
	name = 'Two-Faced Joker',
	config = {},
	rarity = 1,
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_twoface" })
end


function jokerInfo.calculate(self, card, context)
	if context.individual and context.cardarea == G.play and not card.debuff then
		if not self.debuff then
			if context.other_card:get_id() == 14 then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_card:juice_up()
						card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_twoed'), colour = G.C.MONEY, instant = true})
						local suit_prefix = string.sub(context.other_card.base.suit, 1, 1)..'_'
						context.other_card:set_base(G.P_CARDS[suit_prefix..2])
						--delay(G.SETTINGS.GAMESPEED)
						return true
					end
				}))
			elseif context.other_card:get_id() == 2 then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_card:juice_up()
						card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_aced'), colour = G.C.MONEY, instant = true})
						local suit_prefix = string.sub(context.other_card.base.suit, 1, 1)..'_'
						context.other_card:set_base(G.P_CARDS[suit_prefix..'A'])
						--delay(G.SETTINGS.GAMESPEED)
						return true
					end
				}))
			end
		end
	end
end



return jokerInfo
	