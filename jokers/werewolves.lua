local jokerInfo = {
	name = 'That\'s Werewolves [WIP]',
	config = {},
	text = {
		"{X:mult,C:white}X#1#{} Mult, but",
		"cannot play hands",
		"containing a {C:attention}Flush{}",
	},
	rarity = 2,
	cost = 7,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.locDef(self)
	return { self.ability.extra.x_mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 3
	}
end



function jokerInfo.calculate(self, context)
	mult = mod_mult(0)
        hand_chips = mod_chips(0)
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = (function()
                G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff_1'):juice_up(0.3, 0)
                G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff_2'):juice_up(0.3, 0)
                G.GAME.blind:juice_up()
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                play_sound('tarot2', 1, 0.4)
                return true
            end)
        }))

        play_area_status_text("Not Allowed!")--localize('k_not_allowed_ex'), true)
end



return jokerInfo
	