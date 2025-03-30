local consumInfo = {
    key = 'c_stand_diamond_echoes_1',
    name = 'Echoes ACT1',
    set = 'Stand',
    config = {
        aura_colors = { 'DCFB8CDC', '5EEB2FDC' },
        evolve_key = 'c_stand_diamond_echoes_2',
        extra = {
            num_cards = 1,
            mult = 3,
            trigger_suit = nil,
            evolve_rounds = 0,
            evolve_num = 1,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {
        vars = {
            card.ability.extra.num_cards,
            card.ability.extra.trigger_suit and localize(card.ability.extra.trigger_suit, 'suits_singular') or '',
            card.ability.extra.trigger_suit and ' suit' or 'matching suit',
            card.ability.extra.mult,
            card.ability.extra.evolve_num - card.ability.extra.evolve_rounds,
            colours = {G.C.SUITS[card.ability.extra.trigger_suit]}
        }
    }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_stand_diamond_echoes_2']
    or G.GAME.used_jokers['c_stand_diamond_echoes_3'] then
        return false
    end
    
    return true
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    if context.cardarea == G.jokers and context.end_of_round then
        card.ability.extra.evolve_rounds = card.ability.extra.evolve_rounds + 1
        if card.ability.extra.evolve_rounds >= card.ability.extra.evolve_num then
            G.FUNCS.evolve_stand(card)
            return
        end

        card.ability.extra.trigger_suit = nil
        return {
            message = localize{type='variable',key='a_remaining',vars={card.ability.extra.evolve_num - card.ability.extra.evolve_rounds}},
            message_card = card
        }
    end
   
    if card.debuff then
        return
    end
    
    if context.cardarea == G.jokers and G.GAME.current_round.hands_played < 1 and context.before and #context.full_hand == card.ability.extra.num_cards then
        card.ability.extra.trigger_suit = SMODS.Suits[context.full_hand[1].base.suit].key
        G.FUNCS.flare_stand_aura(card, 0.5)
        return {
            message = localize('k_echoes_recorded'),
            message_card = card,
            extra = {
                delay = 0.5
            }
        }
    end

    if card.ability.extra.trigger_suit and context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.trigger_suit) then
        G.FUNCS.flare_stand_aura(card, 0.25)
        return {
            mult = card.ability.extra.mult,
            colour = G.C.RED,
            card = card
        }
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo