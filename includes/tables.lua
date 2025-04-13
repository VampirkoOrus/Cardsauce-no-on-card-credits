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

--- Table containing all names of people who contributed to the mod, used in crediting
csau_team = {
	['gote'] = "BarrierTrio/Gote",
	['dps'] = "DPS2004",
	['cejai'] = "SagaciousCejai",
	['nether'] = "Nether",
	['myst'] = "Mysthaps",
	['numbuh'] = "Numbuh214",
	['aure'] = "Aurelius7309",
	['amtrax'] = "Austin L. Matthews",
	['tort'] = "tortoise",
	['proto'] = "Protokyuuu",
	['shrine'] = "ShrineFox",
	['cyro'] = "cyrobolic",
	['recon'] = "ReconBox",
	['sin'] = "SinCityAssassin",
	['aure'] = "aure",
	['eremel'] = "Eremel",
	['voyager'] = "TheVoyger1234",
	['vinny'] = "Vinny",
	['joel'] = "Joel",
	['mike'] = "Mike",
	['lyman'] = "Lyman",
	['akai'] = "Akai",
	['victin'] = "Victin",
	['keku'] = "Keku",
	['gappie'] = "Gappie",
	['winterg'] = "Winter Grimwell",
	['fenix'] = "FenixSeraph",
	['cherry'] = "WhimsyCherry",
	['trance'] = "Global-Trance",
	['lyzerus'] = "Lyzerus",
	['bass'] = "Bassclefff",
	['frada'] = "fradavovan",
	['greg'] = "Greeeg",
	['cheesy'] = "CheesyDraws",
	['jen'] = "Jazz_Jen",
	['bard'] = "BardVergil",
	['guff'] = "GuffNFluff",
	['sine'] = "sinewuui",
	['swizik'] = "Swizik",
	['burd'] = "Burdrehnar",
	['crispy'] = "Crisppyboat",
	['alli'] = "Alli",
	['alizarin'] = "AlizarinRed",
	['moon'] = "PaperMoon",
	['yunkie'] = "yunkie101",
	['plunch'] = "plunch",
	['wario'] = "MightyKingWario",
	['rerun'] = "KawaiiRerun",
	['winterc'] = "TheWinterComet",
	['gameboy'] = "Sir. Gameboy",
	['cauthen'] = "Cauthen Currie",
	['joey'] = "Joey",
	['burlap'] = "ABBurlap",
	['chvsau'] = "chvsau",
	['dolos'] = "Dolos",
	['kuro'] = "SoloDimeKuro",
	['donk'] = "Donk.TK",
	extra = {
		['amtrax'] = "(AmtraxVA)",
		['bass'] = "(bassclefff.bandcamp.com)",
		['lyman'] = "(JankJonklers)",
		['akai'] = "(Balatrostuck)",
		['myst'] = "(LobotomyCorp)",
		['victin'] = "(Victin's Collection)",

	}
}

--- Table representing the credits for collab artwork. Properties are tables containing localizaiton info for each face card
G.csau_collab_credits = {
	-- Vine
	csau_wildcards = {
		King = {key = "artistcredit", set = "Other", vars = { csau_team.frada } },
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.cheesy } },
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.cheesy } },
	},
	csau_mascots = {
		King = {key = "artistcredit", set = "Other", vars = { csau_team.cheesy } },
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.greg } },
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.cherry } },
	},
	csau_classics = {
		King = {key = "artistcredit", set = "Other", vars = { csau_team.winterg } },
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.winterg } },
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.winterg } },
	},
	csau_confidants = {
		King = {key = "artistcredit", set = "Other", vars = { csau_team.jen } },
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.jen } },
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.jen } },
	},
	-- Varg
	csau_americans = {
		King = {key = "artistcredit", set = "Other", vars = { csau_team.burd } },
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.guff } },
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.plunch } },
	},
	csau_voices = {
		King = {key = "artistcredit", set = "Other", vars = { csau_team.lyzerus } },
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.crispy } },
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.lyzerus } },
	},
	csau_duendes = {
		King = {key = "artistcredit", set = "Other", vars = { csau_team.winterg } },
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.cejai } },
		Jack = nil,
	},
	csau_powerful = {
		King = nil,
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.chvsau } },
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.cejai } },
	},
	-- Mike
	csau_poops = {
		King = {key = "artistcredit_2", set = "Other", vars = { csau_team.gote, csau_team.cejai } , plural = true},
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.gote } },
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.cejai } },
	},
	csau_ocs = {
		King = nil,
		Queen = {key = "artistcredit", set = "Other", vars = { csau_team.guff } },
		Jack = nil,
	},
	csau_pets = {
		King = nil,
		Queen = nil,
		Jack = {key = "artistcredit", set = "Other", vars = { csau_team.winterg } },
	},
}

-- Automatically inserts vanilla friends of Jimbo credits into G.csau_collab_credits. cause why not
local ref_ips = G.FUNCS.initPostSplash
G.FUNCS.initPostSplash = function()
	ref_ips()
	local visited = {}
	local function recursive_search(t)
		if visited[t] then return false end
		visited[t] = true
		if type(t) == "table" and t.label == "Collabs" and type(t.tab_definition_function) == "function" then
			t.tab_definition_function()
			return true
		end
		for _, v in ipairs(t) do
			if type(v) == "table" and recursive_search(v) then
				return true
			end
		end
		for k, v in pairs(t) do
			if type(v) == "table" and recursive_search(v) then
				return true
			end
		end
		return false
	end
	G.FUNCS.show_credits()
	local result = recursive_search(G.OVERLAY_MENU)
	G.FUNCS:exit_overlay_menu()
	if result then
		for k, v in pairs(G.collab_credits) do
			if v.artist then
				G.csau_collab_credits[v.art] = {
					King = {key = "artistcredit", set = "Other", vars = { v.artist } },
					Queen = {key = "artistcredit", set = "Other", vars = { v.artist } },
					Jack = {key = "artistcredit", set = "Other", vars = { v.artist } },
				}
			end
		end
	end
end

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

-- colors used for dynamic badges, used to be in localization file which is a bad place to put hex codes -keku
G.badge_colours = {
	co_vinny = "32A852",
	te_vinny = "FFFFFF",
	co_joel = "3b4635",
	te_joel = "b0cf56",
	co_mike = "8867a5",
	te_mike = "FFFF00",
	co_redvox = "841f20",
	te_redvox = "cac5b7",
	co_rlm = "FFFFFF",
	te_rlm = "b1212a",
	co_uzumaki = "374244",
	te_uzumaki = "bfc7d5",

	-- badge colors for jojo parts
	co_phantom = '3358A2',
	te_phantom = 'B74582',
	co_battle = 'DD5668',
	te_battle = '338FC4',
	co_stardust = '425F7C',
	te_stardust = 'EFCB70',
	co_diamond = 'BEE5E5',
	te_diamond = 'C479BE',
	co_vento = 'EDCE49',
	te_vento = 'D168BC',
	co_feedback = '7e2786',
	te_feedback = 'fe9818',
	co_stone = '99B5B5',
	te_stone = '61DFF8',
	co_steel = 'A38168',
	te_steel = 'A9CF3C',
	co_lion = 'BCBCE5',
	te_lion = 'DCF7FC',
	co_lands = '394E90',
	te_lands = '409CE8',
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