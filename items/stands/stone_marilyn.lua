local consumInfo = {
    name = 'Marilyn Manson',
    set = 'csau_Stand',
    config = {
        stand_mask = true,
        aura_colors = { 'efac55DC', 'df7f32DC' },
        extra = {
            conv_money = 1,
            conv_score = 0.005
        }
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'stone',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return {vars = {card.ability.extra.conv_money, card.ability.extra.conv_score * 100}}
end

local debt_collection = function(card)
    local percentage_left = (G.GAME.blind.chips-G.GAME.chips) / G.GAME.blind.chips
    local debt = math.ceil(percentage_left / card.ability.extra.conv_score)*card.ability.extra.conv_money
    local recoverable = 0
    if to_big(G.GAME.dollars - debt) >= to_big(G.GAME.bankrupt_at) then
        send("Debt satisfied with only money")
        return {
            saved = true,
            ease = -debt
        }
    else
        send("Not enough money. (Debt: "..debt..")")
        local sell = {}
        if #G.jokers.cards > 0 then
            local pool = {}
            for i, v in ipairs(G.jokers.cards) do
                table.insert(pool, v)
            end
            while #pool > 0 do
                local joker = pseudorandom_element(pool, pseudoseed('debtcollector_joker'))
                for i = #pool, 1, -1 do
                    if pool[i] == joker then
                        table.remove(pool, i)
                        break
                    end
                end
                recoverable = recoverable + joker.sell_cost
                send("Selling "..joker.ability.name.." for $"..joker.sell_cost)
                send("funds: "..G.GAME.dollars + recoverable.." (recoverable: "..recoverable.." + money: "..G.GAME.dollars..")")
                send("debt: "..debt)
                send("difference: "..(G.GAME.dollars + recoverable) - debt)
                send("bankrupt at: "..G.GAME.bankrupt_at)
                if to_big((G.GAME.dollars + recoverable) - debt) >= to_big(G.GAME.bankrupt_at) then
                    table.insert(sell, joker)
                    local ease = debt
                    if to_big((G.GAME.dollars + recoverable) - debt) > to_big(0) then
                        ease = ease + (G.GAME.dollars + recoverable) - debt
                    end
                    send("Debt satisfied. (Debt: "..debt..", Recovered: "..recoverable..")")
                    return {
                        saved = true,
                        ease = -ease,
                        sell = sell
                    }
                else
                    table.insert(sell, joker)
                end
            end
        end
        send("funds: "..G.GAME.dollars + recoverable.." (recoverable: "..recoverable.." + money: "..G.GAME.dollars..")")
        send("debt: "..debt)
        send("difference: "..(G.GAME.dollars + recoverable) - debt)
        send("bankrupt at: "..G.GAME.bankrupt_at)
        if to_big((G.GAME.dollars + recoverable) - debt) < to_big(G.GAME.bankrupt_at) then
            send("Not enough money.")
            if #G.playing_cards > 0 then
                send("Playing cards found.")
                local pool = {}
                for i, v in ipairs(G.playing_cards) do
                    table.insert(pool, v)
                end
                while #pool > 0 do
                    send("Checking for valuable cards...")
                    local card = pseudorandom_element(pool, pseudoseed('debtcollector_cards'))
                    for i = #pool, 1, -1 do
                        if pool[i] == card then
                            table.remove(pool, i)
                            break
                        end
                    end
                    send("Selling "..card.base.value.." of "..card.base.suit)
                    send("funds: "..G.GAME.dollars + recoverable)
                    send("debt: "..debt)
                    send("difference: "..(G.GAME.dollars + recoverable) - debt)
                    send("bankrupt at: "..G.GAME.bankrupt_at)
                    recoverable = recoverable + card.sell_cost
                    if to_big((G.GAME.dollars + recoverable) - debt) >= to_big(G.GAME.bankrupt_at) then
                        table.insert(sell, card)
                        local ease = -debt
                        if to_big((G.GAME.dollars + recoverable) - debt) > to_big(0) then
                            ease = (G.GAME.dollars + recoverable) - debt
                        end
                        send("Debt satisfied. (Debt: "..debt..", Recovered: "..recoverable..")")
                        return {
                            saved = true,
                            ease = -ease,
                            sell = sell
                        }
                    else
                        table.insert(sell, card)
                    end
                end
            end
        end
        send("Debt not satisfied. DEATH")
        return {
            death = "*fucking kills you*"
        }
    end
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if not context.blueprint_card and context.game_over and not bad_context then
        local collect = debt_collection(card)
        if collect.saved then
            if collect.sell then
                for i, v in ipairs(collect.sell) do
                    play_sound('coin2')
                    v:juice_up(0.3, 0.4)
                    v:start_dissolve({G.C.GOLD})
                end
            end
            ease_dollars(collect.ease)
            return {
                func = function()
                    G.FUNCS.csau_flare_stand_aura(card, 0.38)
                    card:juice_up()
                    play_sound('tarot1')
                end,
                saved = 'ph_saved_marilyn',
                colour = G.C.RED
            }
        end
    end
end


return consumInfo