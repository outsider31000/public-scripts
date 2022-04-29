Config = {}

Config.Locale = 'en'

Config.giveItemCount = 10
Config.cooldown = 60 * 1000
Config.MedicLocations = {
    { x = -288.07, y = 804.33, z = 119.39 },
    { x = -1806.03, y = -428.94, z = 158.83 },
    { x = 2721.31, y = -1233.65, z = 50.37}
}
Config.MSG = "You consumed "

Config.medicalitems = {
    {
        ["Name"] = "heroin", 
        ["DisplayName"] = "Heroin", 
        ["Animation"] = "syringe",
        ["PropName"] = "p_bottlemedicine09x",
        ["Metabolism"] = 0,
        ["Hunger"] = 0,
        ["Thirst"] = -5,
        ["InnerCoreStamina"] = 0,
        ["InnerCoreStaminaGold"] = 0,
        ["OuterCoreStaminaGold"] = 0,
        ["InnerCoreHealth"] = 0,
        ["OuterCoreHealth"] = 50,
        ["InnerCoreHealthGold"] = 50.0,
        ["OuterCoreHealthGold"] = 100.0,
        ["diff"] = 5000,
        ["Effect"] = "", -- FX Effect you want to add to the consumable
        ["EffectDuration"] = 0, -- Duration of the effect 10000 = 10 seconds


    }, 

    {
        ["Name"] = "opium", 
        ["DisplayName"] = "Opium", 
        ["Animation"] = "syringe",
        ["PropName"] = "p_bottlemedicine09x",
        ["Metabolism"] = 0,
        ["Hunger"] = 0,
        ["Thirst"] = -5,
        ["InnerCoreStamina"] = 0,
        ["InnerCoreStaminaGold"] = 0,
        ["OuterCoreStaminaGold"] = 0,
        ["InnerCoreHealth"] = 50,
        ["OuterCoreHealth"] = 50,
        ["InnerCoreHealthGold"] = 50.0,
        ["OuterCoreHealthGold"] = 100.0,
        ["diff"] = 10000,
        ["Effect"] = "", -- FX Effect you want to add to the consumable
        ["EffectDuration"] = 0, -- Duration of the effect 10000 = 10 seconds


    }, 
    
    {
        ["Name"] = "bandage", 
        ["DisplayName"] = "Bandage", 
        ["Animation"] = "syringe",
        ["PropName"] = "p_bottlemedicine09x",
        ["Metabolism"] = 0,
        ["Hunger"] = 0,
        ["Thirst"] = 0,
        ["InnerCoreStamina"] = 0,
        ["InnerCoreStaminaGold"] = 0,
        ["OuterCoreStaminaGold"] = 0,
        ["InnerCoreHealth"] = 50,
        ["OuterCoreHealth"] = 0,
        ["InnerCoreHealthGold"] = 0,
        ["OuterCoreHealthGold"] = 0,
        ["diff"] = 5000,
        ["Effect"] = "", -- FX Effect you want to add to the consumable
        ["EffectDuration"] = 0, -- Duration of the effect 10000 = 10 seconds


    }, 


    {
        ["Name"] = "morphine", 
        ["DisplayName"] = "Morphine", 
        ["Animation"] = "syringe",
        ["PropName"] = "p_bottlemedicine09x",
        ["Metabolism"] = 0,
        ["Hunger"] = 0,
        ["Thirst"] = -5,
        ["InnerCoreStamina"] = 0,
        ["InnerCoreStaminaGold"] = 0,
        ["OuterCoreStaminaGold"] = 0,
        ["InnerCoreHealth"] = 50,
        ["OuterCoreHealth"] = 50,
        ["InnerCoreHealthGold"] = 50.0,
        ["OuterCoreHealthGold"] = 50.0,
        ["diff"] = 3000,
        ["Effect"] = "DEADEYE", -- FX Effect you want to add to the consumable
        ["EffectDuration"] = 120000, -- Duration of the effect 10000 = 10 seconds


    },

    {
        ["Name"] = "tylenol", 
        ["DisplayName"] = "Tylenol", 
        ["Animation"] = "syringe",
        ["PropName"] = "p_bottlemedicine09x",
        ["Metabolism"] = 0,
        ["Hunger"] = 0,
        ["Thirst"] = 0,
        ["InnerCoreStamina"] = 0,
        ["InnerCoreStaminaGold"] = 0,
        ["OuterCoreStaminaGold"] = 0,
        ["InnerCoreHealth"] = 10,
        ["OuterCoreHealth"] = 10,
        ["InnerCoreHealthGold"] = 0,
        ["OuterCoreHealthGold"] = 0,
        ["diff"] = 5000,
        ["Effect"] = "DEADEYE", -- FX Effect you want to add to the consumable
        ["EffectDuration"] = 60000, -- Duration of the effect 10000 = 10 seconds


    },

    {
        ["Name"] = "herbmed", 
        ["DisplayName"] = "Herbal Remedy", 
        ["Animation"] = "syringe",
        ["PropName"] = "p_bottlemedicine09x",
        ["Metabolism"] = 0,
        ["Hunger"] = 0,
        ["Thirst"] = 10,
        ["InnerCoreStamina"] = 10,
        ["InnerCoreStaminaGold"] = 10,
        ["OuterCoreStaminaGold"] = 0,
        ["InnerCoreHealth"] = 15,
        ["OuterCoreHealth"] = 15,
        ["InnerCoreHealthGold"] = 50.0,
        ["OuterCoreHealthGold"] = 50.0,
        ["diff"] = 4500,
        ["Effect"] = "", -- FX Effect you want to add to the consumable
        ["EffectDuration"] = 0, -- Duration of the effect 10000 = 10 seconds

    },
}