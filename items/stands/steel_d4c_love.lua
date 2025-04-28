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

function consumInfo.calculate(self, card, context)
    if context.destroy_card and context.cardarea == G.play then
        if context.scoring_name == "Pair" and not card.ability.activated then
            context.destroying_card = context.scoring_hand
            card.ability.activated = true
            return true
        end
    end
    if context.end_of_round then
        card.ability.activated = false
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo