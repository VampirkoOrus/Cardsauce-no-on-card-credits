local jokerInfo = {
	name = 'Speed Joker',
	config = {},
	--[[text = {
		"Draw {C:attention}+1{} card each {C:chips}hand{}",
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

function jokerInfo.init(self)
	self.ability.extra = G.GAME.current_round.hands_played + 1
end


function jokerInfo.calculate(self, context)
	if context.setting_blind and not self.getting_sliced and not context.blueprint then
        self.ability.extra = 1
    end
end



return jokerInfo
	