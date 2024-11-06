local jokerInfo = {
	name = 'Grey Joker',
	config = {extra = 3},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	hasSoul = true,
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist1", set = "Other"}
	return { vars = {card.ability.extra} }
end

function jokerInfo.calculate(self, card, context)
	if context.setting_blind and not card.getting_sliced and not card.debuff then
		if not (context.blueprint_card or card).getting_sliced then
			G.E_MANAGER:add_event(Event({func = function()
				ease_discard(card.ability.extra)
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+3 Discards"})
		return true end }))
		end
	end
end


	--[[G.FUNCS.can_discard = function(e)
		if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 4 then 
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		else
			e.config.colour = G.C.RED
			e.config.button = 'discard_cards_from_highlighted'
		end
	  end]]--

--[[function Card:remove_from_deck()
	G.FUNCS.can_discard = function(e)
		if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 0 then 
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		else
			e.config.colour = G.C.RED
			e.config.button = 'discard_cards_from_highlighted'
		end
	  end
end]]--



return jokerInfo
	