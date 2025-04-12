local blindInfo = {
    name = "The Wasp",
    color = HEX('ffd44b'),
    pos = {x = 0, y = 0},
    dollars = 5,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {min = 2, max = 10},
    streamer = 'joel',
}

local function american_hornet(blind)
    if blind.boss and blind.name == "The Wasp" and not G.GAME.blind.disabled then
        return true
    end
    return false
end


local ref_eval = eval_card
function eval_card(card, context)
    local ret = {}
    local post_trig = {}
    if (context.repetition or context.retrigger_joker) and G.GAME and G.GAME.blind and american_hornet(G.GAME.blind) then return ret, post_trig end
    return ref_eval(card, context)
end

local ref_calc_retrig = SMODS.calculate_retriggers
SMODS.calculate_retriggers = function(card, context, _ret)
    local retriggers = {}
    if (context.repetition or context.retrigger_joker) and american_hornet(G.GAME.blind) then return retriggers end
    return ref_calc_retrig(card, context, _ret)
end

function blindInfo.defeat(self)

end

return blindInfo