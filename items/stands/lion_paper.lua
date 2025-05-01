local consumInfo = {
    name = 'Paper Moon King',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'afb5b1DC', '4a7e38DC' },
        aura_hover = true,
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


return consumInfo