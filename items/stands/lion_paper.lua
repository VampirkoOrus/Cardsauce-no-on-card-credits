local consumInfo = {
    name = 'Paper Moon King',
    set = 'csau_Stand',
    config = {},
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    return {vars = {(G.GAME and G.GAME.current_round and G.GAME.current_round.paper_rank) or 'Jack'}}
end

function consumInfo.add_to_deck(self, card)
    set_consumeable_usage(card)
end

function consumInfo.can_use(self, card)
    return false
end

local ref_cgid = Card.get_id
function Card:get_id()
    if next(SMODS.find_card("c_csau_lion_paper")) and self:is_face() then
        return SMODS.Ranks[G.GAME.current_round.csau_current_paper_rank].id
    end
    return ref_cgid(self)
end

return consumInfo