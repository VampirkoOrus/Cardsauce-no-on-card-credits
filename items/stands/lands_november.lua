local consumInfo = {
    name = 'November Rain',
    set = 'csau_Stand',
    config = {
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

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    if context.individual and context.cardarea == G.play and not card.debuff and context.other_card.ability.effect == 'Base' then
        local chip_val = context.other_card.base.nominal
        if chip_val <= 9 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

local ref_as = SMODS.always_scores
SMODS.always_scores = function(card)
    if next(SMODS.find_card('c_csau_lands_november')) then
        if card.base.nominal <= 9 then return true end
    end
    ref_as(card)
end

return consumInfo