SMODS.Sound({
    key = "mmmmmm",
    path = "mmmmmm.ogg",
})

SMODS.Sound({
    key = "sorry_link",
    path = "sorry_link.ogg",
})

local ref_check_buy_space = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    local ret = ref_check_buy_space(card)
    if not ret then
        return ret
    end

    if card.ability.set == 'csau_Stand' and not G.GAME.csau_unlimited_stands and G.FUNCS.csau_get_leftmost_stand() then
        return false
    end

    return ret
end





---------------------------
--------------------------- Helper functions for Morshu Vouchers
---------------------------

local ref_toggle_shop = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
    if G.shop and G.morshu_area and G.morshu_area.cards and G.GAME.morshu_rounds then
        local removed = 0
		for i, v in ipairs(G.morshu_area.cards) do
			v.ability.morshu_count = (v.ability.morshu_count or 0) + 1
			if v.ability.morshu_count > G.GAME.morshu_rounds then
                removed = removed + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.3,
					func = function()
						-- clear the morshu_cards
						v:start_dissolve()
						return true
					end
				})) 
			end
		end
		
        if removed > 0 then
            --play_sound('csau_sorry_link', 1, 0.38)
            delay(1.2)
        end
	end

    return ref_toggle_shop(e)
end

G.FUNCS.check_for_morshu_space = function(card)
    if #G.morshu_area.cards >= G.morshu_area.config.card_limit + ((card.edition and card.edition.negative) and 1 or 0) then
        alert_no_space(card, G.morshu_area)
        return false
    end
    return true
end

G.FUNCS.save_to_morshu = function(e)
    local c1 = e.config.ref_table
    if c1 and c1:is(Card) then
        if not G.FUNCS.check_for_morshu_space(c1) then
            e.disable_button = nil
            return false
        end
        local c2 = copy_card(c1)
        c2.states.visible = false
        if not c2.bypass_discovery_ui or not c2.bypass_discovery_center then
            c2.bypass_discovery_center = true
            c2.params.bypass_discovery_center = true
            c2.bypass_discovery_ui = true
            c2.params.bypass_discovery_ui = true
            c2:set_sprites(c2.config.center)
        end
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                
            -- remove old stuff
            if c1.children.price then c1.children.price:remove() end
            c1.children.price = nil
            if c1.children.buy_button then c1.children.buy_button:remove() end
            c1.children.buy_button = nil
            if c1.children.buy_and_use_button then c1.children.buy_and_use_button:remove() end
            c1.children.buy_and_use_button = nil
            remove_nils(c1.children)
            
            c1:start_dissolve()

            --play_sound('csau_mmmmmm', 1, 0.38)
            return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.8,
            func = function()
            if c2.ability.set == "Voucher" then
                G.GAME.current_round.voucher.spawn[c2.config.center_key] = false
                G.GAME.used_vouchers[c2.config.center_key] = true
            end

            create_shop_card_ui(c2)
            G.morshu_area:emplace(c2)
            create_shop_card_ui(c2, c2.ability.set, G.morshu_area)
            c2:start_materialize()

            -- could add a context for this if you want           
            return true
            end
        }))
    end
end

local ref_buy_shop = G.FUNCS.buy_from_shop
G.FUNCS.buy_from_shop = function(e)
    local ret = ref_buy_shop(e)

    if ret then
        local card = e.config.ref_table
        G.GAME.csau_shop_dollars_spent = G.GAME.csau_shop_dollars_spent + card.cost
        check_for_unlock({type = 'csau_spent_in_shop', dollars = G.GAME.csau_shop_dollars_spent})
    end
    
    return ret
end

-- this also incorporates koffing's ref to reroll so I don't have them in two places
local reroll_shopref = G.FUNCS.reroll_shop
function G.FUNCS.reroll_shop(e)
    local ret = reroll_shopref(e)
    G.GAME.csau_shop_dollars_spent = G.GAME.csau_shop_dollars_spent + G.GAME.current_round.reroll_cost
    check_for_unlock({type = 'csau_spent_in_shop', dollars = G.GAME.csau_shop_dollars_spent})

    for _, v in ipairs(SMODS.find_card('j_csau_koffing')) do
        if not v.ability.extra.rerolled then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if #G.shop_booster.cards > 0 then
                        for i = #G.shop_booster.cards, 1, -1 do
                            local c = G.shop_booster:remove_card(G.shop_booster.cards[i])
                            c:remove()
                            c = nil
                        end
                    end

                    G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
                    for i = #G.GAME.current_round.used_packs+1, #G.GAME.current_round.used_packs+2 do
                        if not G.GAME.current_round.used_packs[i] then
                            G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
                        end

                        if G.GAME.current_round.used_packs[i] ~= 'USED' then 
                            local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
                            G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[i]], {bypass_discovery_center = true, bypass_discovery_ui = true})
                            create_shop_card_ui(card, 'Booster', G.shop_booster)
                            card.ability.booster_pos = i
                            card:start_materialize()
                            G.shop_booster:emplace(card)
                        end
                    end

                    v:juice_up()
                return true
                end
            }))
            G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end}))
            v.ability.extra.rerolled = true
            break
        end
    end
    return ret
end

local ref_uc = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local card = e.config.ref_table
    if card.ability.activation or (card.config.center.activate and type(card.config.center.activate) == 'function') then
        if card.config.center.activate and type(card.config.center.activate) == 'function' then
            card.config.center.activate(card.config.center, card, not card.ability.activated)
        end
        if card.ability.activation then
            G.FUNCS.tape_activate(card)
            card:highlight(true)
        end
        discover_card(card.config.center)
        if card.area and card.area ~= G.consumeables then
            if card.area and card.area == G.pack_cards then
                if G.booster_pack.alignment.offset.py then
                    G.booster_pack.alignment.offset.y = G.booster_pack.alignment.offset.py
                    G.booster_pack.alignment.offset.py = nil
                end
                G.GAME.pack_choices = G.GAME.pack_choices - 1
                if G.GAME.pack_choices <= 0 then
                    G.FUNCS.end_consumeable(nil, delay_fac)
                end
                card.area:remove_card(card)
            end
            card:add_to_deck()
            G.consumeables:emplace(card)
            play_sound('card1', 0.8, 0.6)
            play_sound('generic1')
            dont_dissolve = true
            delay_fac = 0.2
        end
        return
    end

    return ref_uc(e, mute, nosave)
end

