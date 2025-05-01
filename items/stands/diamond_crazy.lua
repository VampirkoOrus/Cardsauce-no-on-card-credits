local consumInfo = {
    name = 'Crazy Diamond',
    set = 'csau_Stand',
    config = {
        stand_mask = true,
        aura_colors = { 'e099e8DC' , 'f5ccf4DC' },
    },
    cost = 4,
    rarity = 'csau_StandRarity',
    alerted = true,
    hasSoul = true,
    part = 'diamond',
    in_progress = true,
}

function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "csau_artistcredit", set = "Other", vars = { G.csau_team.cejai } }
end

function consumInfo.calculate(self, card, context)
    local bad_context = context.repetition or context.blueprint or context.individual or context.retrigger_joker
    if context.before and not card.debuff and not bad_context then
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
                 func = function()
                     card:juice_up()
                     G.FUNCS.csau_flare_stand_aura(card, 0.38)
                 end,
                 card = card,
                 message = localize('k_cd_healed'),
                 colour = G.C.STAND
             }
         end
    end
end


return consumInfo