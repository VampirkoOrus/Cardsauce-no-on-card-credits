---------------------------
--------------------------- 1.0 Items and Loading
---------------------------

SMODS.Atlas({ key = 'csau_undiscovered', path ="undiscovered.png", px = 71, py = 95 })
local itemsToLoad = {
    Joker = {
        -- Common
        'twoface',
        'newjoker',
        'depressedbrother',
        'pivot',
        'fisheye',
        'diaper',
        'speen',
        'pacman',
        'besomeone',
        'disguy',
        'roche',
        'reyn',
        'emmanuel',
        'gnorts',
        'chad',
    
        'purple',
        'garbagehand',
        -- Uncommon
        'meat',
        'greyjoker',
        'veryexpensivejoker',
        'roger',
        'cousinsclub',
        'anotherlight',
        'sohappy',
        'code',
        'deathcard',
        'maskedjoker',
        'dontmind',
        'kerosene',
        'businesstrading',
    
        'red',
        'fate',
        'miracle',
        'chromedup',
        -- Rare
        'thisiscrack',
        'werewolves',
        'hell',
        'odio',
        -- Common (Locked)
        'speedjoker',
        'disturbedjoker',
    
        -- Uncommon (Locked)
        'shrimp',
        'muppet',
        -- Rare (Locked)
        'charity',
        'supper',
        'pepsecret',
    
        'greenneedle',
        'wingsoftime',
        'kings',
        -- Legendary
        'vincenzo',
        'quarterdumb',
    
        -- Update 1.2
        'fantabulous',
        'grand',
        'ten',
        'beginners',
        'joeycastle',
        'voice',
        'rotten',
        'rapture',
        'villains',
        'killjester',
    
        -- Update 1.3
        'crudeoil',
        'grannycream',
        'bjbros',
        'koffing',
        'drippy',
        'sts',
        'meteor',
        'dud',
        'frich',
        'bunji',
    },

    Consumable = {
        --Spectral
        'quixotic',
        'protojoker',
    },

    Deck = {
        'vine',
    },

    Challenge = {
        'tucker',
    },

    Blind = {
        'hog',
        'tray',
        'vod',
        'finger',
        'mochamike',
    },
}

for k, v in pairs(itemsToLoad) do
	if next(itemsToLoad[k]) and (k == 'Joker' or (k ~= 'Joker' and csau_enabled['enable'..k..'s'])) then
		for i = 1, #v do
			load_cardsauce_item(v[i], k, false)
		end
	end
end





---------------------------
--------------------------- 2.0 Items and Loading
---------------------------

if not twoPointO then
    return
end

local twoPointOItems = {
    VHS = {
		'blackspine',
		'doubledown',
		'topslots',
		'donbeveridge',
		'tbone',
		'remlezar',
		'calibighunks',
		'twistedpair',
		'suburbansasquatch',
	},

	Stand = {
        -- stardust crusaders
		'stardust_star',
		'stardust_thoth',
		'stardust_world',

		-- diamond is unbreakable
		'diamond_crazy',
		'diamond_hand',
		'diamond_echoes_1',
		'diamond_echoes_2',
		'diamond_echoes_3',
		'diamond_killer',
		'diamond_killer_btd',
		
		-- vento aureo
		'vento_gold',
		'vento_gold_requiem',
        'vento_moody',
		'vento_metallica',
		'vento_epitaph',
		'vento_epitaph_king',
		'vento_watchtower',

		-- stone ocean
		'stone_stone',
		'stone_marilyn',
		'stone_white',
		'stone_white_moon',
		'stone_white_heaven',

		-- steel ball run
		'steel_tusk_1',
		'steel_tusk_2',
		'steel_tusk_3',
		'steel_tusk_4',
		'steel_civil',
		'steel_d4c',
		'steel_d4c_love',

		-- jojolion
		'lion_soft',
		'lion_soft_beyond',
		'lion_paper',
		'lion_rock',
		'lion_wonder',

		-- jojolands
		'lands_november',
		'lands_smooth',
		'lands_bigmouth',
	},
	Tag = {
		'corrupted',
		'plinkett',
		'spirit',
	},
	Voucher = {
		'scavenger',
		'raffle',
        'foo',
		'plant',
	},
	Consumable = {
		-- Planet
		'lutetia',
		'varuna',
		'lost_galaxy',
		-- Spectral
        'spec_stone',
		'spec_diary',
		-- Tarot
		'tarot_arrow',
	},

	Joker = {
		--Common
		'frens',
		'powers',
		'memehouse',
		'nutbuster',
		'chips',
		'bonzi',
		'bbq',
		'lidl',
		'toeofsatan',
		'superghostbusters',
		'facade',
		'vomitblast',
		'itsmeaustin',
		'bootleg',
		'bald',
		'protogent',
		--Uncommon
		'scam',
		'monkey',
		'skeletor',
		'agga',
		'triptoamerica',
		'passport',
		'fireworks',
		'sprunk',
		'flusher',
		'vinewrestle',
		'plaguewalker',
		'duane',
		'april',
		'mrkill',
		'itsafeature',
		'bulk',
		'mug',
		'blackjack',
		'bsi',
		--Rare
		'tetris',
		'skeletonmetal',
		'byebye',
		'ufo',
		--Legendary
		'wigsaw',

		-- RLM Jokers
		'hack',
		'endlesstrash',
		'genres',
		'weretrulyfrauds',
		'junka',

		-- Jojo Jokers
		'gravity',
		'jokerdrive',
		'photodad',
		'no2joker',
		'sotw',
	},

    Deck = {
        'varg',
		'cbt',
	    'wheel',
	    'disc'
    },

	Booster = {
		'analog1',
		'analog2',
		'analog3',
		'analog4',
	},

    Blind = {
        'outlaw',
        'darkest'
    },

	Edition = {
		'corrupted'
	}
}

