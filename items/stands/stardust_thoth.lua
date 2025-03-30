local consumInfo = {
    name = 'Thoth',
    set = 'Stand',
    config = {
        extra = {
            preview = 3
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'stardust',
    in_progress = 'true',
}

function consumInfo.loc_vars(self, info_queue, card)
    return { vars = {card.ability.extra.preview}}
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end



function consumInfo.can_use(self, card)
    return false
end

return consumInfo