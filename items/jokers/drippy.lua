local jokerInfo = {
    name = 'Dripping Joker',
    config = {},
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
    if context.cardarea == G.jokers and context.before and not card.debuff and G.GAME.current_round.hands_played == 0 and not context.debuffed then

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
        local enhancements = {}
        for k, v in pairs(G.P_CENTERS) do if v.set == "Enhanced" then table.insert(enhancements, v) end end
        for k, v in pairs (SMODS.Centers) do if v.set == "Enhanced" then table.insert(enhancements, v) end end

        local rand_card = pseudorandom_element(G.hand.cards, pseudoseed('stickybytylerthecreator'))
        rand_card:set_ability(pseudorandom_element(enhancements, pseudoseed('whothefuckisdrippysaidvinny')), nil, true)
        G.E_MANAGER:add_event(Event({
            func = function()
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

return jokerInfo