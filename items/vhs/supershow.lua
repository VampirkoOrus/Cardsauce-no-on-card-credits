local consumInfo = {
    name = 'The Super Mario Bros. Super Show',
    key = 'supershow',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 3,
            uses = 0
        },
    },
    origin = 'vinny'
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}

    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.calculate(self, card, context)
    if card.ability.activated and context.remove_playing_cards then
        local emp_area = G.play
        if #G.play.cards > 0 then
            emp_area = G.hand
        end
        for i, v in ipairs(context.removed) do
            if not card.ability.destroyed then
                check_for_unlock({ type = "activate_supershow" })
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = copy_card(v, nil, nil, nil, true)
                        _card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                        emp_area:emplace(_card)
                        local edition = poll_edition('whoreallydiedthatday', nil, true, true)
                        _card:set_edition(edition, true)
                        table.insert(G.playing_cards, _card)
                        if emp_area == G.play then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                                    draw_card(G.play,G.deck, 90,'up', nil)
                                    return true
                                end}))
                        end
                        playing_card_joker_effects({_card})
                        return true
                    end}))
                card.ability.extra.uses = card.ability.extra.uses+1
                if to_big(card.ability.extra.uses) >= to_big(card.ability.extra.runtime) then
                    G.FUNCS.destroy_tape(card)
                    card.ability.destroyed = true
                end
            end
        end
    end
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo