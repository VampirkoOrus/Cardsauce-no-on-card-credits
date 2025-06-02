local consumInfo = {
    name = 'Moody Blues',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'a3f2d7DC', '4fedd0DC' },
        stand_mask = true,
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'vento',
    in_progress = true,
    csau_dependencies = {
        'enableVHSs'
    }
}

function consumInfo.loc_vars(self, info_queue, card)

end

function consumInfo.add_to_deck(self, card)
    for _, v in ipairs(G.I.CARD) do
        if v.ability and v.ability.set == "VHS" and (v.ability.extra and v.ability.extra.runtime) then
            v.ability.extra.runtime = v.ability.extra.runtime * 2
            G.FUNCS.csau_flare_stand_aura(card, 0.38)
        end
    end
end

function consumInfo.remove_from_deck(self, card)
    for _, v in ipairs(G.I.CARD) do
        if v.ability and v.ability.set == "VHS" and (v.ability.extra and v.ability.extra.runtime) then
            v.ability.extra.runtime = v.ability.extra.runtime / 2
        end
    end
end


return consumInfo