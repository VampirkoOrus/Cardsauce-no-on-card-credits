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
        values = {
            x_mult = 1.5,
            mult = 10,
            chips = 50,
            
        },
        weights = {
            x_mult = 3,
            mult = 7,
            chips = 10,
        },
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

local function weighted_random(weights, key)
    local total = 0
	
	for _, v in pairs(weights) do
		total = total + v
	end
	
	local roll = pseudorandom(pseudoseed(key), 1, total)
	local iter = 0
	for k, v in pairs(weights) do
		iter = iter + v
		if roll <= iter then
			return k
		end
	end
end

function editionInfo.loc_vars(self, info_queue, card)
    local last_display = card.edition.corrupted_display_key or 'chips'
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.21, blockable = false, blocking = false, func = function()
        if G.CONTROLLER.hovering.target == card then
            card:stop_hover()

            card.children.focused_ui = G.UIDEF.card_focus_ui(card)
            card.ability_UIBox_table = card:generate_UIBox_ability_table()
            card.config.h_popup = G.UIDEF.card_h_popup(card)
            card.config.h_popup_config = card:align_h_popup()
    
            Node.hover(card)
        else
            card.edition.corrupted_display_key = nil
            card.edition.no_recycle = nil
        end
    return true end}))

    card.edition.no_recycle = (card.edition.corrupted_display_key ~= nil)
    card.edition.corrupted_display_key = weighted_random(self.config.weights, 'csau_corrupted_display')
    return { vars = { self.config.values[last_display] }, key = self.key..'_'..last_display}
end

-- Modified code from Cryptid
function editionInfo.calculate(self, card, context)
    if (context.edition and context.cardarea == G.jokers and card.config.trigger) 
    or (context.main_scoring and context.cardarea == G.play) then
        local roll = weighted_random(self.config.weights, 'csau_corrupted')
        return {
            [roll] = self.config.values[roll]
        }
    end

    if context.joker_main then
        card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
    end

    if context.after then
        card.config.trigger = nil
    end
end


return editionInfo