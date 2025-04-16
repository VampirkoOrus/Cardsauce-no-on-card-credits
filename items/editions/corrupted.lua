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
        chips = 50,
        mult = 10,
        xmult = 1.5,
        poly_chance = 3,
        holo_chance = 7,
        foil_chance = 10,
        prob_min = 1,
        prob = 20,
    },
    unlocked = true,
    in_shop = true,
    weight = 14,
    extra_cost = 4,
    apply_to_float = false,
    csau_dependencies = {
        'enableVinnyContent',
    }
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
        local pull = pseudorandom("CORRUPTED", self.config.prob_min, self.config.prob)
        if pull > 10 then
            return {
                chips = self.config.chips,
            }
        elseif pull <= 10 and pull > 3 then
            return {
                mult = self.config.mult,
            }
        else
            return {
                x_mult = self.config.xmult,
            }
        end
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
    local rand_ui = {
        {
            n=G.UIT.O, config={object = DynaText({
            string = {
                {string = 'X1.5', colour = G.C.RED, outer_colour = G.C.UI.TEXT_DARK, suffix = ' '..localize('k_mult')},
                {string = "+10", colour = G.C.MULT, outer_colour = G.C.UI.TEXT_DARK, suffix = ' '..(localize('k_mult'))},
                {string = "+50", colour = G.C.CHIPS, outer_colour = G.C.UI.TEXT_DARK, suffix = ' '..(localize('k_csau_chips'))},
            },
            colours = {G.C.UI.TEXT_DARK}, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2011, scale = 0.32, min_cycle_time = 0
        })}
        }
    }
    desc_nodes[#desc_nodes + 1] = rand_ui
end

return editionInfo