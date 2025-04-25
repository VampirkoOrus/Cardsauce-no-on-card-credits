local chalInfo = {
    rules = {
        custom = {
            {id = "max_stands", value = 5,}
        },
        modifiers = {
            {id = 'joker_slots', value = 1},
            {id = 'consumable_slots', value = 6}
        }
    },
    unlocked = function(self)
        return G.FUNCS.discovery_check({ mode = 'set_count', set = 'Stand', count = 1, })
    end
}


return chalInfo