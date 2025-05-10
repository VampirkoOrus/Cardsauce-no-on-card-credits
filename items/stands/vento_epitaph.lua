local consumInfo = {
    name = 'Epitaph',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'fd5481DC', 'ee3c69DC' },
        aura_hover = true,
        evolve_key = 'c_csau_vento_epitaph_king',
        extra = {
            evolve_skips = 0,
            evolve_num = 3,
            preview = 1,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'vento',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return {vars = {card.ability.extra.evolve_num - card.ability.extra.evolve_skips}}
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return (not G.GAME.used_jokers['c_csau_vento_epitaph_king'])
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
    localize{type = 'descriptions', key = self.key, set = self.set, nodes = desc_nodes, vars = self.loc_vars(self, info_queue, card).vars}
    if G.deck and not card.area.config.collection then
        local cards = G.FUNCS.stand_preview_deck(card.ability.extra.preview)
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
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.skip_blind and not bad_context then
        card.ability.extra.evolve_skips = card.ability.extra.evolve_skips + 1
        if card.ability.extra.evolve_skips >= card.ability.extra.evolve_num then
            check_for_unlock({ type = "evolve_kingcrimson" })
            G.FUNCS.csau_evolve_stand(card)
        else
            return {
                message = card.ability.extra.evolve_skips..'/'..card.ability.extra.evolve_num,
                colour = G.C.STAND
            }
        end
    end
end


return consumInfo