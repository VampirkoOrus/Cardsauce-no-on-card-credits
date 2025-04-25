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
            runtime = 3,
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

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

local blacklisted_seeds = {
    'soul_Tarot1',
}

local ref_psr = pseudorandom
function pseudorandom(seed, min, max)
    local shakma = G.FUNCS.find_activated_tape('c_csau_shakma')
    if shakma and not shakma.ability.destroyed then
        if not min and not max and not table.contains(blacklisted_seeds, seed) then
            send(seed)
            shakma.ability.extra.uses = shakma.ability.extra.uses+1
            if shakma.ability.extra.uses >= shakma.ability.extra.runtime then
                G.FUNCS.destroy_tape(shakma)
                shakma.ability.destroyed = true
            end
            return 0
        end
    end
    return ref_psr(seed, min, max)
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo