Config = {}

-- Configurable controls
Config.ToggleControl        = `INPUT_PHOTO_MODE_PC`                     -- F6
Config.IncreaseSpeedControl = {`INPUT_CREATOR_LT`, `INPUT_PREV_WEAPON`} -- Page Up, Middle Wheel Up
Config.DecreaseSpeedControl = {`INPUT_CREATOR_RT`, `INPUT_NEXT_WEAPON`} -- Page Down, Middle Wheel Down
Config.UpControl            = `INPUT_JUMP`                              -- Spacebar
Config.DownControl          = `INPUT_SPRINT`                            -- Shift
Config.ForwardControl       = `INPUT_MOVE_UP_ONLY`                      -- W
Config.BackwardControl      = `INPUT_MOVE_DOWN_ONLY`                    -- S
Config.LeftControl          = `INPUT_MOVE_LEFT_ONLY`                    -- A
Config.RightControl         = `INPUT_MOVE_RIGHT_ONLY`                   -- D
Config.ToggleModeControl    = `INPUT_COVER`                             -- Q
Config.FollowCamControl     = `INPUT_MULTIPLAYER_PREDATOR_ABILITY`      -- H

-- Maximum speed
Config.MaxSpeed = 10.0

-- Minimum speed
Config.MinSpeed = 0.1

-- How much speed increases by when speed up/down controls are pressed
Config.SpeedIncrement = 0.1

-- Default speed
Config.Speed = 0.1

-- Whether to enable relative mode by default.
--
-- false: Movement is based on the cardinal directions.
-- 	W = North
-- 	S = South
-- 	A = East
-- 	D = West
--
-- true: Movement is based on the current heading.
-- 	W = forward
-- 	S = backwards
-- 	A = rotate left
-- 	D = rotate right
--
Config.RelativeMode = true

-- Whether to enable follow cam mode by default.
Config.FollowCam = false



Config.AttackTypes = {
	{
		models = {
			`A_C_Alligator_01`,
			`A_C_Alligator_02`,
			`A_C_Alligator_03`,
			`MP_A_C_Alligator_01`
		},
		animation = {
			dict = "creatures_reptile@alligator@melee@streamed_core",
			name = "attack"
		},
		radius = 2.5,
		force = 2.0,
		damage = 25
	},
	{
		models = {
			`A_C_Badger_01`
		},
		animation = {
			dict = "creatures_mammal@badger@melee",
			name = "nip_attack"
		},
		radius = 2.0,
		force = 1.0,
		damage = 15
	},
	{
		models = {
			`A_C_Bear_01`,
			`A_C_BearBlack_01`,
			`MP_A_C_Bear_01`
		},
		animation = {
			dict = "creatures_mammal@bear@melee@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 5.0,
		damage = 30
	},
	{
		models = {
			`A_C_Beaver_01`,
			`MP_A_C_Beaver_01`
		},
		animation = {
			dict = "creatures_mammal@beaver@melee",
			name = "nip_attack"
		},
		radius = 2.0,
		force = 1.0,
		damage = 15
	},
	{
		models = {
			`A_C_Cougar_01`,
			`A_C_Panther_01`,
			`MP_A_C_Cougar_01`,
			`MP_A_C_Panther_01`
		},
		animation = {
			dict = "creatures_mammal@cougar@melee@streamed_core",
			name = "attack"
		},
		radius = 2.0,
		force = 3.0,
		damage = 20
	},
	{
		models = {
			`A_C_Coyote_01`,
			`MP_A_C_Coyote_01`
		},
		animation = {
			dict = "creatures_mammal@coyote@melee@streamed_core",
			name = "attack"
		},
		radius = 2.5,
		force = 2.0,
		damage = 25
	},
	{
		models = {
			`A_C_DogAmericanFoxhound_01`,
			`A_C_DogAustralianShepherd_01`,
			`A_C_DogBluetickCoonhound_01`,
			`A_C_DogCatahoulaCur_01`,
			`A_C_DogChesBayRetriever_01`,
			`A_C_DogCollie_01`,
			`A_C_DogHobo_01`,
			`A_C_DogHound_01`,
			`A_C_DogHusky_01`,
			`A_C_DogLab_01`,
			`A_C_DogLion_01`,
			`A_C_DogPoodle_01`,
			`A_C_DogRufus_01`,
			`A_C_DogStreet_01`,
			`MP_A_C_DogAmericanFoxhound_01`
		},
		animation = {
			dict = "creatures_mammal@dog_pers@melee@streamed_core",
			name = "attack"
		},
		radius = 2.5,
		force = 2.0,
		damage = 20
	},
	{
		models = {
			`A_C_Wolf`,
			`MP_A_C_Wolf_01`,
			`A_C_LionMangy_01`
		},
		animation = {
			dict = "creatures_mammal@wolf@melee@attacks@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 3.0,
		damage = 30
	},
	{
		models = {
			`A_C_Wolf_Medium`
		},
		animation = {
			dict = "creatures_mammal@wolf_medium@melee@attacks@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 3.0,
		damage = 25
	},
	{
		models = {
			`A_C_Wolf_Small`
		},
		animation = {
			dict = "creatures_mammal@wolf_small@melee@attacks@streamed_core",
			name = "attack"
		},
		radius = 3.0,
		force = 3.0,
		damage = 20
	}
}
Config.AttackCooldown = 5000