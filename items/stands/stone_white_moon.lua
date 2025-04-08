local consumInfo = {
    name = 'C-MOON',
    set = 'Stand',
    config = {
        stand_mask = true,
        evolved = true,
        evolve_key = 'c_csau_stone_white_heaven',
        extra = {
            evolve_ranks = 0,
            evolve_num = 14,
        }
    },
    cost = 6,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'stone',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "artistcredit", set = "Other", vars = { csau_team.wario } }
    return { vars = {card.ability.extra.evolve_num - card.ability.extra.evolve_ranks}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_stone_white']
    or G.GAME.used_jokers['c_csau_stone_white_heaven'] then
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