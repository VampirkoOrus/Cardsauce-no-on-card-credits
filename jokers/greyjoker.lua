local jokerInfo = {
	name = 'Grey Joker',
	config = {},
	text = {
		"{C:mult}+#1#{} discards, but must",
		"discard 5 cards {C:attention}at a time{}"
	},
	rarity = 2,
	cost = 6,
	canBlueprint = true,
	canEternal = true,
	hasSoul = true,
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "guestartist1", set = "Other"}
end

function jokerInfo.locDef(self)
	return { self.ability.extra }
end

function jokerInfo.init(self)
	self.ability.extra = 3
end

function jokerInfo.calculate(self, context)
	if context.setting_blind and not self.getting_sliced and not self.debuff then
		if not (context.blueprint_card or self).getting_sliced then
			G.E_MANAGER:add_event(Event({func = function()
				ease_discard(self.ability.extra)
				card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = "+3 Discards"})
		return true end }))
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
end

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
	