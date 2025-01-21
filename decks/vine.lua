local deckInfo = {
    name = 'Vine Deck',
    config = {},
    unlocked = false,
    discovered = false,
    config = {
        vouchers = {
            'v_overstock_norm',
        },
    },
    unlock_condition = {type = 'win_deck', deck = 'b_green'}
}

deckInfo.loc_vars = function(self, info_queue, card)
    return {vars = {localize{type = 'name_text', key = 'v_overstock_norm', set = 'Voucher'}}}
end

return deckInfo