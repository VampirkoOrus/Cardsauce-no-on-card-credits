local jokerInfo = {
    name = 'Nutbuster',
    config = {},
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    streamer = "vinny",
}

G.FUNCS.nutbuster_active = function()
    local nutbusters = SMODS.find_card("j_csau_nutbuster")
    for i, v in ipairs(nutbusters) do
        if not v.debuff then
            return true
        end
    end
    return false
end

function jokerInfo.loc_vars(self, info_queue, card)

end

function jokerInfo.add_to_deck(self, card)

end

return jokerInfo