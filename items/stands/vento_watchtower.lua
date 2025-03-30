local consumInfo = {
    name = 'All Along Watchtower',
    set = 'Stand',
    config = {},
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'vento',
}

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo