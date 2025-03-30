local consumInfo = {
    name = 'Tusk ACT4',
    set = 'Stand',
    config = {
        evolved = true,
        extra = {
            chips = 50,
            hand_mod = 1
        }
    },
    cost = 8,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.chips, card.ability.extra.hand_mod}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_stand_steel_tusk_1']
    or G.GAME.used_jokers['c_stand_steel_tusk_2']
    or G.GAME.used_jokers['c_stand_steel_tusk_3'] then
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