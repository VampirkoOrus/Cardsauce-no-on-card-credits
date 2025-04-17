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
    if context.cardarea == G.jokers and context.before and not card.debuff then
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        local type = pseudorandom(pseudoseed('drippycard'..G.GAME.round_resets.ante)) > 0.6 and "Enhanced" or "Base"
        local _card = create_card(type, G.hand, nil, nil, nil, true, nil, 'drippy')
        if type == "Enhanced" then
            _card.drippy = true
        end
        _card:add_to_deck()
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, _card)
        G.hand:emplace(_card)
        _card.states.visible = nil
        G.E_MANAGER:add_event(Event({
            func = function()
                _card:start_materialize()
                return true
            end
        }))
        return {
            message = localize('k_plus_one_card'),
            colour = G.C.CHIPS,
            card = card,
            playing_cards_created = {true}
        }
    end
    if context.individual and context.cardarea == G.hand and not card.debuff then
        if context.other_card.ability.effect ~= 'Base' and context.other_card.drippy then
            context.other_card.drippy = false
            if context.other_card.ability.effect == 'Bonus Card' then
                check_for_unlock({ type = "activate_drippy" })
                return {
                    message = localize{type='variable',key='a_chips',vars={to_big(50)}},
                    chip_mod = 50,
                    card = context.other_card
                }
            elseif context.other_card.ability.effect == 'Mult Card' then
                check_for_unlock({ type = "activate_drippy" })
                return {
                    message = localize{type='variable',key='a_mult',vars={to_big(4)}},
                    mult = 4,
                    card = context.other_card
                }
            elseif context.other_card.ability.effect == 'Stone Card' then
                check_for_unlock({ type = "activate_drippy" })
                return {
                    message = localize{type='variable',key='a_chips',vars={to_big(50)}},
                    chip_mod = 50,
                    card = context.other_card
                }
            elseif context.other_card.ability.effect == 'Glass Card' then
                check_for_unlock({ type = "activate_drippy" })
                return {
                    x_mult = 2,
                    card = context.other_card
                }
            elseif context.other_card.ability.effect == 'Lucky Card' then
                check_for_unlock({ type = "activate_drippy" })
                local mult = 0
                local dollars = 0
                if pseudorandom('drippylucky1') < G.GAME.probabilities.normal / 5 then
                    mult = 20
                end
                if pseudorandom('drippylucky2') < G.GAME.probabilities.normal / 15 then
                    dollars = to_big(20)
                end
                return {
                    mult =mult,
                    dollars = to_big(dollars),
                    card = context.other_card
                }
            end
        end
    end
end

return jokerInfo