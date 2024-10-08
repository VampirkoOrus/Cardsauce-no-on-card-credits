local jokerInfo = {
	name = 'Pivyot',
	config = {},
	--[[text = {
		"{C:green}#1# in 2{} chance to upgrade",
		"level of played {C:attention}High Card{}",
	},]]--
	rarity = 1,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}


<<<<<<< Updated upstream
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
=======
function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {G.GAME.probabilities.normal} }
>>>>>>> Stashed changes
end


--[[
function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	if context.cardarea == G.jokers and context.before and not self.debuff then
		if context.scoring_name == "High Card" then
			if pseudorandom('pivot') < G.GAME.probabilities.normal / 2 then
				return {
					card = self,
					level_up = true,
					message = localize('k_level_up_ex')
				}
			end
		end
	end
end



return jokerInfo
	