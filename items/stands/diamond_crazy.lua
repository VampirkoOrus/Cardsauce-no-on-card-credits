local consumInfo = {
    name = 'Crazy Diamond',
    set = 'csau_Stand',
    config = {
        aura_colors = { 'e099e8DC' , 'f5ccf4DC' },
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.calculate(self, card, context)
    if context.before and not card.debuff then
         local activated = false
         for i, v in ipairs(context.full_hand) do
             if v.debuff then
                  v.debuff = false
                  v.cured_debuff = true
                  G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function ()
                      v.cured_debuff = false
                      v:juice_up()
                      return true
                  end}))
                 activated = true
             end
         end
         if activated then
             return {
                 card = card,
                 message = localize('k_cd_healed'),
                 colour = G.C.IMPORTANT
             }
         end
    end
end

function consumInfo.can_use(self, card)
    return false
end

return consumInfo