local jokerInfo = {
	name = 'Running Hell [WIP]',
	config = {extra = 1},
	rarity = 3,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

--[[
function jokerInfo.loc_vars(self, info_queue, card)
	return { G.GAME.probabilities.normal }
end]]--

function jokerInfo.set_ability(self, card, initial, delay_sprites)

end

local add_to_deck_ref2 = Card.add_to_deck

function hand_level_reset(self)
	update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3*G.SETTINGS.GAMESPEED}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2*G.SETTINGS.GAMESPEED, func = function()
		play_sound('tarot1')
		self:juice_up(0.8, 0.5)
		G.TAROT_INTERRUPT_PULSE = true
		return true end }))
	update_hand_text({delay = 0}, {mult = '-', StatusText = true})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9*G.SETTINGS.GAMESPEED, func = function()
		play_sound('tarot1')
		self:juice_up(0.8, 0.5)
		return true end }))
	update_hand_text({delay = 0}, {chips = '-', StatusText = true})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9*G.SETTINGS.GAMESPEED, func = function()
		play_sound('tarot1')
		self:juice_up(0.8, 0.5)
		G.TAROT_INTERRUPT_PULSE = nil
		return true end }))
	update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='1'})
	delay(1.3*G.SETTINGS.GAMESPEED)
	for k, v in pairs(G.GAME.hands) do
		level_up_hand(self, k, true, -G.GAME.hands[k].level + 1)
	end
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		func = (function()
			play_area_status_text("A black wind flows through you...")
			-- Custom_Play_Sound("cavestorytext",false,1.3,1) need rework to SMODS.Sound API
			return true
		end)
	}))
	return
end

function Card:add_to_deck(from_debuff)
	add_to_deck_ref2(self, from_debuff)
	if self.config.center_key == 'j_hell' then
		hand_level_reset(self)
	end
end

function jokerInfo.calculate(self, card, context)
	if context.repetition and not card.debuff then
		if context.cardarea == G.play then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card
			}
		end
		if context.cardarea == G.hand then
			if (next(context.card_effects[1]) or #context.card_effects > 1) then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra,
					card = card
				}
			end
		end
	end
	if context.end_of_round and G.GAME.blind.boss and not context.blueprint then
		hand_level_reset(card)
	end
end



return jokerInfo
	