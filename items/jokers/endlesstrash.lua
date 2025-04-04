local jokerInfo = {
    name = "ENDLESS TRASH",
    config = {
        extra = 1,
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "othervinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "artistcredit", set = "Other", vars = { csau_team.yunkie } }
    return { vars = { card.ability.extra } }
end

function jokerInfo.calculate(self, card, context)
    if context.setting_blind and not card.debuff and not context.blueprint then
        if not (context.blueprint_card or card).getting_sliced then
            local count = G.FUNCS.get_vhs_count()
            if count > 0 then
                G.E_MANAGER:add_event(Event({func = function()
                    ease_discard(card.ability.extra*count)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..localize('k_hud_discards').." Discards"})
                    return true
                end }))
            end
        end
    end
end

return jokerInfo
	