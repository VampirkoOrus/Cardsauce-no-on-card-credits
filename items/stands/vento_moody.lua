local consumInfo = {
    name = 'Moody Blues',
    set = 'csau_Stand',
    config = {
        stand_mask = true,
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'vento',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "artistcredit", set = "Other", vars = { csau_team.dolos } }
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
    for i, v in ipairs(G.consumeables.cards) do
        if v.ability.set == "VHS" and (v.ability.extra and v.ability.extra.runtime) then
            v.ability.extra.runtime = v.ability.extra.runtime * 2
        end
    end
end

function consumInfo.remove_from_deck(self, card)
    for i, v in ipairs(G.consumeables.cards) do
        if v.ability.set == "VHS" and (v.ability.extra and v.ability.extra.runtime) then
            v.ability.extra.runtime = v.ability.extra.runtime / 2
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo