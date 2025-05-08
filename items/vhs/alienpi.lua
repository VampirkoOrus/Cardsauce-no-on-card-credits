local consumInfo = {
    name = 'Alien Private Eye',
    key = 'alienpi',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 100,
            uses = 0,
            chance_mod = 1,
            chance = 0,
            rate = 100,
            x_mult = 1.1,
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
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gong } }
    return { vars = { card.ability.extra.x_mult, card.ability.extra.chance_mod, G.FUNCS.csau_add_chance(card.ability.extra.chance, {multiply = true}), card.ability.extra.rate, card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

function consumInfo.calculate(self, card, context)
    if card.ability.activated and context.individual and context.cardarea == G.play and not card.debuff then
        if context.other_card then
            card.ability.extra.uses = card.ability.extra.uses+1
            if to_big(card.ability.extra.uses) >= to_big(card.ability.extra.runtime) then
                G.STATE = G.STATES.GAME_OVER
            else
                card.ability.extra.chance = card.ability.extra.chance+1
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
    if context.selling_self then
        if pseudorandom('youdie') < G.FUNCS.csau_add_chance(card.ability.extra.chance, {multiply = true}) / card.ability.extra.rate then
            G.STATE = G.STATES.GAME_OVER
        end
    end
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo