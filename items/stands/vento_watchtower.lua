local consumInfo = {
    name = 'All Along Watchtower',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'd4483eDC', '374649DC' },
        stand_mask = true,
        extra = {
            x_mult = 4,
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    in_progress = true,
    part = 'feedback',
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return { vars = { card.ability.extra.x_mult } }
end

local reference_deck = {
    Hearts = { ['2'] = 1, ['3'] = 1, ['4'] = 1, ['5'] = 1, ['6'] = 1, ['7'] = 1, ['8'] = 1, ['9'] = 1, ['10'] = 1,
               ['Jack'] = 1, ['Queen'] = 1, ['King'] = 1, ['Ace'] = 1 },
    Diamonds = { ['2'] = 1, ['3'] = 1, ['4'] = 1, ['5'] = 1, ['6'] = 1, ['7'] = 1, ['8'] = 1, ['9'] = 1, ['10'] = 1,
                 ['Jack'] = 1, ['Queen'] = 1, ['King'] = 1, ['Ace'] = 1 },
    Clubs = { ['2'] = 1, ['3'] = 1, ['4'] = 1, ['5'] = 1, ['6'] = 1, ['7'] = 1, ['8'] = 1, ['9'] = 1, ['10'] = 1,
              ['Jack'] = 1, ['Queen'] = 1, ['King'] = 1, ['Ace'] = 1 },
    Spades = { ['2'] = 1, ['3'] = 1, ['4'] = 1, ['5'] = 1, ['6'] = 1, ['7'] = 1, ['8'] = 1, ['9'] = 1, ['10'] = 1,
               ['Jack'] = 1, ['Queen'] = 1, ['King'] = 1, ['Ace'] = 1 }
}

local function is_full_deck(deck, reference)
    for suit, cards in pairs(deck) do
        if not reference[suit] then
            send('extra suit found: '..suit)
            return false
        end
        for rank, count in pairs(cards) do
            if not reference[suit][rank] then
                send('extra rank found: '..rank..' of '..suit)
                return false
            end
            if count ~= reference[suit][rank] then
                send('incorrect count for '..rank..' of '..suit)
                send(count..' ~= '..reference[suit][rank])
                return false
            end
        end
    end

    for suit, cards in pairs(reference) do
        if not deck[suit] then
            send('missing suit: '..suit)
            return false
        end
        for rank, ref_count in pairs(cards) do
            if deck[suit][rank] ~= ref_count then
                send('missing or incorrect count for '..rank..' of '..suit)
                send(deck[suit][rank]..' ~= '..ref_count)
                return false
            end
        end
    end

    return true
end

local function deck_is_52_2Ace(deck)
    local deck = {
        Hearts = {
            ['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0, ['9'] = 0, ['10'] = 0,
            ['Jack'] = 0, ['Queen'] = 0, ['King'] = 0, ['Ace'] = 0
        },
        Diamonds = {
            ['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0, ['9'] = 0, ['10'] = 0,
            ['Jack'] = 0, ['Queen'] = 0, ['King'] = 0, ['Ace'] = 0
        },
        Clubs = {
            ['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0, ['9'] = 0, ['10'] = 0,
            ['Jack'] = 0, ['Queen'] = 0, ['King'] = 0, ['Ace'] = 0
        },
        Spades = {
            ['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0, ['9'] = 0, ['10'] = 0,
            ['Jack'] = 0, ['Queen'] = 0, ['King'] = 0, ['Ace'] = 0
        }
    }
    for i, card in ipairs(G.playing_cards) do
        if not deck[card.base.suit] then deck[card.base.suit] = {} end
        if not deck[card.base.suit][card.base.value] then deck[card.base.suit][card.base.value] = 0 end
        deck[card.base.suit][card.base.value] = deck[card.base.suit][card.base.value]+1
    end
    return is_full_deck(deck, reference_deck)
end

function consumInfo.calculate(self, card, context)
    if context.joker_main and deck_is_52_2Ace(G.playing_cards) then
        return {
            func = function()
                G.FUNCS.csau_flare_stand_aura(card, 0.38)
            end,
            xmult = card.ability.extra.x_mult,
        }
    end
end


return consumInfo