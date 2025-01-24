local consumInfo = {
    name = 'Dirty Deeds Done Dirt Cheap',
    set = "Stand",
    cost = 4,
    config = {
        stand_overlay = true,
        activated = false,
    },
    alerted = true,
    hasSoul = true,
}

function consumInfo.calculate(self, card, context)
    if context.destroy_card and context.cardarea == G.play then
        if context.scoring_name == "Pair" and not card.ability.activated then
            context.destroying_card = context.scoring_hand
            card.ability.activated = true
            return true
        end
    end
    if context.end_of_round then
        card.ability.activated = false
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo