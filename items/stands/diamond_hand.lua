local consumInfo = {
    name = 'The Hand',
    set = 'Stand',
    config = {},
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

local function is_removed(card, removed)
    for i, v in ipairs(removed) do
        if card == v then
            return true
        end
    end
    return false
end

function consumInfo.calculate(self, card, context)
    if context.remove_playing_cards then
        local juice = false
        for i, card in ipairs(context.removed) do
            local pos = card.rank
            local cards_to_convert = {}
            for i=1, 2 do
                local mod = -1
                if i == 2 then mod = 1 end
                if card.area.cards[card.rank+mod] and not is_removed(card.area.cards[card.rank+mod], context.removed) then
                    cards_to_convert[#cards_to_convert+1] = card.area.cards[card.rank+mod]
                end
            end
            if #cards_to_convert > 0 then
                for i, v in ipairs(cards_to_convert) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:set_ability(card.config.center)
                            v:set_base(card.config.card)
                            v:juice_up()
                            return true
                        end
                    }))
                    juice = true
                end
            end
        end
        if juice then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    return true
                end
            }))
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo