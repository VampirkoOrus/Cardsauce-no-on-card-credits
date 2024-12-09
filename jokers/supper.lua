local mod = SMODS.current_mod

local jokerInfo = {
	name = 'WAAUGGHGHHHHGHH',
	config = {
		extra = {
			x_mult = 1.5
		}
	},
	rarity = 3,
	cost = 6,
	unlocked = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.check_for_unlock(self, args)
	if args.type == "ante_up" and args.ante == 7 then
		return true
	end
end

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist8", set = "Other"}
	return { vars = {card.ability.extra.x_mult} }
end

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_supper" })
end

local wega = SMODS.Sound({
	key = "wega",
	path = "wega.ogg"
})

function jokerInfo.calculate(self, card, context)
	if context.individual and context.cardarea == G.play and not card.debuff then
		if context.other_card:get_id() == 2 or context.other_card:get_id() == 4 or context.other_card:get_id() == 14 then
			sendDebugMessage("Triggering WAAUGGHGHHHHGHH")
			G.E_MANAGER:add_event(Event({
				func = function()
					if not mod.config['muteWega'] then
						wega:play(1, (G.SETTINGS.SOUND.volume/100.0) * (G.SETTINGS.SOUND.game_sounds_volume/100.0),true);
					end
					card:juice_up()
					return true
				end
			}))
			return {
				x_mult = card.ability.extra.x_mult,
				card = card
			}
		end
	end
end



return jokerInfo
	