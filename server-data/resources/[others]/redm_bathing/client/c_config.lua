Config = {}

Config.BathingZones = {
	["SaintDenis"] = {
		dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_ST_DENIS",
		rag = vector4(2629.4, -1223.33, 58.57, -92.66),
		consumer = vector3(2632.6, -1223.79, 59.59),
		lady = `U_F_M_RhdNudeWoman_01`,
		guy = `CS_LeviSimon`,
		door = 779421929
	},
	["Valentine"] = {
		dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_VALENTINE",
		rag = vector4(-317.37, 761.8, 116.44, 10.365),
		consumer = vector3(-320.56, 762.41, 117.44),
		lady = `U_F_M_RhdNudeWoman_01`,
		guy = `CS_LeviSimon`,
		door = 142240370
	},
	["Annesburg"] = {
		dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_ANNESBURG",
		rag = vector4(2952.65, 1334.7, 43.44, -291.27),
		consumer = vector3(2950.42, 1332.15, 44.44),
		lady = `U_F_M_RhdNudeWoman_01`,
		guy = `CS_LeviSimon`,
		door = -201071322
	},
	["Strawberry"] = {
		dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_STRAWBERRY",
		rag = vector4(-1812.83, -373.23, 165.5, 1.206),
		consumer = vector3(-1816.45, -372.44, 166.50),
		lady = `U_F_M_RhdNudeWoman_01`,
		guy = `CS_LeviSimon`,
		door = 1256786197
	},
	["Blackwater"] = {
		dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_BLACKWATER",
		rag = vector4(-823.86, -1318.84, 42.68, -0.459),
		consumer = vector3(-822.82, -1315.72, 43.58),
		lady = `U_F_M_RhdNudeWoman_01`,
		guy = `CS_LeviSimon`,
		door = 1523300673
	},
	["Vanhorn"] = {
		dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_VANHORN",
		rag = vector4(2987.62, 573.21, 46.86, 83.841),
		consumer = vector3(2986.31, 568.27, 47.85),
		lady = `U_F_M_RhdNudeWoman_01`,
		guy = `CS_LeviSimon`,
		door = 1102743282
	},
	["Rhodes"] = {
		dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_RHODES",
		rag = vector4(1336.85, -1378.04, 83.2897, 166.469),
		consumer = vector3(1340.11, -1379.6, 84.28),
		lady = `U_F_M_RhdNudeWoman_01`,
		guy = `CS_LeviSimon`,
		door = -1847993131
	},
	--[[["Tumbleweed"] = {
		dict = "script@mini_game@bathing@BATHING_INTRO_OUTRO_TUMBLEWEED",
		rag = vector4(-5513.76, -2972.3, -1.78, 15.0),
		consumer = vector3(-5517.83, -2973.23, -0.78),
		lady = `CS_BATHINGLADIES_01`,
		door = 1682160693
	}]]
}

Config.BathingModes = {
	{
		transition = "Scrub_Head",
		scrub_freq = 0.75
	},
	{
		transition = "Scrub_Left_Arm",
		scrub_freq = 0.7,
		deluxe = true
	},
	{
		transition = "Scrub_Right_Arm",
		scrub_freq = 0.5,
		deluxe = true
	},
	{
		transition = "Scrub_Right_Leg",
		scrub_freq = 0.6,
		deluxe = true
	},
	{
		transition = "Scrub_Left_Leg",
		scrub_freq = 0.7,
		deluxe = true
	}
}

Config.UndressElements = {
	{ category = "hats", hash = 2569388135 },
	{ category = "masks", hash = 1963323202 },
	{ category = "masks_large", hash = 1249071452 },
	{ category = "neckwear", hash = 1606587013 },
	{ category = "shirts_full", hash = 539411565 },
	{ category = "coats", hash = 0xE06D30CE },
	{ category = "coats_closed", hash = 0x662AC34 },
	{ category = "ponchos", hash = 2937336075 },
	{ category = "cloaks", hash = 1008366797 },
	{ category = "vests", hash = 1214179380 },
	{ category = "gloves", hash = 3938320434 },
	{ category = "gauntlets", hash = 2446236448 },
	{ category = "chaps", hash = 822561179 },
	{ category = "pants", hash = 491541130 },
	{ category = "skirts", hash = 0xA0E3AB7F },
	{ category = "boots", hash = 2004797167 },
    { category = "neckties", hash = 2056714954 },
    { category = "neckwear", hash = 1606587013 },
    { category = "eyewear", hash = 98860198 },                                                                                  
    { category = "holsters_right", hash = 3118660097 },
    { category = "holsters_crossdraw", hash = 1237884315 },
    { category = "ammo_pistols", hash = 1058996709 },
    { category = "holsters_knife", hash = 2078766994 },
    { category = "holsters_left", hash = 3065385517 },
    { category = "ammo_rifles", hash = 3658361941 },
    { category = "loadouts", hash = 2206760584 },
    { category = "gunbelts", hash = 2603387785 },
    { category = "accessories", hash = 2044190614 },
    { category = "jewelry_rings_right", hash = 2053881099 },
    { category = "jewelry_rings_left", hash = 4050263331 },
    { category = "jewelry_bracelets", hash = 2076247897 },    
    { category = "badges", hash = 1065301383 },
    { category = "satchels", hash = 2488290598 },
    { category = "spats", hash = 1363860714 },
    { category = "boot_accessories", hash = 410165049 },
    { category = "legs_accessories", hash = 4048825617 },
    { category = "belts", hash = 2798728390 },
    { category = "belt_buckles", hash = 4209578111 },
    { category = "suspenders", hash = 2272931063 },
    { category = "aprons", hash = 1995498098 },
    { category = "armor", hash = 1927737204 }
}

Config.Special = { ["shirts_full"] = 235, ["pants"] = 198 }

Config.DressElements = {}

Config.Prompts = {
    { label = ("Take a bath($1)"), id = "START_BATHING" },

	{ label = "Wash", id = "SCRUB", control = `INPUT_CONTEXT_X`, time = 2000 },
    { label = ("Order a luxury bath($5)"), id = "REQUEST_DELUXE_BATHING" },

	{ label = "Exit", id = "STOP_BATHING", control = `INPUT_INTERACT_NEG` }
}

Config.CreatedEntries = {}