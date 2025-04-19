local jokerInfo = {
    name = 'Dripping Joker',
    config = { rand_card },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "other",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.alli } }
    return { vars = { } }
end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.debuff and G.GAME.current_round.hands_played == 0 then

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

        if context.debuffed then return end

        if context.before and not card.debuff and G.GAME.current_round.hands_played == 0 and #G.hand.cards > 0 then
            rand_card = pseudorandom_element(G.hand.cards, pseudoseed('stickybytylerthecreator'))
            rand_card.enhance_flag = true
        end

        if context.cardarea == G.jokers and rand_card and rand_card.enhance_flag == true then
            G.E_MANAGER:add_event(Event({
                func = function()
                    rand_card:set_ability(enhancements[pseudorandom('sticky', 1, 8)], nil, true)
                    rand_card:juice_up()

                    return true
                end
            })) 
            return {
                message = localize('k_enhanced'),
                card = context.blueprint_card or card,
            }
        end
    end
end

return jokerInfo