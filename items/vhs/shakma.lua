local consumInfo = {
    name = 'Shakma',
    key = 'shakma',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 4,
            uses = 0
        },
    },
    origin = {
        'rlm',
        'rlm_botw',
        color = 'rlm'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.joey } }
    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

local blacklisted_seeds = {
    '',
}

local function blacklisted_seed(seed)
    if starts_with(seed, "soul_") then
        return true
    end
    if starts_with(seed, "pack") then
        return true
    end
    if table.contains(blacklisted_seeds, seed) then
        return true
    end
    return false
end

local ref_psr = pseudorandom
function pseudorandom(seed, min, max, no_shakma)
    no_shakma = no_shakma or false
    if not no_shakma then
        local shakma = G.FUNCS.find_activated_tape('c_csau_shakma')
        if shakma and not shakma.ability.destroyed and not G.GAME.disable_shakma then
            if not min and not max and not blacklisted_seed(seed) then
                send("SHAKMA SEED:")
                send(seed)
                shakma:juice_up()
                shakma.ability.extra.uses = shakma.ability.extra.uses+1
                if to_big(shakma.ability.extra.uses) >= to_big(shakma.ability.extra.runtime) then
                    G.FUNCS.destroy_tape(shakma)
                    shakma.ability.destroyed = true
                end
                return 0
            end
        end
    end
    return ref_psr(seed, min, max)
end

local ccfs_ref = create_card_for_shop
function create_card_for_shop(area)
    G.GAME.disable_shakma = true
    local ret =  ccfs_ref(area)
    G.E_MANAGER:add_event(Event({
        func = function()
            G.GAME.disable_shakma = false
            return true
        end
    }))
    return ret
end

local ref_open = Card.open
function Card:open()
    G.GAME.disable_shakma = true
    local ret =  ref_open(self)
    G.E_MANAGER:add_event(Event({
        func = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.disable_shakma = false
                    return true
                end
            }))
            return true
        end
    }))
    return ret
end

local reroll_shopref = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
    G.GAME.disable_shakma = true
    local ret = reroll_shopref(e)
    G.E_MANAGER:add_event(Event({
        func = function()
            G.GAME.disable_shakma = false
            return true
        end
    }))
    return ret
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo