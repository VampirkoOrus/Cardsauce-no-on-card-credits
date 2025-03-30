local consumInfo = {
    name = 'November Rain',
    set = 'Stand',
    config = {
        extra = {
            max_rank = 9,
            chips = 9,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lands',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return { vars = {card.ability.extra.max_rank, card.ability.extra.chips}}
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