local consumInfo = {
    name = 'Echoes ACT3',
    set = 'Stand',
    config = {
        evolved = true,
        extra = {
            enhancement = 'm_stone',
            mult = 5,
        }
    },
    cost = 8,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {G.P_CENTERS[card.ability.extra.enhancement].name, card.ability.extra.mult}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_stand_diamond_echoes_1']
    or G.GAME.used_jokers['c_stand_diamond_echoes_2'] then
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