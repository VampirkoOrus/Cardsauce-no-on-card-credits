local jokerInfo = {
	name = 'PAC-MAN Incident',
	config = {},
	text = {
		"This Joker gains {C:mult}+5{} Mult if",
        "round ends with your chips",
        "within {C:attention}10%{} of the {C:attention}Blind{}",
        "{C:inactive}(Currently {}{C:mult}+#1#{} {C:inactive}Mult){}",
	},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false
}


function jokerInfo.loc_vars(self, info_queue, card)
	return { card.ability.extra.mult }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = {
		mult = 0,
		mult_mod = 5
	}
end


function jokerInfo.calculate(self, card, context)
	if context.end_of_round and not self.debuff and not context.individual and not context.repetition and not context.blueprint then
		if G.GAME.chips <= (G.GAME.blind.chips * 1.1) then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
			card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.MULT})
		end
	end
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
			mult_mod = card.ability.extra.mult, 
		}
	end
end



return jokerInfo
	