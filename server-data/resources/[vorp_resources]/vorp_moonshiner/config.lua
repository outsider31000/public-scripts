Config = {}

Config.Locale = 'en'

Config.mashProp = "p_boxcar_barrel_09a" -- object that will be displayed, when u place the mash barrel
Config.brewPop = "mp001_p_mp_still02x" -- object that will be displayed, when u place the moonshine destille

-- here you can configure which mashes you can craft and what items do you need for the prducing of the mash
Config.mashes = {
    ['tropicalPunchMash'] = { -- ['DB_ItemName'] here you define the mash
        Label = "Ginseng Mash", -- the displayed label of the mash
        items = { -- here you can define the reqired items for the mash
            ['Agarita'] = 2, -- ['DB_ItemName'] = HowMuchItemsYouNeed
            ['Alaskan_Ginseng'] = 2, 
            ['American_Ginseng'] = 2, 
            ['water'] = 1
        },
        mashTime = 0.3, -- time to mash in minutes
        minXP = 2, -- min xp you can get for producing
        maxXP = 5, -- max xp you can get for producing
        errorMSG = "You need: 2 Agarita, 2 Alaskan Ginseng, 2 American Ginseng, 1 Water" -- error info if you dont have enough items for the mash
    },
    ['wildCiderMash'] = {
        Label = "Black Berry Mash",
        items = {
            ['Bay_Bolete'] = 2, 
            ['Black_Berry'] = 2, 
            ['water'] = 1
        },
        mashTime = 1.3,
        minXP = 2,
        maxXP = 5,
        errorMSG = "You need: 2 Bay Bolete, 2 Black Berry, 1 Water"
    },
    ['alcohol'] = {
        Label = "Alcohol",
        items = {
            ['Yarrow'] = 4, 
            ['water'] = 1
        },
        mashTime = 1.8,
        minXP = 2,
        maxXP = 5,
        errorMSG = "You need: 2 Bay Bolete, 2 Black Berry, 1 Water"
    },
    ['appleCrumbMash'] = {
        Label = "Minty Berry Mash",
        items = {
            ['Black_Currant'] = 2, 
            ['Evergreen_Huckleberry'] = 2, 
            ['Wild_Mint'] = 2
        },
        mashTime = 0.3,
        minXP = 2,
        maxXP = 5,
        errorMSG = "You need: 2 Black Currant, 2 Evergreen Huckleberry, 2 Wild Mint"
    }
}

-- here you can configure which moonshines you can craft and what items do you need for the prducing of the moonshine
Config.moonshine = {
    ['tropicalPunchMoonshine'] = { -- ['DB_ItemName'] here you define the mash
        Label = "Ginseng Moonshine", -- the displayed label of the mash
        items = { -- here you can define the reqired items for the mash
            ['tropicalPunchMash'] = 2, -- ['DB_ItemName'] = HowMuchItemsYouNeed
            ['alcohol'] = 1
        },
        brewTime = 2, -- time to brew in minutes
        minXP = 2, -- min xp you can get for producing
        maxXP = 5, -- max xp you can get for producing
        errorMSG = "You need: 2 Ginseng Mash, 1  Alcohol" -- error info if you dont have enough items for the mash
    },
    ['wildCiderMoonshine'] = {
        Label = "Black Berry Moonshine",
        items = {
            ['wildCiderMash'] = 2, 
            ['alcohol'] = 2, 
            ['water'] = 1
        },
        brewTime = 2,
        minXP = 2,
        maxXP = 5,
        errorMSG = "You need: 2 Black Berry Mash, 2  Alcohol, 1 Water"
    },
    ['appleCrumbMoonshine'] = {
        Label = "Minty Berry Moonshine",
        items = {
            ['appleCrumbMash'] = 2, 
            ['alcohol'] = 2
        },
        brewTime = 2,
        minXP = 2,
        maxXP = 5,
        errorMSG = "You need: 2 Minty Berry Mash, 2  Alcohol"
    }
}

-- here you can define the items which you can collect in the world
-- use this website to get the correct item names:
-- https://rdr2.mooshe.tv/
-- so for example if you want to collect an apple from a specific tree. look on the website for the correct object name
-- for example: p_tree_maple_s_04
-- on the website you can see how this object looks like, just go to a tree that look like that and you can harvest the defined items

Config.collectableObjects = {
    ['goldencurrant_p'] = { -- Object where you have to collect
        Label = "Currant Bush", -- label which will be displayed
        items = { -- here you can define which items you can harvest on this object
           -- ['currant'] = 2 -- ['DB_ItemName'] = HowMuchItemsYouCanMaxGet
        }
    },
    ['blackcurrant_p'] = {
        Label = "Currant Bush",
        items = {
          --  ['currant'] = 2
        }
    },
    ['rdr_bush_sumac_aa_sim'] = {
        Label = "Currant Bush",
        items = {
          --  ['currant'] = 2,
         --   ['consumable_pear'] = 2
        }
    },
    ['p_tree_orange_01'] = {
        Label = "Fruit Tree",
        items = {
         --   ['apple'] = 2,
         --   ['pear'] = 2,
         --   ['consumable_peach'] = 2
        }
    },
    ['p_tree_maple_s_04'] = {
        Label = "Apple Tree",
        items = {
          --  ['apple'] = 3
        }
    },
    ['s_inv_huckleberry01x'] = {
        Label = "Blueberries Shrub",
        items = {
           -- ['blackberry'] = 2
        }
    },
    ['s_inv_raspberry01x'] = {
        Label = "Raspberries Shrub",
        items = {
           -- ['blackberry'] = 2
        }
    }
}

