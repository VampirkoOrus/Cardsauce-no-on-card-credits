local jokerInfo = {
	name = 'Depressed Brother',
	config = {},
	text = {
		"This Joker gains {C:chips}+13{} Chips",
		"if played hand triggers",
		"the {C:attention}Boss Blind{} ability",
		"{C:inactive}(Currently {}{C:chips}+#1#{} {C:inactive}Chips){}",
	},
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "guestartist1", set = "Other"}
end

function jokerInfo.loc_vars(self, info_queue, card)
	return { card.ability.extra.chips }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = {
		chips = 13,
		chip_mod = 13
	}
end

function jokerInfo.calculate(self, card, context)
	if context.joker_main and context.cardarea == G.jokers then
		if G.GAME.blind.triggered and not (context.blueprint or context.repetition or context.individual) then 
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
			card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
		end

		return {
			message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
			chip_mod = card.ability.extra.chips, 
			colour = G.C.CHIPS
		}
	end
end



return jokerInfo
	