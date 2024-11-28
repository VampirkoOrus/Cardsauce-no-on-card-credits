local jokerInfo = {
	name = 'Be Someone Forever',
	config = {},
	rarity = 1,
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true
}

function jokerInfo.add_to_deck(self, card)
	check_for_unlock({ type = "discover_bsf" })
	ach_jokercheck(self, ach_checklists.band)
	ach_jokercheck(self, ach_checklists.high)
end

return jokerInfo


