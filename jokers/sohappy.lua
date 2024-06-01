local jokerInfo = {
	name = 'I\'m So Happy [WIP]',
	config = {},
	text = {
		"{C:blue}+2{} hands, {C:red}-1{} discard",
		"{C:inactive}(Turns upside-down after",
		"{C:inactive}each round played)",
	},
	rarity = 2,
	cost = 6,
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

function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	