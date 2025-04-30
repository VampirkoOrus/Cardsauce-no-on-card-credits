local jokerInfo = {
    name = 'Blowzo Brothers',
    config = {
        prob_1 = 4,
        prob_2 = 4
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.fenix } }
    return { vars = {G.GAME.probabilities.normal, card.ability.prob_1, card.ability.prob_2 } }
end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.debuff then
        if context.scoring_name == "Two Pair" then
            local bj1 = false
            local ps1 = pseudorandom('bjbros1')
            local ps2 = G.GAME.probabilities.normal / card.ability.prob_1
            if ps1 < ps2 then
                bj1 = true
                return {
                    card = card,
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
    if context.cardarea == G.jokers and context.before and not card.debuff then
        if context.scoring_name == "Two Pair" then
            local bj1 = false
            local enhancements = {
                [1] = G.P_CENTERS.m_bonus,
                [2] = G.P_CENTERS.m_mult,
                [3] = G.P_CENTERS.m_wild,
                [4] = G.P_CENTERS.m_glass,
                [5] = G.P_CENTERS.m_steel,
                [6] = G.P_CENTERS.m_stone,
                [7] = G.P_CENTERS.m_gold,
                [8] = G.P_CENTERS.m_lucky,
            }
            for k, v in ipairs(context.scoring_hand) do
                if pseudorandom('bjbros2') < G.GAME.probabilities.normal / card.ability.prob_2 and v.ability.effect == "Base" then
                    if bj1 then
                        check_for_unlock({ type = "gamer_blowzo" })
                    end
                    v:set_ability(enhancements[pseudorandom('hookedonthebros', 1, 8)], nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up()
                            v:juice_up()
                            return {
                                message = localize('k_enhanced'),
                                card = context.blueprint_card or card,
                                }
                        end
                    }))
                end
            end
        end
    end
end

return jokerInfo