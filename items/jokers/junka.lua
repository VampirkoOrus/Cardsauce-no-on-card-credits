local jokerInfo = {
    name = 'Black Spine Junka',
    config = {
        unlock = 10,
        extra = {
            x_mult_mod = 0.2,
            x_mult = 1,
            prob_mod = 1,
            prob_extra = 0,
            prob = 50,
            destroyed = false,
        }
    },
    rarity = 3,
    cost = 8,
    unlocked = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    streamer = "othervinny",
    csau_dependencies = {
        'enableVHSs',
    },
    origin = {
        'rlm',
        'rlm_j',
        color = 'rlm'
    }
}

function jokerInfo.loc_vars(self, info_queue, card)

    return { vars = { card.ability.extra.x_mult_mod, card.ability.extra.prob_mod, G.FUNCS.csau_add_chance(card.ability.extra.prob_extra, {multiply = true}), card.ability.extra.prob, card.ability.extra.x_mult } }
end

function jokerInfo.locked_loc_vars(self, info_queue, card)
    return { vars = { card.ability.unlock, G.DISCOVER_TALLIES.vhss.tally } }
end

function jokerInfo.check_for_unlock(self, args)
    if args.type == 'discover_amount' then
        if G.DISCOVER_TALLIES.vhss.tally >= self.config.unlock then
            return true
        end
    end
end

function jokerInfo.calculate(self, card, context)
    if context.vhs_death and not context.blueprint then
        if not card.ability.extra.destroyed and pseudorandom('junka') < G.FUNCS.csau_add_chance(card.ability.extra.prob_extra, {multiply = true}) / card.ability.extra.prob then
            card.ability.extra.destroyed = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                         func = function()
                             G.jokers:remove_card(card)
                             card:remove()
                             card = nil
                             return true; end}))
                    return true
                end
            }))
            return {
                message = localize('k_junka_lose')
            }
        else
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
            card.ability.extra.prob_extra = card.ability.extra.prob_extra + card.ability.extra.prob_mod
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}}, delay = 0.4 })
        end
    end
    if context.joker_main and context.cardarea == G.jokers then
        if to_big(card.ability.extra.x_mult) > to_big(1) then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                Xmult_mod = card.ability.extra.x_mult,
            }
        end
    end
end

return jokerInfo