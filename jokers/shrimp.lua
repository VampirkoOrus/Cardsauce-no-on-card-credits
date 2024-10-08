local jokerInfo = {
	name = 'Shrimp Joker [WIP]',
	config = {},
	text = {
		"{C:attention}Seals{} trigger an",
		"additional time",
	},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true
}

--[[
function jokerInfo.loc_vars(self, info_queue, card)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)

end
]]--

--[[local get_end_of_round_effect_ref = Card.get_end_of_round_effect

function Card:get_end_of_round_effect(context)
	get_end_of_round_effect_ref(self, context)
	local ret = {}
	if self.seal == 'Blue' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        local card_type = 'Planet'
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = (function()
                if G.GAME.last_hand_played then
                    local _planet = 0
                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == G.GAME.last_hand_played then
                            _planet = v.key
                        end
                    end
                    local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                end
                return true
            end)}))
        card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        ret.effect = true
    end
	return ret
end]]--

function jokerInfo.calculate(self, card, context)
	if context.repetition and not self.debuff then
		if context.end_of_round and context.cardarea == G.hand then
			if (next(context.card_effects[1]) or #context.card_effects > 1) then
				if context.other_card.seal == 'Blue' then 
					return {
						message = localize('k_again_ex'),
						repetitions = 1,
						card = self
					}
				end
			end
		end
		if context.cardarea == G.play then
			if context.other_card.seal == 'Red' then 
				return {
					message = localize('k_again_ex'),
					repetitions = 1,
					card = self
				}
			end
			if context.other_card.seal == 'Gold' then 
				ease_dollars(3)
				return {
					message = localize('k_again_ex'),
					repetitions = 0,
					card = self
				}
			end
		end
	end
	if context.discard and not self.debuff then
		if context.other_card.seal == 'Purple' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
							local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, '8ba')
							card:add_to_deck()
							G.consumeables:emplace(card)
							G.GAME.consumeable_buffer = 0
						return true
					end)}))
				card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
				return {
					message = localize('k_again_ex'),
					repetitions = 1,
					card = self
				}
			
		end
	end
end



return jokerInfo
	