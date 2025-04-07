local consumInfo = {
    name = 'Gold Experience',
    set = 'Stand',
    config = {
        evolve_key = 'c_stand_vento_gold_requiem'
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'vento',
}

function consumInfo.loc_vars(self, info_queue, card)
    return { vars = { localize(G.GAME and G.GAME.wigsaw_suit or "Hearts", 'suits_plural'), colours = {G.C.SUITS[G.GAME and G.GAME.wigsaw_suit or "Hearts"]}} }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return G.GAME.used_jokers['c_stand_vento_gold_requiem'] ~= nil
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if context.cardarea == G.jokers and context.before and not card.debuff and not bad_context then
        local gold = {}
        for k, v in ipairs(context.scoring_hand) do
            if v:is_suit(G.GAME and G.GAME.wigsaw_suit or "Hearts") then
                gold[#gold+1] = v
                v:set_ability(G.P_CENTERS.m_gold, nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
            end
        end
        if #gold > 0 then
            return {
                message = localize('k_gold'),
                colour = G.C.MONEY,
                card = self
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo