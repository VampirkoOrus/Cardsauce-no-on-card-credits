local consumInfo = {
    name = 'Star Platinum',
    set = "Stand",
    cost = 4,
    config = {
    },
    alerted = true,
    hasSoul = true,
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