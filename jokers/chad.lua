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
]]--
function jokerInfo.init(self)
	self.ability.extra = 2
end

function jokerInfo.calculate(self, context)
	if context.other_joker and not self.debuff and not context.blueprint then
		if (context.other_joker.config.center.name == ('No No No No No No No No No No No') or context.other_joker.ability.name == 'Hanging Chad' or context.other_joker.ability.name == 'Showman') and self ~= context.other_joker then
			G.E_MANAGER:add_event(Event({
				func = function()
					context.other_joker:juice_up(0.5, 0.5)
					return true
				end
			})) 
			return {
				message = localize{type='variable',key='a_xmult',vars={self.ability.extra}},
            	Xmult_mod = self.ability.extra
			}
		end
	end
end



return jokerInfo
	