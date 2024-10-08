local jokerInfo = {
	name = 'Odious Joker [WIP]',
	config = {},
	--[[text = {
		"{C:dark_edition}It would be in your best interests to stop.{}",
		"{C:dark_edition}These cards are my domain, and I their master.{}",
	},]]--
	rarity = 3,
	cost = 6,
	canBlueprint = false,
	canEternal = false
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
	