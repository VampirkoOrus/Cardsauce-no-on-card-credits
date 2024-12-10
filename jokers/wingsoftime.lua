local jokerInfo = {
	name = 'Wings of Time',
	config = {},
	rarity = 3,
	cost = 10,
	unlocked = false,
	unlock_condition = {type = 'unlock_epoch'},
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	hasSoul = true,
	width = 284,
	height = 380,
}

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist16", set = "Other"}
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_epoch" })
end

function jokerInfo.calculate(self, card, context)
	if context.game_over and G.GAME.chips/G.GAME.blind.chips >= 0.23 then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.hand_text_area.blind_chips:juice_up()
				G.hand_text_area.game_chips:juice_up()
				play_sound('tarot1')
				card:start_dissolve()
				ante_dec = G.GAME.round_resets.ante - 1
				ease_ante(-ante_dec)
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
				G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante-ante_dec
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