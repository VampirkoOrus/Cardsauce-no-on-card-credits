local consumInfo = {
    name = 'Black Spine',
    set = "VHS",
    cost = 3,
    alerted = true,
    nosleeve = true,
    config = {
        use_activate = true,
    },
    origin = 'rlm',
    origin = {
        'rlm',
        'rlm_bs',
        color = 'rlm'
    }
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.gote } }
end

function consumInfo.activate(self, card, on)
    local key = pseudorandom_element(get_current_pool('VHS', nil, nil, 'blackspine'), pseudoseed('blackspine'))
    local it = 1
    while key == 'UNAVAILABLE' do
        it = it + 1
        key = pseudorandom_element(get_current_pool('VHS', nil, nil, 'blackspine'), pseudoseed('blackspine_resample'..it))
    end
    G.FUNCS.csau_transform_card(card, key)
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo