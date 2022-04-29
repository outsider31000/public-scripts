-- Menu configuration, array of menus to display
sharedconfigs = {
    ["shareddance1"] = {
        label = "Dance",
        dict1 = "cnv_camp@rchso@cnv@ccdtc33@player_karen",
        anim1 = "arthur_dance_loop",
        dict2 = "cnv_camp@rchso@cnv@ccdtc33@player_karen",
        anim2 = "karen_dance_loop",
        flag = 1
    },
}
menuConfigs = {
    ['mainmenu'] = {                                  -- Example menu for emotes when player is on foot
        enableMenu = function()                     -- Function to enable/disable menu handling
            local player = PlayerPedId()
            return true--IsPedOnFoot(player)
        end,
        data = {                                    -- Data that is passed to Javascript
            keybind = "F6",                 -- Wheel keybind to use (case sensitive, must match entry in keybindControls table)
            lastmenu = 0,
            style = {                               -- Wheel style settings
                sizePx = 600,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {                              -- Array of wheels to display
                {
                    navAngle = 270,                 -- Oritentation of wheel
                    minRadiusPercent = 0.25,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 1.0,         -- Maximum radius of wheel in percentage
                    labels = {"Job", "Stop Anim", "Other", "Reload Char", "Clothing", "Walk Style", "Animations", "Check Gun", "Scenarios","Players", "Mail","Bird"},
                    commands = {"job", "sa", "other", "rc", "clothingmenu", "walkstyle", "animations", "checkgun", "scenario","list", "mail","callbird"}
                }
            }
        }
    }
}

subMenuConfigs = {
    ['job'] = {
        data = {
            keybind = "F6",
            lastmenu = "mainmenu",
            style = {
                sizePx = 600,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.65,
                    labels = {"My job", "Give ID", "Pay Bills", "Doctor", "Police", "Alert Police", "Alert Doc", "Show Clan","Clan Menu","Remove Alerts"},
                    commands = {"showjob", "idcard", "paybills ","med", "mmenu", "alertpolice", "alertdoctor","showclan", "clanmenu", "calert"}
                },
            }
        }
    },
    ['clothingmenu'] = {
        data = {
            keybind = "F6",
            lastmenu = "mainmenu",
            style = {
                sizePx = 600,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 270,
                    minRadiusPercent = 0.15,
                    maxRadiusPercent = 0.45,
                    labels = {"Sleeves", "Collar", "Bandana", "Hat", "Eyeware", "Mask", "Neckwear", "Undress", "Dress"},
                    commands = {"sleevesx", "sleeves2x", "bandanax", "hatx", "eyewearx", "maskx", "neckwearx",  "undressx", "dressx"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.45,
                    maxRadiusPercent = 0.80,
                    labels = {"Suspender", "Vest", "Coat", "Closed Coat", "Bow", "Armor", "Poncho", "Cloak", "Glove", "Rings", "Bracelet", "Accessories", "Tie", "shirt", "Loadouts"},
                    commands = {"suspenderx", "vestx", "coatx", "ccoatx", "bowx", "armorx", "ponchox", "cloackx", "glovex", "ringsx", "braceletx","accessoriesx", "necktiesx", "shirtx", "loadoutsx"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.80,
                    maxRadiusPercent = 1.00,
                    labels = { "Satchels", "Gunbelt accs", "Belt", "Buckle", "Pants", "Skirt", "Chaps", "Boots", "Spurs", "Spats", "Gauntlets"},
                    commands = { "satchelsx", "gunbeltaccsx", "beltx", "bucklex", "pantx", "skirtx", "chapx", "bootsx", "spursx", "spatsx", "gauntletsx"}
                },
            }
        }
    },

    ['other'] = {
        data = {
            keybind = "F6",
            lastmenu = "mainmenu",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.85,
                    labels = {"Hud", "Delete Horse", "Delete Wagon", "Delete Campfire", "Delete Tent", "Flip Coin", "Forecast", "Hide Chat", "Race Menu", "RPS", "Reload Plants","Horse Emote"},
                    commands = {"hud", "dh", "dv", "dcampfire", "dtent", "flipcoin", "forecast", "togglechat", "race", "rps", "plant_load", "he"}
                },
                
            }
        }
    },
    ['walkstyle'] = {
        data = {
            keybind = "F6",
            lastmenu = "mainmenu",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.85,
                    labels = {"Casual", "Crazy", "Drunk", "EasyRider", "Flamboyant", "Greenhorn", "Gunslinger", "Inquisitive", "Refined", "SilentType", "Veteran", "Default"},
                    commands = {"walkcasul ", "walkcrazy", "walkdrunk", "walkeasy", "walkflamboyant", "walkgreenhorn", "walkgunslinger", "walkinquisitive", "walkrefined", "walksilentType", "walkveteran", "walkremove"}
                },
                
            }
        }
    },
    ['he'] = {
        data = {
            keybind = "F6",
            lastmenu = "mainmenu",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.75,
                    labels = {"Horse drink ", "Horse Rest", "Horse Sleep", "Horse Wallow"},
                    commands = {"horsedrink ", "horserest", "horsesleep", "horsewallow"}
                },
                
            }
        }
    },            
    ['animations'] = {
        data = {
            keybind = "F6",
            lastmenu = "mainmenu",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 270,                 -- Oritentation of wheel
                    minRadiusPercent = 0.25,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.55,         -- Maximum radius of wheel in percentage
                    labels = {"Greeting", "Actions", "Hurt", "Standing",  "Dance", "Mixed","Shared","Mixed 2"},
                    commands = {"howdy", "handlinger", "skadet", "stående", "danse", "blandet","shared","mixed2"}
                },
                
            }
        }
    },
    ['mixed2'] = {
        data = {
            keybind = "F6",
            lastmenu = "animations",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 270,                 -- Oritentation of wheel
                    minRadiusPercent = 0.25,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.55,         -- Maximum radius of wheel in percentage
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                
            }
        }
    },
    ['submenu1'] = {
        data = {
            keybind = "F6",
            lastmenu = "mixed2",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"SLEEP", "SIT GROUND", "IDLE", "IDLE 2", "LEAN RAIL", "DRUNK", "WRITE LEDGER", "COUGH", "PUKE", "DANCE"},
                    commands = {"sleep1", "sitground2", "idle1", "idle2", "leanrail1", "drunk1", "writeledger1", "cough1", "puke1", "dance1"}
                }
            }
        }
    },
    ['submenu2'] = {
        data = {
            keybind = "F6",
            lastmenu = "mixed2",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"STINKY", "WAVE", "THUMBS UP", "THUMBS DOWN", "DRAW", "YES", "NO", "HELL YEAH", "SPIT", "APPLAUSE", "SLOW CLAP", "TA-DA"},
                    commands = {"stinky1", "wave1", "thumbsup1", "thumbsdown1", "draw1", "yes1", "no1", "hellyeah1", "idlespit1", "applause1", "slowclap1", "tada1"}
                },
            }
        }
    },
    ['submenu3'] = {
        data = {
            keybind = "F6",
            lastmenu = "mixed2",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"BLOW KISS", "BOAST", "FLEX", "FOLLOW ME", "LET'S GO", "LET'S CRAFT", "WANNA FISH?", "PLAY CARDS?", "LOOK DISTANCE", "LOOK YONDER", "POINT"},
                    commands = {"blowkiss1", "boast1", "flex1", "followme1", "letsgo1", "letscraft1", "wannafish1", "playcards1", "lookdistance1", "lookyonder1", "point1"}
                }
            }
        }
    },
    ['submenu4'] = {
        data = {
            keybind = "F6",
            lastmenu = "mixed2",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"POSSE UP", "PROSPECTOR JIG", "SCHEME", "SHOOT EM UP", "SHOOT THE SKY", "LET'S STOP", "FANCY BOW", "GENTLE WAVE", "GOOD TO SEE YA", "TIP HAT", "RESPECTFUL BOW"},
                    commands = {"posseup1", "prospectorjig1", "scheme1", "shootemup1", "shootthesky1", "letsstop1", "fancybow1", "gentlewave1", "goodtoseeya1", "hattipping1", "respectfulbow1"}
                }
            }
        }
    },
    ['submenu5'] = {
        data = {
            keybind = "F6",
            lastmenu = "mixed2",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"TOUGH GUY NOD", "BEG FOR MERCY", "GAG", "HUSH YOUR MOUTH", "POINT & LAUGH", "I'M HIT", "WEEP", "WHO, ME?", "HEY YOU!", "YEEHAW"},
                    commands = {"toughguynod1", "begformercy1", "gag1", "hushyourmouth1", "pointandlaugh1", "imhit1", "weep1", "whome1", "heyyou1", "yeehaw1"}
                }
            }
        }
    },
    ['submenu6'] = {
        data = {
            keybind = "F6",
            lastmenu = "mixed2",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"FLIP OFF", "WATCHIN' YOU", "BRING IT ON", "THROAT SLIT", "WAR CRY", "GONNA CRY?", "CHICKEN", "HOW DARE YOU", "DAMN YOU", "HISSY FIT"},
                    commands = {"flipoff1", "watchinyou1", "bringiton1", "throatslit1", "warcry1", "gonnacry1", "chicken1", "howdareyou1", "damn1", "hissyfit1"}
                }
            }
        }
    },
    ['submenu7'] = {
        data = {
            keybind = "F6",
            lastmenu = "mixed2",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#b30000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.3,
                    maxRadiusPercent = 0.6,
                    labels = {"STANCE", "EMOTES", "EMOTES II", "EMOTES III", "EMOTES IV", "EMOTES V", "SCENARIOS"},
                    commands = {"submenu1", "submenu2", "submenu3", "submenu4", "submenu5", "submenu6", "submenu7"}
                },
                {
                    navAngle = 285,
                    minRadiusPercent = 0.6,
                    maxRadiusPercent = 0.9,
                    labels = {"GUITAR GROUND", "TRUMPET", "SIT GROUND", "CROUCH INSPECT", "STARE STOIC", "STERN IDLE", "BADASS", "BARTENDER", "BROOM", "COFFEE", "LEAN WALL", "IMPATIENT"},
                    commands = {"guitar1", "trumpet1", "sitground1", "crouchinspect1", "starestoic1", "sternidles1", "badass1", "bartender1", "broom1", "coffee1", "walllean1", "impatient1"}
                }
            }
        }
    },
    ['shared'] = {
        data = {
            keybind = "F6",
            lastmenu = "animations",
            style = {
                sizePx = 600,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.55,
                    labels = { "Dance"},
                    commands = { "shareddance1"}
                },
               --[[  {
                    navAngle = 270,
                    minRadiusPercent = 0.55,
                    maxRadiusPercent = 0.9,
                    labels = {"Neutral", "Gentle Wave", "Discreet Wave", "Friendly Wave", "Hyped Wave", "Sarcastic", "Humble", "Smooth"},
                    commands = {"neutralt", "gentlevink", "diskretvink", "venligvink", "hypedvink", "sarkastisk", "ydmyg", "smooth"}
                } ]]
            }
        }
    },
    
    ['howdy'] = {
        data = {
            keybind = "F6",
            lastmenu = "animations",
            style = {
                sizePx = 600,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.55,
                    labels = { "Gentle tip", "Discreet tip", "Excited tip", "Tip hat", "Fancy Bow", "Nod", "Tough"},
                    commands = { "gentletip", "diskrettip","svirphat", "tiphat", "fancybuk", "nik", "tough"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.55,
                    maxRadiusPercent = 0.9,
                    labels = {"Neutral", "Gentle Wave", "Discreet Wave", "Friendly Wave", "Hyped Wave", "Sarcastic", "Humble", "Smooth"},
                    commands = {"neutralt", "gentlevink", "diskretvink", "venligvink", "hypedvink", "sarkastisk", "ydmyg", "smooth"}
                }
            }
        }
    },
    ['handlinger'] = {
        data = {
            keybind = "F6",
            lastmenu = "animations",
            style = {
                sizePx = 600,                       -- Wheel size in pixels
                slices = {                          -- Slice style settings
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
                },
                titles = {                          -- Text style settings
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.55,
                    labels = { "Lay Down", "Sit", "Sweat", "Freeze", "Knock", "Operation", "Cry", "Mourn"},
                    commands = {"sove", "sidde", "svede", "fryse", "bankpå", "betjening", "græde", "sørge"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.55,
                    maxRadiusPercent = 0.9,
                    labels = {"Surrender", "Hostage", "Hands up", "Caught", "Cover", "Scared", "Piss", "Full", "Search", "Point", "Freezing cold", "Over Here"},
                    commands = {"overgiv", "Gidsel", "hænderop", "fanget", "dækning", "vige", "pisse", "fuld", "søge", "pege", "hidkald", "fagter"}
                }
            }
        }
    },
    ['skadet'] = {
        data = {
            keybind = "F6",
            lastmenu = "animations",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.55,
                    labels = { "Arm", "Shoulder", "Hip", "Brystet", "Chest", "Neck", "Back"},
                    commands = { "armen", "skulder", "benet", "brystet", "hovedet", "halsen", "ryggen"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.55,
                    maxRadiusPercent = 0.9,
                    labels = {"Dying", "Itches", "Uncomfortable", "Throw up", "Collapse", "Damage 1", "Damage 2", "Sick"},
                    commands = {"døende", "klørsig", "utilpas", "kastop", "kollaps", "lide1", "lide2", "syg"}
                }
            }
        }
    },
    ['danse'] = {
        data = {
            keybind = "F6",
            lastmenu = "animations",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.55,
                    labels = { "Jig", "Awkward","Carefree","Smart","Confident","Drunk 1","Drunk 2","Confident","Wild 2","Drunk 3","Snake","Fire"},
                    commands = { "djig","dakavet","dubekymret","dsmart","dselvsikkert","dance1","dance2","dance3","dance4","dance5","snakedance","firedance"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.55,
                    maxRadiusPercent = 0.9,
                    labels = {"Full","Simple","Formal","Graceful","The hassle","Hyped", "Cheerful", "Wild","Old","Confident 2","Carefree2","Awkward2","Cancan","Sword"},
                    commands = {"dfuld","dsimpelt","dformelt","dyndefuldt","dbesværet","dhyped", "dmuntert", "dvildt","dance6","dance7","dance8","dance9","cancan","sword"}
                }
            }
        }
    },
    ['stående'] = {
        data = {
            keybind = "F6",
            lastmenu = "animations",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.55,
                    labels = { "Nervous", "Drunk", "Seductive", "Feminine", "Careless", "Impatient", "Pending"},
                    commands = { "nervøs", "beruset", "forførende", "feminint", "careless", "utålmodig", "opgivende", "afventende"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.55,
                    maxRadiusPercent = 0.9,
                    labels = {"Hands Belt", "Hands Side", "Badass", "Cross arms", "Confused", "Abandoned", "Guard", "Clear", "Angry", "Sad"},
                    commands = {"hænderbælte", "hænderside", "badass", "krydsarme", "forvirret", "opgivende", "vagt", "klar", "vred", "trist"}
                }
            }
        }
    },
    ['blandet'] = {
        data = {
            keybind = "F6",
            lastmenu = "animations",
            style = {
                sizePx = 600,
                slices = {
                    default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
                    hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
                    selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
                },
                titles = {
                    default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
                    selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                {
                    navAngle = 0,                 -- Oritentation of wheel
                    minRadiusPercent = 0.0,         -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.3,         -- Maximum radius of wheel in percentage
                    labels = {"CLOSE", "STOP"},
                    commands = {"closewheel", "annullere"}
                },
                {
                    navAngle = 270,
                    minRadiusPercent = 0.25,
                    maxRadiusPercent = 0.55,
                    labels = { "Tak", "Please", "Quiet now", "Stinky", "Shh", "Fuck You", "Fight me", "keep up", "Yeeha", "Angry"},
                    commands = { "tak", "please", "rolignu", "puha", "shh", "fuckdig", "fightme", "følgmed", "yeeha", "satans"}
                },
                {
                    navAngle = 288,
                    minRadiusPercent = 0.55,
                    maxRadiusPercent = 0.9,
                    labels = {"Sneaky", "Chicken", "Thumbs up", "Thumbs down", "Gorilla", "Careful", "Flap", "Laugh at", "Laugh", "Challenge", "Air kisses", "Mirror", "Notepad", "Check out", "Flex", "Threat"},
                    commands = {"lusket", "kylling", "thumbsup", "thumbsdown", "gorilla", "holdøje", "klap", "grineaf", "grine", "udfordre", "luftkys", "spejl", "notesblok", "tjekur", "flex", "trussel"}
                }
            }
        }
    },
        

}