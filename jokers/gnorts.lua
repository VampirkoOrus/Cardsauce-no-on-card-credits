local jokerInfo = {
	name = 'Rekoj Gnorts',
	config = {},
	rarity = 2,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_gnorts" })
end

function jokerInfo.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = {key = "guestartist7", set = "Other"}
end

return jokerInfo
	