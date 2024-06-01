local jokerInfo = {
	name = 'Diaper Joker [WIP]',
	config = {},
	text = {
		"idfk",
	},
	rarity = 1,
	cost = 0,
	canBlueprint = false,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "diapernote", set = "Other"}
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
	