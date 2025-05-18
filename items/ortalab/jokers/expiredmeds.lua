local jokerInfo = {
    name = 'Expired',
    config = {
        id = nil,
        timesSold = nil,
        extra = {
            chips = 50,
            chips_mod = 50,
            chance = 4,
        },
    },
    rarity = 2,
    cost = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    streamer = "other",
}

function jokerInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.wario } }
    return { vars = {card.ability.extra.chips_mod, G.GAME.probabilities.normal, card.ability.extra.chance, card.ability.extra.chips} }
end

function jokerInfo.add_to_deck(self, card)
    if not card.ability.id then
        if not G.GAME.uniqueExpiredMedsAcquired then
            G.GAME.uniqueExpiredMedsAcquired = 1
        else
            G.GAME.uniqueExpiredMedsAcquired = G.GAME.uniqueExpiredMedsAcquired + 1
        end
        card.ability.id = G.GAME.uniqueExpiredMedsAcquired
    else
        local other_dc = SMODS.find_card('j_csau_expiredmeds')
        if other_dc[1] then
            if other_dc[1].Mid.ability.id == card.ability.id then
                G.GAME.uniqueExpiredMedsAcquired = G.GAME.uniqueExpiredMedsAcquired + 1
                card.ability.id = G.GAME.uniqueExpiredMedsAcquired
            end
        end
    end
end

function jokerInfo.calculate(self, card, context)
    if context.joker_main and context.cardarea == G.jokers then
        return {
            chips = card.ability.extra.chips
        }
    end
    if context.selling_self then
        local stop = false
        if G.GAME.sellShopJokersSold then
            for i, v in ipairs(G.GAME.sellShopJokersSold) do
                if v['id'] == card.ability.id then
                    stop = true
                end
            end
        end
        if not stop then
            if card.ability.timesSold then
                card.ability.timesSold = card.ability.timesSold + 1
            else
                card.ability.timesSold = 1
            end
            if pseudorandom('buckshot') < G.GAME.probabilities.normal / card.ability.extra.chance then
                card.ability.timesSold = 0
            end
            if not G.GAME.sellShopJokersSold then
                G.GAME.sellShopJokersSold = {}
            end
            G.GAME.sellShopJokersSold[#G.GAME.sellShopJokersSold+1] = {key =card.config.center.key, id=card.ability.id, timesSold=card.ability.timesSold, edition=card.edition and card.edition.type or nil}
            if G.GAME.spawnSellShopJokers then
                G.GAME.spawnSellShopJokers = G.GAME.spawnSellShopJokers + 1
            else
                G.GAME.spawnSellShopJokers = 1
            end
            if card.ability.timesSold == 0 then
                return {
                    message = localize('k_reset'),
                    colour = G.C.IMPORTANT
                }
            end
        end
    end
end

function jokerInfo.update(self, card)
    if card.area and card.area.config.type == "shop" and G.GAME.sellShopJokersSold then
        if #G.GAME.sellShopJokersSold > 0 and not card.ability.id and not card.ability.timesSold then
            local meds = G.GAME.sellShopJokersSold[1]
            local id = meds['id']
            if meds['edition'] then
                if meds['edition'] == "foil" then
                    card:set_edition({foil = true}, true, true)
                elseif meds['edition'] == "holo" then
                    card:set_edition({holo = true}, true, true)
                elseif meds['edition'] == "polychrome" then
                    card:set_edition({polychrome = true}, true, true)
                elseif meds['edition'] == "negative" then
                    card:set_edition({negative = true}, true, true)
                end
            end
            card.ability.id = id
            local timesSold = meds['timesSold']
            card.ability.timesSold = timesSold
            local newchips = card.ability.extra.chips + (card.ability.extra.chips_mod * card.ability.timesSold)
            send(newchips)
            if card.ability.timesSold == 0 then
                newchips = self.config.extra.chips
            end
            send(newchips)
            card.ability.extra.chips = newchips
            table.remove(G.GAME.sellShopJokersSold, 1)
        end
    end
end

return jokerInfo
	