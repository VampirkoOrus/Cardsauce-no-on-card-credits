local consumInfo = {
    name = 'King Crimson',
    set = 'Stand',
    config = {
        evolved = true
    },
    cost = 8,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'vento',
    in_progress = true,
}

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return G.GAME.used_jokers['c_stand_vento_epitaph'] ~= nil
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