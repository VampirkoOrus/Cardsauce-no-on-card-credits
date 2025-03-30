local consumInfo = {
    name = 'Gold Experience Requiem',
    set = 'Stand',
    config = {
        evolved = true,
        extra = {
            chance = 0,
            divide = 5,
        }
    },
    cost = 8,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'vento',
}

function consumInfo.loc_vars(self, info_queue, card)
    return { vars = { card.ability.extra.chance, card.ability.extra.divide, G.GAME.probabilities.normal}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return G.GAME.used_jokers['c_stand_vento_gold'] ~= nil
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo