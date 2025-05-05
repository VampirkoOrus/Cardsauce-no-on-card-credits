local consumInfo = {
    name = 'Metallica',
    set = 'csau_Stand',
    config = {
        stand_mask = true,
        aura_colors = { 'F97C87DA', 'CE3749DA' },
        extra = {
            x_mult = 2,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'vento',
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_steel
    info_queue[#info_queue+1] = G.P_CENTERS.m_glass
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
end

local function detect_jacks(scoring_hand)
    for k, v in ipairs(scoring_hand) do
        if v:get_id() == 11 and v.ability.effect == "Base" then
            return true
        end
    end
    return false
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not card.debuff and not bad_context then
        if detect_jacks(context.full_hand) then
            for i, v in ipairs(context.full_hand) do
                if v:get_id() == 11 and v.ability.effect == "Base" then
                    v:set_ability(G.P_CENTERS.m_steel, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            return {
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end,
                message = localize('k_metal'),
                card = card,
            }
        end
    end
    bad_context = context.repetition or context.blueprint or context.retrigger_joker
    if context.individual and context.cardarea == G.play and not card.debuff and not bad_context then
        if context.other_card:get_id() == 11 and context.other_card.ability.effect == "Steel Card" then
            return {
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end,
                xmult = (next(SMODS.find_card("j_csau_plaguewalker")) and 3 or card.ability.extra.x_mult),
                card = context.other_card
            }
        end
    end
    bad_context = context.repetition or context.blueprint or context.individual
    if context.destroying_card and not bad_context then
        if context.destroying_card:get_id() == 11 and context.destroying_card.ability.effect == "Steel Card" then
            if pseudorandom('metallica') < G.GAME.probabilities.normal / (next(SMODS.find_card("j_csau_plaguewalker")) and 2 or 4) then
                return true
            end
        end
    end
end


return consumInfo