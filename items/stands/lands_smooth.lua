local consumInfo = {
    key = 'c_csau_lands_smooth',
    name = 'Smooth Operators',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'f2be53DC', 'f7e580DC' },
        extra = {
            rank_range = 1,
            rank_mod = 1
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lands',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if not context.before or bad_context then return end

    local scoring_ranks = {}
    for _, scored in ipairs(context.scoring_hand) do
        scoring_ranks[scored:get_id()] = true
    end

    local ranges = {}
    for i=1, card.ability.extra.rank_range do
        ranges[#ranges+1] = i
        ranges[#ranges+1] = -i
    end

    local change_cards = {}
    for _, unscored in ipairs(context.full_hand) do
        if not SMODS.in_scoring(unscored, context.scoring_hand) then
            local in_range = nil
            for _, v in ipairs(ranges) do
                local search_adjacent = unscored:get_id()+v
                if search_adjacent < 1 then search_adjacent = 14 - search_adjacent end
                if search_adjacent > 14 then search_adjacent = search_adjacent % 14 end
                
                if scoring_ranks[search_adjacent] then 
                    in_range = v
                    break
                end
            end

            if in_range then 
                change_cards[#change_cards+1] = { card = unscored, mod = in_range}
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        unscored:flip()
                        play_sound('card1')
                        unscored:juice_up(0.3, 0.3)
                        return true 
                    end 
                }))
            end
        end
    end

    if #change_cards < 1 then return end 

    for _, v in ipairs(change_cards) do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                SMODS.modify_rank(v.card, v.mod)
                return true 
            end
        }))
    end
    
    -- do flip back over
    for _, v in ipairs(change_cards) do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.25,
            func = function() 
                v.card:flip()
                play_sound('tarot2', 1, 0.6)
                v.card:juice_up(0.3, 0.3)
                return true 
            end 
        }))
    end

    return {
        func = function()
            G.FUNCS.csau_flare_stand_aura(card, 0.38)
        end,
        message = localize('k_smooth_operators'),
        message_card = card
    }
end


return consumInfo