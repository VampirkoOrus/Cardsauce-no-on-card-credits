local jokerInfo = {
	name = 'Rekoj Gnorts',
	config = {},
	text = {
		"Allows {C:attention}Straights{} to be made",
		"with {C:attention}Aces{} in the middle",
		"{C:inactive}(ex:{} {C:attention}3 2 A K Q{}{C:inactive}){}",
	},
	rarity = 2,
	cost = 7,
	canBlueprint = false,
	canEternal = true
}

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.init(self)

end
]]--

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "guestartist7", set = "Other"}
end

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	