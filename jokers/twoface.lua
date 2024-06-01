local jokerInfo = {
	name = 'Two-Faced Joker [WIP]',
	config = {},
	text = {
		"Each played {C:attention}Ace{} becomes",
		"a {C:attention}2{}, each played {C:attention}2{}",
		"becomes an {C:attention}Ace{}",
	},
	rarity = 1,
	cost = 4,
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


--card works, just need to fix timing on the card changing
function jokerInfo.calculate(self, context)
	if context.cardarea == G.jokers and context.before and not self.debuff and not context.blueprint then
		for k, v in ipairs(context.full_hand) do 
			if v:get_id() == 14 then 
				local suit_prefix = string.sub(v.base.suit, 1, 1)..'_'
				v:set_base(G.P_CARDS[suit_prefix..2])
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
				card_eval_status_text(self, 'extra', nil, nil, nil, {message = "Twoed!", colour = G.C.MONEY})

			elseif v:get_id() == 2 then 
				local suit_prefix = string.sub(v.base.suit, 1, 1)..'_'
				v:set_base(G.P_CARDS[suit_prefix..'A'])
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				})) 
				card_eval_status_text(self, 'extra', nil, nil, nil, {message = "Aced!", colour = G.C.MONEY})
			end
		end
	end
end



return jokerInfo
	