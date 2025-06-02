local jokerInfo = {
    name = 'Protegent Antivirus',
    config = {
        extra = {
            boss_prob = 4,
            save_prob = 8,
        }
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    has_shiny = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)

    return { vars = { G.GAME.probabilities.normal, card.ability.extra.boss_prob, card.ability.extra.save_prob } }
end

function jokerInfo.calculate(self, card, context)
    if context.setting_blind and context.blind.boss and not card.getting_sliced then
        if pseudorandom('malwarespywaretrojan') < G.GAME.probabilities.normal / card.ability.extra.boss_prob then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.blind:disable()
                    play_sound('timpani')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                         func = function()
                             G.jokers:remove_card(card)
                             card:remove()
                             card = nil
                             return true
                         end
                    }))
                    return true
                end
            }))
            return {
                message = localize('ph_boss_disabled'),
                colour = G.C.FILTER
            }
        end
    end
    if not context.blueprint_card and context.game_over then
        if pseudorandom('allgoneforever') < G.GAME.probabilities.normal / card.ability.extra.save_prob then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    card:start_dissolve()
                    return true
                end
            }))
            check_for_unlock({ type = "activate_proto" })
            return {
                saved = 'ph_saved_proto',
                colour = G.C.RED
            }
        end
    end
end

return jokerInfo