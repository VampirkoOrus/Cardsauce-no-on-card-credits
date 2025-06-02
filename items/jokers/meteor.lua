local jokerInfo = {
    name = "Meteor",
    config = {
        id = 7,
        extra = {
            x_mult = 2
        }
    },
    rarity = 1,
    cost = 5,
    unlocked = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "othervinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_glass

end

function jokerInfo.check_for_unlock(self, args)
    if args.type == "roche_destroyed" then
        return true
    end
end

function jokerInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint
    if context.individual and context.cardarea == G.play and not card.debuff and not bad_context then
        if context.other_card:get_id() == 7 and context.other_card.ability.effect ~= "Glass Card" then
            return {
                x_mult = (next(SMODS.find_card("j_csau_plaguewalker")) and 3 or card.ability.extra.x_mult),
                card = context.other_card
            }
        end
    end
    bad_context = context.repetition or context.blueprint or context.individual
    if context.destroying_card and not bad_context then
        if context.destroying_card:get_id() == 7 and context.destroying_card.ability.effect ~= "Glass Card" then
            if pseudorandom('meteor') < G.GAME.probabilities.normal / (next(SMODS.find_card("j_csau_plaguewalker")) and 2 or 4) then
                return true
            end
        end
    end
end

return jokerInfo