local consumInfo = {
    name = 'Epitaph',
    set = 'Stand',
    config = {
        evolve_key = 'c_csau_vento_epitaph_king',
        extra = {
            evolve_skips = 0,
            evolve_num = 3,
            preview = 1,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'vento',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {card.ability.extra.evolve_num - card.ability.extra.evolve_skips}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return G.GAME.used_jokers['c_csau_vento_epitaph_king'] ~= nil
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end


-- Modified Code from Jimbo's Pack
local create_tohth_cardarea = function(card, cards)
    tohth_cards = CardArea(
            0, 0,
            (math.min(card.ability.extra.preview,#cards) * G.CARD_W)*0.75,
            (G.CARD_H*1.5)*0.5,
            {card_limit = #cards, type = 'title', highlight_limit = 0, card_w = G.CARD_W*0.7}
    )
    for i = 1, #cards do
        local card = copy_card(cards[i], nil, nil, G.playing_card)
        tohth_cards:emplace(card)
    end
    return {
        n=G.UIT.R, config = {
            align = "cm", colour = G.C.CLEAR, r = 0.0
        },
        nodes={
            {
                n=G.UIT.C,
                config = {align = "cm", padding = 0.2},
                nodes={
                    {n=G.UIT.O, config = {padding = 0.2, object = tohth_cards}},
                }
            }
        },
    }
end

function consumInfo.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    if card.area and card.area == G.jokers or card.config.center.discovered then
        -- If statement makes it so that this function doesnt activate in the "Joker Unlocked" UI and cause 'Not Discovered' to be stuck in the corner
        full_UI_table.name = localize{type = 'name', key = self.key, set = self.set, name_nodes = {}, vars = specific_vars or {}}
    end
    info_queue[#info_queue+1] = {key = "artistcredit", set = "Other", vars = { csau_team.gote } }
    localize{type = 'descriptions', key = self.key, set = self.set, nodes = desc_nodes, vars = self.loc_vars(self, info_queue, card).vars}
    if G.deck and not card.area.config.collection then
        local cards = {}
        for i = 1, card.ability.extra.preview do
            if G.deck.cards[i] then
                cards[#cards+1]=G.deck.cards[#G.deck.cards-(i-1)]
            end
        end
        if cards[1] then
            local cardarea = create_tohth_cardarea(card, cards)
            desc_nodes[#desc_nodes+1] = {{
                                             n=G.UIT.R, config = {
                    align = "tm", colour = G.C.CLEAR, r = 0.0
                },
                                             nodes={
                                                 {
                                                     n=G.UIT.C,
                                                     config = {align = "cm", padding = 0.05},
                                                     nodes={
                                                         {n=G.UIT.T, config={text = '/', scale = 0.05, colour = G.C.CLEAR}},
                                                     }
                                                 }
                                             },
                                         }}
            desc_nodes[#desc_nodes+1] = {cardarea}
        end
    end
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if context.skip_blind and not bad_context then
        card.ability.extra.evolve_skips = card.ability.extra.evolve_skips + 1
        if card.ability.extra.evolve_skips >= card.ability.extra.evolve_num then
            G.FUNCS.evolve_stand(card)
        else
            return {
                message = card.ability.extra.evolve_skips..'/'..card.ability.extra.evolve_num,
                colour = G.C.STAND
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo