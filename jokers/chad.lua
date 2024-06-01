local jokerInfo = {
	name = 'No No No No No No No No No No No',
	config = {},
	text = {
		"Greetings, Cloud, it is me, Chudlot. As you can plainly see,",
		"my lifelong dream of transmogrifying myself into a Joker",
		"from the hit video game by LocalThunk \"Balatro\"",
		"has finally been achieved! Now, while you are searching",
		"for the Protojoker, please pick up any Showman you come across.",
		"The Showman will allow me to obtain more copies of myself,",
		"and facilitate the Chumpley reunion! When enough Chandlers are gathered,",
		"we shall transform into CHADNOVA, and at last,",
		"humanity will become as Chadesque as myself.",
	},
	rarity = 1,
	cost = 0,
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
	