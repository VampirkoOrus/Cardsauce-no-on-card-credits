local jokerInfo = {
	name = 'DIS JOAKERRR',
	config = {extra = {messageIndex = 0}},
	text = {
		"eACH SKOARD DEE EMC {C:attention}2{}",
		"OR BERSONA {C:attention}5{}",
		"GAET RANDUM {C:attention}EHANCEMAENT{}",
	},
	rarity = 1,
	cost = 6,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

--[[
function jokerInfo.loc_vars(self, info_queue, card)
	return { G.GAME.probabilities.normal }
end
]]--

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	
end

function jokerInfo.calculate(self, card, context)
	if context.cardarea == G.jokers and context.before and not card.debuff and not context.blueprint then
		local enhancements = {
			[1] = G.P_CENTERS.m_bonus,
			[2] = G.P_CENTERS.m_mult,
			[3] = G.P_CENTERS.m_wild,
			[4] = G.P_CENTERS.m_glass,
			[5] = G.P_CENTERS.m_steel,
			[6] = G.P_CENTERS.m_stone,
			[7] = G.P_CENTERS.m_gold,
			[8] = G.P_CENTERS.m_lucky,
		}
		local messages = {
			[1] = "BLS BLAY GAME BINTY!!!",
			[2] = "ONLY 20 MINOOT!!!",
		}
		for k, v in ipairs(context.scoring_hand) do 
			if v:get_id() == 2 or v:get_id() == 5 then 
				v:set_ability(enhancements[pseudorandom('OONDORTOOL', 1, 8)], nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
				card_eval_status_text(self, 'extra', nil, nil, nil, {message = messages[(card.ability.extra.messageIndex % 2) + 1], colour = G.C.MONEY})
				card.ability.extra.messageIndex = card.ability.extra.messageIndex + 1
			end
		end
	end
end



return jokerInfo
	