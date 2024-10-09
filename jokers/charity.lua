local jokerInfo = {
	name = 'Vinesauce is HOPE',
	config = {extra = {
		keepNoInterest = G.GAME.modifiers.no_interest,
		mult = 0,
		mult_gain = 0
	}},
	rarity = 3,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false
}


function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.mult } }
end

--[[function jokerInfo.set_ability(self, card, initial, delay_sprites)
	
end]]--

function jokerInfo.calculate(self, card, context)
	
	if context.end_of_round and not card.debuff and not context.individual and not context.repetition and not context.blueprint then
		card.ability.extra.mult_gain = 0
		if not G.GAME.modifiers.no_interest then
			card.ability.extra.mult_gain = G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5)
		end
		card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
		if card.ability.extra.mult_gain ~= 0 then
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{ type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult_gain} }, colour = G.C.MULT})
		end
	end
	
	if context.joker_main and context.cardarea == G.jokers then
		if card.ability.extra.mult ~= 0 then
			return {
				message = localize { type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult} },
				mult_mod = card.ability.extra.mult,
			}
		end
	end
end



return jokerInfo
	