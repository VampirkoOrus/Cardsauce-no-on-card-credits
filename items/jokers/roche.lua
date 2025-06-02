local jokerInfo = {
	name = 'Motorcyclist Joker',
	config = {
		gil = 13
	},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
	if G.SETTINGS.roche then
		info_queue[#info_queue+1] = {key = "vacredit", set = "Other", vars = { G.csau_team.amtraxva } }
	end

	return { vars = {card.ability.gil} }
end

local roche = SMODS.Sound({
	key = "roche",
	path = "roche.wav"
})

local rochedies = SMODS.Sound({
	key = "rochedies",
	path = "roche_dies.wav"
})

function jokerInfo.remove_from_deck(self, card)
	if not G.screenwipe then
		rochedies:play(1, (G.SETTINGS.SOUND.volume/100.0) * (G.SETTINGS.SOUND.game_sounds_volume/70.0),true)
		check_for_unlock({ type = "roche_destroyed" })
	end
end

function jokerInfo.calculate(self, card, context)
	if context.end_of_round and not self.debuff and not context.individual and not context.repetition then
		if to_big(G.GAME.dollars) <= to_big(card.ability.gil) and G.GAME.last_hand_played then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				local card_type = 'Planet'
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				card:vic_say_stuff(2, nil, true, roche)
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					blockable = false,
					blocking = false,
					func = function()
						local speech_key = 'roche_voiceline'
						card:vic_add_speech_bubble(speech_key, 'bm', nil, {text_alignment = "cm"})
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 8,
							blocking = false,
							func = function()
								card:vic_remove_speech_bubble()
								return true
							end
						}))
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.0,
					func = (function()
						local _planet = 0
						for k, v in pairs(G.P_CENTER_POOLS.Planet) do
							if v.config.hand_type == G.GAME.last_hand_played then
								_planet = v.key
							end
						end
						local _card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'youearnedit')
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						G.GAME.consumeable_buffer = 0
						return true
					end)}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 3,
					func = (function()
						check_for_unlock({ type = "activate_roche" })
						return true
					end)}))
				G.SETTINGS.roche = true
				G:save_settings()
			end
		end
	end
end



return jokerInfo
	