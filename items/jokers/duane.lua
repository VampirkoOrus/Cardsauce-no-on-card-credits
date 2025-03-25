local jokerInfo = {
    name = 'Dancing Joker',
    config = {
        extra = {
            repetitions = 1,
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = { localize(G.GAME and G.GAME.wigsaw_suit or G.GAME.current_round.duane_suit, 'suits_singular'), colours = {G.C.SUITS[G.GAME and G.GAME.wigsaw_suit or G.GAME.current_round.duane_suit]}} }
end

function jokerInfo.add_to_deck(self, card)

end

function jokerInfo.calculate(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only and not card.debuff then
        if context.other_card:is_suit(G.GAME and G.GAME.wigsaw_suit or G.GAME.current_round.duane_suit) then
            return {
                message = 'Again!',
                repetitions = card.ability.extra.repetitions,
                card = context.other_card
            }
        end
    end
end

local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.current_round.duane_suit = 'Clubs'
    return ret
end

return jokerInfo
	