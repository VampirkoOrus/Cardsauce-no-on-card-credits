local jokerInfo = {
	name = 'Diaper Joker',
	config = {},
	text = {
		"{C:mult}+2{} Mult for each {C:attention}2",
		"in your {C:attention}full deck",
		"{C:inactive}(Currently {}{C:mult}+#1#{} {C:inactive}Mult){}",
	},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "diapernote", set = "Other"}
end

function jokerInfo.loc_vars(self, info_queue, card)
	return { card.ability.extra.mult }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = {
		mult = 0,
		mult_mod = 2
	}
end

function jokerInfo.calculate(self, card, context)
	if context.joker_main and context.cardarea == G.jokers and not self.debuff then
		return {
			message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
			mult_mod = card.ability.extra.mult,
			colour = G.C.MULT
		}
	end

end



return jokerInfo
	