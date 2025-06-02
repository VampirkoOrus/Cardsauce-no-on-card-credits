local consumInfo = {
    name = 'Rent-a-Friend',
    key = 'rentafriend',
    set = "VHS",
    cost = 3,
    alerted = true,
    config = {
        activation = true,
        extra = {
            runtime = 1,
            uses = 0,
        },
        activated = false,
        destroyed = false,
    },
    origin = {
        'vinny',
        'vinny_wotw',
        color = 'vinny'
    }
}


function consumInfo.loc_vars(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "vhs_activation", set = "Other"}

    return { 
        vars = {
            card.ability.extra.runtime-card.ability.extra.uses,
            (card.ability.extra.runtime-card.ability.extra.uses) > 1 and 's' or ''
        }
    }
end

function consumInfo.calculate(self, card, context)
    if card.ability.activated and context.buying_card then
        if context.card.ability.rent_ref then
            context.card.ability.rent_ref = nil
            card.ability.extra.uses = card.ability.extra.uses+1
            if to_big(card.ability.extra.uses) >= to_big(card.ability.extra.runtime) then
                G.FUNCS.destroy_tape(card)
                card.ability.destroyed = true
            end
        end
    end
end

function consumInfo.activate(self, card, on)
    if not on then
        if G.shop_jokers and G.shop_jokers.cards then
            for i, v in ipairs(G.shop_jokers.cards) do
                if v.ability.set == "Joker" then
                    if v.ability.rent_ref then
                        if v.ability.rent_ref.edition then
                            v:set_edition({ [v.ability.rent_ref.edition] = true }, true)
                        else
                            v:set_edition(nil, true)
                        end
                        if not v.ability.rent_ref.rental then
                            v:set_rental(false)
                        end
                        v.ability.rent_ref = nil
                    end
                end
            end
        end
    end
end

local upd = Game.update
function Game:update(dt)
    upd(self,dt)
    if next(SMODS.find_card('c_csau_rentafriend')) then
        if G.shop_jokers and G.shop_jokers.cards then
            for i, v in ipairs(G.shop_jokers.cards) do
                if v.ability.set == "Joker" then
                    local rent = G.FUNCS.find_activated_tape('c_csau_rentafriend')
                    if rent then
                        if not v.ability.rent_ref then
                            v.ability.rent_ref = {}
                            if v.edition and v.edition.type then
                                v.ability.rent_ref.edition = v.edition.type
                            end
                            if v.ability.rental then
                                v.ability.rent_ref.rental = true
                            end
                            v:set_edition({ negative = true }, true)
                            v:set_rental(true)
                        end
                    else
                        if v.ability.rent_ref then
                            if v.ability.rent_ref.edition then
                                v:set_edition({ [v.ability.rent_ref.edition] = true }, true)
                            else
                                v:set_edition(nil, true)
                            end
                            if not v.ability.rent_ref.rental then
                                v:set_rental(false)
                            end
                            v.ability.rent_ref = nil
                        end
                    end
                end
            end
        end
    end
end

function consumInfo.can_use(self, card)
    if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or card.area == G.consumeables then return true end
end

return consumInfo