-- here you can configure zones where you can farm items
Config.collectableZones = {
    {
        point = {x = -1983.08,y = 553.27,z = 116.05}, -- the middle of the zone
        radius = 15, -- the zone radius
        items = { -- items that u can find in the zone
         --   ['vanillaFlower'] = 2 -- ['DB_ItemName'] = HowMuchItemsYouCanMaxGet
        }
    },
    {
        point = {x = -2013.66,y = 529.29,z = 116.7}, 
        radius = 5,
        items = {
          --  ['vanillaFlower'] = 2
        }
    },
    {
        point = {x = -2023.63,y = 534.62,z = 116.51}, 
        radius = 2.5,
        items = {
         --   ['blackberry'] = 2
        }
    },
    {
        point = {x = -2010.58,y = 537.61,z = 116.43}, 
        radius = 3,
        items = {
          --  ['blackberry'] = 2
        }
    },
    {
        point = {x = 1304.39, y = 308.16, z = 88.19}, 
        radius = 7,
        items = {
         --   ['pear'] = 2
        }
    },
    {
        point = {x = 1306.49, y = 322.83, z = 88.0}, 
        radius = 10,
        items = {
          --  ['pear'] = 2
        }
    },
    {
        point = {x = 1287.65, y = 341.92, z = 90.15}, 
        radius = 15,
        items = {
         --   ['pear'] = 2
        }
    }
}

keys = {
    -- Letters
    ["A"] = 0x7065027D,
    ["B"] = 0x4CC0E2FE,
    ["C"] = 0x9959A6F0,
    ["D"] = 0xB4E465B4,
    ["E"] = 0xCEFD9220,
    ["F"] = 0xB2F377E8,
    ["G"] = 0x760A9C6F,
    ["H"] = 0x24978A28,
    ["I"] = 0xC1989F95,
    ["J"] = 0xF3830D8E,
    -- Missing K, don't know if anything is actually bound to it
    ["L"] = 0x80F28E95,
    ["M"] = 0xE31C6A41,
    ["N"] = 0x4BC9DABB, -- Push to talk key
    ["O"] = 0xF1301666,
    ["P"] = 0xD82E0BD2,
    ["Q"] = 0xDE794E3E,
    ["R"] = 0xE30CD707,
    ["S"] = 0xD27782E3,
    -- Missing T
    ["U"] = 0xD8F73058,
    ["V"] = 0x7F8D09B8,
    ["W"] = 0x8FD015D8,
    ["X"] = 0x8CC9CD42,
    -- Missing Y
    ["Z"] = 0x26E9DC00,

    -- Symbol Keys
    ["RIGHTBRACKET"] = 0xA5BDCD3C,
    ["LEFTBRACKET"] = 0x430593AA,
    -- Mouse buttons
    ["MOUSE1"] = 0x07CE1E61,
    ["MOUSE2"] = 0xF84FA74F,
    ["MOUSE3"] = 0xCEE12B50,
    ["MWUP"] = 0x3076E97C,
    -- Modifier Keys
    ["CTRL"] = 0xDB096B85,
    ["TAB"] = 0xB238FE0B,
    ["SHIFT"] = 0x8FFC75D6,
    ["SPACEBAR"] = 0xD9D0E1C0,
    ["ENTER"] = 0xC7B5340A,
    ["BACKSPACE"] = 0x156F7119,
    ["LALT"] = 0x8AAA0AD4,
    ["DEL"] = 0x4AF4D473,
    ["PGUP"] = 0x446258B6,
    ["PGDN"] = 0x3C3DD371,
    -- Function Keys
    ["F1"] = 0xA8E3F467,
    ["F4"] = 0x1F6D95E5,
    ["F6"] = 0x3C0A40F2,
    -- Number Keys
    ["1"] = 0xE6F612E4,
    ["2"] = 0x1CE6D9EB,
    ["3"] = 0x4F49CC4C,
    ["4"] = 0x8F9F9E58,
    ["5"] = 0xAB62E997,
    ["6"] = 0xA1FDE2A6,
    ["7"] = 0xB03A913B,
    ["8"] = 0x42385422,
    -- Arrow Keys
    ["DOWN"] = 0x05CA7C52,
    ["UP"] = 0x6319DB71,
    ["LEFT"] = 0xA65EBAB4,
    ["RIGHT"] = 0xDEB34313
    -- Numpad Keys
}