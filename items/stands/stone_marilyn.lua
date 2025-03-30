local consumInfo = {
    name = 'Marilyn Manson',
    set = 'Stand',
    config = {
        extra = {
            conv_money = 1,
            conv_score = 0.005
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
    return {vars = {card.ability.extra.conv_money, card.ability.extra.conv_score * 100}}
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