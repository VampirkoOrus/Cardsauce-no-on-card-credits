local consumInfo = {
    name = 'D4C -Love Train-',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'f3b7f5DC', '8ae5ffDC' },
        stand_mask = true,
        evolved = true,
    },
    cost = 10,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_steel_d4c'] then
        return false
    end
    
    return true
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo