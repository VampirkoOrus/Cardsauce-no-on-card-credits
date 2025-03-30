local consumInfo = {
    name = 'Epitaph',
    set = 'Stand',
    config = {
        evolve_key = 'c_stand_vento_epitaph_king',
        extra = {
            evolve_skips = 0,
            evolve_num = 3,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'vento',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.evolve_num - card.ability.extra.evolve_skips}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return G.GAME.used_jokers['c_stand_vento_epitaph_king'] ~= nil
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