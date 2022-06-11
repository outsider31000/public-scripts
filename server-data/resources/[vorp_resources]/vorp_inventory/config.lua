----------------------------------------------------------------------------------------------------
--------------------------------------- CONFIG -----------------------------------------------------
-- VORP INVENTORY LUA*

Config  = {

  Debug = false, -- if your server is live set this to false.  to true only if you are testing things
  DevMode = false, -- if your server is live set this to false.  to true only if you are testing things (auto load inventory when script restart and before character selection. Alos add /getInv command)
  
  defaultlang = "en_lang",
  
  -- DEATH FUNCTIONS
  DisableDeathInventory = true, -- prevent the ability to access inventory while dead

   --{ I } OPEN INVENTORY
  OpenKey = 0xC1989F95, 

  --RMB mouse PROMPT PICKUP
  PickupKey = 0xF84FA74F, 

  -- LOGS 
  webhookavatar = "https://cdn3.iconfinder.com/data/icons/hand/500/Hand_give_thumbs_finger-512.png",
  webhook = "https://discord.com/api/webhooks/952537644259221544/EdqpLMoDJJx0b-eXJJn3m4cOUhktW21YY2nr-8pq8XEbsMZYEYbL8t6LO5dIzavr9tzE",
  discordid = false, -- turn to true if ur using discord whitelist 

  -- WEBHOOK LANGUAGE
  Language = {
    gaveitem = "item transfer",
    gave = " transfered ",
    to = " to ",
    withid = " with the weapon ID: ",
  },

  -- NEED TO TEST
  DropOnRespawn  = {
    Money   = true,
    Weapons = true,
    Items  = true
  },

  -- HOW MANY WEAPONS AND ITEMS ALLOWED PER PLAYER
  MaxItemsInInventory  = {
    Weapons = 6,
    Items = 50,
  },

 
  -- FIRST JOIN
  startItems  = {
    consumable_raspberrywater = 2, --ITEMS SAME NAME AS IN DATABASE
    ammorevolvernormal = 1 --AMMO SAME NAME AS I NTHE DATABASE
  },

  startWeapons = {
    WEAPON_MELEE_KNIFE = {{}} --WEAPON HASH NAME
  },


  --DON'T TOUCH BESIDES NAME OF WEAPON
  Weapons = {
    {
      
      Name = "Lasso", -- TRANSLATE NAME ONLY
      HashName = "WEAPON_LASSO",
      WeaponModel  = "w_melee_lasso01"
    },
    {
      Name = "Reinforced Lasso",
      HashName = "WEAPON_LASSO_REINFORCED",
      WeaponModel  = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Knife",
      HashName = "WEAPON_MELEE_KNIFE",
      WeaponModel = "w_melee_knife02",
      AmmoHash = {},
      CompsHash = {
        {
          w_melee_knife02_grip1  = 0
        }
      }
    },
    {
      Name = "Knife Rustic",
      HashName =" WEAPON_MELEE_KNIFE_RUSTIC",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Knife Horror",
      HashName = "WEAPON_MELEE_KNIFE_HORROR",
      WeaponModel = "w_melee_knife02",
      AmmoHash = {},
      CompsHash = {
        {
          w_melee_knife02_grip1 = 0
        }
      }
    },
    {
      Name = "Knife Civil War",
      HashName = "WEAPON_MELEE_KNIFE_CIVIL_WAR",
      WeaponModel = "w_melee_knife16",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Knife Jawbone",
      HashName = "WEAPON_MELEE_KNIFE_JAWBONE",
      WeaponModel =" w_melee_knife03",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Knife Miner",
      HashName = "WEAPON_MELEE_KNIFE_MINER",
      WeaponModel = "w_melee_knife14",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Knife Vampire",
      HashName = "WEAPON_MELEE_KNIFE_VAMPIRE",
      WeaponModel = "w_melee_knife18",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Cleaver",
      HashName = "WEAPON_MELEE_CLEAVER",
      WeaponModel = "w_melee_hatchet02",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Hachet",
      HashName = "WEAPON_MELEE_HATCHET",
      WeaponModel = "w_melee_hatchet01",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Hachet Double Bit",
      HashName = "WEAPON_MELEE_HATCHET_DOUBLE_BIT",
      WeaponModel = "w_melee_hatchet06",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Hachet Hewing",
      HashName = "WEAPON_MELEE_HATCHET_HEWING",
      WeaponModel = "w_melee_hatchet05",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Hachet Hunter",
      HashName = "WEAPON_MELEE_HATCHET_HUNTER",
      WeaponModel = "w_melee_hatchet07",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Hachet Viking",
      HashName = "WEAPON_MELEE_HATCHET_VIKING",
      WeaponModel = "w_melee_hatchet04",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Tomahawk",
      HashName = "WEAPON_THROWN_TOMAHAWK",
      WeaponModel = "w_melee_tomahawk01",
      AmmoHash = {
        {
          AMMO_TOMAHAWK = 2,
          AMMO_TOMAHAWK_IMPROVED = 2,
          AMMO_TOMAHAWK_HOMING = 2
        }
      },
      CompsHash = {}
    },
    {
      Name = "Tomahawk Ancient",
      HashName = "WEAPON_THROWN_TOMAHAWK_ANCIENT",
      WeaponModel = "w_melee_tomahawk02",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Throwing Knifes",
      HashName = "WEAPON_THROWN_THROWING_KNIVES",
      WeaponModel = "w_melee_knife05",
      AmmoHash = {
        {
          AMMO_THROWING_KNIVES = 2,
          AMMO_THROWING_KNIVES_IMPROVED = 2,
          AMMO_THROWING_KNIVES_POISON = 2
        }
      },
      CompsHash = {}
    },
    {
      Name = "Machete",
      HashName = "WEAPON_MELEE_MACHETE",
      WeaponModel = "w_melee_machete01",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Bow",
      HashName = "WEAPON_BOW",
      WeaponModel = "w_sp_bowarrow",
      AmmoHash = {
        {
          AMMO_ARROW = 0.25,
          AMMO_ARROW_DYNAMITE = 0.25,
          AMMO_ARROW_FIRE = 0.25,
          AMMO_ARROW_IMPROVED = 0.25,
          AMMO_ARROW_POISON = 0.25,
          AMMO_ARROW_SMALL_GAME = 0.25
        }
      },
      CompsHash = {}
    },
    {
      Name = "Pistol Semi-Auto",
      HashName = 'WEAPON_PISTOL_SEMIAUTO',
      WeaponModel = "w_pistol_semiauto01",
      AmmoHash = {
        {
          AMMO_PISTOL = 0.25,
          AMMO_PISTOL_EXPRESS = 0.25,
          AMMO_PISTOL_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_PISTOL_HIGH_VELOCITY = 0.25,
          AMMO_PISTOL_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_pistol_semiauto01_sight1 = 0,
          w_pistol_semiauto01_sight2 = 10,
          w_pistol_semiauto01_grip1 = 0,
          w_pistol_semiauto01_grip2 = 10,
          w_pistol_semiauto01_grip3 = 10,
          w_pistol_semiauto01_grip4 = 10,
          w_pistol_semiauto01_clip = 0,
          w_pistol_semiauto01_barrel1 = 0,
          w_pistol_semiauto01_barrel2 = 10
        }
      }
    },
    {
      Name = "Pistol Mauser",
      HashName = "WEAPON_PISTOL_MAUSER",
      WeaponModel = "w_pistol_mauser01",
      AmmoHash = {
        {
          AMMO_PISTOL = 0.25,
          AMMO_PISTOL_EXPRESS = 0.25,
          AMMO_PISTOL_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_PISTOL_HIGH_VELOCITY = 0.25,
          AMMO_PISTOL_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_pistol_mauser01_sight1 = 0,
          w_pistol_mauser01_sight2 = 10,
          w_pistol_mauser01_grip1 = 0,
          w_pistol_mauser01_grip2 = 10,
          w_pistol_mauser01_grip3 = 10,
          w_pistol_mauser01_grip4 = 10,
          w_pistol_mauser01_clip = 0,
          w_pistol_mauser01_barrel1 = 0,
          w_pistol_mauser01_barrel2 = 10
        }
      }
    },
    {
      Name = "Pistol Volcanic",
      HashName = "WEAPON_PISTOL_VOLCANIC",
      WeaponModel = "w_pistol_volcanic01",
      AmmoHash = {
        {
          AMMO_PISTOL = 0.25,
          AMMO_PISTOL_EXPRESS = 0.25,
          AMMO_PISTOL_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_PISTOL_HIGH_VELOCITY = 0.25,
          AMMO_PISTOL_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_pistol_volcanic01_sight1 = 0,
          w_pistol_volcanic01_sight2 = 10,
          w_pistol_volcanic01_grip1 = 0,
          w_pistol_volcanic01_grip2 = 10,
          w_pistol_volcanic01_grip3 = 10,
          w_pistol_volcanic01_grip4 = 10,
          w_pistol_volcanic01_barrel01 = 0,
          w_pistol_volcanic01_barrel02 = 10
        }
      }
    },
    {
      Name = "Pistol M1899",
      HashName = "WEAPON_PISTOL_M1899",
      WeaponModel = "w_pistol_m189902",
      AmmoHash = {
        {
          AMMO_PISTOL = 0.25,
          AMMO_PISTOL_EXPRESS = 0.25,
          AMMO_PISTOL_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_PISTOL_HIGH_VELOCITY = 0.25,
          AMMO_PISTOL_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_pistol_m189902_sight1 = 0,
          w_pistol_m189902_sight2 = 10,
          w_pistol_m189902_grip1 = 0,
          w_pistol_m189902_grip2 = 10,
          w_pistol_m189902_grip3 = 10,
          w_pistol_m189902_grip4 = 10,
          w_pistol_m189902_clip1 = 0,
          w_pistol_m189902_barrel01 = 0,
          w_pistol_m189902_barrel02 = 10
        }
      }
    },
    {
      Name = "Revolver Schofield",
      HashName = "WEAPON_REVOLVER_SCHOFIELD",
      WeaponModel = "w_revolver_schofield01",
      AmmoHash = {
        {
          AMMO_REVOLVER = 0.25,
          AMMO_REVOLVER_EXPRESS = 0.25,
          AMMO_REVOLVER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REVOLVER_HIGH_VELOCITY = 0.25,
          AMMO_REVOLVER_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_revolver_schofield01_sight1 = 0,
          w_revolver_schofield01_sight2 = 10,
          w_revolver_schofield01_grip1 = 0,
          w_revolver_schofield01_grip2 = 10,
          w_revolver_schofield01_grip3 = 10,
          w_revolver_schofield01_grip4 = 10,
          w_revolver_schofield01_barrel01 = 0,
          w_revolver_schofield01_barrel02 = 10
        }
      }
    },
    {
      Name = "Revolver Navy",
      HashName = "WEAPON_REVOLVER_NAVY",
      WeaponModel = "w_revolver_navy",
      AmmoHash = {
        {
          AMMO_REVOLVER = 0.25,
          AMMO_REVOLVER_EXPRESS = 0.25,
          AMMO_REVOLVER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REVOLVER_HIGH_VELOCITY = 0.25,
          AMMO_REVOLVER_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          COMPONENT_REVOLVER_NAVY_BARREL_SHORT = 0,
          COMPONENT_REVOLVER_NAVY_BARREL_LONG = 10,
          COMPONENT_REVOLVER_NAVY_BARREL_CROSSOVER = 0,
          COMPONENT_REVOLVER_NAVY_GRIP = 10,
          COMPONENT_REVOLVER_NAVY_GRIP_IRONWOOD = 10,
          COMPONENT_REVOLVER_NAVY_GRIP_PEARL = 10,
          COMPONENT_REVOLVER_NAVY_GRIP_EBONY = 0,
          COMPONENT_REVOLVER_NAVY_GRIP_CROSSOVER = 10,
          COMPONENT_REVOLVER_NAVY_SIGHT_NARROW = 10,
          COMPONENT_REVOLVER_NAVY_SIGHT_WIDE = 10,
          COMPONENT_REVOLVER_NAVY_SIGHT_CROSSOVER = 10
        }
      }
    },
    {
      Name = "Revolver Navy Crossover",
      HashName = "WEAPON_REVOLVER_NAVY_CROSSOVER",
      WeaponModel = "w_revolver_navy", -- need to find model name althoug this is not being used anyways
      AmmoHash = {
        {
          AMMO_REVOLVER = 0.25,
          AMMO_REVOLVER_EXPRESS = 0.25,
          AMMO_REVOLVER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REVOLVER_HIGH_VELOCITY = 0.25,
          AMMO_REVOLVER_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          COMPONENT_REVOLVER_NAVY_BARREL_SHORT = 0,
          COMPONENT_REVOLVER_NAVY_BARREL_LONG = 10,
          COMPONENT_REVOLVER_NAVY_BARREL_CROSSOVER = 0,
          COMPONENT_REVOLVER_NAVY_GRIP = 10,
          COMPONENT_REVOLVER_NAVY_GRIP_IRONWOOD = 10,
          COMPONENT_REVOLVER_NAVY_GRIP_PEARL = 10,
          COMPONENT_REVOLVER_NAVY_GRIP_EBONY = 0,
          COMPONENT_REVOLVER_NAVY_GRIP_CROSSOVER = 10,
          COMPONENT_REVOLVER_NAVY_SIGHT_NARROW = 10,
          COMPONENT_REVOLVER_NAVY_SIGHT_WIDE = 10,
          COMPONENT_REVOLVER_NAVY_SIGHT_CROSSOVER = 10
        }
      }
    },
    {
      Name = "Revolver Lemat",
      HashName = "WEAPON_REVOLVER_LEMAT",
      WeaponModel = "w_revolver_lemat01",
      AmmoHash = {
        {
          AMMO_REVOLVER = 0.25,
          AMMO_REVOLVER_EXPRESS = 0.25,
          AMMO_REVOLVER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REVOLVER_HIGH_VELOCITY = 0.25,
          AMMO_REVOLVER_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_revolver_lemat01_sight1 = 0,
          w_revolver_lemat01_sight2 = 10,
          w_revolver_lemat01_grip1 = 0,
          w_revolver_lemat01_grip2 = 10,
          w_revolver_lemat01_grip3 = 10,
          w_revolver_lemat01_grip4 = 10,
          w_revolver_lemat01_barrel01 = 0,
          w_revolver_lemat01_barrel02 = 10
        }
      }
    },
    {
      Name = "Revolver Double Action",
      HashName = "WEAPON_REVOLVER_DOUBLEACTION",
      WeaponModel = "w_revolver_doubleaction01",
      AmmoHash = {
        {
          AMMO_REVOLVER = 0.25,
          AMMO_REVOLVER_EXPRESS = 0.25,
          AMMO_REVOLVER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REVOLVER_HIGH_VELOCITY = 0.25,
          AMMO_REVOLVER_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_revolver_doubleaction01_sight1 = 0,
          w_revolver_doubleaction01_sight2 = 10,
          w_revolver_doubleaction01_grip1 = 0,
          w_revolver_doubleaction01_grip2 = 10,
          w_revolver_doubleaction01_grip3 = 10,
          w_revolver_doubleaction01_grip4 = 10,
          w_revolver_doubleaction01_grip5 = 10,
          w_revolver_doubleaction01_barrel01 = 0,
          w_revolver_doubleaction01_barrel02 = 10
        }
      }
    },
    {
      Name = "Revolver Cattleman",
      HashName = "WEAPON_REVOLVER_CATTLEMAN",
      WeaponModel = "w_revolver_cattleman01",
      AmmoHash = {
        {
          AMMO_REVOLVER = 0.25,
          AMMO_REVOLVER_EXPRESS = 0.25,
          AMMO_REVOLVER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REVOLVER_HIGH_VELOCITY = 0.25,
          AMMO_REVOLVER_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_revolver_cattleman01_sight1 = 0,
          w_revolver_cattleman01_sight2 = 10,
          w_revolver_cattleman01_grip1 = 0,
          w_revolver_cattleman01_grip2 = 10,
          w_revolver_cattleman01_grip3 = 10,
          w_revolver_cattleman01_grip4 = 10,
          w_revolver_cattleman01_grip5 = 10,
          w_revolver_cattleman01_barrel01 = 0,
          w_revolver_cattleman01_barrel02 = 10
        }
      }
    },
    {
      Name = "Revolver Cattleman mexican",
      HashName = "WEAPON_REVOLVER_CATTLEMAN_MEXICAN",
      WeaponModel = "w_revolver_cattleman02",
      AmmoHash = {
        {
          AMMO_REVOLVER = 0.25,
          AMMO_REVOLVER_EXPRESS = 0.25,
          AMMO_REVOLVER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REVOLVER_HIGH_VELOCITY = 0.25,
          AMMO_REVOLVER_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {}
      }
    },
    {
      Name =  "Varmint Rifle",
      HashName = "WEAPON_RIFLE_VARMINT",
      WeaponModel = "w_repeater_pumpaction01",
      AmmoHash = {
        {
          AMMO_22 = 0.25
        }
      },
      CompsHash = {
        {
          w_repeater_pumpaction01_wrap1 = 0,
          w_repeater_pumpaction01_sight1 = 0,
          w_repeater_pumpaction01_sight2 = 10,
          w_repeater_pumpaction01_grip1 = 0,
          w_repeater_pumpaction01_grip2 = 10,
          w_repeater_pumpaction01_grip3 = 10,
          w_repeater_pumpaction01_clip1 = 0,
          w_repeater_pumpaction01_clip2 = 10,
          w_repeater_pumpaction01_clip3 = 10
        }
      }
    },
    {
      Name = "Winchester Repeater",
      HashName = "WEAPON_REPEATER_WINCHESTER",
      WeaponModel = "w_repeater_winchester01",
      AmmoHash = {
        {
          AMMO_REPEATER = 0.25,
          AMMO_REPEATER_EXPRESS = 0.25,
          AMMO_REPEATER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REPEATER_HIGH_VELOCITY = 0.25
        }
      },
      CompsHash = {
        {
          w_repeater_winchester01_wrap1 = 0,
          w_repeater_winchester01_sight1 = 0,
          w_repeater_winchester01_sight2 = 10,
          w_repeater_winchester01_grip1 = 0,
          w_repeater_winchester01_grip2 = 10,
          w_repeater_winchester01_grip3 = 10
        }
      }
    },
    {
      Name = "Henry Reapeater",
      HashName = "WEAPON_REPEATER_HENRY",
      WeaponModel = "w_repeater_henry01",
      AmmoHash = {
        {
          AMMO_REPEATER = 0.25,
          AMMO_REPEATER_EXPRESS = 0.25,
          AMMO_REPEATER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REPEATER_HIGH_VELOCITY = 0.25
        }
      },
      CompsHash = {
        {
          w_repeater_henry01_wrap1 = 0,
          w_repeater_henry01_sight1 = 0,
          w_repeater_henry01_sight2 = 10,
          w_repeater_henry01_grip1 = 0,
          w_repeater_henry01_grip2 = 10,
          w_repeater_henry01_grip3 = 10
        }
      }
    },
    {
      Name = "Evans Repeater",
      HashName = "WEAPON_REPEATER_EVANS",
      WeaponModel = "w_repeater_evans01",
      AmmoHash = {
        {
          AMMO_REPEATER = 0.25,
          AMMO_REPEATER_EXPRESS = 0.25,
          AMMO_REPEATER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REPEATER_HIGH_VELOCITY = 0.25
        }
      },
      CompsHash = {
        {
          w_repeater_evans01_wrap1 = 0,
          w_repeater_evans01_sight1 = 0,
          w_repeater_evans01_sight2 = 10,
          w_repeater_evans01_grip1 = 0,
          w_repeater_evans01_grip2 = 10,
          w_repeater_evans01_grip3 = 10
        }
      }
    },
    {
      Name = "Carabine Reapeater",
      HashName = "WEAPON_REPEATER_CARBINE",
      WeaponModel = "w_repeater_carbine01",
      AmmoHash = {
        {
          AMMO_REPEATER = 0.25,
          AMMO_REPEATER_EXPRESS = 0.25,
          AMMO_REPEATER_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_REPEATER_HIGH_VELOCITY = 0.25
        }
      },
      CompsHash = {
        {
          w_repeater_carbine01_wrap1 = 0,
          w_repeater_carbine01_sight1 = 0,
          w_repeater_carbine01_sight2 = 10,
          w_repeater_carbine01_grip1 = 0,
          w_repeater_carbine01_grip2 = 10,
          w_repeater_carbine01_grip3 = 10,
          w_repeater_carbine01_clip1 = 0
        }
      }
    },
    {
      Name = "Rolling Block Rifle",
      HashName = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",
      WeaponModel = "w_rifle_rollingblock01",
      AmmoHash = {
        {
          AMMO_RIFLE = 0.25,
          AMMO_RIFLE_EXPRESS = 0.25,
          AMMO_RIFLE_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_RIFLE_HIGH_VELOCITY = 0.25,
          AMMO_RIFLE_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_rifle_rollingblock01_wrap1 = 0,
          w_rifle_rollingblock01_sight2 = 10,
          w_rifle_rollingblock01_sight1 = 0,
          w_rifle_rollingblock01_grip1 = 0,
          w_rifle_rollingblock01_grip2 = 10,
          w_rifle_rollingblock01_grip3 = 10,
          w_rifle_scopeinner01 = 0,
          w_rifle_scope04 = 10,
          w_rifle_scope03 = 10,
          w_rifle_scope02 = 10,
          w_rifle_cs_strap01 = 0
        }
      }
    },
    {
      Name = "Carcano Rifle",
      HashName = "WEAPON_SNIPERRIFLE_CARCANO",
      WeaponModel = "w_rifle_carcano01",
      AmmoHash = {
        {
          AMMO_RIFLE = 0.25,
          AMMO_RIFLE_EXPRESS = 0.25,
          AMMO_RIFLE_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_RIFLE_HIGH_VELOCITY = 0.25,
          AMMO_RIFLE_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_rifle_carcano01_wrap1 = 0,
          w_rifle_carcano01_sight2 = 10,
          w_rifle_carcano01_sight1 = 0,
          w_rifle_carcano01_grip1 = 0,
          w_rifle_carcano01_grip2 = 10,
          w_rifle_carcano01_grip3 = 10,
          w_rifle_carcano01_clip = 0,
          w_rifle_carcano01_clip2 = 10,
          w_rifle_scopeinner01 = 0,
          w_rifle_scope04 = 10,
          w_rifle_scope03 = 10,
          w_rifle_scope02 = 10,
          w_rifle_cs_strap01 = 0
        }
      }
    },
    {
      Name = "Springfield Rifle",
      HashName = "WEAPON_RIFLE_SPRINGFIELD",
      WeaponModel = "w_rifle_springfield01",
      AmmoHash = {
        {
          AMMO_RIFLE = 0.25,
          AMMO_RIFLE_EXPRESS = 0.25,
          AMMO_RIFLE_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_RIFLE_HIGH_VELOCITY = 0.25,
          AMMO_RIFLE_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_rifle_springfield01_wrap1 = 0,
          w_rifle_springfield01_sight2 = 10,
          w_rifle_springfield01_sight1 = 0,
          w_rifle_springfield01_grip1 = 0,
          w_rifle_springfield01_grip2 = 10,
          w_rifle_springfield01_grip3 = 10,
          w_rifle_scopeinner01 = 0,
          w_rifle_scope04 = 10,
          w_rifle_scope03 = 10,
          w_rifle_scope02 = 10,
          w_rifle_cs_strap01 = 0
        }
      }
    },
    {
      Name = "Elephant Rifle",
      HashName = "WEAPON_RIFLE_ELEPHANT",
      WeaponModel = "weapon_rifle_elephant",
      AmmoHash = {
        {
          AMMO_RIFLE = 0.25,
          AMMO_RIFLE_EXPRESS = 0.25,
          AMMO_RIFLE_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_RIFLE_HIGH_VELOCITY = 0.25,
          AMMO_RIFLE_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {}
      }
    },
    {
      Name = "BoltAction Rifle",
      HashName = "WEAPON_RIFLE_BOLTACTION",
      WeaponModel = "w_rifle_boltaction01",
      AmmoHash = {
        {
          AMMO_RIFLE = 0.25,
          AMMO_RIFLE_EXPRESS = 0.25,
          AMMO_RIFLE_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_RIFLE_HIGH_VELOCITY = 0.25,
          AMMO_RIFLE_SPLIT_POINT = 0.25
        }
      },
      CompsHash = {
        {
          w_rifle_boltaction01_wrap1 = 0,
          w_rifle_boltaction01_sight1 = 0,
          w_rifle_boltaction01_sight2 = 10,
          w_rifle_boltaction01_grip1 = 0,
          w_rifle_boltaction01_grip2 = 10,
          w_rifle_boltaction01_grip3 = 10
        }
      }
    },
    {
      Name = "Semi-Auto Shotgun",
      HashName = "WEAPON_SHOTGUN_SEMIAUTO",
      WeaponModel = "w_shotgun_semiauto01",
      AmmoHash = {
        {
          AMMO_SHOTGUN = 0.25,
          AMMO_SHOTGUN_BUCKSHOT_INCENDIARY = 0.25,
          AMMO_SHOTGUN_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_SHOTGUN_SLUG = 0.25
        }
      },
      CompsHash = {
        {
          w_shotgun_semiauto01_wrap1 = 0,
          w_shotgun_semiauto01_sight1 = 0,
          w_shotgun_semiauto01_sight2 = 10,
          w_shotgun_semiauto01_grip1 = 0,
          w_shotgun_semiauto01_grip2 = 10,
          w_shotgun_semiauto01_grip3 = 10,
          w_shotgun_semiauto01_barrel1 = 0,
          w_shotgun_semiauto01_barrel2 = 10
        }
      }
    },
    {
      Name = "Sawedoff Shotgun",
      HashName = "WEAPON_SHOTGUN_SAWEDOFF",
      WeaponModel = "w_shotgun_sawed01",
      AmmoHash = {
        {
          AMMO_SHOTGUN = 0.25,
          AMMO_SHOTGUN_BUCKSHOT_INCENDIARY = 0.25,
          AMMO_SHOTGUN_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_SHOTGUN_SLUG = 0.25
        }
      },
      CompsHash = {
        {
          w_shotgun_sawed01_wrap1 = 0,
          w_shotgun_sawed01_sight1 = 0,
          w_shotgun_sawed01_sight2 = 10,
          w_shotgun_sawed01_grip1 = 0,
          w_shotgun_sawed01_grip2 = 10,
          w_shotgun_sawed01_grip3 = 10,
          w_shotgun_sawed01_stock1 = 0,
          w_shotgun_sawed01_stock2 = 10,
          w_shotgun_sawed01_stock3 = 10
        }
      }
    },
    {
      Name = "Repeating Shotgun",
      HashName = "WEAPON_SHOTGUN_REPEATING",
      WeaponModel = "w_shotgun_repeating01",
      AmmoHash = {
        {
          AMMO_SHOTGUN = 0.25,
          AMMO_SHOTGUN_BUCKSHOT_INCENDIARY = 0.25,
          AMMO_SHOTGUN_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_SHOTGUN_SLUG = 0.25
        }
      },
      CompsHash = {
        {
          w_shotgun_repeating01_wrap1 = 0,
          w_shotgun_repeating01_sight1 = 0,
          w_shotgun_repeating01_sight2 = 10,
          w_shotgun_repeating01_grip1 = 0,
          w_shotgun_repeating01_grip2 = 10,
          w_shotgun_repeating01_grip3 = 10,
          w_shotgun_repeating01_barrel1 = 0,
          w_shotgun_repeating01_barrel2 = 10
        }
      }
    },
    {
      Name = "Double Barrel Exotic Shotgun",
      HashName = "WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC",
      WeaponModel = "w_shotgun_doublebarrel01",
      AmmoHash = {
        {
          AMMO_SHOTGUN = 0.25,
          AMMO_SHOTGUN_BUCKSHOT_INCENDIARY = 0.25,
          AMMO_SHOTGUN_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_SHOTGUN_SLUG = 0.25
        }
      },
      CompsHash = {
        {
          COMPONENT_REVOLVER_DOUBLEACTION_GRIP_EXOTIC = 0
        }
      }
    },
    {
      Name = "Pump Shotgun",
      HashName = "WEAPON_SHOTGUN_PUMP",
      WeaponModel = "w_shotgun_pumpaction01",
      AmmoHash = {
        {
          AMMO_SHOTGUN = 0.25,
          AMMO_SHOTGUN_BUCKSHOT_INCENDIARY = 0.25,
          AMMO_SHOTGUN_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_SHOTGUN_SLUG = 0.25
        }
      },
      CompsHash = {
        {
          w_shotgun_pumpaction01_wrap1 = 0,
          w_shotgun_pumpaction01_sight1 = 0,
          w_shotgun_pumpaction01_sight2 = 10,
          w_shotgun_pumpaction01_grip1 = 0,
          w_shotgun_pumpaction01_grip2 = 10,
          w_shotgun_pumpaction01_grip3 = 10,
          w_shotgun_pumpaction01_barrel1 = 0,
          w_shotgun_pumpaction01_barrel2 = 10,
          w_shotgun_pumpaction01_clip1 = 0,
          w_shotgun_pumpaction01_clip2 = 10,
          w_shotgun_pumpaction01_clip3 = 10
        }
      }
    },
    {
      Name = "Double Barrel Shotgun",
      HashName = "WEAPON_SHOTGUN_DOUBLEBARREL",
      WeaponModel = "w_shotgun_doublebarrel01",
      AmmoHash = {
        {
          AMMO_SHOTGUN = 0.25,
          AMMO_SHOTGUN_BUCKSHOT_INCENDIARY = 0.25,
          AMMO_SHOTGUN_EXPRESS_EXPLOSIVE = 0.25,
          AMMO_SHOTGUN_SLUG = 0.25
        }
      },
      CompsHash = {
        {
          w_shotgun_doublebarrel01_wrap1 = 0,
          w_shotgun_doublebarrel01_sight1 = 0,
          w_shotgun_doublebarrel01_sight2 = 10,
          w_shotgun_doublebarrel01_grip1 = 0,
          w_shotgun_doublebarrel01_grip2 = 10,
          w_shotgun_doublebarrel01_grip3 = 10,
          w_shotgun_doublebarrel01_barrel1 = 0,
          w_shotgun_doublebarrel01_barrel2 = 10,
          w_shotgun_doublebarrel01_mag1 = 0,
          w_shotgun_doublebarrel01_mag2 = 10,
          w_shotgun_doublebarrel01_mag3 = 10
        }
      }
    },
    {
      Name = "Camera",
      HashName = "WEAPON_KIT_CAMERA",
      WeaponModel = "p_camerabox01x",
      AmmoHash = {},
      CompsHash = {
        {
          w_camera_inner01 = 0
        }
      }
    },
    {
      Name = "Improved Binoculars",
      HashName = "WEAPON_KIT_BINOCULARS_IMPROVED",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Knife Trader",
      HashName = "WEAPON_MELEE_KNIFE_TRADER",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Binoculars",
      HashName = "WEAPON_KIT_BINOCULARS",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Advanced Camera",
      HashName = "WEAPON_KIT_CAMERA_ADVANCED",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Lantern",
      HashName = "WEAPON_MELEE_LANTERN",
      WeaponModel = "" ,
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Davy Lantern",
      HashName = "WEAPON_MELEE_DAVY_LANTERN",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Halloween Lantern",
      HashName = "WEAPON_MELEE_LANTERN_HALLOWEEN",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Poison Bottle",
      HashName = "WEAPON_THROWN_POISONBOTTLE",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Metal Detector",
      HashName = "WEAPON_KIT_METAL_DETECTOR",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Dynamite",
      HashName = "WEAPON_THROWN_DYNAMITE",
      WeaponModel = "w_throw_dynamite01",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Molotov",
      HashName = "WEAPON_THROWN_MOLOTOV",
      WeaponModel = "w_throw_molotov01",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Improved Bow",
      HashName = "WEAPON_BOW_IMPROVED",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Machete Collector",
      HashName = "WEAPON_MELEE_MACHETE_COLLECTOR",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Electric Lantern",
      HashName = "WEAPON_MELEE_LANTERN_ELECTRIC",
      WeaponModel = "s_interact_lantern03x_pickup",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Torch",
      HashName = "WEAPON_MELEE_TORCH",
      WeaponModel = "s_interact_torch",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Moonshine Jug",
      HashName = "WEAPON_MOONSHINEJUG_MP",
      WeaponModel = "s_interact_jug_pickup",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Bolas",
      HashName = "WEAPON_THROWN_BOLAS",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Bolas Hawkmoth",
      HashName = "WEAPON_THROWN_BOLAS_HAWKMOTH",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Bolas Ironspiked",
      HashName = "WEAPON_THROWN_BOLAS_IRONSPIKED",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Bolas Intertwined",
      HashName = "WEAPON_THROWN_BOLAS_INTERTWINED",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {
        {}
      }
    },
    {
      Name = "Fishing Rod",
      HashName = "WEAPON_FISHINGROD",
      WeaponModel = "w_melee_fishingpole02",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Machete Horror",
      HashName = "WEAPON_MACHETE_HORROR",
      WeaponModel = "",
      AmmoHash = {},
      CompsHash = {}
    },
    {
      Name = "Lantern Haloween",
      HashName = "WEAPON_MELEE_LANTERN_HALOWEEN",
      WeaponModel = "" ,
      AmmoHash = {},
      CompsHash = {
        {}
      }
    }
  }
}
