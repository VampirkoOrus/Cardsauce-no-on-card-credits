local consumInfo = {
    key = 'c_csau_lands_bigmouth',
    name = 'Bigmouth Strikes Again',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'f3e2b5DC', 'd2caa4DC' },
        extra = {
            hand_size = 5,
            suit_count = 4
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
    return { 
        vars = {
            card.ability.extra.hand_size,
            card.ability.extra.suit_count,
            csau_format_display_number(card.ability.extra.hand_size, 'order')
        }
    }
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
	if not context.before or #context.full_hand ~= card.ability.extra.hand_size or bad_context then return end

    -- record flip cards and do initial flip
    if not next(context.poker_hands['Flush']) then return end

    local target_key = context.poker_hands['Flush'][1][1].base.suit
    local change_cards = {}
    for k, v in pairs(context.full_hand) do
        -- find any cards not of the target transform key to transform
        if v.base.suit ~= target_key then
            local change = v
            change_cards[#change_cards+1] = change
            local suit = SMODS.Suits[target_key].card_key
            local rank = SMODS.Ranks[change.base.value].card_key
            change:set_base(G.P_CARDS[suit..'_'..rank], nil, true)

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    change:flip()
                    play_sound('card1')
                    change:juice_up(0.3, 0.3)
                    return true 
                end 
            }))
        end
    end

    if #change_cards < 1 then return end

    G.FUNCS.csau_flare_stand_aura(card, 0.5)
    card_eval_status_text(card, 'extra', nil, nil, nil, {
        message = localize(target_key, 'suits_plural'),
        colour = G.C.SUITS[target_key]
    })

    for i=1, #change_cards do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                change_cards[i]:set_sprites(nil, G.P_CARDS[change_cards[i].config.card_key])
                return true 
            end
        }))
    end
    
    -- do flip back over
    for i=1, #change_cards do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.25,
            func = function() 
                change_cards[i]:flip()
                play_sound('tarot2', 1, 0.6)
                change_cards[i]:juice_up(0.3, 0.3)
                return true 
            end 
        }))
    end
end


return consumInfo