local jokerInfo = {
    name = 'The Purple Joker',
    config = {},
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_TAGS.tag_charm
    info_queue[#info_queue+1] = {key = "guestartist18", set = "Other"}
end

function jokerInfo.add_to_deck(self, card)
    check_for_unlock({ type = "discover_purple" })
end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.debuff and G.GAME.current_round.hands_played == 0 then
        local purp = true
        for k, v in ipairs(context.full_hand) do
            if not v:is_suit('Spades', nil, true) then
                purp = false
            end
        end
        if purp then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_charm'), colour = G.C.SECONDARY_SET.Tarot})
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                blocking = false,
                func = (function()
                    add_tag(Tag('tag_charm'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
    end
end

return jokerInfo