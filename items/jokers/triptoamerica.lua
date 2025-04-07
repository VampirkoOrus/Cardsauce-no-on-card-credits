local jokerInfo = {
    name = "Trip To America",
    config = {
        extra = {
            mult = 0,
            mult_mod = 3,
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "artistcredit", set = "Other", vars = { csau_team.gote } }
    return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
end

function jokerInfo.calculate(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint then
        local allFaces = true
        for i = 1, #context.scoring_hand do
            if not context.scoring_hand[i]:is_face() then allFaces = false end
        end
        if allFaces then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        else
            local last_mult = card.ability.extra.mult
            card.ability.extra.mult = 0
            if last_mult > 0 then
                return {
                    card = card,
                    message = localize('k_reset')
                }
            end
        end
    end
    if card.ability.extra.mult > 0 and context.joker_main and context.cardarea == G.jokers then
        return {
            mult = card.ability.extra.mult,
        }
    end
end

return jokerInfo