local jokerInfo = {
	name = 'Grey Joker [WIP]',
	config = {},
	text = {
		"{C:mult}+2{} discards, but must",
		"discard 5 cards {C:attention}at a time{}"
	},
	rarity = 2,
	cost = 6,
	canBlueprint = true,
	canEternal = true,
	hasSoul = true,
}

function jokerInfo.tooltip(self, info_queue)
	info_queue[#info_queue+1] = {key = "guestartist1", set = "Other"}
end


function jokerInfo.calculate(self, context)
	--todo
end



return jokerInfo
	