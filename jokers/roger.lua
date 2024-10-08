local jokerInfo = {
	name = 'Mr. Roger [WIP]',
	config = {},
	text = {
		"This Joker gains {X:mult,C:white}X0.1{} Mult",
		"for each {C:attention}finger{} played this {C:attention}Blind{}",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
	},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "rogernote", set = "Other"}
end

function jokerInfo.loc_vars(self, info_queue, card)
	return { card.ability.extra.x_mult }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = {
		x_mult = 1 + 0.5*(G.GAME.current_round.hands_played)
	}
end

function jokerInfo.calculate(self, card, context)
	if context.joker_main and context.cardarea == G.jokers then
		card.ability.extra.x_mult = 1 + 0.5*(G.GAME.current_round.hands_played)
		if card.ability.extra.x_mult ~= 1 then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
				Xmult_mod = card.ability.extra.x_mult, 
				--colour = G.C.MULT
			}
		end
	end
	if context.end_of_round and not context.blueprint then
		card.ability.extra.x_mult = 1
	end
end



return jokerInfo
	