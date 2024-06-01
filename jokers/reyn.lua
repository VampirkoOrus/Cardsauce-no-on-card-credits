local jokerInfo = {
	name = 'Bunch Of Jokers [WIP]',
	config = {},
	text = {
		"Create a {C:purple}Judgement{} card",
		"when {C:attention}Blind{} is selected",
		"{C:inactive}(Must have room){}",
		--todo: add judgement side text
	},
	rarity = 1,
	cost = 6,
	canBlueprint = true,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = G.P_CENTERS.c_judgement
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
	