local consumInfo = {
    name = 'Metallica',
    set = "Stand",
    cost = 4,
    config = {
        stand_overlay = true,
        activated = false,
    },
    alerted = true,
    hasSoul = true,
}

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

local function detect_jacks(scoring_hand)
    for k, v in ipairs(scoring_hand) do
        if v:get_id() == 11 and v.ability.effect == "Base" then
            return true
        end
    end
    return false
end

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff and not context.blueprint then
        if detect_jacks(context.full_hand) then
            for i, v in ipairs(context.full_hand) do
                if v:get_id() == 11 and v.ability.effect == "Base" then
                    v:set_ability(G.P_CENTERS.m_steel, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            return {
                message = localize('k_metal'),
                card = card,
            }
        end
    end
    if context.check_enhancement and context.other_card.config.center.key == 'm_steel' then
        return { m_glass = true }
    end
end

function consumInfo.can_use(self, card)
    return false
end

function consumInfo.draw(self,card,layer)

end


return consumInfo