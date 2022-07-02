----------------------------------------------------------------------------------------------------
--------------------------------------- CONFIG -----------------------------------------------------
-- VORP INVENTORY LUA*

Config = {

  Debug = false, -- if your server is live set this to false.  to true only if you are testing things
  DevMode = false, -- if your server is live set this to false.  to true only if you are testing things (auto load inventory when script restart and before character selection. Alos add /getInv command)

  defaultlang = "en_lang",

  -- items that dont get added up torwards your max weapon count 
  notweapons = {
    "WEAPON_KIT_BINOCULARS_IMPROVED",
    "WEAPON_KIT_BINOCULARS",
    "WEAPON_FISHINGROD",
    "WEAPON_KIT_CAMERA",
    "WEAPON_kIT_CAMERA_ADVANCED",
    "WEAPON_MELEE_LANTERN",
    "WEAPON_MELEE_DAVY_LANTERN",
    "WEAPON_MELEE_LANTERN_HALLOWEEN",
    "WEAPON_KIT_METAL_DETECTOR",
    "WEAPON_MELEE_HAMMER",
  },
  -- GOLD ITEM LIKE DOLLARS
  UseGoldItem = false, -- IF TRUE YOU HAVE GOLD IN INVENTORY LIKE DOLLARS
  -- CHANGE IN html/js/config.js TOO !!!

  -- DEATH FUNCTIONS
  DisableDeathInventory = true, -- prevent the ability to access inventory while dead

  --{ I } OPEN INVENTORY
  OpenKey = 0xC1989F95,

  --RMB mouse PROMPT PICKUP
  PickupKey = 0xF84FA74F,

  -- LOGS
  webhookavatar = "https://cdn3.iconfinder.com/data/icons/hand/500/Hand_give_thumbs_finger-512.png",
  webhook = "",
  discordid = true, -- turn to true if ur using discord whitelist

  -- WEBHOOK LANGUAGE
  Language = {
    gaveitem = "item transfer",
    gave = " transfered ",
    to = " to ",
    withid = " with the weapon ID: ",
  },

  -- NEED TO TEST
  DropOnRespawn = {
    Money   = false,
    Gold    = false, -- TRUE ONLY IF UseGoldItem = true
    Weapons = false,
    Items   = false
  },

  -- HOW MANY WEAPONS AND ITEMS ALLOWED PER PLAYER
  MaxItemsInInventory = {
    Weapons = 6,
    Items = 200,
  },


  -- FIRST JOIN
  startItems = {
    consumable_raspberrywater = 2, --ITEMS SAME NAME AS IN DATABASE
    ammorevolvernormal = 1 --AMMO SAME NAME AS I NTHE DATABASE
  },

  startWeapons = {
    WEAPON_MELEE_KNIFE = {} --WEAPON HASH NAME
  },

  Ammotypes = { 
    ["416676503"] = {"AMMO_PISTOL","AMMO_PISTOL_EXPRESS","AMMO_PISTOL_EXPRESS_EXPLOSIVE","AMMO_PISTOL_HIGH_VELOCITY","AMMO_PISTOL_SPLIT_POINT"},
    ["-594562071"] = {"AMMO_REPEATER","AMMO_REPEATER_EXPRESS","AMMO_REPEATER_EXPRESS_EXPLOSIVE","AMMO_REPEATER_HIGH_VELOCITY","AMMO_REPEATER_SPLIT_POINT"},
    ["-1101297303"] = {"AMMO_REVOLVER","AMMO_REVOLVER_EXPRESS","AMMO_REVOLVER_EXPRESS_EXPLOSIVE","AMMO_REVOLVER_HIGH_VELOCITY","AMMO_REVOLVER_SPLIT_POINT","AMMO_SHOTGUN","AMMO_SHOTGUN_BUCKSHOT_INCENDIARY","AMMO_SHOTGUN_EXPRESS_EXPLOSIVE","AMMO_SHOTGUN_SLUG"},
    ["970310034"] = {"AMMO_RIFLE","AMMO_RIFLE_ELEPHANT","AMMO_RIFLE_EXPRESS","AMMO_RIFLE_EXPRESS_EXPLOSIVE","AMMO_RIFLE_HIGH_VELOCITY","AMMO_RIFLE_SPLIT_POINT","AMMO_22","AMMO_22_TRANQUILIZER"},
    ["-1212426201"] = {"AMMO_RIFLE","AMMO_RIFLE_EXPRESS","AMMO_RIFLE_EXPRESS_EXPLOSIVE","AMMO_RIFLE_HIGH_VELOCITY","AMMO_RIFLE_SPLIT_POINT"},
    ["860033945"] = {"AMMO_SHOTGUN","AMMO_SHOTGUN_BUCKSHOT_INCENDIARY","AMMO_SHOTGUN_EXPRESS_EXPLOSIVE","AMMO_SHOTGUN_SLUG"},
    ["-1241684019"] = {"AMMO_ARROW","AMMO_ARROW_DYNAMITE","AMMO_ARROW_FIRE","AMMO_ARROW_IMPROVED","AMMO_ARROW_SMALL_GAME","AMMO_ARROW_POISON"},
    ["1548507267"] = {"AMMO_THROWING_KNIVES","AMMO_TOMAHAWK","AMMO_POISONBOTTLE","AMMO_BOLAS","AMMO_BOLAS_HAWKMOTH","AMMO_BOLAS_INTERTWINED","AMMO_BOLAS_IRONSPIKED","AMMO_DYNAMITE","AMMO_DYNAMITE_VOLATILE","AMMO_MOLOTOV","AMMO_MOLOTOV_VOLATILE"}
  },

  maxammo = { -- max ammo allowed to transfer between players
    AMMO_PISTOL = 100,
    AMMO_PISTOL_EXPRESS = 100,
    AMMO_PISTOL_EXPRESS_EXPLOSIVE = 100,
    AMMO_PISTOL_HIGH_VELOCITY = 100,
    AMMO_PISTOL_SPLIT_POINT = 100,
    AMMO_REPEATER = 100,
    AMMO_REPEATER_EXPRESS = 100,
    AMMO_REPEATER_EXPRESS_EXPLOSIVE = 100,
    AMMO_REPEATER_HIGH_VELOCITY = 100,
    AMMO_REPEATER_SPLIT_POINT = 100,
    AMMO_REVOLVER = 100,
    AMMO_REVOLVER_EXPRESS = 100,
    AMMO_REVOLVER_EXPRESS_EXPLOSIVE = 100,
    AMMO_REVOLVER_HIGH_VELOCITY = 100,
    AMMO_REVOLVER_SPLIT_POINT = 100,
    AMMO_RIFLE = 100,
    AMMO_RIFLE_ELEPHANT = 100,
    AMMO_RIFLE_EXPRESS = 100,
    AMMO_RIFLE_EXPRESS_EXPLOSIVE = 100,
    AMMO_RIFLE_HIGH_VELOCITY = 100,
    AMMO_RIFLE_SPLIT_POINT = 100,
    AMMO_22 = 100,
    AMMO_22_TRANQUILIZER = 100,
    AMMO_SHOTGUN = 100,
    AMMO_SHOTGUN_BUCKSHOT_INCENDIARY = 100,
    AMMO_SHOTGUN_EXPRESS_EXPLOSIVE = 100,
    AMMO_SHOTGUN_SLUG = 100,
    AMMO_ARROW = 10,
    AMMO_ARROW_DYNAMITE = 10,
    AMMO_ARROW_FIRE = 10,
    AMMO_ARROW_IMPROVED = 10,
    AMMO_ARROW_SMALL_GAME = 10,
    AMMO_ARROW_POISON = 10,
    AMMO_THROWING_KNIVES = 10,
    AMMO_TOMAHAWK = 10,
    AMMO_POISONBOTTLE = 10,
    AMMO_BOLAS = 10,
    AMMO_BOLAS_HAWKMOTH = 10,
    AMMO_BOLAS_INTERTWINED = 10,
    AMMO_BOLAS_IRONSPIKED = 10,
    AMMO_DYNAMITE = 5,
    AMMO_DYNAMITE_VOLATILE = 5,
    AMMO_MOLOTOV = 5,
    AMMO_MOLOTOV_VOLATILE = 5
  },
  Ammolabels = { -- you can change this to your language
    AMMO_PISTOL = "Normal Pistol",
    AMMO_PISTOL_EXPRESS = "Express Pistol",
    AMMO_PISTOL_EXPRESS_EXPLOSIVE = "Explosives Pistol",
    AMMO_PISTOL_HIGH_VELOCITY = "Velocity Pistol",
    AMMO_PISTOL_SPLIT_POINT = "Splitpoint Pistol",
    AMMO_REPEATER = "Normal Repeater",
    AMMO_REPEATER_EXPRESS = "Express Repeater",
    AMMO_REPEATER_EXPRESS_EXPLOSIVE = "Explosives Repeater",
    AMMO_REPEATER_HIGH_VELOCITY = "Velocity Repeater",
    AMMO_REPEATER_SPLIT_POINT = "Splitpoint Repeater",
    AMMO_REVOLVER = "Normal Revolver",
    AMMO_REVOLVER_EXPRESS = "Express Revolver",
    AMMO_REVOLVER_EXPRESS_EXPLOSIVE = "Explosives Revolver",
    AMMO_REVOLVER_HIGH_VELOCITY = "Velocity Revolver",
    AMMO_REVOLVER_SPLIT_POINT = "Splitpoint Revolver",
    AMMO_RIFLE = "Normal Rifle",
    AMMO_RIFLE_ELEPHANT = "Elephant Rifle",
    AMMO_RIFLE_EXPRESS = "Express Rifle",
    AMMO_RIFLE_EXPRESS_EXPLOSIVE = "Explosives Rifle",
    AMMO_RIFLE_HIGH_VELOCITY = "Velocity Rifle",
    AMMO_RIFLE_SPLIT_POINT = "Splitpoint Rifle",
    AMMO_22 = "22 Rifle",
    AMMO_22_TRANQUILIZER = "22 Tranquilizer Rifle",
    AMMO_SHOTGUN = "Normal Shotgun",
    AMMO_SHOTGUN_BUCKSHOT_INCENDIARY = "Incendiary Shotgun",
    AMMO_SHOTGUN_EXPRESS_EXPLOSIVE = "Explosive Shotgun",
    AMMO_SHOTGUN_SLUG = "Slug Shotgun",
    AMMO_ARROW = "Normal Arrows",
    AMMO_ARROW_DYNAMITE = "Dynamite Arrows",
    AMMO_ARROW_FIRE = "Fire Arrows",
    AMMO_ARROW_IMPROVED = "Improved Arrows",
    AMMO_ARROW_SMALL_GAME = "Small Game Arrows",
    AMMO_ARROW_POISON = "Poison Arrows",
    AMMO_THROWING_KNIVES = "Throwing Knives",
    AMMO_TOMAHAWK = "Tomahawk",
    AMMO_POISONBOTTLE = "Poison Bottle",
    AMMO_BOLAS = "Bolas",
    AMMO_BOLAS_HAWKMOTH = "Hawkmoth Bolas",
    AMMO_BOLAS_INTERTWINED = "Intertwined Bolas",
    AMMO_BOLAS_IRONSPIKED = "Ironspiked Bolas",
    AMMO_DYNAMITE = "Dynamite",
    AMMO_DYNAMITE_VOLATILE = 'Volatile Dynamite',
    AMMO_MOLOTOV = "Molotov",
    AMMO_MOLOTOV_VOLATILE = "Volatile Molotov"
  },
  --DON'T TOUCH BESIDES NAME OF WEAPON
  Weapons = {
    {
      Name     = "Lasso", -- TRANSLATE NAME ONLY
      Desc     = "An annoyingly useful rope", -- CHANGE DESCRIPTION ONLY
      HashName = "WEAPON_LASSO", -- DONT TOUCH
    },
    {
      Name     = "Reinforced Lasso",
      Desc     = "A super annoyingly useful role",
      HashName = "WEAPON_LASSO_REINFORCED",
    },
    {
      Name = "Knife",
      Desc = "Knife used mainly for skinning animals",
      HashName = "WEAPON_MELEE_KNIFE",
    },
    {
      Name = "Knife Rustic",
      Desc = "old looking knife, could it be still useful ?",
      HashName = "WEAPON_MELEE_KNIFE_RUSTIC",
    },
    {
      Name = "Knife Horror",
      Desc = "This knife was used to do plenty of unpleasant things",
      HashName = "WEAPON_MELEE_KNIFE_HORROR",
    },
    {
      Name = "Knife Civil War",
      Desc = "A knife with a lot of history",
      HashName = "WEAPON_MELEE_KNIFE_CIVIL_WAR",
    },
    {
      Name = "Knife Jawbone",
      Desc = "A knife made of ancient bones",
      HashName = "WEAPON_MELEE_KNIFE_JAWBONE",
    },
    {
      Name = "Knife Miner",
      Desc = "Miners bestfriend",
      HashName = "WEAPON_MELEE_KNIFE_MINER",
    },
    {
      Name = "Knife Vampire",
      Desc = "They cant be real...",
      HashName = "WEAPON_MELEE_KNIFE_VAMPIRE",
    },
    {
      Name = "Cleaver",
      Desc = "Scary looking but useful",
      HashName = "WEAPON_MELEE_CLEAVER",
    },
    {
      Name = "Hachet",
      Desc = "A piece of wood with a blade",
      HashName = "WEAPON_MELEE_HATCHET",
    },
    {
      Name = "Hachet Double Bit",
      Desc = "A Piece of wood with twice the blade",
      HashName = "WEAPON_MELEE_HATCHET_DOUBLE_BIT",
    },
    {
      Name = "Hachet Hewing",
      Desc = "Some say this hatchet is magical",
      HashName = "WEAPON_MELEE_HATCHET_HEWING",
    },
    {
      Name = "Hachet Hunter",
      Desc = "A Hunters bestfriend",
      HashName = "WEAPON_MELEE_HATCHET_HUNTER",
    },
    {
      Name = "Hachet Viking",
      Desc = "Smells of fish and salt",
      HashName = "WEAPON_MELEE_HATCHET_VIKING",
    },
    {
      Name = "Tomahawk",
      Desc = "A weapon befitting a warrior",
      HashName = "WEAPON_THROWN_TOMAHAWK",
    },
    {
      Name = "Tomahawk Ancient",
      Desc = "This one is Ancient",
      HashName = "WEAPON_THROWN_TOMAHAWK_ANCIENT",
    },
    {
      Name = "Throwing Knifes",
      Desc = "Folks love playing with these",
      HashName = "WEAPON_THROWN_THROWING_KNIVES",

    },
    {
      Name = "Machete",
      Desc = "Useful in the jungle",
      HashName = "WEAPON_MELEE_MACHETE",
    },
    {
      Name = "Bow",
      Desc = "A Simple but effective weapon",
      HashName = "WEAPON_BOW",
    },
    {
      Name = "Pistol Semi-Auto",
      Desc = "repeating single-chamber handgun",
      HashName = 'WEAPON_PISTOL_SEMIAUTO',
    },
    {
      Name = "Pistol Mauser",
      Desc = "semi-automatic pistol that was originally produced by German arms manufacturer Mauser",
      HashName = "WEAPON_PISTOL_MAUSER",
    },
    {
      Name = "Pistol Volcanic",
      Desc = " an improved version of the Rocket Ball ammunition",
      HashName = "WEAPON_PISTOL_VOLCANIC",
    },
    {
      Name = "Pistol M1899",
      Desc = "its magazine-loaded ammunition allows for a swift reload",
      HashName = "WEAPON_PISTOL_M1899",
    },
    {
      Name = "Revolver Schofield",
      Desc = "single-action, cartridge-firing, top-break revolver",
      HashName = "WEAPON_REVOLVER_SCHOFIELD",
    },
    {
      Name = "Revolver Navy",
      Desc = "cap and ball revolver that was designed by Samuel Colt",
      HashName = "WEAPON_REVOLVER_NAVY",
    },
    {
      Name = "Revolver Navy Crossover",
      Desc = "DESC IN config.lua",
      HashName = "WEAPON_REVOLVER_NAVY_CROSSOVER",
    },
    {
      Name = "Revolver Lemat",
      Desc = "a revolver that is also a shotgun",
      HashName = "WEAPON_REVOLVER_LEMAT",
    },
    {
      Name = "Revolver Double Action",
      Desc = "has a trigger that both cocks the hammer and releases it in one pull ",
      HashName = "WEAPON_REVOLVER_DOUBLEACTION",
    },
    {
      Name = "Revolver Cattleman",
      Desc = "A cowboys bestfriend",
      HashName = "WEAPON_REVOLVER_CATTLEMAN",
    },
    {
      Name = "Revolver Cattleman mexican",
      Desc = "a different flavor",
      HashName = "WEAPON_REVOLVER_CATTLEMAN_MEXICAN",
    },
    {
      Name = "Varmint Rifle",
      Desc = "A rifle useful for hunting critters",
      HashName = "WEAPON_RIFLE_VARMINT",

    },
    {
      Name = "Winchester Repeater",
      Desc = "lever-action repeating rifles manufactured by the Winchester Repeating Arms Company",
      HashName = "WEAPON_REPEATER_WINCHESTER",

    },
    {
      Name = "Henry Reapeater",
      Desc = " lever-action tubular magazine rifle",
      HashName = "WEAPON_REPEATER_HENRY",

    },
    {
      Name = "Evans Repeater",
      Desc = "a lever-action repeating rifle designed by Warren R. Evans as a high capacity rifle",
      HashName = "WEAPON_REPEATER_EVANS",

    },
    {
      Name = "Carabine Reapeater",
      Desc = "A reliable and popular repeating rifle, the Buck Carbine provides medium damage and a decent firing rate",
      HashName = "WEAPON_REPEATER_CARBINE",
    },
    {
      Name = "Rolling Block Rifle",
      Desc = "Remington Rolling Block is a family of breech-loading rifles",
      HashName = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",
    },
    {
      Name = "Carcano Rifle",
      Desc = "The Carcano is an Italian, bolt action rifle",
      HashName = "WEAPON_SNIPERRIFLE_CARCANO",
    },
    {
      Name = "Springfield Rifle",
      Desc = "Army's standard issue rifle",
      HashName = "WEAPON_RIFLE_SPRINGFIELD",
    },
    {
      Name = "Elephant Rifle",
      Desc = "Best Weapon for a hunter looking to take down large prey",
      HashName = "WEAPON_RIFLE_ELEPHANT",
    },
    {
      Name = "BoltAction Rifle",
      Desc = "manual firearm action that is operated by directly manipulating the bolt",
      HashName = "WEAPON_RIFLE_BOLTACTION",
    },
    {
      Name = "Semi-Auto Shotgun",
      Desc = "a repeating shotgun with a semi-automatic action, capable of automatically chambering a new shell",
      HashName = "WEAPON_SHOTGUN_SEMIAUTO",
    },
    {
      Name = "Sawedoff Shotgun",
      Desc = "shotgun with a shorter gun barre",
      HashName = "WEAPON_SHOTGUN_SAWEDOFF",
    },
    {
      Name = "Repeating Shotgun",
      Desc = "The Lancaster Repeating Shotgun",
      HashName = "WEAPON_SHOTGUN_REPEATING",
    },
    {
      Name = "Double Barrel Exotic Shotgun",
      Desc = "exotic-rarity variant of the Double Barrel Shotgun",
      HashName = "WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC",
    },
    {
      Name = "Pump Shotgun",
      Desc = "repeating firearm action that is operated manually by moving a sliding handguard",
      HashName = "WEAPON_SHOTGUN_PUMP",

    },
    {
      Name = "Double Barrel Shotgun",
      Desc = "break-action shotgun with two parallel barrels, allowing two single shots to be fired in quick succession",
      HashName = "WEAPON_SHOTGUN_DOUBLEBARREL",
    },
    {
      Name = "Camera",
      Desc = "a journalists bestfriend",
      HashName = "WEAPON_KIT_CAMERA",
    },
    {
      Name = "Improved Binoculars",
      Desc = "See things clearly !",
      HashName = "WEAPON_KIT_BINOCULARS_IMPROVED",
    },
    {
      Name = "Knife Trader",
      Desc = "a traders bestfriend",
      HashName = "WEAPON_MELEE_KNIFE_TRADER",
    },
    {
      Name = "Binoculars",
      Desc = "lets you see far things",
      HashName = "WEAPON_KIT_BINOCULARS",
    },
    {
      Name = "Advanced Camera",
      Desc = "a camera thats slightly technologicaly better",
      HashName = "WEAPON_KIT_CAMERA_ADVANCED",
    },
    {
      Name = "Lantern",
      Desc = "lets you see better in the dark",
      HashName = "WEAPON_MELEE_LANTERN",
    },
    {
      Name = "Davy Lantern",
      Desc = "safety lamp for use in flammable atmospheres",
      HashName = "WEAPON_MELEE_DAVY_LANTERN",
    },
    {
      Name = "Halloween Lantern",
      Desc = "made with a real human skull",
      HashName = "WEAPON_MELEE_LANTERN_HALLOWEEN",
    },
    {
      Name = "Poison Bottle",
      Desc = "who knows whats in this thing",
      HashName = "WEAPON_THROWN_POISONBOTTLE",
    },
    {
      Name = "Metal Detector",
      Desc = "helps you find valuables",
      HashName = "WEAPON_KIT_METAL_DETECTOR",
    },
    {
      Name = "Dynamite",
      Desc = "boomstick",
      HashName = "WEAPON_THROWN_DYNAMITE",

    },
    {
      Name = "Molotov",
      Desc = "an arsonists bestfriend",
      HashName = "WEAPON_THROWN_MOLOTOV",

    },
    {
      Name = "Improved Bow",
      Desc = "a bow with better accuracy",
      HashName = "WEAPON_BOW_IMPROVED",
    },
    {
      Name = "Machete Collector",
      Desc = "every collector needs one",
      HashName = "WEAPON_MELEE_MACHETE_COLLECTOR",
    },
    {
      Name = "Electric Lantern",
      Desc = "a marvel of technology",
      HashName = "WEAPON_MELEE_LANTERN_ELECTRIC",
    },
    {
      Name = "Torch",
      Desc = "your basic stick on fire",
      HashName = "WEAPON_MELEE_TORCH",
    },
    {
      Name = "Moonshine Jug",
      Desc = "those are very fun",
      HashName = "WEAPON_MOONSHINEJUG_MP",

    },
    {
      Name = "Bolas",
      Desc = "every badass cowboy needs one",
      HashName = "WEAPON_THROWN_BOLAS",
    },
    {
      Name = "Bolas Hawkmoth",
      Desc = "a bola with a twist",
      HashName = "WEAPON_THROWN_BOLAS_HAWKMOTH",
    },
    {
      Name = "Bolas Ironspiked",
      Desc = "a more edgy bola",
      HashName = "WEAPON_THROWN_BOLAS_IRONSPIKED",

    },
    {
      Name = "Bolas Intertwined",
      Desc = "a stronger bola",
      HashName = "WEAPON_THROWN_BOLAS_INTERTWINED",

    },
    {
      Name = "Fishing Rod",
      Desc = "whats better than catching fish",
      HashName = "WEAPON_FISHINGROD",
    },
    {
      Name = "Machete Horror",
      Desc = "this one scares people",
      HashName = "WEAPON_MACHETE_HORROR",
    },
    {
      Name = "Lantern Haloween",
      Desc = "made with a real human skull",
      HashName = "WEAPON_MELEE_LANTERN_HALOWEEN",

    },
    {
      Name = "Hammer",
      Desc = "Richards Hammer!",
      HashName = "WEAPON_MELEE_HAMMER",

    }
  }
}
