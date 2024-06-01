local jokerInfo = {
	name = 'Emmanuel Blast [WIP]',
	config = {},
	text = {
		"{C:dark_edition}Negative Jokers{} appear",
		"{C:green}4X{} more often",
	},
	rarity = 1,
	cost = 0,
	canBlueprint = false,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = G.P_CENTERS.e_negative
end

--[[
function jokerInfo.locDef(self)
	return { G.GAME.probabilities.normal }
end

function jokerInfo.init(self)

end
]]--

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	