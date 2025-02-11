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

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    return false
end

function consumInfo.draw(self,card,layer)

end


return consumInfo