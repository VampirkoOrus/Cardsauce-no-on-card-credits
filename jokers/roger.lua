local jokerInfo = {
	name = 'Mr. Roger [WIP]',
	config = {},
	text = {
		"iThis Joker gains {X:mult,C:white}X0.1{} Mult",
		"for each {C:attention}finger{} played this {C:attention}Blind{}",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
	},
	rarity = 2,
	cost = 6,
	canBlueprint = false,
	canEternal = true
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "rogernote", set = "Other"}
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
	