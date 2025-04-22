local consumInfo = {
    name = "Robot in the Family",
    key = 'ritf',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        activated = false,
        destroyed = false,
        extra = {
            runtime = 5,
            uses = 0,
            pi_index = 1,
        },
    },
    origin = {
        'rlm',
        'rlm_botw',
        color = 'rlm'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.yunkie } }
    return { vars = { card.ability.extra.runtime-card.ability.extra.uses } }
end

function consumInfo.set_ability(self, card, initial, delay_sprites)
    if next(SMODS.find_card("c_csau_moodyblues")) then
        card.ability.extra.runtime = card.ability.extra.runtime*2
    end
end

local pi_digits = "314159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172"

local function get_pi_digit(i)
    local len = #pi_digits
    local index = ((i - 1) % len) + 1 -- Wrap around to 1-based index
    return tonumber(pi_digits:sub(index, index))
end

function consumInfo.calculate(self, card, context)
    if context.individual and not context.end_of_round then
        if context.cardarea == G.play then
            card.ability.extra.pi_index = card.ability.extra.pi_index+1
            return {
                mult = get_pi_digit(card.ability.extra.pi_index-1)
            }
        elseif context.cardarea == G.hand then
            card.ability.extra.pi_index = card.ability.extra.pi_index+1
            return {
                chips = get_pi_digit(card.ability.extra.pi_index-1)
            }
        end
    end
end

function consumInfo.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    G.FUNCS.csau_generate_detail_desc(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
end

function consumInfo.can_use(self, card)
    if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then return true end
end

return consumInfo