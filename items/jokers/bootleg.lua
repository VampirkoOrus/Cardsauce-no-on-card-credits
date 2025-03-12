local jokerInfo = {
    name = 'Bootleg Joker',
    config = {},
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return { vars = {  } }
end

function jokerInfo.add_to_deck(self, card)

end

function jokerInfo.calculate(self, card, context)

end

return jokerInfo
	