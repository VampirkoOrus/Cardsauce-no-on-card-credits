local consumInfo = {
    name = 'Killer Queen: Bites the Dust',
    set = 'csau_Stand',
    config = {
        evolved = true,
        aura_colors = { '151590DC', '5f277dDC' },
    },
    cost = 10,
    rarity = 'csau_EvolvedRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "codercredit", set = "Other", vars = { G.csau_team.eremel } }
end

function consumInfo.in_pool(self, args)
    if next(SMODS.find_card('j_showman')) then
        return true
    end

    if G.GAME.used_jokers['c_csau_diamond_killer'] then
        return false
    end
    
    return true
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)

end

local get_btd = function()
    for i, v in ipairs(G.consumeables.cards) do
        if v.config.center.key == 'c_csau_diamond_killer_btd' then
            return true
        end
    end
    return false
end

local get_card_areas = SMODS.get_card_areas
function SMODS.get_card_areas(_type, context)
    local t = get_card_areas(_type, context)
    if  _type == 'playing_cards' then
        if get_btd() then
            local new_area = {cards = {}, reverse = true}
            for i= #G.play.cards - 1, 1, -1 do
                new_area.cards[#new_area.cards+1] = G.play.cards[i]
            end
            table.insert(t, 2, new_area)
        end
    end
    return t
end

local calc_main = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
    if get_btd() and context.cardarea and context.cardarea.reverse then
        calc_main(context, true)
    else
        calc_main(context, scoring_hand)
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo