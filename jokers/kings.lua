local jokerInfo = {
    name = '2 Kings 2:23-24',
    config = {
        extra = {
            x_mult = 5,
            cards = {}
        },
    },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult } }
end

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function jokerInfo.add_to_deck(self, card)
    if G.GAME.buttons then G.GAME.buttons:remove(); G.GAME.buttons = nil end
    if G.GAME.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.FUNCS.draw_from_deck_to_hand(42)

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            for i = 1, #G.hand.cards do
                                local _card = G.hand.cards[i]
                                table.insert(card.ability.extra.cards, card)
                                if _card.ability.name == 'Glass Card' then
                                    _card:shatter()
                                else
                                    _card:start_dissolve(nil, i == #G.hand.cards)
                                end
                            end
                            return true end }))

                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 1,
                        func = function()
                            if G.GAME.shop then G.shop.alignment.offset.y = -5.3 end
                            return true end }))
                    return true
                end
            }))
            return true
        end
    }))
end

function jokerInfo.remove_from_deck(self, card)
    if G.playing_cards ~= nil then
        for i, ref_card in ipairs(card.ability.extra.cards) do
            local _card = create_playing_card({front = pseudorandom_element(filtered_cards, pseudoseed('miracle_card')), center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
        end
    end
end

return jokerInfo


