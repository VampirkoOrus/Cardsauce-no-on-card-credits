local consumInfo = {
    name = 'All Along Watchtower',
    set = 'Stand',
    config = {
        extra = {
            x_mult = 4,
        }
    },
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'vento',
}

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

local fiftyTwoTwoAce = {
    Hearts = {
        ['2'] = 1, ['3'] = 1, ['4'] = 1, ['5'] = 1, ['6'] = 1, ['7'] = 1, ['8'] = 1, ['9'] = 1, ['10'] = 1,
        ['J'] = 1, ['Q'] = 1, ['K'] = 1, ['A'] = 1
    },
    Diamonds = {
        ['2'] = 1, ['3'] = 1, ['4'] = 1, ['5'] = 1, ['6'] = 1, ['7'] = 1, ['8'] = 1, ['9'] = 1, ['10'] = 1,
        ['J'] = 1, ['Q'] = 1, ['K'] = 1, ['A'] = 1
    },
    Clubs = {
        ['2'] = 1, ['3'] = 1, ['4'] = 1, ['5'] = 1, ['6'] = 1, ['7'] = 1, ['8'] = 1, ['9'] = 1, ['10'] = 1,
        ['J'] = 1, ['Q'] = 1, ['K'] = 1, ['A'] = 1
    },
    Spades = {
        ['2'] = 1, ['3'] = 1, ['4'] = 1, ['5'] = 1, ['6'] = 1, ['7'] = 1, ['8'] = 1, ['9'] = 1, ['10'] = 1,
        ['J'] = 1, ['Q'] = 1, ['K'] = 1, ['A'] = 1
    }
}

local function deck_is_52_2Ace(deck)
    local deck = {
        Hearts = {
            ['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0, ['9'] = 0, ['10'] = 0,
            ['J'] = 0, ['Q'] = 0, ['K'] = 0, ['A'] = 0
        },
        Diamonds = {
            ['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0, ['9'] = 0, ['10'] = 0,
            ['J'] = 0, ['Q'] = 0, ['K'] = 0, ['A'] = 0
        },
        Clubs = {
            ['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0, ['9'] = 0, ['10'] = 0,
            ['J'] = 0, ['Q'] = 0, ['K'] = 0, ['A'] = 0
        },
        Spades = {
            ['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0, ['9'] = 0, ['10'] = 0,
            ['J'] = 0, ['Q'] = 0, ['K'] = 0, ['A'] = 0
        }
    }
    for i, card in ipairs(G.playing_cards) do
        if deck[card.base.suit][card.base.value] then
            deck[card.base.suit][card.base.value] = deck[card.base.suit][card.base.value]+1
        end
    end
    if deck == fiftyTwoTwoAce then
        return true
    else
        return false
    end
end

function consumInfo.calculate(self, card, context)
    if context.joker_main and context.cardarea == G.jokers then
        if deck_is_52_2Ace(G.playing_cards) then
            return {
                xmult = card.ability.extra.x_mult,
            }
        end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo