local jokerInfo = {
	name = 'Masked Joker',
	config = {},
	text = {
		"If played hand is all",
		"{C:attention}Steel Cards{}, each gives",
		"{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
	},
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = G.P_CENTERS.m_steel
end

function jokerInfo.loc_vars(self, info_queue, card)
	return { card.ability.extra.chips, card.ability.extra.mult }
end

function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = {
		chips = 29,
		mult = 16
	}
end

function jokerInfo.calculate(self, card, context)
	if context.individual and context.cardarea == G.play and not self.debuff then
		local chimera = true
                for k, v in ipairs(context.full_hand) do
                    chimera = chimera and v.ability.name == 'Steel Card'
                end
                if not chimera then
                    return nil
                end
		return {
			chips = card.ability.extra.chips,
			mult = card.ability.extra.mult,
			card = self
		}
	end
end



return jokerInfo
	