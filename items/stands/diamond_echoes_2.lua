local consumInfo = {
    name = 'Echoes ACT2',
    set = 'Stand',
    
    config = {   
        evolve_key = 'c_csau_diamond_echoes_3',
        extra = {
            evolved = true,
            num_cards = 1,
            mult = 4,
            evolve_rounds = 0,
            evolve_num = 6,
        }
    },
    cost = 6,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.num_cards, card.ability.extra.mult, card.ability.extra.evolve_num - card.ability.extra.evolve_rounds}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_diamond_echoes_1']
    or G.GAME.used_jokers['c_csau_diamond_echoes_3'] then
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