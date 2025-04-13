local jokerInfo = {
    name = 'Vinewrestle',
    config = {},
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.cejai } }
end

function jokerInfo.add_to_deck(self, card)

end

local tag_colors = {
    tag_uncommon = G.C.GREEN,
    tag_rare = G.C.RED,
    tag_negative = G.C.DARK_EDITION,
    tag_foil = G.C.DARK_EDITION,
    tag_holo = G.C.DARK_EDITION,
    tag_polychrome = G.C.DARK_EDITION,
}

function jokerInfo.calculate(self, card, context)
    if context.end_of_round and G.GAME.blind.boss and not card.debuff then
        local free_joker_tags = {}
        for k, v in pairs(G.P_TAGS) do
            if starts_with(v.config.type, 'store_joker') and (not v.min_ante or (G.GAME.round_resets.ante >= v.min_ante)) then
                free_joker_tags[#free_joker_tags + 1] = k
            end
        end
        local free_tag = pseudorandom('ITSSOMOAJOE', 1, #free_joker_tags)
        local color = tag_colors[free_joker_tags[free_tag]] or G.C.IMPORTANT
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_one')..G.localization.descriptions["Tag"][free_joker_tags[free_tag]].name, colour = color})
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            blocking = false,
            func = (function()
                add_tag(Tag(free_joker_tags[free_tag]))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end)
        }))
    end
end

return jokerInfo
	