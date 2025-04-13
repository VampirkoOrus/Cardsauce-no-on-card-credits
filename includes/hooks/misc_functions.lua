-- I replaced a lovely patch with this, since hooking is generally more stable
-- Since it's a vanilla function, you're less likely to run into an issue when SMODS updates ~Winter
local ref_loc_colour = loc_colour
function loc_colour(_c, _default)
	ref_loc_colour(_c, _default)
	G.ARGS.LOC_COLOURS.mug = G.C.MUG
    G.ARGS.LOC_COLOURS.vhs = G.C.VHS
    G.ARGS.LOC_COLOURS.stand = G.C.STAND
    return G.ARGS.LOC_COLOURS[_c] or _default or G.C.UI.TEXT_DARK
end

local get_straight_ref = get_straight
function get_straight(hand)
	local base = get_straight_ref(hand)
	local results = {}
	local vals = {}
	local verified = {}
	local can_loop = next(find_joker('Rekoj Gnorts'))
	local target = next(find_joker('Four Fingers')) and 4 or 5
	local skip_var = next(find_joker('Shortcut'))
	local skipped = false
	if not(can_loop) or #hand < target then
		G.GAME.gnortstraight = false
		return base
	else
		local hand_ref = {}
		for k, v in pairs(hand) do
			table.insert(hand_ref, v)
		end
		table.sort(hand_ref, function(a,b) return a:get_id() < b:get_id() end)
		local ranks = {}
		local _next = nil
		local val = 0
		for k, v in pairs(G.P_CARDS) do
			if (ranks[v.pos.x+1] == nil) then
				ranks[v.pos.x+1] = v.value
			end
		end
		while val < #hand_ref*2 do
			local i = val%#hand_ref + 1
			local id = hand_ref[i]:get_id()-1
			val = val + 1
			if _next == nil then
				table.insert(results,hand_ref[i])
				_next = ranks[id%#ranks+1]
				skipped = false
			else
				if (ranks[id] == _next) then

					table.insert(results,hand_ref[i])
					_next = ranks[id%#ranks+1]
					skipped = false
				elseif skip_var and not skipped then
					_next = ranks[id%#ranks+1]
					skipped = true
				else
					_next = nil
					val = val-1
					results = {}
					skipped = false
				end
			end
			if (#results == target) then
				table.sort(hand, function(a,b) return a.T.x < b.T.x end)
				table.sort(results, function(a,b) return a.T.x < b.T.x end)
				return {results}
			elseif _next ~= nil then

			end
		end
	end

	return {}
end

-- I put this in misc_functions because this is where similar functions are in Vanilla ~Winter

--- Resets the rank used by the Paper Moon King stand card
function csau_reset_paper_rank()
    G.GAME.csau_current_paper_rank = {'Jack'}
	local valid_ranks = {}
    for _, rank in pairs(SMODS.Ranks) do
        if rank.face then valid_ranks[#valid_ranks+1] = rank.key end
    end
    G.GAME.csau_current_paper_rank = pseudorandom_element(valid_ranks, pseudoseed('papermoon'..G.GAME.round_resets.ante))
end


--- Calculation for Fibonacci Scoring
function csau_get_fibonacci(hand)
	local ret = {}
	if #hand < 5 then return ret end
	local vals = {}
	for i = 1, #hand do
		local value = hand[i].base.nominal
		if hand[i].base.value == 'Ace' then
			value = 1
		elseif SMODS.has_no_rank(hand[i]) then
			value = 0
		end
		
		vals[#vals+1] = value
	end
	table.sort(vals, function(a, b) return a < b end)

	if not vals[1] == 0 and not (is_perfect_square(5 * vals[1]^2 + 4) or is_perfect_square(5 * vals[1]^2 - 4)) then
		return ret
	end

	local sum = 0
	local prev_1 = vals[1]
	local prev_2 = 0
	for i=1, #vals do
		sum = prev_1 + prev_2
		
		if vals[i] ~= sum then
			return ret
		end

		prev_2 = prev_1
		prev_1 = vals[i] == 0 and 1 or vals[i]
	end

	local t = {}
	for i=1, #hand do
		t[#t+1] = hand[i]
	end

	table.insert(ret, t)
	return ret
end
