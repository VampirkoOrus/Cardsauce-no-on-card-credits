local jokerInfo = {
	name = 'The NEW Joker!',
	config = {
		extra = {
			mult = 4
		}
	},
	--[[text = {
		"Played cards with an",
		"{C:attention}Enhancement{} give {C:mult}+#1#{} Mult",
		"when scored",
	},]]--
	rarity = 1,
	cost = 4,
	canBlueprint = true,
	canEternal = true
}


<<<<<<< Updated upstream
function jokerInfo.locDef(self)
	return {self.ability.extra.mult}
end


function jokerInfo.init(self)
	self.ability.extra = {
		mult = 4
	}
=======
function jokerInfo.loc_vars(self, info_queue, card)
	return {vars = {card.ability.extra.mult}}
>>>>>>> Stashed changes
end

--[[
function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	if context.individual and context.cardarea == G.play and not self.debuff then
		if context.other_card.ability.effect ~= 'Base'
		then
			return {
				mult = self.ability.extra.mult,
				card = self
			}
		end
	end
end



return jokerInfo
	