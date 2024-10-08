local jokerInfo = {
	name = 'Cousin\'s Club [WIP]',
<<<<<<< Updated upstream
	config = {},
	text = {
		"This Joker gains {C:chips}+1{} Chips",
		"for each {C:clubs}Club{} card scored,",
		"{C:attention}double{} if hand contains a {C:attention}Flush{}",
		"{C:inactive}(Currently {}{C:chips}+#1#{} {C:inactive}Chips){}",
=======
	config = {
		extra = {
			chips = 0,
			chip_mod = 1
		}
>>>>>>> Stashed changes
	},
	rarity = 2,
	cost = 6,
	canBlueprint = true,
	canEternal = true
}

<<<<<<< Updated upstream
function jokerInfo.locDef(self)
	return { self.ability.extra.chips }
=======
function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.chips, card.ability.extra.chip_mod} }
>>>>>>> Stashed changes
end

function jokerInfo.init(self)
	self.ability.extra = {
		chips = 0,
		chip_mod = 1
	}
end

function jokerInfo.calculate(self, context)
	if context.individual and context.cardarea == G.play and not self.debuff and not (context.blueprint) then
		for k, v in ipairs(context.scoring_hand) do
			if v:is_suit('Clubs') then 
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
				if get_flush(context.scoring_hand) then
					self.ability.extra.chips = self.ability.extra.chips + 2*self.ability.extra.chip_mod
				else
					self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chip_mod
				end
				card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.CHIPS})
			end
		end
	end
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_chips',vars={self.ability.extra.chips}},
			chip_mod = self.ability.extra.chips, 
			colour = G.C.CHIPS
		}
	end
end



return jokerInfo
	