local consumInfo = {
    key = 'c_stand_tarot_arrow',
    name = 'The Arrow',
    set = 'Tarot',
    cost = 4,
    alerted = true,
    part = 'diamond',
}

function consumInfo.loc_vars(self, info_queue, card)
    if G.GAME.csau_unlimited_stands then
        info_queue[#info_queue+1] = {key = "csau_stand_info_unlimited", set = "Other"}
    else
        info_queue[#info_queue+1] = {key = "csau_stand_info", set = "Other", vars = { G.GAME.csau_max_stands or 1, (card.area.config.collection and localize('k_csau_stand')) or (G.GAME.csau_max_stands > 1 and localize('b_csau_stand_cards') or localize('k_csau_stand')) }}
    end
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
end

function consumInfo.use(self, card, area, copier)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        if next(SMODS.find_card("c_csau_vento_gold")) then
            local stand = SMODS.find_card("c_csau_vento_gold")[1]
            G.FUNCS.csau_evolve_stand(stand)
        else
            G.FUNCS.csau_new_stand(false)
        end
        return true
    end }))
    delay(0.6)
end

function consumInfo.can_use(self, card)
    if G.GAME.csau_unlimited_stands then
        return G.consumeables.config.card_limit > #G.consumeables.cards - (card.area == G.consumeables and 1 or 0)
    end

    return (G.FUNCS.csau_get_num_stands() < G.GAME.csau_max_stands) or next(SMODS.find_card("c_csau_vento_gold"))
end

return consumInfo