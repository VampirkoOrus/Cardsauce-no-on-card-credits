local consumInfo = {
    name = 'Stone Free',
    set = 'Stand',
    config = {
        extra = {
            chips = 60,
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
    return { vars = {card.ability.extra.chips}}
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