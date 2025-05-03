local consumInfo = {
    name = 'Civil War',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'c09f5fDC', '6c161fDC' },
        stand_mask = true,
        extra = {
            tarot = 'c_hanged_man'
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'steel',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.c_fool
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return { vars = {localize{type = 'name_text', key = card.ability.extra.tarot, set = 'Tarot'}}}
end


function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.using_consumeable and not card.debuff and not bad_context then
        local cons = context.consumeable
        if cons.ability.name == "Hanged Man" then
            G.FUNCS.csau_flare_stand_aura(card, 0.38)
        end
    end
end



return consumInfo