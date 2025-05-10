local blindInfo = {
    name = "Felt Fortress",
    color = HEX('88e054'),
    pos = {x = 0, y = 0},
    dollars = 8,
    mult = 2,
    vars = {},
    debuff = {},
    boss = {min = 1, max = 10, showdown = true},
    csau_dependencies = {
        'enableJoelContent',
    }
}

function blindInfo.defeat(self)
    check_for_unlock({ type = "defeat_feltfortress" })
end

blindInfo.set_blind = function(self, reset, silent)
    if not G.GAME.blind.disabled then
        G.GAME.blind.backup_chips = G.GAME.blind.chips
    end
end

blindInfo.press_play = function(self)
    G.GAME.blind.activated = true
end

--Modified code from Math Blinds
blindInfo.drawn_to_hand = function(self)
    if not G.GAME.blind.disabled and G.GAME.blind.activated then
        G.GAME.blind.activated = false
        local new_chips = math.floor(G.GAME.blind.chips * 2)
        G.GAME.blind:wiggle()
        play_area_status_text(localize('k_fort_doubled'))
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            blocking = false,
            ref_table = G.GAME.blind,
            ref_value = 'chips',
            ease_to = new_chips,
            delay =  0.5,
            func = (function(t) G.GAME.blind.chip_text = number_format(G.GAME.blind.chips); return math.floor(t) end)
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                return true
            end
        }))
    end
end

blindInfo.disable = function(self, silent)
    G.GAME.blind.chips = G.GAME.blind.backup_chips
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    G.GAME.blind.backup_chips = nil
end

return blindInfo