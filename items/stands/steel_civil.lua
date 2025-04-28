local consumInfo = {
    name = 'Civil War',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'c09f5fDC', '6c161fDC' },
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
    info_queue[#info_queue+1] = G.P_CENTERS.c_fool
    info_queue[#info_queue+1] = G.P_CENTERS.c_hanged_man
    return { vars = {localize{type = 'name_text', key = card.ability.extra.tarot, set = 'Tarot'}}}
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo