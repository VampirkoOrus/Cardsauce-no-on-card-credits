local consumInfo = {
    name = 'Black Spine',
    set = "VHS",
    cost = 3,
    alerted = true,
    nosleeve = true,
}

function consumInfo.use(self, card, area, copier)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        if G.consumeables.config.card_limit > #G.consumeables.cards then
            play_sound('timpani')
            local card = create_card('VHS', G.consumeables, nil, nil, nil, nil, nil, 'blackspine')
            card:add_to_deck()
            G.consumeables:emplace(card)
            card:juice_up(0.3, 0.5)
        end
        return true
    end }))
    delay(0.6)
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo