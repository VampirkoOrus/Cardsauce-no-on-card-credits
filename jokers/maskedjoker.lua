local jokerInfo = {
	name = 'Masked Joker',
	config = {
		extra = {
			chips = 29,
			mult = 16
		}
	},
	--[[text = {
		"If played hand is all",
		"{C:attention}Steel Cards{}, each gives",
		"{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
	},]]--
	rarity = 2,
	cost = 7,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = G.P_CENTERS.m_steel
end

<<<<<<< Updated upstream
function jokerInfo.locDef(self)
	return { self.ability.extra.chips, self.ability.extra.mult }
=======
function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.chips, card.ability.extra.mult}}
>>>>>>> Stashed changes
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
                for k, v in ipairs(context.full_hand) do
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
	