local jokerInfo = {
	name = 'Fisheye',
	config = {},
	text = {
		"{C:chips}+#1#{} Chips",
	},
	rarity = 1,
	cost = 1,
	blueprint_compat = true,
	eternal_compat = true
}


function jokerInfo.loc_vars(self, info_queue, card)
	return { card.ability.extra.chips }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = {
		chips = 15
	}
end

function jokerInfo.calculate(self, card, context)
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
			chip_mod = card.ability.extra.chips, 
			colour = G.C.CHIPS
		}
	end
end


return jokerInfo
	