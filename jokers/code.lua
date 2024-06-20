local jokerInfo = {
	name = 'Industry Code',
	config = {},
	text = {
		"If played hand is a",
		"{C:attention}5{}, {C:attention}7{}, {C:attention}6{}, {C:attention}8{}, and {C:attention}7{},",
		"gain {C:money}$#1#{}",
	},
	rarity = 2,
	cost = 5,
	canBlueprint = true,
	canEternal = true
}


function jokerInfo.locDef(self)
	return { self.ability.extra.money }
end

function jokerInfo.init(self)
	self.ability.extra = {
		money = 25
	}
end


function jokerInfo.calculate(self, context)
	if context.joker_main and context.cardarea == G.jokers and not self.debuff then
		local code5 = 0
		local code6 = 0
		local code7 = 0
		local code8 = 0
		for k, v in ipairs(context.full_hand) do
			if v:get_id() == 5 then
				code5 = code5 + 1
			end
			if v:get_id() == 6 then
				code6 = code6 + 1
			end
			if v:get_id() == 7 then
				code7 = code7 + 1
			end
			if v:get_id() == 8 then
				code8 = code8 + 1
			end
		end
		if code5 == 1 and code6 == 1 and code7 == 2 and code8 == 1 then
			ease_dollars(self.ability.extra.money)
			return {
				message = localize('$')..self.ability.extra.money,
				colour = G.C.MONEY,
				card = self
			}
		end
	end
end



return jokerInfo
	