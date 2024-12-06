local jokerInfo = {
	name = 'DIS JOAKERRR',
	config = {extra = {messageIndex = 0}},
	rarity = 1,
	cost = 6,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

local function detect2or5(scoring_hand)
	for k, v in ipairs(scoring_hand) do
		if v:get_id() == 2 or v:get_id() == 5 then
			return true
		end
	end
	return false
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_disguy" })
end

function jokerInfo.calculate(self, card, context)
	if context.cardarea == G.jokers and context.before and not card.debuff and not context.blueprint then
		if detect2or5(context.scoring_hand) then
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
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = messages[(card.ability.extra.messageIndex % 2) + 1], colour = G.C.MONEY})
			card.ability.extra.messageIndex = card.ability.extra.messageIndex + 1
			for i, v in ipairs(context.scoring_hand) do
				if v:get_id() == 2 or v:get_id() == 5 then
					local percent = 1.15 - (i-0.999)/(#context.scoring_hand-0.998)*0.3
					G.E_MANAGER:add_event(Event({trigger = 'before',delay = 0.15,func = function() context.scoring_hand[i]:flip();play_sound('card1', percent);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
				end
			end
			for i, v in ipairs(context.scoring_hand) do
				if v:get_id() == 2 or v:get_id() == 5 then
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.15,
						func = function()
							v:set_ability(enhancements[pseudorandom('OONDORTOOL', 1, 8)])
							return true
						end }))
				end
			end
			for i, v in ipairs(context.scoring_hand) do
				if v:get_id() == 2 or v:get_id() == 5 then
					local percent = 0.85 + (i-0.999)/(#context.scoring_hand-0.998)*0.3
					G.E_MANAGER:add_event(Event({trigger = 'before',delay = 0.15,func = function() context.scoring_hand[i]:flip();play_sound('tarot2', percent, 0.6);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
				end
			end
		end
	end
end



return jokerInfo
	