local consumInfo = {
    name = 'King Crimson',
    set = 'csau_Stand',
    config = {
        evolved = true,
        aura_colors = { 'e53663DC', 'a71d40DC' },
    },
    cost = 10,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'vento',
    in_progress = true,
}

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return G.GAME.used_jokers['c_csau_vento_epitaph'] ~= nil
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if context.end_of_round and not G.GAME.blind.boss and not bad_context then
        add_tag(Tag(G.GAME.round_resets.blind_tags[G.GAME.blind_on_deck]))
        card:juice_up()
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo