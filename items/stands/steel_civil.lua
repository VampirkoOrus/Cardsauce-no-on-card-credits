local consumInfo = {
    name = 'Civil War',
    set = 'csau_Stand',
    config = {
        extra = {
            tarot = 'c_hanged_man'
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return { vars = {localize{type = 'name_text', key = card.ability.extra.tarot, set = 'Tarot'}}}
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