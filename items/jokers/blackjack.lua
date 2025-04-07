local function isBlackjack(hand)
    local total = 0
    local ace_count = 0
    for _, v in ipairs(hand) do
        local rank = SMODS.Ranks[v.base.value]
        if rank.key == "Ace" then
            ace_count = ace_count + 1
        end
        total = total + rank.nominal
    end
    while total > 21 and ace_count > 0 do
        total = total - 10
        ace_count = ace_count - 1
    end
    return total == 21
end

SMODS.PokerHand {
    key = "Blackjack",
    chips = 21,
    mult = 6,
    l_chips = 11,
    l_mult = 3,
    visible = false,
    example = {
        { 'H_A', true },
        { 'S_7', true },
        { 'C_3', true },
    },
    evaluate = function(parts, hand)
        if next(SMODS.find_card("j_csau_blackjack")) then
            if isBlackjack(hand) then
                return { hand }
            end
        end
    end,
}

local function allOneSuit(hand)
    local suits = SMODS.Suit.obj_buffer
    for j = 1, #suits do
        local t = {}
        local suit = suits[j]
        local flush_count = 0
        for i=1, #hand do
            if hand[i]:is_suit(suit, nil, true) then flush_count = flush_count + 1;  t[#t+1] = hand[i] end
        end
        if flush_count == #hand then
            return true
        end
    end
    return false
end

SMODS.PokerHand {
    key = "FlushBlackjack",
    chips = 84,
    mult = 8,
    l_chips = 42,
    l_mult = 4,
    visible = false,
    example = {
        { 'C_A', true },
        { 'C_8', true },
        { 'C_5', true },
        { 'C_4', true },
        { 'C_3', true },
    },
    evaluate = function(parts, hand)
        if next(SMODS.find_card("j_csau_blackjack")) then
            if next(parts._flush) and isBlackjack(hand) then
                return { hand }
            end
        end
    end,
}


local jokerInfo = {
    name = "Blackjack",
    config = {},
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = { } }
end

function jokerInfo.add_to_deck(self, card)

end

function jokerInfo.calculate(self, card, context)

end

return jokerInfo