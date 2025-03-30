local consumInfo = {
    name = 'Gold Experience',
    set = 'Stand',
    config = {
        evolve_key = 'c_stand_vento_gold_requiem'
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'vento',
}

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return G.GAME.used_jokers['c_stand_vento_gold_requiem'] ~= nil
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