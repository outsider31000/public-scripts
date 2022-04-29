Config = {}

-- Control to start/stop interactions. Comment this out to disable the control.
Config.InteractControl = 0x4CC0E2FE -- 2

-- Interaction picker menu controls
Config.MenuUpControl = `INPUT_GAME_MENU_UP`
Config.MenuDownControl = `INPUT_GAME_MENU_DOWN`
Config.MenuAcceptControl = `INPUT_GAME_MENU_ACCEPT`
Config.MenuCancelControl = `INPUT_GAME_MENU_CANCEL`

-- Settings for the marker that appears on the currently selected object
Config.MarkerType = 0x26E9DC00
Config.MarkerColor = {254, 127, 156, 128}

-- Effects that may be applied when interacting with objects
Config.Effects = {
	["clean"] = function()
		local ped = PlayerPedId()
		ClearPedEnvDirt(ped)
		ClearPedDamageDecalByZone(ped, 10, "ALL")
		ClearPedBloodDamage(ped)
	end
}

-- List of interactable types of objects.
Config.Interactions = {
	-- Pianos
	{
		isCompatible = PlayerPedIsHuman,
		objects = {"p_piano03x"},
		radius = 2.0,
		scenarios = {
			{name = "PROP_HUMAN_PIANO", isCompatible = PlayerPedIsMale},
			{name = "PROP_HUMAN_ABIGAIL_PIANO", isCompatible = PlayerPedIsFemale}
		},
		x = 0.0,
		y = -0.70,
		z = 0.5,
		heading = 0.0
	},
	{
		isCompatible = PlayerPedIsHuman,
		objects = {"p_piano02x"},
		radius = 2.0,
		scenarios = {
			{name = "PROP_HUMAN_PIANO", isCompatible = PlayerPedIsMale},
			{name = "PROP_HUMAN_ABIGAIL_PIANO", isCompatible = PlayerPedIsFemale}
		},
		x = 0.0,
		y = -0.70,
		z = 0.5,
		heading = 0.0
	},
	{
		isCompatible = PlayerPedIsHuman,
		objects = {"p_nbxpiano01x"},
		radius = 2.0,
		scenarios = {
			{name = "PROP_HUMAN_PIANO", isCompatible = PlayerPedIsMale},
			{name = "PROP_HUMAN_ABIGAIL_PIANO", isCompatible = PlayerPedIsFemale}
		},
		x = -0.1,
		y = -0.75,
		z = 0.5,
		heading = 0.0
	},
	{
		isCompatible = PlayerPedIsHuman,
		objects = {"p_nbmpiano01x"},
		radius = 2.0,
		scenarios = {
			{name = "PROP_HUMAN_PIANO", isCompatible = PlayerPedIsMale},
			{name = "PROP_HUMAN_ABIGAIL_PIANO", isCompatible = PlayerPedIsFemale}
		},
		x = 0.0,
		y = -0.77,
		z = 0.5,
		heading = 0.0
	},
	{
		objects = {"sha_man_piano01"},
		radius = 2.0,
		scenarios = {
			{name = "PROP_HUMAN_PIANO", isCompatible = PlayerPedIsMale},
			{name = "PROP_HUMAN_ABIGAIL_PIANO", isCompatible = PlayerPedIsFemale}
		},
		x = 0.0,
		y = -0.75,
		z = 0.5,
		heading = 0.0
	},
	{
		isCompatible = PlayerPedIsAdult,
		objects = GenericChairs,
		radius = 1.5,
		scenarios = GenericChairAndBenchScenarios,
		x = 0.0,
		y = 0.0,
		z = 0.5,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsAdult,
		objects = GenericChairs,
		radius = 1.5,
		scenarios = {
			{name = "PROP_HUMAN_SEAT_CHAIR_DRINKING"}
		},
		x = 0.0,
		y = 0.05,
		z = -0.1,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsAdult,
		objects = GenericBenches,
		radius = 1.5,
		scenarios = {
			{name = "PROP_HUMAN_SEAT_CHAIR_DRINKING"}
		},
		label = "left",
		x = 0.4,
		y = -0.05,
		z = -0.1,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsAdult,
		objects = GenericBenches,
		radius = 1.5,
		scenarios = {
			{name = "PROP_HUMAN_SEAT_CHAIR_DRINKING"}
		},
		label = "right",
		x = -0.4,
		y = -0.05,
		z = -0.1,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsMale,
		objects = GenericChairs,
		radius = 1.5,
		scenarios = {
			{name = "PROP_HUMAN_SEAT_BENCH_HARMONICA"}
		},
		x = 0.0,
		y = -0.3,
		z = 0.5,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsAdultFemale,
		objects = GenericChairs,
		radius = 1.5,
		scenarios = {
			{name = "PROP_HUMAN_SEAT_CHAIR_FAN"}
		},
		x = 0.0,
		y = 0.0,
		z = 0.5,
		heading = 240.0
	},
	{
		isCompatible = PlayerPedIsAdult,
		objects = {"p_chairrusticsav01x"},
		radius = 1.5,
		scenarios = GenericChairAndBenchScenarios,
		x = 0.0,
		y = -0.1,
		z = 0.5,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsAdult,
		objects = {"p_chairtall01x"},
		radius = 1.5,
		scenarios = GenericChairAndBenchScenarios,
		x = 0.0,
		y = 0.0,
		z = 0.8,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsHuman,
		objects = {"p_barstool01x"},
		radius = 1.5,
		scenarios = GenericChairAndBenchScenarios,
		x = 0.0,
		y = 0.0,
		z = 0.8,
		heading = 0.0
	},
	{
		isCompatible = PlayerPedIsChild,
		objects = GenericChairs,
		radius = 1.5,
		scenarios = GenericChairAndBenchScenarios,
		x = 0.0,
		y = 0.0,
		z = 0.4,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsHuman,
		objects = GenericBenches,
		label = "right",
		radius = 2.0,
		scenarios = GenericChairAndBenchScenarios,
		x = -0.5,
		y = 0.0,
		z = 0.5,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsHuman,
		objects = GenericBenches,
		label = "left",
		radius = 2.0,
		scenarios = GenericChairAndBenchScenarios,
		x = 0.5,
		y = 0.0,
		z = 0.5,
		heading = 180.0
	},
	{
		isCompatible = PlayerPedIsHuman,
		objects = {
			"p_bench17x",
			"p_benchbear01x"
		},
		label = "right",
		radius = 1.5,
		scenarios = GenericChairAndBenchScenarios,
		x = -0.3,
		y = 0.0,
		z = 0.5,
		heading = 180.0
	},
	{
		objects = {
			"p_bench17x",
			"p_benchbear01x"
		},
		label = "left",
		radius = 1.5,
		scenarios = GenericChairAndBenchScenarios,
		x = 0.3,
		y = 0.0,
		z = 0.5,
		heading = 180.0
	},
	{
		objects = {
			"p_bed14x",
			"p_bed17x",
			"p_bed21x",
			"p_bedbunk03x",
			"p_bedindian02x",
			"p_cot01x"
		},
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.0,
		y = 0.0,
		z = 0.5,
		heading = 180.0
	},
	{
		objects = {
			"p_bed20madex",
			"p_cs_pro_bed_unmade",
			"p_cs_bed20madex"
		},
		label = "right",
		radius = 2.0,
		scenarios = BedScenarios,
		x = -0.3,
		y = -0.2,
		z = 0.5,
		heading = 180.0
	},
	{
		objects = {
			"p_bed20madex",
			"p_cs_pro_bed_unmade",
			"p_cs_bed20madex"
		},
		label = "left",
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.3,
		y = -0.2,
		z = 0.5,
		heading = 180.0
	},
	{
		objects = {
			"p_ambbed01x",
			"p_bed03x",
			"p_bed09x",
			"p_bedindian01x",
		},
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.0,
		y = 0.0,
		z = 0.5,
		heading = 270.0
	},
	{
		objects = {
			"p_bed05x"
		},
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.0,
		y = -0.5,
		z = 0.5,
		heading = 180.0
	},
	{
		objects = {
			"p_bed10x",
			"p_bed12x",
			"p_bed13x",
			"p_bed22x"
		},
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.0,
		y = -0.3,
		z = 0.8,
		heading = 180.0
	},
	{
		objects = {
			"p_bed20x"
		},
		label = "right",
		radius = 2.0,
		scenarios = BedScenarios,
		x = -0.3,
		y = -0.2,
		z = 0.8,
		heading = 180.0
	},
	{
		objects = {
			"p_bed20x"
		},
		label = "left",
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.3,
		y = -0.2,
		z = 0.8,
		heading = 180.0
	},
	{
		objects = {
			"p_bedking02x"
		},
		label = "left",
		radius = 2.0,
		scenarios = BedScenarios,
		x = -0.5,
		y = 0.5,
		z = 0.5,
		heading = 180.0
	},
	{
		objects = {
			"p_bedking02x"
		},
		label = "right",
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.5,
		y = 0.5,
		z = 0.5,
		heading = 180.0
	},
	{
		objects = {
			"p_bedrollopen01x",
			"p_bedrollopen03x",
			"p_re_bedrollopen01x",
			"s_bedrollfurlined01x",
			"s_bedrollopen01x",
			"p_amb_mattress04x",
			"p_mattress04x",
			"p_mattress07x",
			"p_mattresscombined01x"
		},
		radius = 1.5,
		scenarios = BedScenarios,
		x = 0.0,
		y = 0.0,
		z = 0.0,
		heading = 180.0
	},
	{
		objects = {
			"p_cs_ann_wrkr_bed01x",
			"p_cs_roc_hse_bed",
			"p_medbed01x"
		},
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.1,
		y = 0.0,
		z = 0.85,
		heading = 270.0
	},
	{
		objects = {
			"p_cs_bedsleptinbed08x"
		},
		label = "left",
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.3,
		y = -0.3,
		z = 0.5,
		heading = 270.0
	},
	{
		objects = {
			"p_cs_bedsleptinbed08x"
		},
		label = "right",
		radius = 2.0,
		scenarios = BedScenarios,
		x = 0.3,
		y = 0.3,
		z = 0.5,
		heading = 270.0
	},

	-- Valentine bath
	
}
