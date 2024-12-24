local jokerInfo = {
    name = "Joey's Castle",
    config = {
        money = 1,
        suit = nil,
        suit_pool = {}
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true
}

function jokerInfo.set_ability(self, card, initial, delay_sprites)
    for k, v in pairs(SMODS.Suits) do
        card.ability.suit_pool[#card.ability.suit_pool + 1] = k
    end
    card.ability.suit = pseudorandom_element(card.ability.suit_pool, pseudoseed('joeyscastle'))
end

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "guestartist0", set = "Other"}
    return {card.ability.money, localize(card.ability.suit or "Clubs", 'suits_singular'), colours = {G.C.SUITS[card.ability.suit or "Clubs"]}}
end

function jokerInfo.add_to_deck(self, card)

end

function jokerInfo.calculate(self, card, context)
    if context.discard and not context.other_card.debuff and not context.blueprint and context.other_card:is_suit(card.ability.suit) then
        return {
            message = localize('$')..card.ability.money,
            dollars = card.ability.money,
            colour = G.C.MONEY
        }
    end
end

return jokerInfo