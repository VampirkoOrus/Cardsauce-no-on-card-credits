local ref_game_update_hand = Game.update_selecting_hand
function Game:update_selecting_hand(dt)
    local state_complete = G.STATE_COMPLETE

    local ret = ref_game_update_hand(self, dt)

    if not state_complete and G.STATE_COMPLETE and #G.hand.cards >= 1 and #G.deck.cards >= 1 then
        SMODS.calculate_context({csau_resetting_hand = true})
    end

    return ret
end

local consumInfo = {
    name = 'Chopping Mall',
    key = 'c_csau_choppingmall',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 3,
            uses = 0,
        },
    },
    origin = {
        'rlm',
        'rlm_botw',
        color = 'rlm'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}

    return { 
        vars = {
            card.ability.extra.runtime-card.ability.extra.uses,
            (card.ability.extra.runtime-card.ability.extra.uses) > 1 and 's' or ''
        }
    }
end

function consumInfo.calculate(self, card, context)
    if not card.ability.activated then return end

    if (context.csau_resetting_hand and G.GAME.current_round.hands_played > 0) or (context.end_of_round and context.game_over ~= nil) then
        card.ability.extra.uses = card.ability.extra.uses + 1
        if to_big(card.ability.extra.uses) >= to_big(card.ability.extra.runtime) then
            G.E_MANAGER:add_event(Event({
                blocking = false,
                func = function()
                    G.FUNCS.destroy_tape(card)
                    card.ability.destroyed = true
                    return true
                end 
            }))
        end
        return
    end

    if not (context.repetition and context.cardarea == G.hand)
    or not (next(context.card_effects[1]) or #context.card_effects > 1) then
        return
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        blocking = false,
        func = function()
            card:juice_up()
            return true
        end 
    }))

    return {
        message = localize('k_again_ex'),
        repetitions = 1,
        card = card
    }
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo