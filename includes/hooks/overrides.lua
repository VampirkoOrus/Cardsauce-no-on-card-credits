local restrict = SMODS.Challenges.c_jokerless_1.restrictions
table.insert(restrict.banned_tags, {id = 'tag_csau_corrupted'})
SMODS.Challenge:take_ownership('jokerless_1', {
    restrictions = restrict
}, true)

SMODS.Consumable:take_ownership('ouija', {
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        juice_flip(used_tarot)
        local _rank = pseudorandom_element(SMODS.Ranks, pseudoseed('ouija'))
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = G.hand.cards[i]
                    assert(SMODS.change_base(_card, nil, _rank.key))
                    return true
                end
            }))
        end
        if SMODS.spectral_lower_handsize() then
            G.hand:change_size(-1)
        end
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.cards[i]:juice_up(0.3, 0.3); return true
                end
            }))
        end
        delay(0.5)
    end,
}, true)