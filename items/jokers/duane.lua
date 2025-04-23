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
    animated = {
        tiles = {
            x = 8,
        },
        speed = 0.15
    }
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.ele } }
    return { vars = { localize(G.GAME and G.GAME.wigsaw_suit or G.GAME.current_round.duane_suit, 'suits_singular'), colours = {G.C.SUITS[G.GAME and G.GAME.wigsaw_suit or G.GAME.current_round.duane_suit]}} }
end

local function get_suit_y(suit)
    if suit and suit == 'Hearts' then
        return 1
    elseif suit and suit == 'Clubs' then
        return 2
    elseif suit and suit == 'Diamonds' then
        return 3
    elseif suit and suit == 'Spades' then
        return 4
    else
        return 5
    end
end

function jokerInfo.calculate(self, card, context)
    if context.csau_duane_change then
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_duane', vars = {string.upper(localize(context.suit, 'suits_plural'))}}})
        G.E_MANAGER:add_event(Event({
             trigger = 'immediate',
             func = function()
                 G.GAME.csau_delay_duane = false
                 return true
             end
        }))
    end
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

function jokerInfo.update(self, card)
    if G.GAME and not G.GAME.csau_delay_duane then
        local obj = G.P_CENTERS.j_csau_duane
        local duane_suit = G.GAME and G.GAME.wigsaw_suit or G.GAME.current_round.duane_suit or nil
        if get_suit_y(duane_suit) ~= obj.pos.y then
            obj.pos.y = get_suit_y(duane_suit)
        end
    end
end

return jokerInfo
	