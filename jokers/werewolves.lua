local jokerInfo = {
	name = 'That\'s Werewolves',
	config = {
		extra = {
			x_mult = 3
		}
	},
	--[[text = {
		"{X:mult,C:white}X#1#{} Mult, but",
		"cannot play hands",
		"containing a {C:attention}Flush{}",
	},]]--
	rarity = 2,
	cost = 7,
	canBlueprint = true,
	canEternal = true
}

<<<<<<< Updated upstream
function jokerInfo.locDef(self)
	return { self.ability.extra.x_mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 3
	}
=======
function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.x_mult} }
>>>>>>> Stashed changes
end

local debuff_hand_ref = Blind.debuff_hand

function Blind:debuff_hand(cards, hand, handname, check)
	debuff_hand_ref(self, cards, hand, handname, check)
	if next(find_joker('That\'s Werewolves')) then
		if next(hand["Flush"]) then
            return true
		end
	end
end

function jokerInfo.calculate(self, context)
	--[[if context.cardarea == G.jokers and context.before and not self.debuff and not context.blueprint then
		if next(get_flush(context.scoring_hand)) then
			mult = 0
    		hand_chips = 0
        	G.E_MANAGER:add_event(Event({
            	trigger = 'immediate',
            	func = (function()
                	self:juice_up()
                	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                	play_sound('tarot2', 1, 0.4)
					play_area_status_text("Not Allowed!")--localize('k_not_allowed_ex'), true)
                	return true
         		end)
        	}))

		end
	end]]--

	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
			Xmult_mod = self.ability.extra.x_mult, 
		}
	end
end



return jokerInfo
	