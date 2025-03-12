local consumInfo = {
    name = 'The Arrow',
    set = "Tarot",
    cost = 4,
    alerted = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    if G.GAME.unlimited_stands then
        info_queue[#info_queue+1] = {key = "stand_info_unlimited", set = "Other"}
    else
        if card and card.area then
            info_queue[#info_queue+1] = {key = "stand_info", set = "Other", vars = { G.GAME.max_stands or 1, (card.area.config.collection and localize('k_stand')) or (G.GAME.max_stands > 1 and localize('b_stand_cards') or localize('k_stand')) }}
        end
    end
    return {}
end

get_replaceable_stand = function()
    for i, v in ipairs(G.consumeables.cards) do
        if v.ability.set == "Stand" then
            return v
        end
    end
    return nil
end

stand_count = function()
    local count = 0
    for i, v in ipairs(G.consumeables.cards) do
        if v.ability.set == "Stand" then
            count = count+1
        end
    end
    return count
end

replace_stand = function()
    local card = get_replaceable_stand()
    local new_stand_key = pseudorandom_element(get_current_pool('Stand', nil, nil, 'arrow'), pseudoseed('arrowreplace'))
    G.FUNCS.transform_card(card, new_stand_key)
end

new_stand = function()
    if G.GAME.unlimited_stands then
        if G.consumeables.config.card_limit > #G.consumeables.cards then
            local card = create_card('Stand', G.consumeables, nil, nil, nil, nil, nil, 'arrow')
            card:add_to_deck()
            G.consumeables:emplace(card)
            card:juice_up(0.3, 0.5)
        else
            replace_stand()
        end
    else
        if G.GAME.max_stands > stand_count() then
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                local card = create_card('Stand', G.consumeables, nil, nil, nil, nil, nil, 'arrow')
                card:add_to_deck()
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            else
                if get_replaceable_stand() ~= nil then
                    replace_stand()
                end
            end
        else
            if get_replaceable_stand() ~= nil then
                replace_stand()
            end
        end
    end
end

function consumInfo.use(self, card, area, copier)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        new_stand()
        return true
    end }))
    delay(0.6)
end

function consumInfo.can_use(self, card)
    if G.consumeables.config.card_limit > #G.consumeables.cards-(card.area == G.consumeables and 1 or 0) then
        return true
    else
        if get_replaceable_stand() ~= nil then
            return true
        end
    end
    return true
end

return consumInfo