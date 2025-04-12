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

    if card.ability.set == 'Stand' and not G.GAME.unlimited_stands and G.FUNCS.get_leftmost_stand() then
        return false
    end

    return ret
end

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
            play_sound('csau_sorry_link', 1, 0.38)
            delay(1.2)
        end
	end

    return ref_toggle_shop(e)
end

-- a more general function for morshu space, rather than
-- the very specific ones for general shop buy
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

            play_sound('csau_mmmmmm', 1, 0.38)
            return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.8,
            func = function()
            if c2.ability.set == "Voucher" then
                if c2.shop_voucher then G.GAME.current_round.voucher.spawn[c2.config.center_key] = false end 
                G.GAME.used_vouchers[c2.config.center_key] = true
            end

            create_shop_card_ui(c2)
            G.morshu_area:emplace(c2)
            c2:start_materialize()

            -- could add a context for this if you want           
            return true
            end
        }))
    end
end