--------------------------- VHS Consumable Type

SMODS.Sound({ key = "vhsopen", path = "vhsopen.ogg"})
SMODS.Sound({ key = "vhsclose", path = "vhsclose.ogg"})
SMODS.UndiscoveredSprite{ key = "VHS", atlas = "csau_undiscovered", pos = { x = 0, y = 0 }}
SMODS.ConsumableType{
    key = "VHS",
    primary_colour = G.C.VHS,
    secondary_colour = G.C.VHS,
    collection_rows = { 8, 8 },
    shop_rate = 0,
    loc_txt = {},
    default = "c_csau_blackspine",
    can_stack = false,
    can_divide = false,
}



--------------------------- Stands consumable type


SMODS.ObjectType { default = 'c_csau_stardust_star', key = 'StandPool', prefix_config = false }
SMODS.ObjectType { default = 'c_csau_stardust_star', key = 'EvolvedPool', prefix_config = false,}


SMODS.Rarity {
	key = 'StandRarity',
	default_weight = 1,
	no_mod_badges = true,
	prefix_config = false,
	badge_colour = 'FFFFFF'
}

SMODS.Rarity {
	key = 'EvolvedRarity',
	default_weight = 0,
	no_mod_badges = true,
	prefix_config = false,
	badge_colour = 'FFFFFF',
}

-- Stand Consumable
SMODS.Atlas({ key = 'undiscovered', path = "undiscovered.png", px = 71, py = 95 })
SMODS.UndiscoveredSprite { key = "Stand", atlas = "undiscovered", pos = { x = 1, y = 0 }, overlay_pos = { x = 2, y = 0 } }
SMODS.ConsumableType {
	key = 'Stand',
	primary_colour = G.C.STAND,
	secondary_colour = G.C.STAND,
	collection_rows = { 8, 8 },
	shop_rate = 0,
	default = "c_csau_diamond_star",
	prefix_config = false,
	rarities = {
		{key = 'StandRarity'},
		{key = 'EvolvedRarity'},
	},
	inject_card = function(self, center)
		if center.set ~= self.key then SMODS.insert_pool(G.P_CENTER_POOLS[self.key], center) end
		local pool_key = center.config.evolved and 'EvolvedPool' or 'StandPool'
		SMODS.insert_pool(G.P_CENTER_POOLS[pool_key], center)
		if center.rarity and self.rarity_pools[center.rarity] then
			SMODS.insert_pool(self.rarity_pools[center.rarity], center)
		end
	end,
	delete_card = function(self, center)
		if center.set ~= self.key then SMODS.remove_pool(G.P_CENTER_POOLS[self.key], center.key) end
		local pool_key = center.config.evolved and 'EvolvedPool' or 'StandPool'
		SMODS.remove_pool(G.P_CENTER_POOLS[pool_key], center)
		if center.rarity and self.rarity_pools[center.rarity] then
			SMODS.remove_pool(self.rarity_pools[center.rarity], center.key)
		end
	end,
}
SMODS.Shader {
	key = 'stand_mask',
	path = 'stand_mask.fs',
}

-- actual loading
for k, v in pairs(twoPointOItems) do
	if next(twoPointOItems[k]) then
        if (k == 'Joker' or ((k == 'VHS' or k == 'Stand') and csau_enabled['enableConsumables']) or csau_enabled['enable'..k..'s']) then
            for i = 1, #v do
                load_cardsauce_item(v[i], k, false)
            end
        end
	end
end
