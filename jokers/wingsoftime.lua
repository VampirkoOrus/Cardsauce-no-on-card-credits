local jokerInfo = {
	name = 'Wings of Time',
	config = {},
	rarity = 3,
	cost = 10,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	hasSoul = true,
}

function jokerInfo.calculate(self, card, context)
	if context.game_over and G.GAME.chips/G.GAME.blind.chips >= 0.23 then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.hand_text_area.blind_chips:juice_up()
				G.hand_text_area.game_chips:juice_up()
				play_sound('tarot1')
				card:start_dissolve()
				ante_dec = G.GAME.round_resets.ante - 1
				sendDebugMessage("round_sesets.blind_ante Before: " .. G.GAME.round_resets.blind_ante)
				sendDebugMessage("round_sesets.ante Before: " .. G.GAME.round_resets.ante)
				ease_ante(-ante_dec)
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante-ante_dec
				sendDebugMessage("round_sesets.blind_ante After: " .. G.GAME.round_resets.blind_ante)
				sendDebugMessage("round_sesets.ante After: " .. G.GAME.round_resets.ante)
				return true
			end
		})) 
	return {
		message = localize('k_saved_ex'),
		saved = true,
		colour = G.C.RED
	}
	end
end

return jokerInfo