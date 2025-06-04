local jokerInfo = {
    name = "No. 2 Joker",
    config = {
        extra = 1,
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "otherjoel",
    part = 'stardust',
    csau_dependencies = {
        'enableStands',
    }
}

function jokerInfo.loc_vars(self, info_queue, card)

end

function jokerInfo.calculate(self, card, context)
    if context.retrigger_joker_check and not context.retrigger_joker then
        if context.other_card.ability and context.other_card.ability.set == "csau_Stand" then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra,
                card = card,
            }
        end
    end
end

return jokerInfo
