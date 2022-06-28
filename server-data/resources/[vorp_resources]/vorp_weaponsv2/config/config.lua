Config = {}
Config.keys = {
    -- change the hashes to the keys u want, do not change the writings in qoutes. for example if u wana change B do ["B"] = (CHANGE THIS 0x8AAA0AD4), do not change whats inside those brackets > ["B"]
    ["G"] = 0x760A9C6F,
    ["1"] = 0xE6F612E4,
    ["2"] = 0x1CE6D9EB,
    ["3"] = 0x4F49CC4C,
    ["4"] = 0x8F9F9E58,
}

---------------------- 
Config.syndual = false --- always false 
-----------------------
Config.updatedinventoryammo = true -- use if using updated inventory with new ammo system 

Config.adminwebhook = "https://discord.com/api/webhooks/792119960432148480/pe_FudhkrXZTQsOTRPimLj569T0kwLf4E0RFhLIz1nwe-XTZ_ROFfEIUVxaHOWrSoAEw"
Config.jobonly = true -- only players with mentioned jobs below can access crafting/customization station
Config.job ={ "gunsmith", "rguns"}
Config.jobrankcustomization = 2
Config.jobrankcrafting = 1

Config.weaponshops = true -- endable or disable weapon shops

Config.craftinganimations = "WORLD_HUMAN_CROUCH_INSPECT" -- animation for crafting
Config.customizationanimation = "WORLD_HUMAN_WRITE_NOTEBOOK" -- animations for customizations

Config.customizationLocations = { 
    Valentine = {	   
        Pos = {x= -277.22, y=778.922, z=119.50}, -- location weapon customization station
        Pos2 = {x= -276.47, y=778.922, z=119.80}, -- location spawned weapon 3d model
    },
    Rhodes = {	   
        Pos = {x= 1327.09, y=-1321.91, z=77.88}, -- location weapon customization station
        Pos2 = {x= 1326.09, y=-1321.91, z=78.28}, -- location spawned weapon 3d model
    },
}

Config.craftinglocation = { 
    Valentine = {	   
        Pos = {x= -277.0, y=780.689, z=119.68}, -- location weapon crafting station
    },
    Rhodes = {	   
        Pos = {x= 1329.68, y=-1320.9, z=77.88}, -- location weapon crafting station
    },
}


----------- DO NOT CHANGE THE LABELS IN THE WEPCOMP.JSON FILE ! IF YOU SO YOU WILL BREAK THE SCRIPT!!!!!!!!!!!
Config.customizationcurrency = 0 -- 0 for cash, 1 for gold.
Config.price = {
    variant = 100,
    griptype = 20,
    gripdecal = 10,
    decalframe = 15,
    decalbarrel = 20,
    decalextra = 15,
    wrapcolor = 5,
    sight = 100,
    rifling = 50,
    barrel = 50,
    wrap = 15,
    gold = 40,
    silver = 30,
    bluesteel = 25,
    brownsteel = 25,
    blacksteel = 25,
    copper = 10,
    nickle = 10,
    brass = 10,
    iron = 10
}

---------------------------------------------------------
