local consumInfo = {
    name = 'Tusk ACT1',
    set = 'Stand',
    config = {
        evolve_key = 'c_stand_steel_tusk_2',
        extra = {
            chips = 20,
            evolve_scores = 0,
            evolve_num = 20,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.chips, card.ability.extra.evolve_num - card.ability.extra.evolve_scores}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_stand_steel_tusk_2']
    or G.GAME.used_jokers['c_stand_steel_tusk_3']
    or G.GAME.used_jokers['c_stand_steel_tusk_4'] then
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