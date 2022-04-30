Config5 = {}

Config5.weaponshops = { -- money for houses bought goes here. sellers have it to collected from here. 
    Valentine = {	   -- you can add more wep markets by copy pasting this 
        Pos = {x=-281.0, y=780.7, z=119.52}, -- location of wep market 
        blipsprite = 202506373, -- blip sprite for wep market
        showblip = true, -- show blip or not 
        Name = 'Weapons Shop', -- blip name 
        weapons = {
            ["Melee"] = {
                ["Tradders Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_TRADER",
                    price = 5,    
                
                },
                ["Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE",  
                    price = 5,      
                
                },
                ["JawBone Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_JAWBONE",  
                    price = 2,   
                
                },
                ["Cleaver"] = {	
                    hashname = "WEAPON_MELEE_CLEAVER",    
                    price = 2, 
                
                },
                ["Hunter Hatchet"] = {	
                    hashname = "WEAPON_MELEE_HATCHET_HUNTER",  
                    price = 8,   
                },
                ["Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE",   
                    price = 5.5,  
                },
                ["Collector Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE_COLLECTOR",   
                    price = 5.5,  
                },
            },
            ["Bows"] = {
                ["Bow"] = {	
                    hashname = "WEAPON_BOW",    
                    price = 10.75, 
                
                },
               --[[  ["Improved Bow"] = {	
                    hashname = "WEAPON_BOW_IMPROVED",   
                    price = 15,  
                
                }, ]]
            },
            ["Rifles"] = {
                ["Elephant Rifle"] = {	
                    hashname = "WEAPON_RIFLE_ELEPHANT",  
                    price = 400,   
                
                },
                ["Varmint Rifle"] = {	
                    hashname = "WEAPON_RIFLE_VARMINT",   
                    price = 30.75,  
                
                },
                ["Rollingblock Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",    
                    price = 1000, 
                
                },
                ["Carcano Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_CARCANO",  
                    price = 1000,   
                
                },
                ["Springfield Rifle"] = {	
                    hashname = "WEAPON_RIFLE_SPRINGFIELD", 
                    price = 1000,    
                
                },
                ["Boltaction Rifle"] = {	
                    hashname = "WEAPON_RIFLE_BOLTACTION",    
                    price = 250, 
                
                },
            },
            ["Repeaters"] = {
                ["Winchester Repeater"] = {	
                    hashname = "WEAPON_REPEATER_WINCHESTER",   
                    price = 70,  
                
                },
                ["Henry Repeater"] = {	
                    hashname = "WEAPON_REPEATER_HENRY",    
                    price = 75.5, 
                
                },
                ["Evans Repeater"] = {	
                    hashname = "WEAPON_REPEATER_EVANS",    
                    price = 80, 
                
                },
                ["Carbine Repeater"] = {	
                    hashname = "WEAPON_REPEATER_CARBINE",    
                    price = 50, 
                
                },
            },
            ["Pistols"] = {
                ["Volcanic Pistol "] = {	
                    hashname = "WEAPON_PISTOL_VOLCANIC",    
                    price = 1000, 
                
                },
                ["M1899 Pistol "] = {	
                    hashname = "WEAPON_PISTOL_M1899",    
                    price = 10000, 
                
                },
               --[[  ["SemiAuto Pistol "] = {	
                    hashname = "WEAPON_PISTOL_SEMIAUTO",    
                    price = 1000, 
                
                }, ]]
             --[[    ["Mauser Pistol "] = {	
                    hashname = "WEAPON_PISTOL_MAUSER",    
                    price = 1000, 
                
                },
                 ]]

            },
            ["Revolvers"] = {
                ["Schofield Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_SCHOFIELD",    
                    price = 50, 
                
                },
                ["Lemat Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_LEMAT",    
                    price = 40, 
                
                },
                ["Double Action Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_DOUBLEACTION",    
                    price = 55, 
                
                },
                ["Cattleman Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_CATTLEMAN",    
                    price = 25, 
                
                },
                ["Navy Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_NAVY",    
                    price = 60, 
                
                },
            },
            ["Throwable"] = { -- Due to vorp bug, using this weapon never runs out of ammo if u requip. 
            -- in order for throwables to work. the player must buy the throwable weapon then buy and use the related ammo box
            -- only then will the throwable show up in their weapon wheel 
                ["Tomahawk"] = {	
                    hashname = "WEAPON_THROWN_TOMAHAWK",    
                    price = 10, 
                
                },
                ["Knives"] = {	
                    hashname = "WEAPON_THROWN_THROWING_KNIVES",    
                    price = 8, 
                
                },
                ["Poison Bottle"] = {	
                    hashname = "WEAPON_THROWN_POISONBOTTLE",    
                    price = 15, 
                
                },
                ["Bolas"] = {	
                    hashname = "WEAPON_THROWN_BOLAS",    
                    price = 4, 
                
                },
               --[[  ["Dynamite"] = {	
                    hashname = "WEAPON_THROWN_DYNAMITE",    
                    price = 100, 
                
                },
                ["Molotov"] = {	
                    hashname = "WEAPON_THROWN_MOLOTOV",    
                    price = 100, 
                
                }, ]]

            },
            ["Shotguns"] = {
                --[[ ["Semiauto Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SEMIAUTO",    
                    price = 100, 
                
                }, ]]
                ["Sawedoff Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SAWEDOFF",    
                    price = 250, 
                
                },
                ["Repeating Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_REPEATING",    
                    price = 1000, 
                
                },
                ["Pump Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_PUMP",    
                    price = 1000, 
                
                },
                ["Doublebarrel Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_DOUBLEBARREL",    
                    price = 500, 
                
                },
            },
            ["Misc."] = {
                ["Lasso"] = {	
                    hashname = "WEAPON_LASSO",    
                    price = 2, 
                
                },
                ["Reinforced Lasso"] = {	
                    hashname = "WEAPON_LASSO_REINFORCED",    
                    price = 10, 
                
                },
                ["Improved Binoculars"] = {	
                    hashname = "WEAPON_KIT_BINOCULARS_IMPROVED",    
                    price = 10, 
                
                },
                ["Binoculars"] = {	
                    hashname = "WEAPON_kIT_BINOCULARS",    
                    price = 5, 
                
                },
                ["Fishing Rod"] = {	
                    hashname = "WEAPON_FISHINGROD",    
                    price = 3, 
                
                },
                ["Camera"] = {	
                    hashname = "WEAPON_KIT_CAMERA",    
                    price = 40, 
                
                },
                ["Advanced Camera"] = {	
                    hashname = "WEAPON_kIT_CAMERA_ADVANCED",    
                    price = 200, 
                
                },
                ["Lantern"] = {	
                    hashname = "WEAPON_MELEE_LANTERN",    
                    price = 9.75, 
                
                },
                ["Davy Lantern"] = {	
                    hashname = "WEAPON_MELEE_DAVY_LANTERN",    
                    price = 15, 
                
                },
            },
        }, 
        ammo = {
            ["Repeater"] = {
                ["Repeater Ammo Normal"] = {
                    price = 1, 
                    item = "ammorepeaternormal",
                },
                ["Repeater Ammo Express"] = {
                    price = 2, 
                    item = "ammorepeaterexpress",
                    
                },
                --[[ ["Repeater Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorepeaterexplosive",
                    
                }, ]]
                ["Repeater Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorepeatervelocity",
                    
                },
                ["Repeater Ammo Splitpoint"] = {
                    
                    price = 8, 
                    item = "ammorepeatersplitpoint",
                   
                },
            },

            ["Revolver"] = {
                ["Revolver Ammo Normal"] = {
                   
                    price = 1, 
                    item = "ammorevolvernormal",
                    
                },
                ["Revolver Ammo Express"] = {
                    
                    price = 2, 
                    item = "ammorevolverexpress",
                    
                },
               --[[  ["Revolver Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammorevolverexplosive",
                    
                }, ]]
                ["Revolver Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorevolvervelocity",
                    
                },
                ["Revolver Ammo Splitpoint"] = {
                   
                    price = 8, 
                    item = "ammorevolversplitpoint",
                   
                },

            },
            ["Rifle"] = {
                ["Rifle Ammo Normal"] = {
                    
                    price = 1, 
                    item = "ammoriflenormal",
                    
                },
                ["Elephant Rifle Ammo"] = {
                    
                    price = 10, 
                    item = "ammoelephant",
                    
                },
                ["Rifle Ammo Express"] = {
                   
                    price = 5, 
                    item = "ammorifleexpress",
                    
                },
               --[[  ["Rifle Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorifleexplosive",
                    
                }, ]]
                ["Rifle Ammo Velocity"] = {
                   
                    price = 5, 
                    item = "ammoriflevelocity",
                   
                },
                ["Rifle Ammo Splitpoint"] = {
                    
                    price = 8, 
                    item = "ammoriflesplitpoint",
                   
                },

            },
            ["Shotgun"] = {
               --[[  ["Shotgun Ammo Incendiary"] = {
                   
                    price = 5, 
                    item = "ammoshotgunincendiary",
                   
                }, ]]
                --[[ ["Shotgun Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammoshotgunexplosive",
                    
                }, ]]
                ["Shotgun Ammo Normal"] = {
                   
                    price = 1, 
                    item = "ammoshotgunnormal",
                    
                },
                ["Shotgun Ammo Slug"] = {
                   
                    price = 2, 
                    item = "ammoshotgunslug",
                   
                },
            },
            ["Pistol"] = {
                ["Pistol Ammo Normal"] = {
                   
                    price = 1, 
                    item = "ammopistolnormal",
                    
                },
                ["Pistol Ammo Express"] = {
                   
                    price = 2, 
                    item = "ammopistolexpress",
                    
                },
               --[[  ["Pistol Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammopistolexplosive",
                    
                }, ]]
                ["Pistol Ammo Velocity"] = {
                   
                    price = 5, 
                    item = "ammopistolvelocity",
                    
                },
                ["Pistol Ammo Splitpoint"] = {
                   
                    price = 8, 
                    item = "ammopistolsplitpoint",
                   
                },

            },
            ["Arrow"] = {
                ["Arrow Normal"] = {
                   
                    price = .5, 
                    item = "ammoarrmownormal",
                    
                },
                --[[ ["Arrow Dynamite"] = {
                    
                    price = 5, 
                    item = "ammoarrowdynamite",
                    
                }, ]]
               --[[  ["Arrow Fire"] = {
                   
                    price = 2, 
                    item = "ammoarrowfire",
                    
                }, ]]
               --[[  ["Arrow Improved"] = {
                  
                    price = 3, 
                    item = "ammoarrowimproved",
                    
                }, ]]
                ["Arrow Small Game"] = {
                   
                    price = .25, 
                    item = "ammoarrowsmallgame",
                    
                },
                --[[ ["Arrow Poison"] = {
                   
                    price = 5, 
                    item = "ammoarrowpoison",
                    
                }, ]]

            },
            ["Varmint Ammo"] = {
                ["Varmint ammo"] = {
                   
                    price = 1, 
                    item = "ammovarmint",
                    
                },
                --[[ ["Varmint Tranquilizer Ammo"] = {
                    
                    price = 5, 
                    item = "ammovarminttranq",
                    
                }, ]]

            },
            ["Throwing"] = {
                ["Knives ammo"] = {
                    
                    price = 2, 
                    item = "ammoknives",
                    
                },
                ["Tomahawk Ammo"] = {
                   
                    price = 2, 
                    item = "ammotomahawk",
                   
                },
                --[[ ["Poison Bottle Ammo"] = {
                   
                    price = 5, 
                    item = "ammopoisonbottle",
                   
                }, ]]
                ["Bolla Ammo"] = {
                   
                    price = 1, 
                    item = "ammobolla",
                    
                },
                --[[ ["Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammodynamite",
                    
                }, ]]
               --[[  ["Volatile Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammovoldynamite",
                    
                }, ]]
               --[[  ["Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammomolotov",
                   
                }, ]]
               --[[  ["Volatile Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammovolmolotov",
                   
                }, ]]

            },

        }
    },
    ---------------------------
    SaintD = {	  
        Pos = {x=2716.73, y=-1285.27, z=49.63}, 
        blipsprite = 202506373,
        showblip = true,
        Name = 'Weapons Shop', 
        weapons = {
            ["Melee"] = {
                ["Tradders Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_TRADER",
                    price = 5,    
                
                },
                ["Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE",  
                    price = 5,      
                
                },
                ["JawBone Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_JAWBONE",  
                    price = 2,   
                
                },
                ["Cleaver"] = {	
                    hashname = "WEAPON_MELEE_CLEAVER",    
                    price = 2, 
                
                },
                ["Hunter Hatchet"] = {	
                    hashname = "WEAPON_MELEE_HATCHET_HUNTER",  
                    price = 8,   
                },
                ["Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE",   
                    price = 5.5,  
                },
                ["Collector Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE_COLLECTOR",   
                    price = 5.5,  
                },
            },
            ["Bows"] = {
                ["Bow"] = {	
                    hashname = "WEAPON_BOW",    
                    price = 10.75, 
                
                },
               --[[  ["Improved Bow"] = {	
                    hashname = "WEAPON_BOW_IMPROVED",   
                    price = 15,  
                
                }, ]]
            },
            ["Rifles"] = {
                ["Elephant Rifle"] = {	
                    hashname = "WEAPON_RIFLE_ELEPHANT",  
                    price = 400,   
                
                },
                ["Varmint Rifle"] = {	
                    hashname = "WEAPON_RIFLE_VARMINT",   
                    price = 30.75,  
                
                },
                ["Rollingblock Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",    
                    price = 1000, 
                
                },
                ["Carcano Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_CARCANO",  
                    price = 1000,   
                
                },
                ["Springfield Rifle"] = {	
                    hashname = "WEAPON_RIFLE_SPRINGFIELD", 
                    price = 1000,    
                
                },
                ["Boltaction Rifle"] = {	
                    hashname = "WEAPON_RIFLE_BOLTACTION",    
                    price = 250, 
                
                },
            },
            ["Repeaters"] = {
                ["Winchester Repeater"] = {	
                    hashname = "WEAPON_REPEATER_WINCHESTER",   
                    price = 70,  
                
                },
                ["Henry Repeater"] = {	
                    hashname = "WEAPON_REPEATER_HENRY",    
                    price = 75.5, 
                
                },
                ["Evans Repeater"] = {	
                    hashname = "WEAPON_REPEATER_EVANS",    
                    price = 80, 
                
                },
                ["Carbine Repeater"] = {	
                    hashname = "WEAPON_REPEATER_CARBINE",    
                    price = 50, 
                
                },
            },
            ["Pistols"] = {
                ["Volcanic Pistol "] = {	
                    hashname = "WEAPON_PISTOL_VOLCANIC",    
                    price = 1000, 
                
                },
                ["M1899 Pistol "] = {	
                    hashname = "WEAPON_PISTOL_M1899",    
                    price = 10000, 
                
                },
               --[[  ["SemiAuto Pistol "] = {	
                    hashname = "WEAPON_PISTOL_SEMIAUTO",    
                    price = 1000, 
                
                }, ]]
             --[[    ["Mauser Pistol "] = {	
                    hashname = "WEAPON_PISTOL_MAUSER",    
                    price = 1000, 
                
                },
                 ]]

            },
            ["Revolvers"] = {
                ["Schofield Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_SCHOFIELD",    
                    price = 50, 
                
                },
                ["Lemat Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_LEMAT",    
                    price = 40, 
                
                },
                ["Double Action Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_DOUBLEACTION",    
                    price = 55, 
                
                },
                ["Cattleman Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_CATTLEMAN",    
                    price = 25, 
                
                },
                ["Navy Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_NAVY",    
                    price = 60, 
                
                },
            },
            ["Throwable"] = { -- Due to vorp bug, using this weapon never runs out of ammo if u requip. 
            -- in order for throwables to work. the player must buy the throwable weapon then buy and use the related ammo box
            -- only then will the throwable show up in their weapon wheel 
                ["Tomahawk"] = {	
                    hashname = "WEAPON_THROWN_TOMAHAWK",    
                    price = 10, 
                
                },
                ["Knives"] = {	
                    hashname = "WEAPON_THROWN_THROWING_KNIVES",    
                    price = 8, 
                
                },
                ["Poison Bottle"] = {	
                    hashname = "WEAPON_THROWN_POISONBOTTLE",    
                    price = 15, 
                
                },
                ["Bolas"] = {	
                    hashname = "WEAPON_THROWN_BOLAS",    
                    price = 4, 
                
                },
               --[[  ["Dynamite"] = {	
                    hashname = "WEAPON_THROWN_DYNAMITE",    
                    price = 100, 
                
                },
                ["Molotov"] = {	
                    hashname = "WEAPON_THROWN_MOLOTOV",    
                    price = 100, 
                
                }, ]]

            },
            ["Shotguns"] = {
                --[[ ["Semiauto Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SEMIAUTO",    
                    price = 100, 
                
                }, ]]
                ["Sawedoff Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SAWEDOFF",    
                    price = 250, 
                
                },
                ["Repeating Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_REPEATING",    
                    price = 1000, 
                
                },
                ["Pump Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_PUMP",    
                    price = 1000, 
                
                },
                ["Doublebarrel Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_DOUBLEBARREL",    
                    price = 500, 
                
                },
            },
            ["Misc."] = {
                ["Lasso"] = {	
                    hashname = "WEAPON_LASSO",    
                    price = 2, 
                
                },
                ["Reinforced Lasso"] = {	
                    hashname = "WEAPON_LASSO_REINFORCED",    
                    price = 10, 
                
                },
                ["Improved Binoculars"] = {	
                    hashname = "WEAPON_KIT_BINOCULARS_IMPROVED",    
                    price = 10, 
                
                },
                ["Binoculars"] = {	
                    hashname = "WEAPON_kIT_BINOCULARS",    
                    price = 5, 
                
                },
                ["Fishing Rod"] = {	
                    hashname = "WEAPON_FISHINGROD",    
                    price = 3, 
                
                },
                ["Camera"] = {	
                    hashname = "WEAPON_KIT_CAMERA",    
                    price = 40, 
                
                },
                ["Advanced Camera"] = {	
                    hashname = "WEAPON_kIT_CAMERA_ADVANCED",    
                    price = 200, 
                
                },
                ["Lantern"] = {	
                    hashname = "WEAPON_MELEE_LANTERN",    
                    price = 9.75, 
                
                },
                ["Davy Lantern"] = {	
                    hashname = "WEAPON_MELEE_DAVY_LANTERN",    
                    price = 15, 
                
                },
            },
        }, 
        ammo = {
            ["Repeater"] = {
                ["Repeater Ammo Normal"] = {
                    price = 1, 
                    item = "ammorepeaternormal",
                },
                ["Repeater Ammo Express"] = {
                    price = 2, 
                    item = "ammorepeaterexpress",
                    
                },
             --[[    ["Repeater Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorepeaterexplosive",
                    
                }, ]]
                ["Repeater Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorepeatervelocity",
                    
                },
                ["Repeater Ammo Splitpoint"] = {
                    
                    price = 8, 
                    item = "ammorepeatersplitpoint",
                   
                },
            },

            ["Revolver"] = {
                ["Revolver Ammo Normal"] = {
                   
                    price = 1, 
                    item = "ammorevolvernormal",
                    
                },
                ["Revolver Ammo Express"] = {
                    
                    price = 2, 
                    item = "ammorevolverexpress",
                    
                },
               --[[  ["Revolver Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammorevolverexplosive",
                    
                }, ]]
                ["Revolver Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorevolvervelocity",
                    
                },
                ["Revolver Ammo Splitpoint"] = {
                   
                    price = 8, 
                    item = "ammorevolversplitpoint",
                   
                },

            },
            ["Rifle"] = {
                ["Rifle Ammo Normal"] = {
                    
                    price = 2, 
                    item = "ammoriflenormal",
                    
                },
                --[[ ["Elephant Rifle Ammo"] = {
                    
                    price = 5, 
                    item = "ammoelephant",
                    
                }, ]]
                ["Rifle Ammo Express"] = {
                   
                    price = 8, 
                    item = "ammorifleexpress",
                    
                },
                --[[ ["Rifle Ammo Explosive"] = {
                    
                    price = 10, 
                    item = "ammorifleexplosive",
                    
                }, ]]
                ["Rifle Ammo Velocity"] = {
                   
                    price = 12, 
                    item = "ammoriflevelocity",
                   
                },
                ["Rifle Ammo Splitpoint"] = {
                    
                    price = 20, 
                    item = "ammoriflesplitpoint",
                   
                },

            },
            ["Shotgun"] = {
                --[[ ["Shotgun Ammo Incendiary"] = {
                   
                    price = 3, 
                    item = "ammoshotgunincendiary",
                   
                }, ]]
                --[[ ["Shotgun Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammoshotgunexplosive",
                    
                }, ]]
                ["Shotgun Ammo Normal"] = {
                   
                    price = 3, 
                    item = "ammoshotgunnormal",
                    
                },
                ["Shotgun Ammo Slug"] = {
                   
                    price = 5, 
                    item = "ammoshotgunslug",
                   
                },
            },
            ["Pistol"] = {
                ["Pistol Ammo Normal"] = {
                   
                    price = 5, 
                    item = "ammopistolnormal",
                    
                },
                ["Pistol Ammo Express"] = {
                   
                    price = 5, 
                    item = "ammopistolexpress",
                    
                },
               --[[  ["Pistol Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammopistolexplosive",
                    
                }, ]]
                ["Pistol Ammo Velocity"] = {
                   
                    price = 5, 
                    item = "ammopistolvelocity",
                    
                },
                ["Pistol Ammo Splitpoint"] = {
                   
                    price = 5, 
                    item = "ammopistolsplitpoint",
                   
                },

            },
            ["Arrow"] = {
                ["Arrow Normal"] = {
                   
                    price = 2, 
                    item = "ammoarrmownormal",
                    
                },
                --[[ ["Arrow Dynamite"] = {
                    
                    price = 5, 
                    item = "ammoarrowdynamite",
                    
                }, ]]
                --[[ ["Arrow Fire"] = {
                   
                    price = 10, 
                    item = "ammoarrowfire",
                    
                }, ]]
               --[[  ["Arrow Improved"] = {
                  
                    price = 8, 
                    item = "ammoarrowimproved",
                    
                }, ]]
                ["Arrow Small Game"] = {
                   
                    price = 1, 
                    item = "ammoarrowsmallgame",
                    
                },
                --[[ ["Arrow Poison"] = {
                   
                    price = 5, 
                    item = "ammoarrowpoison",
                    
                }, ]]

            },
            ["Varmint Ammo"] = {
                ["Varmint ammo"] = {
                   
                    price = 5, 
                    item = "ammovarmint",
                    
                },
                --[[ ["Varmint Tranquilizer Ammo"] = {
                    
                    price = 5, 
                    item = "ammovarminttranq",
                    
                }, ]]

            },
            ["Throwing"] = {
                ["Knives ammo"] = {
                    
                    price = 2, 
                    item = "ammoknives",
                    
                },
                ["Tomahawk Ammo"] = {
                   
                    price = 2, 
                    item = "ammotomahawk",
                   
                },
                --[[ ["Poison Bottle Ammo"] = {
                   
                    price = 5, 
                    item = "ammopoisonbottle",
                   
                }, ]]
                ["Bolla Ammo"] = {
                   
                    price = 1, 
                    item = "ammobolla",
                    
                },
                --[[ ["Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammodynamite",
                    
                }, ]]
                --[[ ["Volatile Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammovoldynamite",
                    
                }, ]]
                --[[ ["Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammomolotov",
                   
                }, ]]
                --[[ ["Volatile Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammovolmolotov",
                   
                }, ]]

            },

        }
    },
  --[[  Rhodes = {	  
        Pos = {x=1323.04, y=-1321.56, z=77.889}, 
        blipsprite = 202506373,
        showblip = true,
        Name = 'Weapons Shop', 
        weapons = {
            ["Melee"] = {
                ["Tradders Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_TRADER",
                    price = 5,    
                
                },
                ["Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE",  
                    price = 5,      
                
                },
                ["JawBone Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_JAWBONE",  
                    price = 2,   
                
                },
                ["Cleaver"] = {	
                    hashname = "WEAPON_MELEE_CLEAVER",    
                    price = 2, 
                
                },
                ["Hunter Hatchet"] = {	
                    hashname = "WEAPON_MELEE_HATCHET_HUNTER",  
                    price = 8,   
                },
                ["Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE",   
                    price = 5.5,  
                },
                ["Collector Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE_COLLECTOR",   
                    price = 5.5,  
                },
            },
            ["Bows"] = {
                ["Bow"] = {	
                    hashname = "WEAPON_BOW",    
                    price = 10.75, 
                
                },
                ["Improved Bow"] = {	
                    hashname = "WEAPON_BOW_IMPROVED",   
                    price = 15,  
                
                },
            },
            ["Rifles"] = {
                ["Elephant Rifle"] = {	
                    hashname = "WEAPON_RIFLE_ELEPHANT",  
                    price = 400,   
                
                },
                ["Varmint Rifle"] = {	
                    hashname = "WEAPON_RIFLE_VARMINT",   
                    price = 30.75,  
                
                },
                ["Rollingblock Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",    
                    price = 1000, 
                
                },
                ["Carcano Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_CARCANO",  
                    price = 1000,   
                
                },
                ["Springfield Rifle"] = {	
                    hashname = "WEAPON_RIFLE_SPRINGFIELD", 
                    price = 1000,    
                
                },
                ["Boltaction Rifle"] = {	
                    hashname = "WEAPON_RIFLE_BOLTACTION",    
                    price = 250, 
                
                },
            },
            ["Repeaters"] = {
                ["Winchester Repeater"] = {	
                    hashname = "WEAPON_REPEATER_WINCHESTER",   
                    price = 70,  
                
                },
                ["Henry Repeater"] = {	
                    hashname = "WEAPON_REPEATER_HENRY",    
                    price = 75.5, 
                
                },
                ["Evans Repeater"] = {	
                    hashname = "WEAPON_REPEATER_EVANS",    
                    price = 80, 
                
                },
                ["Carbine Repeater"] = {	
                    hashname = "WEAPON_REPEATER_CARBINE",    
                    price = 50, 
                
                },
            },
            ["Pistols"] = {
                ["Volcanic Pistol "] = {	
                    hashname = "WEAPON_PISTOL_VOLCANIC",    
                    price = 1000, 
                
                },
                ["M1899 Pistol "] = {	
                    hashname = "WEAPON_PISTOL_M1899",    
                    price = 10000, 
                
                },
                ["SemiAuto Pistol "] = {	
                    hashname = "WEAPON_PISTOL_SEMIAUTO",    
                    price = 1000, 
                
                },
                ["Mauser Pistol "] = {	
                    hashname = "WEAPON_PISTOL_MAUSER",    
                    price = 1000, 
                
                },

            },
            ["Revolvers"] = {
                ["Schofield Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_SCHOFIELD",    
                    price = 50, 
                
                },
                ["Lemat Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_LEMAT",    
                    price = 40, 
                
                },
                ["Double Action Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_DOUBLEACTION",    
                    price = 55, 
                
                },
                ["Cattleman Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_CATTLEMAN",    
                    price = 25, 
                
                },
                ["Navy Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_NAVY",    
                    price = 60, 
                
                },
            },
            ["Throwable"] = { -- Due to vorp bug, using this weapon never runs out of ammo if u requip. 
            -- in order for throwables to work. the player must buy the throwable weapon then buy and use the related ammo box
            -- only then will the throwable show up in their weapon wheel 
                ["Tomahawk"] = {	
                    hashname = "WEAPON_THROWN_TOMAHAWK",    
                    price = 10, 
                
                },
                ["Knives"] = {	
                    hashname = "WEAPON_THROWN_THROWING_KNIVES",    
                    price = 8, 
                
                },
                ["Poison Bottle"] = {	
                    hashname = "WEAPON_THROWN_POISONBOTTLE",    
                    price = 15, 
                
                },
                ["Bolas"] = {	
                    hashname = "WEAPON_THROWN_BOLAS",    
                    price = 4, 
                
                },
                ["Dynamite"] = {	
                    hashname = "WEAPON_THROWN_DYNAMITE",    
                    price = 100, 
                
                },
                ["Molotov"] = {	
                    hashname = "WEAPON_THROWN_MOLOTOV",    
                    price = 100, 
                
                },

            },
            ["Shotguns"] = {
                ["Semiauto Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SEMIAUTO",    
                    price = 100, 
                
                },
                ["Sawedoff Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SAWEDOFF",    
                    price = 250, 
                
                },
                ["Repeating Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_REPEATING",    
                    price = 1000, 
                
                },
                ["Pump Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_PUMP",    
                    price = 1000, 
                
                },
                ["Doublebarrel Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_DOUBLEBARREL",    
                    price = 500, 
                
                },
            },
            ["Misc."] = {
                ["Lasso"] = {	
                    hashname = "WEAPON_LASSO",    
                    price = 2, 
                
                },
                ["Reinforced Lasso"] = {	
                    hashname = "WEAPON_LASSO_REINFORCED",    
                    price = 10, 
                
                },
                ["Improved Binoculars"] = {	
                    hashname = "WEAPON_KIT_BINOCULARS_IMPROVED",    
                    price = 10, 
                
                },
                ["Binoculars"] = {	
                    hashname = "WEAPON_kIT_BINOCULARS",    
                    price = 5, 
                
                },
                ["Fishing Rod"] = {	
                    hashname = "WEAPON_FISHINGROD",    
                    price = 3, 
                
                },
                ["Camera"] = {	
                    hashname = "WEAPON_KIT_CAMERA",    
                    price = 40, 
                
                },
                ["Advanced Camera"] = {	
                    hashname = "WEAPON_kIT_CAMERA_ADVANCED",    
                    price = 200, 
                
                },
                ["Lantern"] = {	
                    hashname = "WEAPON_MELEE_LANTERN",    
                    price = 9.75, 
                
                },
                ["Davy Lantern"] = {	
                    hashname = "WEAPON_MELEE_DAVY_LANTERN",    
                    price = 15, 
                
                },
            },
        }, 
        ammo = {
            ["Repeater"] = {
                ["Repeater Ammo Normal"] = {
                    price = 1, 
                    item = "ammorepeaternormal",
                },
                ["Repeater Ammo Express"] = {
                    price = 2, 
                    item = "ammorepeaterexpress",
                    
                },
                ["Repeater Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorepeaterexplosive",
                    
                },
                ["Repeater Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorepeatervelocity",
                    
                },
                ["Repeater Ammo Splitpoint"] = {
                    
                    price = 8, 
                    item = "ammorepeatersplitpoint",
                   
                },
            },

            ["Revolver"] = {
                ["Revolver Ammo Normal"] = {
                   
                    price = 1, 
                    item = "ammorevolvernormal",
                    
                },
                ["Revolver Ammo Express"] = {
                    
                    price = 2, 
                    item = "ammorevolverexpress",
                    
                },
                ["Revolver Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammorevolverexplosive",
                    
                },
                ["Revolver Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorevolvervelocity",
                    
                },
                ["Revolver Ammo Splitpoint"] = {
                   
                    price = 8, 
                    item = "ammorevolversplitpoint",
                   
                },

            },
            ["Rifle"] = {
                ["Rifle Ammo Normal"] = {
                    
                    price = 5, 
                    item = "ammoriflenormal",
                    
                },
                ["Elephant Rifle Ammo"] = {
                    
                    price = 5, 
                    item = "ammoelephant",
                    
                },
                ["Rifle Ammo Express"] = {
                   
                    price = 8, 
                    item = "ammorifleexpress",
                    
                },
                ["Rifle Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorifleexplosive",
                    
                },
                ["Rifle Ammo Velocity"] = {
                   
                    price = 9, 
                    item = "ammoriflevelocity",
                   
                },
                ["Rifle Ammo Splitpoint"] = {
                    
                    price = 10, 
                    item = "ammoriflesplitpoint",
                   
                },

            },
            ["Shotgun"] = {
                ["Shotgun Ammo Incendiary"] = {
                   
                    price = 5, 
                    item = "ammoshotgunincendiary",
                   
                },
                ["Shotgun Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammoshotgunexplosive",
                    
                },
                ["Shotgun Ammo Normal"] = {
                   
                    price = 1, 
                    item = "ammoshotgunnormal",
                    
                },
                ["Shotgun Ammo Slug"] = {
                   
                    price = 3, 
                    item = "ammoshotgunslug",
                   
                },
            },
            ["Pistol"] = {
                ["Pistol Ammo Normal"] = {
                   
                    price = 5, 
                    item = "ammopistolnormal",
                    
                },
                ["Pistol Ammo Express"] = {
                   
                    price = 5, 
                    item = "ammopistolexpress",
                    
                },
                ["Pistol Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammopistolexplosive",
                    
                },
                ["Pistol Ammo Velocity"] = {
                   
                    price = 5, 
                    item = "ammopistolvelocity",
                    
                },
                ["Pistol Ammo Splitpoint"] = {
                   
                    price = 5, 
                    item = "ammopistolsplitpoint",
                   
                },

            },
            ["Arrow"] = {
                ["Arrow Normal"] = {
                   
                    price = 1, 
                    item = "ammoarrmownormal",
                    
                },
                ["Arrow Dynamite"] = {
                    
                    price = 5, 
                    item = "ammoarrowdynamite",
                    
                },
                ["Arrow Fire"] = {
                   
                    price = 5, 
                    item = "ammoarrowfire",
                    
                },
                ["Arrow Improved"] = {
                  
                    price = 4, 
                    item = "ammoarrowimproved",
                    
                },
                ["Arrow Small Game"] = {
                   
                    price = .5, 
                    item = "ammoarrowsmallgame",
                    
                },
                ["Arrow Poison"] = {
                   
                    price = 5, 
                    item = "ammoarrowpoison",
                    
                },

            },
            ["Varmint Ammo"] = {
                ["Varmint ammo"] = {
                   
                    price = 2, 
                    item = "ammovarmint",
                    
                },
                ["Varmint Tranquilizer Ammo"] = {
                    
                    price = 5, 
                    item = "ammovarminttranq",
                    
                },

            },
            ["Throwing"] = {
                ["Knives ammo"] = {
                    
                    price = 3, 
                    item = "ammoknives",
                    
                },
                ["Tomahawk Ammo"] = {
                   
                    price = 3, 
                    item = "ammotomahawk",
                   
                },
                ["Poison Bottle Ammo"] = {
                   
                    price = 5, 
                    item = "ammopoisonbottle",
                   
                },
                ["Bolla Ammo"] = {
                   
                    price = 1, 
                    item = "ammobolla",
                    
                },
                ["Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammodynamite",
                    
                },
                ["Volatile Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammovoldynamite",
                    
                },
                ["Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammomolotov",
                   
                },
                ["Volatile Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammovolmolotov",
                   
                },

            },

        }
    }, ]]
    Annesburg = {	  
        Pos = {x=2946.56, y=1319.68, z=44.82}, 
        blipsprite = 202506373,
        showblip = true,
        Name = 'Weapons Shop', 
        weapons = {
            ["Melee"] = {
                ["Tradders Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_TRADER",
                    price = 5,    
                
                },
                ["Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE",  
                    price = 5,      
                
                },
                ["JawBone Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_JAWBONE",  
                    price = 2,   
                
                },
                ["Cleaver"] = {	
                    hashname = "WEAPON_MELEE_CLEAVER",    
                    price = 2, 
                
                },
                ["Hunter Hatchet"] = {	
                    hashname = "WEAPON_MELEE_HATCHET_HUNTER",  
                    price = 8,   
                },
                ["Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE",   
                    price = 5.5,  
                },
                ["Collector Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE_COLLECTOR",   
                    price = 5.5,  
                },
            },
            ["Bows"] = {
                ["Bow"] = {	
                    hashname = "WEAPON_BOW",    
                    price = 10.75, 
                
                },
               --[[  ["Improved Bow"] = {	
                    hashname = "WEAPON_BOW_IMPROVED",   
                    price = 15,  
                
                }, ]]
            },
            ["Rifles"] = {
                ["Elephant Rifle"] = {	
                    hashname = "WEAPON_RIFLE_ELEPHANT",  
                    price = 400,   
                
                },
                ["Varmint Rifle"] = {	
                    hashname = "WEAPON_RIFLE_VARMINT",   
                    price = 30.75,  
                
                },
                ["Rollingblock Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",    
                    price = 1000, 
                
                },
                ["Carcano Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_CARCANO",  
                    price = 1000,   
                
                },
                ["Springfield Rifle"] = {	
                    hashname = "WEAPON_RIFLE_SPRINGFIELD", 
                    price = 1000,    
                
                },
                ["Boltaction Rifle"] = {	
                    hashname = "WEAPON_RIFLE_BOLTACTION",    
                    price = 250, 
                
                },
            },
            ["Repeaters"] = {
                ["Winchester Repeater"] = {	
                    hashname = "WEAPON_REPEATER_WINCHESTER",   
                    price = 70,  
                
                },
                ["Henry Repeater"] = {	
                    hashname = "WEAPON_REPEATER_HENRY",    
                    price = 75.5, 
                
                },
                ["Evans Repeater"] = {	
                    hashname = "WEAPON_REPEATER_EVANS",    
                    price = 80, 
                
                },
                ["Carbine Repeater"] = {	
                    hashname = "WEAPON_REPEATER_CARBINE",    
                    price = 50, 
                
                },
            },
            ["Pistols"] = {
                ["Volcanic Pistol "] = {	
                    hashname = "WEAPON_PISTOL_VOLCANIC",    
                    price = 1000, 
                
                },
                ["M1899 Pistol "] = {	
                    hashname = "WEAPON_PISTOL_M1899",    
                    price = 10000, 
                
                },
               --[[  ["SemiAuto Pistol "] = {	
                    hashname = "WEAPON_PISTOL_SEMIAUTO",    
                    price = 1000, 
                
                }, ]]
             --[[    ["Mauser Pistol "] = {	
                    hashname = "WEAPON_PISTOL_MAUSER",    
                    price = 1000, 
                
                },
                 ]]

            },
            ["Revolvers"] = {
                ["Schofield Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_SCHOFIELD",    
                    price = 50, 
                
                },
                ["Lemat Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_LEMAT",    
                    price = 40, 
                
                },
                ["Double Action Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_DOUBLEACTION",    
                    price = 55, 
                
                },
                ["Cattleman Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_CATTLEMAN",    
                    price = 25, 
                
                },
                ["Navy Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_NAVY",    
                    price = 60, 
                
                },
            },
            ["Throwable"] = { -- Due to vorp bug, using this weapon never runs out of ammo if u requip. 
            -- in order for throwables to work. the player must buy the throwable weapon then buy and use the related ammo box
            -- only then will the throwable show up in their weapon wheel 
                ["Tomahawk"] = {	
                    hashname = "WEAPON_THROWN_TOMAHAWK",    
                    price = 10, 
                
                },
                ["Knives"] = {	
                    hashname = "WEAPON_THROWN_THROWING_KNIVES",    
                    price = 8, 
                
                },
                ["Poison Bottle"] = {	
                    hashname = "WEAPON_THROWN_POISONBOTTLE",    
                    price = 15, 
                
                },
                ["Bolas"] = {	
                    hashname = "WEAPON_THROWN_BOLAS",    
                    price = 4, 
                
                },
               --[[  ["Dynamite"] = {	
                    hashname = "WEAPON_THROWN_DYNAMITE",    
                    price = 100, 
                
                },
                ["Molotov"] = {	
                    hashname = "WEAPON_THROWN_MOLOTOV",    
                    price = 100, 
                
                }, ]]

            },
            ["Shotguns"] = {
                --[[ ["Semiauto Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SEMIAUTO",    
                    price = 100, 
                
                }, ]]
                ["Sawedoff Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SAWEDOFF",    
                    price = 250, 
                
                },
                ["Repeating Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_REPEATING",    
                    price = 1000, 
                
                },
                ["Pump Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_PUMP",    
                    price = 1000, 
                
                },
                ["Doublebarrel Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_DOUBLEBARREL",    
                    price = 500, 
                
                },
            },
            ["Misc."] = {
                ["Lasso"] = {	
                    hashname = "WEAPON_LASSO",    
                    price = 2, 
                
                },
                ["Reinforced Lasso"] = {	
                    hashname = "WEAPON_LASSO_REINFORCED",    
                    price = 10, 
                
                },
                ["Improved Binoculars"] = {	
                    hashname = "WEAPON_KIT_BINOCULARS_IMPROVED",    
                    price = 10, 
                
                },
                ["Binoculars"] = {	
                    hashname = "WEAPON_kIT_BINOCULARS",    
                    price = 5, 
                
                },
                ["Fishing Rod"] = {	
                    hashname = "WEAPON_FISHINGROD",    
                    price = 3, 
                
                },
                ["Camera"] = {	
                    hashname = "WEAPON_KIT_CAMERA",    
                    price = 40, 
                
                },
                ["Advanced Camera"] = {	
                    hashname = "WEAPON_kIT_CAMERA_ADVANCED",    
                    price = 200, 
                
                },
                ["Lantern"] = {	
                    hashname = "WEAPON_MELEE_LANTERN",    
                    price = 9.75, 
                
                },
                ["Davy Lantern"] = {	
                    hashname = "WEAPON_MELEE_DAVY_LANTERN",    
                    price = 15, 
                
                },
            },
        }, 
        ammo = {
            ["Repeater"] = {
                ["Repeater Ammo Normal"] = {
                    price = 5, 
                    item = "ammorepeaternormal",
                },
                ["Repeater Ammo Express"] = {
                    price = 5, 
                    item = "ammorepeaterexpress",
                    
                },
              --[[   ["Repeater Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorepeaterexplosive",
                    
                }, ]]
                ["Repeater Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorepeatervelocity",
                    
                },
                ["Repeater Ammo Splitpoint"] = {
                    
                    price = 5, 
                    item = "ammorepeatersplitpoint",
                   
                },
            },

            ["Revolver"] = {
                ["Revolver Ammo Normal"] = {
                   
                    price = 5, 
                    item = "ammorevolvernormal",
                    
                },
                ["Revolver Ammo Express"] = {
                    
                    price = 5, 
                    item = "ammorevolverexpress",
                    
                },
              --[[   ["Revolver Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammorevolverexplosive",
                    
                }, ]]
                ["Revolver Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorevolvervelocity",
                    
                },
                ["Revolver Ammo Splitpoint"] = {
                   
                    price = 5, 
                    item = "ammorevolversplitpoint",
                   
                },

            },
            ["Rifle"] = {
                ["Rifle Ammo Normal"] = {
                    
                    price = 5, 
                    item = "ammoriflenormal",
                    
                },
                ["Elephant Rifle Ammo"] = {
                    
                    price = 5, 
                    item = "ammoelephant",
                    
                },
                ["Rifle Ammo Express"] = {
                   
                    price = 5, 
                    item = "ammorifleexpress",
                    
                },
              --[[   ["Rifle Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorifleexplosive",
                    
                }, ]]
                ["Rifle Ammo Velocity"] = {
                   
                    price = 5, 
                    item = "ammoriflevelocity",
                   
                },
                ["Rifle Ammo Splitpoint"] = {
                    
                    price = 5, 
                    item = "ammoriflesplitpoint",
                   
                },

            },
            ["Shotgun"] = {
              --[[   ["Shotgun Ammo Incendiary"] = {
                   
                    price = 5, 
                    item = "ammoshotgunincendiary",
                   
                },
                ["Shotgun Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammoshotgunexplosive",
                    
                }, ]]
                ["Shotgun Ammo Normal"] = {
                   
                    price = 5, 
                    item = "ammoshotgunnormal",
                    
                },
                ["Shotgun Ammo Slug"] = {
                   
                    price = 5, 
                    item = "ammoshotgunslug",
                   
                },
            },
            ["Pistol"] = {
                ["Pistol Ammo Normal"] = {
                   
                    price = 5, 
                    item = "ammopistolnormal",
                    
                },
                ["Pistol Ammo Express"] = {
                   
                    price = 5, 
                    item = "ammopistolexpress",
                    
                },
              --[[   ["Pistol Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammopistolexplosive",
                    
                }, ]]
                ["Pistol Ammo Velocity"] = {
                   
                    price = 5, 
                    item = "ammopistolvelocity",
                    
                },
                ["Pistol Ammo Splitpoint"] = {
                   
                    price = 5, 
                    item = "ammopistolsplitpoint",
                   
                },

            },
            ["Arrow"] = {
                ["Arrow Normal"] = {
                   
                    price = 5, 
                    item = "ammoarrmownormal",
                    
                },
               --[[  ["Arrow Dynamite"] = {
                    
                    price = 5, 
                    item = "ammoarrowdynamite",
                    
                }, ]]
                ["Arrow Fire"] = {
                   
                    price = 5, 
                    item = "ammoarrowfire",
                    
                },
               --[[  ["Arrow Improved"] = {
                  
                    price = 5, 
                    item = "ammoarrowimproved",
                    
                }, ]]
                ["Arrow Small Game"] = {
                   
                    price = 5, 
                    item = "ammoarrowsmallgame",
                    
                },
                ["Arrow Poison"] = {
                   
                    price = 5, 
                    item = "ammoarrowpoison",
                    
                },

            },
            ["Varmint Ammo"] = {
                ["Varmint ammo"] = {
                   
                    price = 5, 
                    item = "ammovarmint",
                    
                },
                ["Varmint Tranquilizer Ammo"] = {
                    
                    price = 5, 
                    item = "ammovarminttranq",
                    
                },

            },
            ["Throwing"] = {
                ["Knives ammo"] = {
                    
                    price = 5, 
                    item = "ammoknives",
                    
                },
                ["Tomahawk Ammo"] = {
                   
                    price = 5, 
                    item = "ammotomahawk",
                   
                },
                ["Poison Bottle Ammo"] = {
                   
                    price = 5, 
                    item = "ammopoisonbottle",
                   
                },
                ["Bolla Ammo"] = {
                   
                    price = 5, 
                    item = "ammobolla",
                    
                },
                --[[ ["Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammodynamite",
                    
                },
                ["Volatile Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammovoldynamite",
                    
                }, ]]
            --[[     ["Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammomolotov",
                   
                },
                ["Volatile Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammovolmolotov",
                   
                },
 ]]
            },

        }
    },
    tumbleweed = {	  
        Pos = {x=-5508.327, y=-2964.35, z=-0.6288}, 
        blipsprite = 202506373,
        showblip = true,
        Name = 'Weapons Shop', 
        weapons = {
            ["Melee"] = {
                ["Tradders Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_TRADER",
                    price = 5,    
                
                },
                ["Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE",  
                    price = 5,      
                
                },
                ["JawBone Knife"] = {	
                    hashname = "WEAPON_MELEE_KNIFE_JAWBONE",  
                    price = 2,   
                
                },
                ["Cleaver"] = {	
                    hashname = "WEAPON_MELEE_CLEAVER",    
                    price = 2, 
                
                },
                ["Hunter Hatchet"] = {	
                    hashname = "WEAPON_MELEE_HATCHET_HUNTER",  
                    price = 8,   
                },
                ["Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE",   
                    price = 5.5,  
                },
                ["Collector Machete"] = {	
                    hashname = "WEAPON_MELEE_MACHETE_COLLECTOR",   
                    price = 5.5,  
                },
            },
            ["Bows"] = {
                ["Bow"] = {	
                    hashname = "WEAPON_BOW",    
                    price = 10.75, 
                
                },
               --[[  ["Improved Bow"] = {	
                    hashname = "WEAPON_BOW_IMPROVED",   
                    price = 15,  
                
                }, ]]
            },
            ["Rifles"] = {
                ["Elephant Rifle"] = {	
                    hashname = "WEAPON_RIFLE_ELEPHANT",  
                    price = 400,   
                
                },
                ["Varmint Rifle"] = {	
                    hashname = "WEAPON_RIFLE_VARMINT",   
                    price = 30.75,  
                
                },
                ["Rollingblock Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",    
                    price = 1000, 
                
                },
                ["Carcano Rifle"] = {	
                    hashname = "WEAPON_SNIPERRIFLE_CARCANO",  
                    price = 1000,   
                
                },
                ["Springfield Rifle"] = {	
                    hashname = "WEAPON_RIFLE_SPRINGFIELD", 
                    price = 1000,    
                
                },
                ["Boltaction Rifle"] = {	
                    hashname = "WEAPON_RIFLE_BOLTACTION",    
                    price = 250, 
                
                },
            },
            ["Repeaters"] = {
                ["Winchester Repeater"] = {	
                    hashname = "WEAPON_REPEATER_WINCHESTER",   
                    price = 70,  
                
                },
                ["Henry Repeater"] = {	
                    hashname = "WEAPON_REPEATER_HENRY",    
                    price = 75.5, 
                
                },
                ["Evans Repeater"] = {	
                    hashname = "WEAPON_REPEATER_EVANS",    
                    price = 80, 
                
                },
                ["Carbine Repeater"] = {	
                    hashname = "WEAPON_REPEATER_CARBINE",    
                    price = 50, 
                
                },
            },
            ["Pistols"] = {
                ["Volcanic Pistol "] = {	
                    hashname = "WEAPON_PISTOL_VOLCANIC",    
                    price = 1000, 
                
                },
                ["M1899 Pistol "] = {	
                    hashname = "WEAPON_PISTOL_M1899",    
                    price = 10000, 
                
                },
               --[[  ["SemiAuto Pistol "] = {	
                    hashname = "WEAPON_PISTOL_SEMIAUTO",    
                    price = 1000, 
                
                }, ]]
             --[[    ["Mauser Pistol "] = {	
                    hashname = "WEAPON_PISTOL_MAUSER",    
                    price = 1000, 
                
                },
                 ]]

            },
            ["Revolvers"] = {
                ["Schofield Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_SCHOFIELD",    
                    price = 50, 
                
                },
                ["Lemat Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_LEMAT",    
                    price = 40, 
                
                },
                ["Double Action Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_DOUBLEACTION",    
                    price = 55, 
                
                },
                ["Cattleman Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_CATTLEMAN",    
                    price = 25, 
                
                },
                ["Navy Revolver"] = {	
                    hashname = "WEAPON_REVOLVER_NAVY",    
                    price = 60, 
                
                },
            },
            ["Throwable"] = { -- Due to vorp bug, using this weapon never runs out of ammo if u requip. 
            -- in order for throwables to work. the player must buy the throwable weapon then buy and use the related ammo box
            -- only then will the throwable show up in their weapon wheel 
                ["Tomahawk"] = {	
                    hashname = "WEAPON_THROWN_TOMAHAWK",    
                    price = 10, 
                
                },
                ["Knives"] = {	
                    hashname = "WEAPON_THROWN_THROWING_KNIVES",    
                    price = 8, 
                
                },
                ["Poison Bottle"] = {	
                    hashname = "WEAPON_THROWN_POISONBOTTLE",    
                    price = 15, 
                
                },
                ["Bolas"] = {	
                    hashname = "WEAPON_THROWN_BOLAS",    
                    price = 4, 
                
                },
               --[[  ["Dynamite"] = {	
                    hashname = "WEAPON_THROWN_DYNAMITE",    
                    price = 100, 
                
                },
                ["Molotov"] = {	
                    hashname = "WEAPON_THROWN_MOLOTOV",    
                    price = 100, 
                
                }, ]]

            },
            ["Shotguns"] = {
                --[[ ["Semiauto Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SEMIAUTO",    
                    price = 100, 
                
                }, ]]
                ["Sawedoff Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_SAWEDOFF",    
                    price = 250, 
                
                },
                ["Repeating Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_REPEATING",    
                    price = 1000, 
                
                },
                ["Pump Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_PUMP",    
                    price = 1000, 
                
                },
                ["Doublebarrel Shotgun"] = {	
                    hashname = "WEAPON_SHOTGUN_DOUBLEBARREL",    
                    price = 500, 
                
                },
            },
            ["Misc."] = {
                ["Lasso"] = {	
                    hashname = "WEAPON_LASSO",    
                    price = 2, 
                
                },
                ["Reinforced Lasso"] = {	
                    hashname = "WEAPON_LASSO_REINFORCED",    
                    price = 10, 
                
                },
                ["Improved Binoculars"] = {	
                    hashname = "WEAPON_KIT_BINOCULARS_IMPROVED",    
                    price = 10, 
                
                },
                ["Binoculars"] = {	
                    hashname = "WEAPON_kIT_BINOCULARS",    
                    price = 5, 
                
                },
                ["Fishing Rod"] = {	
                    hashname = "WEAPON_FISHINGROD",    
                    price = 3, 
                
                },
                ["Camera"] = {	
                    hashname = "WEAPON_KIT_CAMERA",    
                    price = 40, 
                
                },
                ["Advanced Camera"] = {	
                    hashname = "WEAPON_kIT_CAMERA_ADVANCED",    
                    price = 200, 
                
                },
                ["Lantern"] = {	
                    hashname = "WEAPON_MELEE_LANTERN",    
                    price = 9.75, 
                
                },
                ["Davy Lantern"] = {	
                    hashname = "WEAPON_MELEE_DAVY_LANTERN",    
                    price = 15, 
                
                },
            },
        },
        ammo = {
            ["Repeater"] = {
                ["Repeater Ammo Normal"] = {
                    price = 5, 
                    item = "ammorepeaternormal",
                },
                ["Repeater Ammo Express"] = {
                    price = 5, 
                    item = "ammorepeaterexpress",
                    
                },
               --[[  ["Repeater Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorepeaterexplosive",
                    
                }, ]]
                ["Repeater Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorepeatervelocity",
                    
                },
                ["Repeater Ammo Splitpoint"] = {
                    
                    price = 5, 
                    item = "ammorepeatersplitpoint",
                   
                },
            },

            ["Revolver"] = {
                ["Revolver Ammo Normal"] = {
                   
                    price = 5, 
                    item = "ammorevolvernormal",
                    
                },
                ["Revolver Ammo Express"] = {
                    
                    price = 5, 
                    item = "ammorevolverexpress",
                    
                },
               --[[  ["Revolver Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammorevolverexplosive",
                    
                }, ]]
                ["Revolver Ammo Velocity"] = {
                    
                    price = 5, 
                    item = "ammorevolvervelocity",
                    
                },
                ["Revolver Ammo Splitpoint"] = {
                   
                    price = 5, 
                    item = "ammorevolversplitpoint",
                   
                },

            },
            ["Rifle"] = {
                ["Rifle Ammo Normal"] = {
                    
                    price = 5, 
                    item = "ammoriflenormal",
                    
                },
                ["Elephant Rifle Ammo"] = {
                    
                    price = 5, 
                    item = "ammoelephant",
                    
                },
                ["Rifle Ammo Express"] = {
                   
                    price = 5, 
                    item = "ammorifleexpress",
                    
                },
               --[[  ["Rifle Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammorifleexplosive",
                    
                }, ]]
                ["Rifle Ammo Velocity"] = {
                   
                    price = 5, 
                    item = "ammoriflevelocity",
                   
                },
                ["Rifle Ammo Splitpoint"] = {
                    
                    price = 5, 
                    item = "ammoriflesplitpoint",
                   
                },

            },
            ["Shotgun"] = {
              --[[   ["Shotgun Ammo Incendiary"] = {
                   
                    price = 5, 
                    item = "ammoshotgunincendiary",
                   
                },
                ["Shotgun Ammo Explosive"] = {
                   
                    price = 5, 
                    item = "ammoshotgunexplosive",
                    
                }, ]]
                ["Shotgun Ammo Normal"] = {
                   
                    price = 5, 
                    item = "ammoshotgunnormal",
                    
                },
                ["Shotgun Ammo Slug"] = {
                   
                    price = 5, 
                    item = "ammoshotgunslug",
                   
                },
            },
            ["Pistol"] = {
                ["Pistol Ammo Normal"] = {
                   
                    price = 5, 
                    item = "ammopistolnormal",
                    
                },
                ["Pistol Ammo Express"] = {
                   
                    price = 5, 
                    item = "ammopistolexpress",
                    
                },
              --[[   ["Pistol Ammo Explosive"] = {
                    
                    price = 5, 
                    item = "ammopistolexplosive",
                    
                }, ]]
                ["Pistol Ammo Velocity"] = {
                   
                    price = 5, 
                    item = "ammopistolvelocity",
                    
                },
                ["Pistol Ammo Splitpoint"] = {
                   
                    price = 5, 
                    item = "ammopistolsplitpoint",
                   
                },

            },
            ["Arrow"] = {
                ["Arrow Normal"] = {
                   
                    price = 5, 
                    item = "ammoarrmownormal",
                    
                },
                --[[ ["Arrow Dynamite"] = {
                    
                    price = 5, 
                    item = "ammoarrowdynamite",
                    
                }, ]]
                ["Arrow Fire"] = {
                   
                    price = 5, 
                    item = "ammoarrowfire",
                    
                },
               --[[  ["Arrow Improved"] = {
                  
                    price = 5, 
                    item = "ammoarrowimproved",
                    
                }, ]]
                ["Arrow Small Game"] = {
                   
                    price = 5, 
                    item = "ammoarrowsmallgame",
                    
                },
                ["Arrow Poison"] = {
                   
                    price = 5, 
                    item = "ammoarrowpoison",
                    
                },

            },
            ["Varmint Ammo"] = {
                ["Varmint ammo"] = {
                   
                    price = 5, 
                    item = "ammovarmint",
                    
                },
                ["Varmint Tranquilizer Ammo"] = {
                    
                    price = 5, 
                    item = "ammovarminttranq",
                    
                },

            },
            ["Throwing"] = {
                ["Knives ammo"] = {
                    
                    price = 5, 
                    item = "ammoknives",
                    
                },
                ["Tomahawk Ammo"] = {
                   
                    price = 5, 
                    item = "ammotomahawk",
                   
                },
                ["Poison Bottle Ammo"] = {
                   
                    price = 5, 
                    item = "ammopoisonbottle",
                   
                },
                ["Bolla Ammo"] = {
                   
                    price = 5, 
                    item = "ammobolla",
                    
                },
               --[[  ["Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammodynamite",
                    
                }, ]]
                --[[ ["Volatile Dynamite Ammo"] = {
                   
                    price = 5, 
                    item = "ammovoldynamite",
                    
                }, ]]
               --[[  ["Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammomolotov",
                   
                },
                ["Volatile Molotov Ammo"] = {
                   
                    price = 5, 
                    item = "ammovolmolotov",
                   
                }, ]]

            },

        }
    },
} 