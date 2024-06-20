local jokerInfo = {
	name = 'Running Hell [WIP]',
	config = {},
	text = {
		"All cards are {C:attention}retriggered{}",
		"All {C:attention}hands{} drop to {C:planet}Level 1{} upon pickup",
		"and the start of each {C:attention}Ante{}",
	},
	rarity = 3,
	cost = 6,
	canBlueprint = true,
	canEternal = true
}

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end]]--

function jokerInfo.init(self)
	self.ability.extra = 1
end

local add_to_deck_ref2 = Card.add_to_deck

function hand_level_reset(self)
	update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
		play_sound('tarot1')
		self:juice_up(0.8, 0.5)
		G.TAROT_INTERRUPT_PULSE = true
		return true end }))
	update_hand_text({delay = 0}, {mult = '-', StatusText = true})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
		play_sound('tarot1')
		self:juice_up(0.8, 0.5)
		return true end }))
	update_hand_text({delay = 0}, {chips = '-', StatusText = true})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
		play_sound('tarot1')
		self:juice_up(0.8, 0.5)
		G.TAROT_INTERRUPT_PULSE = nil
		return true end }))
	update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='1'})
	delay(1.3)
	for k, v in pairs(G.GAME.hands) do
		level_up_hand(self, k, true, -G.GAME.hands[k].level + 1)
	end
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		func = (function()
			play_area_status_text("A black wind flows through you...")
			Custom_Play_Sound("cavestorytext",false,1.3,1)
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

function jokerInfo.calculate(self, context)
	if context.repetition and not self.debuff then
		if context.cardarea == G.play then
			return {
				message = localize('k_again_ex'),
				repetitions = self.ability.extra,
				card = self
			}
		end
		if context.cardarea == G.hand then
			if (next(context.card_effects[1]) or #context.card_effects > 1) then
				return {
					message = localize('k_again_ex'),
					repetitions = self.ability.extra,
					card = self
				}
			end
		end
	end
	if context.end_of_round and G.GAME.blind.boss and not context.blueprint then
		hand_level_reset(self)
	end
end



return jokerInfo
	