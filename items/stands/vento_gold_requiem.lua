local consumInfo = {
    name = 'Gold Experience Requiem',
    set = 'csau_Stand',
    config = {
        stand_mask = true,
        aura_colors = { '99d3ffDC' , 'd3f5fbDC' },
        evolved = true,
        extra = {
            chance = 0,
            divide = 5,
        }
    },
    cost = 10,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'vento',
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    info_queue[#info_queue+1] = {key = "csau_artistcredit_2", set = "Other", vars = { G.csau_team.reda, G.csau_team.wario } }
    return { vars = { card.ability.extra.chance, card.ability.extra.divide, G.GAME.probabilities.normal}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    return (not G.GAME.used_jokers['c_csau_vento_gold'])
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not card.debuff and not bad_context then
        local gold = {}
        for k, v in ipairs(context.scoring_hand) do
            if v.ability.effect == "Gold Card" then
                gold[#gold+1] = v
            end
        end
        if pseudorandom('thisisrequiem') < G.FUNCS.csau_add_chance(card.ability.extra.chance+#gold, {multiply = true}) / card.ability.extra.divide then
            return {
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end,
                card = card,
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
    end
end


return consumInfo