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
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gappie } }
    return { vars = { G.GAME.probabilities.normal, card.ability.prob, localize(G.GAME and G.GAME.wigsaw_suit or "Hearts", 'suits_plural'), colours = {G.C.SUITS[G.GAME and G.GAME.wigsaw_suit or "Hearts"]} } }
end

function jokerInfo.add_to_deck(self, card)
    check_for_unlock({ type = "discover_red" })
end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.before and not card.debuff then
        local last_hand = G.GAME.last_hand_played
        if pseudorandom('red') < G.GAME.probabilities.normal / card.ability.prob then
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
            local scoring = {}
            for i=1, #context.scoring_hand do
                local _card = context.scoring_hand[i]
                _card.base.suit = G.GAME and G.GAME.wigsaw_suit or card.ability.suit_conv
                table.insert(scoring, _card)
            end
            local text = G.FUNCS.recheck_hand(last_hand, scoring)
            return {
                update_hand = text,
                delay = 4.5,
                silent = true
            }
        end
    end
end

return jokerInfo

