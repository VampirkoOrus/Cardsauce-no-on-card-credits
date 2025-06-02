local jokerInfo = {
    name = "IT'S A FEATURE",
    config = {
        extra = {
            money = 0,
            money_mod = 2,
            prob = 2,
            reset = false,
        },
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    has_shiny = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)

    return { vars = { card.ability.extra.money_mod, G.GAME.probabilities.normal, card.ability.extra.prob, card.ability.extra.money, } }
end

function jokerInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if context.before and not card.debuff and not bad_context then
        card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
        if to_big(card.ability.extra.money) >= to_big(50) then
            check_for_unlock({ type = "high_feature" })
        end
        return {
            message = localize('$')..card.ability.extra.money,
            colour = G.C.ATTENTION,
        }
    end
    if context.joker_main and not card.debuff and not bad_context then
        if context.scoring_name == "Straight" and to_big(card.ability.extra.money) > to_big(0) and pseudorandom('funfudgeyspray') < G.GAME.probabilities.normal / card.ability.extra.prob then
            card.ability.extra.reset = true
            return {
                dollars = card.ability.extra.money
            }
        end
    end
    if context.after and not card.debuff and not bad_context then
        if card.ability.extra.reset then
            card.ability.extra.money = 0
            card.ability.extra.reset = false
            return {
                message = localize('k_reset'),
                card = card
            }
        end
    end
end

return jokerInfo