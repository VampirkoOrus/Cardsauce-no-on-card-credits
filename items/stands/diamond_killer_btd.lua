local consumInfo = {
    name = 'Killer Queen: Bites the Dust',
    set = 'Stand',
    config = {
        evolved = true
    },
    cost = 8,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}



function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_stand_diamond_killer'] then
        return false
    end
    
    return true
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