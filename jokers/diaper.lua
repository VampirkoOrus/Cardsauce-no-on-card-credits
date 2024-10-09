local jokerInfo = {
	name = 'Diaper Joker',
	config = {extra = {
		mult = 0,
		mult_mod = 2
	}},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "diapernote", set = "Other"}
	return { vars = {card.ability.extra.mult} }
end

function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.mult, card.ability.extra.mult_mod} }
end

function jokerInfo.calculate(self, card, context)
	if context.joker_main and context.cardarea == G.jokers and not card.debuff then
		return {
			message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
			mult_mod = card.ability.extra.mult,
			colour = G.C.MULT
		}
	end

end



return jokerInfo
	