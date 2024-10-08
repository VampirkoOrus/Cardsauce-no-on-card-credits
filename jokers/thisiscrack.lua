local jokerInfo = {
	name = 'This Is Crack',
	config = {},
	text = {
		"This Joker gains {X:mult,C:white}X0.1{} Mult",
		"per {C:attention}consecutive{} hand played",
		"of the {C:attention}same type{}",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
		"{C:inactive}(Current hand: {}{C:attention}#2#{}{C:inactive}){}",
	},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	hasSoul = true,
}

function jokerInfo.loc_vars(self, info_queue, card)
	local hand_var = card.ability.extra.crack_hand and localize(card.ability.extra.crack_hand, 'poker_hands') or localize('k_none')
	return { card.ability.extra.x_mult, card.ability.extra.crack_hand }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = {
		x_mult = 1,
		crack_hand = "None" --replace with previous hand?
	}
end

function jokerInfo.calculate(self, card, context)
	if context.cardarea == G.jokers and context.before and not context.blueprint then
		local hand = context.scoring_name
		if hand == card.ability.extra.crack_hand or card.ability.extra.crack_hand == "None" then
			card.ability.extra.x_mult = card.ability.extra.x_mult + 0.1
		else
			card.ability.extra.crack_hand = hand
			if card.ability.extra.x_mult > 1 then
                card.ability.extra.x_mult = 1
                return {
                    card = self,
                    message = localize('k_reset')
                }
            end
		end
		card.ability.extra.crack_hand = hand
	  end
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
			Xmult_mod = card.ability.extra.x_mult, 
			--colour = G.C.MULT
		}
	end
	--[[	if not context.blueprint then
		local reset = true
        --local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
        for k, v in pairs(G.GAME.hands) do
            if k == context.scoring_name and v.visible then
                reset = false
            end
        end
        if reset then
            if self.ability.x_mult > 1 then
                self.ability.x_mult = 1
                return {
                    card = self,
                    message = localize('k_reset')
                }
            end
        else
            self.ability.x_mult = self.ability.x_mult + 0.1
        end
		card.ability.extra.crack_hand = context.scoring_name
	end
	]]--
end



return jokerInfo
	