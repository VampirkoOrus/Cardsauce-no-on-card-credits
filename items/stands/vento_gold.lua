local consumInfo = {
    name = 'Gold Experience',
    set = 'csau_Stand',
    config = {
        stand_mask = true,
        aura_colors = { 'fff679DC' , 'f9d652DC' },
        evolve_key = 'c_csau_vento_gold_requiem',
        extra = {
            prob = 2,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'vento',
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.wario } }
    return { vars = { G.GAME.probabilities.normal, card.ability.extra.prob, localize(G.GAME and G.GAME.wigsaw_suit or "Hearts", 'suits_plural'), colours = {G.C.SUITS[G.GAME and G.GAME.wigsaw_suit or "Hearts"]}} }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end
    
    return (not G.GAME.used_jokers['c_csau_vento_gold_requiem'])
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not card.debuff and not bad_context then
        local gold = {}
        for k, v in ipairs(context.scoring_hand) do
            if v:is_suit(G.GAME and G.GAME.wigsaw_suit or "Hearts") and pseudorandom('thisisrequiem') < G.GAME.probabilities.normal / card.ability.extra.prob then
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
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                end,
                message = localize('k_gold_exp'),
                colour = G.C.MONEY,
                card = card
            }
        end
    end
end


return consumInfo