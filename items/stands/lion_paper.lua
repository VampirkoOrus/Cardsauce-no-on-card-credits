local consumInfo = {
    name = 'Paper Moon King',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'afb5b1DC', '4a7e38DC' },
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'lion',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
    return {vars = {(G.GAME and G.GAME.current_round and G.GAME.current_round.paper_rank) or 'Jack'}}
end

function consumInfo.can_use(self, card)
    return false
end

local ref_cgid = Card.get_id
function Card:get_id()
    if self.ability.set == 'Default' and self:is_face() and next(SMODS.find_card("c_csau_lion_paper")) then
        local pmk = SMODS.find_card("c_csau_lion_paper")
        for i, v in ipairs(pmk) do
            G.FUNCS.csau_flare_stand_aura(v, 0.38)
        end
        return SMODS.Ranks[G.GAME.current_round.csau_current_paper_rank].id
    end
    return ref_cgid(self)
end

return consumInfo