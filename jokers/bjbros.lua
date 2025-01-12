local jokerInfo = {
    name = 'Blowzo Brothers',
    config = {
        prob_1 = 2,
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
    info_queue[#info_queue+1] = {key = "guestartist11", set = "Other"}
    return { vars = {G.GAME.probabilities.normal, card.ability.prob_1, card.ability.prob_2 } }
end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.debuff then
        if context.scoring_name == "Two Pair" then
            if pseudorandom('bjbros1') < G.GAME.probabilities.normal / card.ability.prob_1 then
                return {
                    card = card,
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
            if not context.blueprint_card and pseudorandom('bjbros2') < G.GAME.probabilities.normal / card.ability.prob_2 then
                card:juice_up()
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
                local card_1 = pseudorandom_element(context.scoring_hand, pseudoseed('bjbros'))
                local card_2
                repeat
                    card_2 = pseudorandom_element(context.scoring_hand, pseudoseed('second_pick'))
                until card_2 ~= card_1
                for i, v in ipairs(context.scoring_hand) do
                    if (v == card_1 or v == card_2) and v.ability.effect == "Base" then
                        local percent = 1.15 - (i-0.999)/(#context.scoring_hand-0.998)*0.3
                        G.E_MANAGER:add_event(Event({trigger = 'before',delay = 0.15,func = function() context.scoring_hand[i]:flip();play_sound('card1', percent);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
                    end
                end
                for i, v in ipairs(context.scoring_hand) do
                    if (v == card_1 or v == card_2) and v.ability.effect == "Base" then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.15,
                            func = function()
                                v:set_ability(enhancements[pseudorandom('hookedonthebros', 1, 8)])
                                return true
                            end
                        }))
                    end
                end
                for i, v in ipairs(context.scoring_hand) do
                    if (v == card_1 or v == card_2) and v.ability.effect == "Base" then
                        local percent = 0.85 + (i-0.999)/(#context.scoring_hand-0.998)*0.3
                        G.E_MANAGER:add_event(Event({trigger = 'before',delay = 0.15,func = function() context.scoring_hand[i]:flip();play_sound('tarot2', percent, 0.6);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
                    end
                end
            end
        end
    end
end

return jokerInfo