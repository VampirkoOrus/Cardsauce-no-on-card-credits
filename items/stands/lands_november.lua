local consumInfo = {
    name = 'November Rain',
    set = 'csau_Stand',
    config = {
        aura_colors = { '43b7abDC', '2e8cfaDC' },
        stand_mask = true,
        extra = {
            max_rank = 9,
            chips = 9,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lands',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return { vars = {card.ability.extra.max_rank, card.ability.extra.chips}}
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.modify_scoring_hand and not bad_context then
        local chip_val = context.other_card.base.nominal
        if to_big(chip_val) <= to_big(9) then
            return {
                add_to_hand = true
            }
        end
    end
    if context.individual and context.cardarea == G.play and not card.debuff then
        local chip_val = context.other_card.base.nominal
        if to_big(chip_val) <= to_big(9) then
            return {
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end,
                chips = card.ability.extra.chips
            }
        end
    end
end


return consumInfo