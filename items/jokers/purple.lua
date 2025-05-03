local jokerInfo = {
    name = 'The Purple Joker',
    config = {
        tarot = 1
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.sine } }
    return {vars = { card.ability.tarot, localize(G.GAME and G.GAME.wigsaw_suit or "Spades", 'suits_plural'), colours = {G.C.SUITS[G.GAME and G.GAME.wigsaw_suit or "Spades"]} } }
end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.debuff and next(context.poker_hands['Flush']) then
        local purp = G.FUNCS.csau_all_suit(context.full_hand, G.GAME and G.GAME.wigsaw_suit or "Spades")
        if purp then
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                if G.FUNCS.find_activated_tape('c_csau_rawtime') then check_for_unlock({ type = "wheres_po" }) end
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({func = function()
                    play_sound('timpani')
                    local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'imthepurpleone')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    card:juice_up(0.3, 0.5)
                    G.GAME.consumeable_buffer = 0
                    return true
                end }))
            end
        end
    end
end

return jokerInfo
