local consumInfo = {
    name = 'Wonder of U',
    set = 'Stand',
    config = {
        extra = {
            mult = 0,
            mult_mod = 1,
        }
    },
    cost = 8,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
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