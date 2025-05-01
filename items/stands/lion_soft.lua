local consumInfo = {
    name = 'Soft & Wet',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'cc90f6DC', '734caeDC' },
        stand_mask = true,
        evolve_key = 'c_csau_lion_soft_beyond',
        extra = {
            perma_reduction = 0.5,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_bonus
    info_queue[#info_queue+1] = G.P_CENTERS.m_mult
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.stup } }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_lion_soft_beyond'] then
        return false
    end
    
    return true
end

local enhance_match = function(center, ref_center)
    return (ref_center.set == "Enhanced" and ref_center.effect == center.effect)
end

local get_enhancement_center = function(center)
    for k, v in pairs(G.P_CENTERS) do
        if enhance_match(center, v) then return v end
    end
    for k, v in pairs(SMODS.Centers) do
        if enhance_match(center, v) then return v end
    end
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not card.debuff and not bad_context then
        if not SMODS.PokerHands[context.scoring_name].visible then
            check_for_unlock({ type = "evolve_soft" })
            G.FUNCS.csau_evolve_stand(card)
        else
            local enhanced = {}
            for k, v in ipairs(context.scoring_hand) do
                if (v.config.center == G.P_CENTERS.m_bonus or v.config.center == G.P_CENTERS.m_mult) and not v.debuff then
                    local mult = v.config.center == G.P_CENTERS.m_mult
                    enhanced[#enhanced+1] = v
                    local colour = v.config.center == G.P_CENTERS.m_bonus and G.C.CHIPS or v.config.center == G.P_CENTERS.m_mult and G.C.MULT
                    if v.config.center == G.P_CENTERS.m_bonus then
                        v.ability.perma_bonus = v.ability.perma_bonus or 0
                        v.ability.perma_bonus = v.ability.perma_bonus + (v.config.center.config.bonus*card.ability.extra.perma_reduction)
                    elseif v.config.center == G.P_CENTERS.m_mult then
                        v.ability.perma_mult = v.ability.perma_mult or 0
                        v.ability.perma_mult = v.ability.perma_mult + (v.config.center.config.mult*card.ability.extra.perma_reduction)
                    end
                    v.vampired = true
                    v:set_ability(G.P_CENTERS.c_base, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(v, 'extra', nil, nil, nil, {message = localize('k_soft_and_wet'), colour = (mult and G.C.MULT or G.C.CHIPS)})
                            v.vampired = nil
                            return true
                        end
                    }))
                end
            end
            if #enhanced > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.FUNCS.csau_flare_stand_aura(card, 0.38)
                        card:juice_up()
                        return true
                    end
                }))
            end
        end
    end
end


return consumInfo