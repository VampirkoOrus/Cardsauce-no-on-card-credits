local jokerInfo = {
	name = 'Disturbed Joker',
<<<<<<< Updated upstream
	config = {},
	text = {
=======
	config = {extra = 0},
	--[[text = {
>>>>>>> Stashed changes
		"Draw {C:attention}+1{} card each {C:mult}discard{}",
	},]]--
	rarity = 1,
	cost = 4,
	canBlueprint = false,
	canEternal = true
}

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end
]]--

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "guestartist4", set = "Other"}
end

<<<<<<< Updated upstream
function jokerInfo.init(self)
	self.ability.extra = G.GAME.current_round.discards_used + 1
=======
function jokerInfo.set_ability(self, card, initial, delay_sprites)
	card.ability.extra = G.GAME.current_round.discards_used + 1
>>>>>>> Stashed changes
end


function jokerInfo.calculate(self, context)
	if context.setting_blind and not self.getting_sliced and not context.blueprint then
        self.ability.extra = 1
    end
end



return jokerInfo
	