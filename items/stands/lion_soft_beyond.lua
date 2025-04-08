local consumInfo = {
    name = 'Soft & Wet: Go Beyond',
    set = 'Stand',
    config = {
        evolved = true,
        extra = {
            mult = 0,
            x_mult = 1,
            x_mult_mod = 0.2,
        }
    },
    cost = 8,
    rarity = 'EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.x_mult_mod, card.ability.extra.mult, card.ability.extra.x_mult}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_lion_soft'] then
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