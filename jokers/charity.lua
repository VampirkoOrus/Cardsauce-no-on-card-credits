local jokerInfo = {
	name = 'Vinesauce is HOPE [WIP]',
	config = {},
	text = {
		"Earn no {C:money}Interest{} at the end of",
		"each round. This Joker gains {C:mult}+1{} Mult",
		"for each {C:money}$1{} lost this way",
		"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}",
	},
	rarity = 3,
	cost = 7,
	canBlueprint = true,
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
	