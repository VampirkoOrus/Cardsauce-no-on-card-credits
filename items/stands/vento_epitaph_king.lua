local consumInfo = {
    name = 'King Crimson',
    set = 'csau_Stand',
    config = {
        evolved = true,
        stand_mask = true,
        aura_colors = { 'e53663DC', 'a71d40DC' },
    },
    cost = 10,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'vento',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return (not G.GAME.used_jokers['c_csau_vento_epitaph'])
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.end_of_round and not G.GAME.blind.boss and not bad_context then
        add_tag(Tag(G.GAME.round_resets.blind_tags[G.GAME.blind_on_deck]))
        card:juice_up()
        G.FUNCS.csau_flare_stand_aura(card, 0.38)
    end
end


return consumInfo