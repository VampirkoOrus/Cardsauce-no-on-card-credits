local jokerInfo = {
    name = 'Why Are You Red?',
    config = {
        suit_conv = "Hearts",
        prob = 4
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "mike",
}

function jokerInfo.loc_vars(self, info_queue, card)

    return { vars = { G.GAME.probabilities.normal, card.ability.prob, localize(G.GAME and G.GAME.wigsaw_suit or "Hearts", 'suits_plural'), colours = {G.C.SUITS[G.GAME and G.GAME.wigsaw_suit or "Hearts"]} } }
end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.after and not card.debuff then
        if pseudorandom('red') < G.GAME.probabilities.normal / card.ability.prob then
            check_for_unlock({ type = "activate_red" })
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_red', vars = {string.upper(localize(G.GAME and G.GAME.wigsaw_suit or "Hearts", 'suits_plural'))}}})
            for i=1, #context.scoring_hand do
                local percent = 1.15 - (i-0.999)/(#context.scoring_hand-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'before',delay = 0.15,func = function() context.scoring_hand[i]:flip();play_sound('card1', percent);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
            end
            for i=1, #context.scoring_hand do
                G.E_MANAGER:add_event(Event({trigger = 'before',delay = 0.1,func = function() context.scoring_hand[i]:change_suit(G.GAME and G.GAME.wigsaw_suit or card.ability.suit_conv);return true end }))
            end
            for i=1, #context.scoring_hand do
                local percent = 0.85 + (i-0.999)/(#context.scoring_hand-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'before',delay = 0.15,func = function() context.scoring_hand[i]:flip();play_sound('tarot2', percent, 0.6);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
            end
            delay(0.8)
        end
    end
end

return jokerInfo

