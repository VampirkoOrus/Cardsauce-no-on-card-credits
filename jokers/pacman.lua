local jokerInfo = {
	name = 'PAC-MAN Incident [WIP]',
	config = {},
	text = {
		"This Joker gains {C:mult}+5{} Mult if",
        "round ends with your chips",
        "within {C:attention}5%{} of the {C:attention}Blind{}",
        "{C:inactive}(Currently {}{C:mult}+#1#{} {C:inactive}Mult){}",
	},
	rarity = 1,
	cost = 5,
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
	