local jokerInfo = {
    name = 'Crude Oil',
    config = {
        extra = {
            dollars = 8,
            dollars_mod = 2
        }
    },
    rarity = 1,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    streamer = "vinny",
}

function jokerInfo.loc_vars(self, info_queue, card)
    return {vars = { card.ability.extra.dollars, card.ability.extra.dollars_mod } }
end

function jokerInfo.calc_dollar_bonus(self, card)
    return card.ability.extra.dollars
end

local shopref = G.UIDEF.shop
function G.UIDEF.shop()
    local t = shopref()
    -- Wrap this in an event for it to get dollars after ease_dollars
    G.E_MANAGER:add_event(Event({trigger = 'after', blocking = false, func = function()
        for _, v in ipairs(SMODS.find_card("j_csau_crudeoil")) do
            v.ability.extra.dollars = v.ability.extra.dollars - v.ability.extra.dollars_mod
            if v.ability.extra.dollars <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        v.T.r = -0.2
                        v:juice_up(0.3, 0.4)
                        v.states.drag.is = true
                        v.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                             func = function()
                                 G.jokers:remove_card(v)
                                 v:remove()
                                 v = nil
                                 return true
                             end
                        }))
                        return true
                    end
                }))
            end
        end
        return true end }))
    return t
end



return jokerInfo