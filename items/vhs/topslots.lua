local consumInfo = {
    name = 'Top Slots',
    key = 'topslots',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        extra = {
            max_initial_money = 20,

            winnings = nil,
            conv_money = 1,
            conv_score = 20,
            prob_double = 6,
            double = 2,
            prob_triple = 8,
            triple = 3,

            runtime = 2,
            uses = 0,
        },
        alt_title = true,
        activated = false,
        destroy = false,
    },
    origin = 'rlm'
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}

    return { vars = { card.ability.extra.conv_money, card.ability.extra.conv_score, card.ability.extra.max_initial_money, G.GAME.probabilities.normal, card.ability.extra.prob_double, card.ability.extra.prob_triple, card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.individual or context.blueprint
    if card.ability.activated and context.end_of_round and not card.debuff and not bad_context then
        if G.GAME.chips > G.GAME.blind.chips then
            local percent = ((G.GAME.chips - G.GAME.blind.chips) / G.GAME.blind.chips) * 100
            local money = math.floor(percent / card.ability.extra.conv_score) + card.ability.extra.conv_money
            if to_big(money) > to_big(card.ability.extra.max_initial_money) then
                money = card.ability.extra.max_initial_money
            end
            local doubled, tripled = false, false
            if pseudorandom('READYOURMACHINES') < G.GAME.probabilities.normal / card.ability.extra.prob_double then
                money = money * card.ability.extra.double
                doubled = true
            end
            if pseudorandom('NOCONTROLOVERTHAT') < G.GAME.probabilities.normal / card.ability.extra.prob_triple then
                money = money * card.ability.extra.triple
                tripled = true
            end
            card.ability.extra.winnings = money
            card.ability.extra.uses = card.ability.extra.uses + 1
            if doubled or tripled then
                return {
                    message = localize((doubled and tripled and 'k_ts_wild') or (doubled and not tripled and 'k_ts_doubled') or (tripled and not doubled and 'k_ts_tripled')),
                    card = card
                }
            end
        end
    end
    if context.starting_shop and not context.blueprint then
        if to_big(card.ability.extra.uses) >= to_big(card.ability.extra.runtime) then
            G.FUNCS.destroy_tape(card)
            card.ability.destroyed = true
        end
    end
    if card.ability.activated and context.game_over then
        check_for_unlock({ type = "the_scot" })
    end
end

function consumInfo.calc_dollar_bonus(self, card)
    if card.ability.extra.winnings then
        return card.ability.extra.winnings
    end
end

function consumInfo.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    if card.area == G.consumeables or card.config.center.discovered then
        -- If statement makes it so that this function doesnt activate in the "Joker Unlocked" UI and cause 'Not Discovered' to be stuck in the corner
        full_UI_table.name = localize{type = 'name', key = card.config.center.key..'_alt_title', set = self.set, name_nodes = {}, vars = specific_vars or {}}
    end
    localize{type = 'descriptions', key = card.config.center.key, set = self.set, nodes = desc_nodes, vars = self.loc_vars and self.loc_vars(self, info_queue, card).vars or {}}
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo