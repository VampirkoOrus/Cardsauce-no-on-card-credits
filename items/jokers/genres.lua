local jokerInfo = {
    name = "Battle of the Genres",
    config = {
        debuffed = false,
        extra = {
            h_mod = 1,
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "othervinny",
    csau_dependencies = {
        'enableVHSs',
    },
    origin = {
        'rlm',
        'rlm_botw',
        color = 'rlm'
    }
}

function jokerInfo.loc_vars(self, info_queue, card)

    return { vars = { card.ability.extra.h_mod, G.FUNCS.get_vhs_count()*card.ability.extra.h_mod } }
end

function jokerInfo.add_to_deck(self, card)
    local count = G.FUNCS.get_vhs_count()
    if count > 0 then
        G.hand:change_size(card.ability.extra.h_mod * count)
    end
end

function jokerInfo.remove_from_deck(self, card)
    local count = G.FUNCS.get_vhs_count()
    if count > 0 then
        G.hand:change_size(-(card.ability.extra.h_mod * count))
    end
end

function jokerInfo.calculate(self, card, context)
    if not context.blueprint and not card.debuff then
        if context.vhs_death then
            G.hand:change_size(-card.ability.extra.h_mod)
            card:juice_up()
        end
        if context.buying_card then
            if context.card.ability.set == "VHS" then
                G.hand:change_size(card.ability.extra.h_mod)
                card:juice_up()
            end
        end
        if context.selling_card then
            if context.card.ability.set == "VHS" then
                card:juice_up()
            end
        end
    end
end

return jokerInfo
	