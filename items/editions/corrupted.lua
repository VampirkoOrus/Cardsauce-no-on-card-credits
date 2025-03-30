local function hashString(input)
    local hash = 5381  -- Seed value
    for i = 1, #input do
        local char = string.byte(input, i)
        hash = ((hash * 32) + hash + char) % 2^15  -- Wrap to 16-bit integer
    end
    return hash
end

SMODS.Shader {
    key = 'glitched',
    path = 'glitched.fs',
    send_vars = function (sprite, card)
        if card == nil then
            return {
                seed = hashString(card.config.center.key)
            }
        end
        return {
            seed = hashString(card.config.center.key..'_'..card.ID)
        }
    end,
}

local editionInfo = {
    shader = "csau_glitched",
    config = {
        min = 2,
        max = 25,
    },
    unlocked = true,
    discovered = true,
    in_shop = true,
    weight = 14,
    extra_cost = 4,
    apply_to_float = false,
}

-- Modified code from Cryptid
editionInfo.calculate = function(self, card, context)
    if (
            context.edition -- for when on jonklers
                    and context.cardarea == G.jokers -- checks if should trigger
                    and card.config.trigger -- fixes double trigger
    ) or (
            context.main_scoring -- for when on playing cards
                    and context.cardarea == G.play
    )
    then
        return {
            mult = pseudorandom("CORRUPTED", self.config.min, self.config.max),
        }
    end
    if context.joker_main then
        card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
    end

    if context.after then
        card.config.trigger = nil
    end
end

editionInfo.generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    if not full_UI_table.name then
        full_UI_table.name = localize({ type = "name", set = self.set, key = self.key, nodes = full_UI_table.name })
    end
    local r_mults = {}
    for i = self.config.min, self.config.max do
        r_mults[#r_mults+1] = tostring(i)
    end
    local loc_mult = ' '..(localize('k_mult'))..' '
    local mult_ui = {
        {n=G.UIT.T, config={text = '  +',colour = G.C.MULT, scale = 0.32}},
        {n=G.UIT.O, config={object = DynaText({string = r_mults, colours = {G.C.RED},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0})}},
        {n=G.UIT.O, config={object = DynaText({string = {
            {string = 'rand()', colour = G.C.JOKER_GREY},{string = "#@"..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11)..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or 'D'), colour = G.C.RED},
            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult},
                                               colours = {G.C.UI.TEXT_DARK},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2011, scale = 0.32, min_cycle_time = 0})}},
    }
    desc_nodes[#desc_nodes + 1] = mult_ui
end

return editionInfo