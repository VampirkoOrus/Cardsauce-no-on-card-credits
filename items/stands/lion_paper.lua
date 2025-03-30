local consumInfo = {
    name = 'Paper Moon King',
    set = 'Stand',
    config = {},
    cost = 4,
    rarity = 'StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    if not G.GAME or not G.GAME.current_paper_rank then
        return {vars = {'Jack'}}
    end

    return {vars = {G.GAME.current_paper_rank}}
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.calculate(self, card, context)

end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo