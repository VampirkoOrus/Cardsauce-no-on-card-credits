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

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    return false
end

function consumInfo.draw(self,card,layer)

end


return consumInfo