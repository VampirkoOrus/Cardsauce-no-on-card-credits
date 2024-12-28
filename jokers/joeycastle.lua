local jokerInfo = {
    name = "Joey's Castle",
    config = {
        money = 1,
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "guestartist20", set = "Other"}
    return { vars = { card.ability.money, localize(G.GAME.current_round.joeycastle.suit, 'suits_singular'), colours = {G.C.SUITS[G.GAME.current_round.joeycastle.suit]} }}
end

function jokerInfo.add_to_deck(self, card)
    check_for_unlock({ type = "discover_joeycastle" })
end

function jokerInfo.calculate(self, card, context)
    if context.discard and not context.other_card.debuff and context.other_card:is_suit(G.GAME.current_round.joeycastle.suit) and not context.blueprint then
        ease_dollars(card.ability.money)
        return {
            message = localize('$')..card.ability.money,
            dollars = card.ability.money,
            colour = G.C.MONEY
        }
    end
end

local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.current_round.joeycastle = { suit = 'Clubs' }
    return ret
end

function SMODS.current_mod.reset_game_globals(run_start)
    G.GAME.current_round.joeycastle = { suit = 'Clubs' }
    local valid_joeycastle_cards = {}
    for _, v in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(v) then
            valid_joeycastle_cards[#valid_joeycastle_cards+1] = v
        end
    end
    if valid_joeycastle_cards[1] then
        local randCard = pseudorandom_element(valid_joeycastle_cards, pseudoseed('fent'..G.GAME.round_resets.ante))
        G.GAME.current_round.joeycastle.suit = randCard.base.suit
    end
end

return jokerInfo