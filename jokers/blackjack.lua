local jokerInfo = {
    name = "Blackjack",
    config = {
        extra = {
            x_mult = 3,
        },
        activated = false,
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult } }
end

function jokerInfo.add_to_deck(self, card)

end

local function validBlackjack()
    if next(SMODS.find_card("j_csau_blackjack")) then
        for i, v in ipairs(SMODS.find_card("j_csau_blackjack")) do
            if not v.debuff then
                return true
            end
        end
    end
    return false
end

function G.FUNCS.find_blackjack(hand, skip)
    skip = skip or false
    if skip or validBlackjack() then
        local total_chips = 0
        for i, v in ipairs(hand) do
            local chip_val = v.debuff and 0 or v.base.nominal
            local bonus_chip = v.debuff and 0 or v.ability.perma_bonus or 0
            total_chips = total_chips + chip_val + bonus_chip
        end
        send(total_chips)
        if total_chips == 21 then
            return true
        else
            return false
        end
    end
end

function jokerInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if context.cardarea == G.jokers and context.before and not card.debuff and not bad_context then
        if G.FUNCS.find_blackjack(context.full_hand, true) then
            card.ability.activated = true
            return {
                message = localize('k_blackjack'),
                colour = G.C.ATTENTION
            }
        end
    end
    if context.joker_main and context.cardarea == G.jokers and card.ability.activated then
        return {
            xmult = card.ability.extra.x_mult,
        }
    end
    if context.after and context.cardarea == G.play then
        card.ability.activated = false
    end
end

return jokerInfo