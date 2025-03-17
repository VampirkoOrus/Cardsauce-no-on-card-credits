local jokerInfo = {
    name = 'Bye-Bye, Norway',
    config = {
        extra = {
            dollars_mod = 4
        },
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = { card.ability.extra.dollars_mod } }
end

function jokerInfo.calculate(self, card, context)
    if context.selling_self and G.hand and #G.hand.cards > 0 then
        local destroyed_cards = {}
        for i, v in ipairs(G.hand.cards) do
            if v:is_face() then
                destroyed_cards[#destroyed_cards+1] = v
            end
        end
        local money = #destroyed_cards * card.ability.extra.dollars_mod
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                for i=#destroyed_cards, 1, -1 do
                    local card = destroyed_cards[i]
                    if card.ability.name == 'Glass Card' then
                        card:shatter()
                    else
                        card:start_dissolve(nil, i == #destroyed_cards)
                    end
                end
                return true end }))
        return {
            dollars = money
        }
    end
end

return jokerInfo
	