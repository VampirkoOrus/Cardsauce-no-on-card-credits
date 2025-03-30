local consumInfo = {
    name = 'Whitesnake',
    set = 'Stand',
    config = {
        evolve_key = 'c_stand_stone_white_moon',
        extra = {
            evolve_cards = 0,
            evolve_num = 36,
            evolve_val = '6'
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'stone',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return { vars = {card.ability.extra.evolve_num - card.ability.extra.evolve_cards, SMODS.Ranks[card.ability.extra.evolve_val].key}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_stand_stone_white_moon']
    or G.GAME.used_jokers['c_stand_stone_white_heaven'] then
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