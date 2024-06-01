local jokerInfo = {
	name = 'This Is Crack [WIP]',
	config = {},
	text = {
		"This Joker gains {X:mult,C:white}X0.1{} Mult",
		"per {C:attention}consecutive{} hand played",
		"of the {C:attention}same type{}",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
		"{C:inactive}(Current hand: {}{C:attention}#2#{}{C:inactive}){}",
	},
	rarity = 3,
	cost = 8,
	canBlueprint = true,
	canEternal = true,
	hasSoul = true,
}

function jokerInfo.locDef(self)
	return { self.ability.extra.x_mult, self.ability.extra.crack_hand }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 1,
		crack_hand = {"None"} --replace with previous hand?
	}
end

function jokerInfo.calculate(self, context)
	if not context.blueprint then
		local reset = true
        --local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
        for k, v in pairs(G.GAME.hands) do
            if k == context.scoring_name and v.visible then
                reset = false
            end
        end
        if reset then
            if self.ability.x_mult > 1 then
                self.ability.x_mult = 1
                return {
                    card = self,
                    message = localize('k_reset')
                }
            end
        else
            self.ability.x_mult = self.ability.x_mult + 0.1
        end
		self.ability.extra.crack_hand = context.scoring_name
	end
end



return jokerInfo
	