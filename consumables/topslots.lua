local consumInfo = {
    name = 'Top Slots - Spotting The Best',
    set = "VHS",
    cost = 4,
    alerted = true,
    activation = false,
    config = {
        prob_base = 3,
        dollars = 20,
        prob_double = 6,
        double = 2,
        prob_triple = 8,
        triple = 3,
    },
}

function consumInfo.loc_vars(self, info_queue, card)
    return { vars = { G.GAME.probabilities.normal, card.ability.prob_base, card.ability.dollars, card.ability.prob_double, card.ability.prob_triple } }
end

function consumInfo.use(self, card, area, copier)
    if pseudorandom('ILOST') < G.GAME.probabilities.normal / card.ability.prob_base then
        local gamble_money = card.ability.dollars
        if pseudorandom('READYOURMACHINES') < G.GAME.probabilities.normal / card.ability.prob_double then
            gamble_money = gamble_money * card.ability.double
        end
        if pseudorandom('NOCONTROLOVERTHAT') < G.GAME.probabilities.normal / card.ability.prob_triple then
            gamble_money = gamble_money * card.ability.triple
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            attention_text({
                text = localize('$')..gamble_money,
                scale = 1.3,
                hold = 1.4,
                major = card,
                backdrop_colour = G.C.MONEY,
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                silent = true
            })
            play_sound('timpani')
            card:juice_up(0.3, 0.5)
            ease_dollars(gamble_money, true)
            return true end }))
    else
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            attention_text({
                text = localize('k_nope_ex'),
                scale = 1.3,
                hold = 1.4,
                major = card,
                backdrop_colour = G.C.MONEY,
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                silent = true
            })
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                play_sound('tarot2', 0.76, 0.4);return true end}))
            play_sound('tarot2', 1, 0.4)
            card:juice_up(0.3, 0.5)
            return true end }))
    end
    delay(0.6)
end

function consumInfo.can_use(self, card)
    return true
end

return consumInfo