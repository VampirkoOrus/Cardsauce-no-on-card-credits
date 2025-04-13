local jokerInfo = {
    name = "IT'S A FEATURE",
    config = {
        extra = {
            money = 0,
            money_mod = 2,
            prob = 2,
        },
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.burlap } }
    return { vars = { card.ability.extra.money_mod, G.GAME.probabilities.normal, card.ability.extra.prob, card.ability.extra.money, } }
end

function jokerInfo.add_to_deck(self, card)

end

function jokerInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if context.cardarea == G.jokers and context.before and not card.debuff and not bad_context then
        if context.scoring_name == "Straight" and card.ability.extra.money > 0 and pseudorandom('funfudgeyspray') < G.GAME.probabilities.normal / card.ability.extra.prob then
            local cash = card.ability.extra.money
            card.ability.extra.money = 2
            return {
                dollars = cash
            }
        else
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
            return {
                message = localize('$')..card.ability.extra.money,
                colour = G.C.ATTENTION,
            }
        end
    end
end

return jokerInfo