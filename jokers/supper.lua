local jokerInfo = {
	name = 'WAAUGGHGHHHHGHH',
	config = {
		extra = {
			x_mult = 1.75
		}
	},
	rarity = 3,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true
}


function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist8", set = "Other"}
	return { vars = {card.ability.extra.x_mult} }
end


--[[function jokerInfo.set_ability(self, card, initial, delay_sprites)
	
end]]--

local wega = SMODS.Sound({
	key = "wega",
	path = "wega.ogg"
})

function jokerInfo.calculate(self, card, context)
	if context.individual and context.cardarea == G.play and not self.debuff then
		if context.other_card:get_id() == 2 or context.other_card:get_id() == 4 or context.other_card:get_id() == 14 then
			sendDebugMessage("Triggering WAAUGGHGHHHHGHH")
			G.E_MANAGER:add_event(Event({
				func = function()
					wega:play(1, (G.SETTINGS.SOUND.volume/100.0) * (G.SETTINGS.SOUND.game_sounds_volume/100.0),true);
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
	