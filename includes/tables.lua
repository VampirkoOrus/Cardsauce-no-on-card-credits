-- I replaced the old is_food() function by just making this a map instead ~Winter

--- Table representing "food" jokers, including vanilla Balatro jokers like Ice Cream and Ramen
G.foodjokers = {
	['j_gros_michel'] = true,
	['j_ice_cream'] = true,
	['j_cavendish'] = true,
	['j_turtle_bean'] = true,
	['j_popcorn'] = true,
	['j_ramen'] = true,
	['j_selzer'] = true,
	['j_diet_cola'] = true,
	['j_csau_meat'] = true,
	['j_csau_fantabulous'] = true,
	['j_csau_crudeoil'] = true,
	['j_csau_grannycream'] = true,
	['j_csau_toeofsatan'] = true,
}

--- Table representing the credits for collab artwork. Properties are tables containing localizaiton info for each face card
G.csau_collab_credits = {
	-- Vine
	csau_wildcards = {
		King = {key = "guestartist23", set = "Other"}, --fradavovan
		Queen = {key = "guestartist26", set = "Other"}, --CheesyDraws
		Jack = {key = "guestartist26", set = "Other"}, --CheesyDraws
	},
	csau_mascots = {
		King = {key = "guestartist26", set = "Other"}, --CheesyDraws
		Queen = {key = "guestartist27", set = "Other"}, --Greeeg
		Jack = {key = "guestartist12", set = "Other"}, --WhimsyCherry
	},
	csau_classics = {
		King = {key = "guestartist10", set = "Other"}, --Arthur Effgus
		Queen = {key = "guestartist10", set = "Other"}, --Arthur Effgus
		Jack = {key = "guestartist10", set = "Other"}, --Arthur Effgus
	},
	csau_confidants = {
		King = {key = "guestartist17", set = "Other"}, --Jazz_Jen
		Queen = {key = "guestartist17", set = "Other"}, --Jazz_Jen
		Jack = {key = "guestartist17", set = "Other"}, --Jazz_Jen
	},
	-- Varg
	csau_americans = {
		King = {key = "guestartist21", set = "Other"}, --Burdrehnar
		Queen = {key = "guestartist16", set = "Other"}, --GuffNFluff
		Jack = nil,
	},
	csau_voices = {
		King = {key = "guestartist13", set = "Other"}, --Lyzerus
		Queen = {key = "guestartist22", set = "Other"}, --Crisppyboat
		Jack = {key = "guestartist13", set = "Other"}, --Lyzerus
	},
	csau_duendes = {
		King = nil,
		Queen = {key = "guestartist1", set = "Other"}, --SagaciousCejai
		Jack = nil,
	},
	csau_powerful = {
		King = nil,
		Queen =nil,
		Jack = {key = "guestartist1", set = "Other"}, --SagaciousCejai
	},
	-- Mike
	csau_poops = {
		King = {key = "twoartists0", set = "Other", plural = true}, --Gote + SagaciousCejai
		Queen = {key = "guestartist0", set = "Other"}, --Gote
		Jack = {key = "guestartist1", set = "Other"}, --SagaciousCejai
	},
	csau_ocs = {
		King = nil,
		Queen = {key = "guestartist16", set = "Other"}, --GuffNFluff
		Jack = nil,
	},
}

-- A table of preset color settings when Colors are enabled in mod configs
G.color_presets = {
	{
		"GREEN",
		"PURPLE",
		{'50846e', "BAL_DEF_SMALLBIGGREEN"},
		{"4f6367", "BAL_DEF_ENDLESSBLUEGREY"},
		'default_csau'
	},
	{
		"RED",
		"BLUE",
		{'50846e', "BAL_DEF_SMALLBIGGREEN"},
		{"4f6367", "BAL_DEF_ENDLESSBLUEGREY"},
		'default_bal'
	},
	{
		{'2c997f', "DS_GREENCYAN"},
		{'09271d', "DS_DARKGREEN"},
		{'3a6658', "DS_BGGREEN"},
		'darkshroom',
	},
	{
		{'60b283', "VS_GREEN"},
		{'a3c86f', "VS_YELLOWGREEN"},
		{'3a664c', "VS_BGGREEN"},
		'vineshroom',
	},
	{
		{"547bb8", "FS_BLUE"},
		{"67b874", "FS_PALEGREEN"},
		{"3a4b66", "FS_BGBLUE"},
		'fullsauce',
	},
	{
		{'e26565', "ES_PALERED"},
		{'a53b38', "ES_DARKRED"},
		{'704b4b', "ES_BGRED"},
		'extrasauce',
	},
	{
		{'9967a7', "TWITCH_PALEPURPLE"},
		{'483062', "TWITCH_DARKPURPLE"},
		{'655478', "TWITCH_BGPURPLE"},
		'twitch',
	},
	{
		{"b5e61d", "FREN_NEONGREEN"},
		{"04a1e5", "FREN_LIGHTBLUE"},
		{"446138", "FREN_BGGREEN"},
		'fren',
	},
	{
		"PURPLE",
		"YELLOW",
		{"655478", "JM_BGPURPLE"},
		'jabroni',
	},
	{
		"JOKER_GREY",
		"BLACK",
		{'404040', "UZU_BGGRAY"},
		'uzumaki',
	},
	{
		"customhex"
	}
}

G.color_presets_nums = {}
G.color_presets_strings = {}
for i, v in ipairs(G.color_presets) do
	local k = v[#v]
	table.insert(G.color_presets_strings, k)
	G.color_presets_nums[k] = i
	if k ~= "customhex" then
		for i = 1, #v - 1 do
			local func_name, color_name
			if type(v[i]) == "string" then
				func_name = "cs_"..v[i].."c"
				color_name = v[i]
			elseif type(v[i]) == "table" then
				G.C[v[i][2]] = HEX(v[i][1])
				func_name = "cs_"..v[i][2].."c"
				color_name = v[i][2]
			end
		end
	end
end

--- Table representing collection checklist for Cardsauce achievements
G.ach_checklists = {
	band = {
		4,
		'the_band',
		{
			'Be Someone Forever',
			'Garbage Hand',
			'Another Light',
			'Kerosene',
			'Vincenzo',
			'Quarterdumb'
		},
	},
	high = {
		2,
		'high_one',
		{
			'Be Someone Forever',
			'Pivyot',
			'Meat',
			"Don't Mind If I Do",
		},
	},
	ff7 = {
		3,
		'triple_seven',
		{
			'Motorcyclist Joker',
			'No No No No No No No No No No No',
			'Meteor',
		}
	}
}

-- I'll be honest, I have no idea what this does
-- But it's a global table, so it goes here
mgt = {"m", "e", "t", "a", "l", "g", "e", "a", "r", "t", "a", "c", "o"}
mgt_num = 1