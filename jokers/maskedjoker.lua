local jokerInfo = {
	name = 'Masked Joker',
	config = {},
	text = {
		"If scored hand is all",
		"{C:attention}Steel Cards{}, each gives",
		"{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
	},
	rarity = 2,
	cost = 7,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = G.P_CENTERS.m_steel
end

function jokerInfo.locDef(self)
	return { self.ability.extra.chips, self.ability.extra.mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		chips = 29,
		mult = 16
	}
end

function jokerInfo.calculate(self, context)
	if context.individual and context.cardarea == G.play and not self.debuff then
		local chimera = true
                for k, v in ipairs(context.scoring_hand) do
                    chimera = chimera and v.ability.name == 'Steel Card'
                end
                if not chimera then
                    return nil
                end
		return {
			chips = self.ability.extra.chips,
			mult = self.ability.extra.mult,
			card = self
		}
	end
end



return jokerInfo
	
