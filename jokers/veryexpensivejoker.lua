local jokerInfo = {
	name = 'Very Expensive Joker',
	config = {
		extra = {
			x_mult = 1,
			dollars = 0
		}
	},
	--[[text = {
		"{X:mult,C:white}X0.5{} Mult for every {C:money}$10{}",
		"spent on this Joker, spend all",
		"{C:attention}money{} obtaining this",
		"{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
	},]]--
	rarity = 1,
	cost = 0,
	canBlueprint = false,
	canEternal = true
}
<<<<<<< Updated upstream
function jokerInfo.locDef(self)
	return { self.ability.extra.x_mult }
end

function jokerInfo.init(self)
	self.ability.extra = {
		x_mult = 1,
		dollars = 0
	}
=======
function jokerInfo.loc_vars(self, info_queue, card)
	return { vars = {card.ability.extra.x_mult} }
>>>>>>> Stashed changes
end

local add_to_deck_ref = Card.add_to_deck

function Card:add_to_deck(from_debuff)
	add_to_deck_ref(self, from_debuff)
	if self.config.center_key == 'j_veryexpensivejoker' then
		if G.GAME.dollars > 0 then 
			self.ability.extra.dollars = G.GAME.dollars
		else
			self.ability.extra.dollars = 0
		end
		self.ability.extra.x_mult = (math.floor(self.ability.extra.dollars/10)/2) + 1
		ease_dollars(-(self.ability.extra.dollars) +1)
		card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}}})
	end
end


function jokerInfo.calculate(self, context)
	
	if context.joker_main and context.cardarea == G.jokers then
		return {
			message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
			Xmult_mod = self.ability.extra.x_mult, 
		}
	end
end



return jokerInfo
	