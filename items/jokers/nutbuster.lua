local jokerInfo = {
    name = 'Nutbuster',
    config = {},
    rarity = 1,
    cost = 4,
    unlocked = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "joel",
}

SMODS.Sound({
    key = "doot",
    path = "doot.ogg",
})

function jokerInfo.check_for_unlock(self, args)
    if args.type == "wheel_trigger" then
        return true
    end
end

function jokerInfo.loc_vars(self, info_queue, card)

end

return jokerInfo