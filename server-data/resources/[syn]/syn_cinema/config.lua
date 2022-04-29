Globals = {}

Globals.Shows = {
	["BIGBAND_A"] = {
		animscene = { "script@shows@band_play@p1_and_p2", 2, "PL_P1", false, true },
		curtain = "SAINTDENIS",
		endAtProgress = 0.95,
		entities = {
			{ fields = { "CS_BANDSINGER", 0 }, model = `CS_BANDSINGER` },
			{ fields = { "CS_BANDBASSIST", 0 }, model = `CS_BANDBASSIST` },
			{ fields = { "CS_BANDPIANIST", 0 }, model = `CS_BANDPIANIST` },
			{ fields = { "CS_BANDDRUMMER", 0 }, model = `CS_BANDDRUMMER` },
			{ fields = { "p_benchpiano02x", 0 }, model = `P_BENCHPIANO02X` },
			{ fields = { "p_benchPiano02x^1", 0 }, model = `P_BENCHPIANO02X` },
			{ fields = { "p_cs_contrabass01x", 0 }, model = `P_CS_CONTRABASS01X` },
			{ fields = { "p_cs_drumkit01x", 0 }, model = `P_CS_DRUMKIT01X` },
			{ fields = { "p_drumstick01x", 0 }, model = `P_DRUMSTICK01X` },
			{ fields = { "p_drumstick01x^1", 0 }, model = `P_DRUMSTICK01X` },
			{ fields = { "p_piano01x", 0 }, model = `P_NBXPIANO01X` }
		}
	},
	["BIGBAND_B"] = {
		animscene = { "script@shows@band_play@p1_and_p2", 2, "PL_P2", false, true },
		curtain = "SAINTDENIS",
		endAtProgress = 0.95,
		entities = {
			{ fields = { "CS_BANDSINGER", 0 }, model = `CS_BANDSINGER` },
			{ fields = { "CS_BANDBASSIST", 0 }, model = `CS_BANDBASSIST` },
			{ fields = { "CS_BANDPIANIST", 0 }, model = `CS_BANDPIANIST` },
			{ fields = { "CS_BANDDRUMMER", 0 }, model = `CS_BANDDRUMMER` },
			{ fields = { "p_benchpiano02x", 0 }, model = `P_BENCHPIANO02X` },
			{ fields = { "p_benchPiano02x^1", 0 }, model = `P_BENCHPIANO02X` },
			{ fields = { "p_cs_contrabass01x", 0 }, model = `P_CS_CONTRABASS01X` },
			{ fields = { "p_cs_drumkit01x", 0 }, model = `P_CS_DRUMKIT01X` },
			{ fields = { "p_drumstick01x", 0 }, model = `P_DRUMSTICK01X` },
			{ fields = { "p_drumstick01x^1", 0 }, model = `P_DRUMSTICK01X` },
			{ fields = { "p_piano01x", 0 }, model = `P_NBXPIANO01X` }
		}
	},
	["BULLETCATCH"] = {
		animscene = { "script@shows@bulletcatcher@action", 2, "PL_A_Performance", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "Benjamin", 0 }, model = `CS_ESCAPEARTIST`, flags = { 263, 245, 19, 18, 17, 16, 6 }, ragdollFlag = 524369, ragdoll = false },
			{ fields = { "Assistant", 0 }, model = `CS_ESCAPEARTISTASSISTANT` },
			{ fields = { "BUCKET", 0 }, model = `P_BUCKET03X` },
			{ fields = { "Stool", 0 }, model = `P_BARSTOOL01X` },
			{ fields = { "BOTTLE", 0 }, model = `P_BOTTLEBEER01X` },
			{ fields = { "Gun", 0 }, model = "WEAPON_REVOLVER_CATTLEMAN" },

			{ fields = { "Crowd_Member", 0 }, model = `A_M_O_BlWUpperClass_01` },
			{ fields = { "Crowd_Member_Gun", 0 }, model = "WEAPON_REVOLVER_CATTLEMAN" }
		},
		sequence = {
			{ "PL_E_Volunteer_Challenge", "PL_E_Volunteer_Challenge_ALT" }
		} 

		--[[ Player sequence
			"PL_Player_Volunteered"
			{ "PL_Player_Shot_Stomach", "PL_Player_Shot_Magician" } --// here we can use GetPedLastDamageBone to identify if player hit Benjamin in head
		]]
	},
	["CANCAN_A"] = {
		animscene = { "script@shows@cancan_dance@CanCanDanceP1", 2, "PB_MAIN", false, true },
		position = vector3(2546.41, -1303.55, 46.9),
		rotation = vector3(0.0, 0.0, 40.0),
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "CS_CANCAN_01", 0 }, model = `CS_CANCAN_01` },
			{ fields = { "CS_CANCAN_02", 0 }, model = `CS_CANCAN_02` },
			{ fields = { "CS_CANCAN_03", 0 }, model = `CS_CANCAN_03` },
			{ fields = { "CS_CANCAN_04", 0 }, model = `CS_CANCAN_04` },
			{ fields = { "CS_CANCANMAN_01", 0 }, model = `CS_CANCANMAN_01` }
		}
	},
	["CANCAN_B"] = {
		animscene = { "script@shows@cancan_dance@CanCanDanceP2", 2, 0, false, true },
		position = vector3(2546.41, -1303.55, 46.9),
		rotation = vector3(0.0, 0.0, 40.0),
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "CS_CANCAN_01", 0 }, model = `CS_CANCAN_01` },
			{ fields = { "CS_CANCAN_02", 0 }, model = `CS_CANCAN_02` },
			{ fields = { "CS_CANCAN_03", 0 }, model = `CS_CANCAN_03` },
			{ fields = { "CS_CANCAN_04", 0 }, model = `CS_CANCAN_04` },
			{ fields = { "CS_CANCANMAN_01", 0 }, model = `CS_CANCANMAN_01` }
		}
	},
	["ESCAPEARTIST"] = {
		animscene = { "script@shows@escape_artist@act2_p1@action", 2, "PL_A_Performance", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "Benjamin", 0 }, model = `CS_ESCAPEARTIST` },
			{ fields = { "ASSISTANT_", 0 }, model = `CS_ESCAPEARTISTASSISTANT` },
			{ fields = { "BOX", 0 }, model = `S_ESCAPEBOX01X` },
			{ fields = { "Knife", 0 }, model = `W_MELEE_KNIFE05` },
			{ fields = { "mask", 0 }, model = `P_CS_ESCAPEARTIST_MASK` }
		},
		sequence = {
			{ "PL_C_Reappears_Among_Crowd", "PL_C_Reappears_Among_Crowd_AI" },
			"PL_E_Outro"
		}
	},
	["ESCAPENOOSE"] = { 
		animscene = { "script@shows@escape_noose@act3_p1@action", 2, "PL_A_Performance", false, true },
		curtain = "SAINTDENIS",
		endAtProgress = 0.65,
		entities = {
			{ fields = { "BENJAMIN_NO_JACKET", 0 }, model = `CS_ESCAPEARTIST` },
			{ fields = { "Assistant", 0 }, model = `CS_ESCAPEARTISTASSISTANT` },
			{ fields = { "NOOSE_STAND", 0 }, model = `S_NOOSESTAND01X` },
			{ fields = { "JACKET", 0 }, model = `P_CS_STRAIGHTJACKET` },
			{ fields = { "DIVIDER", 0 }, model = `P_DIVIDER01X` },
			{ fields = { "Noose", 0 }, model = `P_CS_NOOSE01XB` }
		},
		sequence = {
			"PL_B_Trying_To_Escape",
			"PL_C_Choking",
			"PL_E_Shoot_Rope"
		}
	},
	["FIREBREATH"] = {
		animscene = { "script@shows@fire_breather@act2_p1@action", 2, "PL_Dance", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "DANCER", 0 }, model = `CS_FIRE_BREATHER` },
			{ fields = { "BOTTLE", 0 }, model = `P_BOTTLE03X` },
			{ fields = { "STICK_0_", 0 }, model = `S_FIRESTICK01X` },
			{ fields = { "STICK_1_", 0 }, model = `S_FIRESTICK01X` },
			{ fields = { "TABLE", 0 }, model = `P_TABLE_SD_THEATER01X` },
			{ fields = { "lantern", 0 }, model = `P_LIGHT_SD_THEATER01X` }
		},
		sequence = {
			{ "Pl_BreathWin", "Pl_BreathFail" }
		}
	},
	["FIREDANCE_A"] = {
		animscene = { "script@shows@fire_performer@act1_p1@action", 2, 0, false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "PERFORMER", 0 }, model = `CS_FIRE_BREATHER` },
			{ fields = { "BOTTLE", 0 }, model = `P_BOTTLE03X` },
			{ fields = { "lantern", 0 }, model = `P_LIGHT_SD_THEATER01X` },
			{ fields = { "TABLE", 0 }, model = `P_TABLE_SD_THEATER01X` },
			{ fields = { "BATON", 0 }, model = `S_FIREBATON01X` }
		}
	},
	["FIREDANCE_B"] = {
		animscene = { "script@shows@fire_dancer@act3_p1@action", 2, 0, false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "DANCER", 0 }, model = `CS_FIRE_BREATHER` },
			{ fields = { "LOTUS_0", 0 }, model = `S_LOTUSFIREPALM_01X` },
			{ fields = { "LOTUS_1", 0 }, model = `S_LOTUSFIREPALM_01X` },
			{ fields = { "LANTERN", 0 }, model = `P_LIGHT_SD_THEATER01X` }
		}
	},
	["FLEXFIGHT"] = {
		animscene = { "script@shows@flex_fight@act2@action", 2, "pbl_FightIntro", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "PERFORMER", 0 }, model = `CS_FEATSOFSTRENGTH` },
			{ fields = { "Stool", 0 }, model = `P_BARSTOOL01X` },
			{ fields = { "Chair", 0 }, model = `P_THEATERCHAIR01B01X` },
			{ fields = { "Chair^1", 0 }, model = `P_THEATERCHAIR01B01X` },

			{ fields = { "CrowdMember", 0 }, model = `A_M_O_BlWUpperClass_01` }
		},
		sequence = {
			{ "pbl_CrowdChallenge_P2", "pbl_CrowdChallenge_P1" }
		}
	},
	["ODDFELLOWS"] = {
		animscene = { "script@rcm@roddf@ig@roddf_s3@roddf_s3", 2, "pl_Performance", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "CS_GENSTORYFEMALE", 0 }, model = `CS_MISSMARJORIE` },
			{ fields = { "CS_ODDFELLOWSPINHEAD", 0 }, model = `CS_ODDFELLOWSPINHEAD` },
			{ fields = { "CS_MAGNIFICO", 0 }, model = `CS_MAGNIFICO` },
			{ fields = { "p_cs_bullwhip01x", 0 }, model = `P_CS_BULLWHIP01X` },

			{ fields = { "CS_GENSTORYMALE", 0 }, model = `A_M_O_BlWUpperClass_01` }
		}
	},
	["SNAKEDANCE_A"] = {
		animscene = { "script@shows@snake_dancer@act1_p1@action", 2, "PL_DANCE", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "DANCER", 0 }, model = `CS_SWORDDANCER` },
			{ fields = { "SNAKE", 0 }, model = `A_C_SNAKEREDBOA10FT_01` }
		},
		sequence = {
			{ "PL_KISSWIN", "PL_KISSFAIL" }
		}
	},
	["SNAKEDANCE_B"] = {
		animscene = { "script@shows@snake_dancer@act2_p1@action", 2, "PL_DANCE", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "DANCER", 0 }, model = `CS_SWORDDANCER` },
			{ fields = { "SNAKE", 0 }, model = `A_C_SNAKEREDBOA10FT_01` }
		},
		sequence = {
			{ "PL_KISSWIN", "PL_KISSFAIL" }
		}
	},
	["STRONGWOMAN"] = {
		animscene = { "script@shows@feats_of_strength@act1@action", 2, "Pbl_Intro", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "Female", 0 }, model = `CS_FEATSOFSTRENGTH` },
			{ fields = { "male", 0 }, model = `U_M_M_SDSTRONGWOMANASSISTANT_01` },
			{ fields = { "BAR", 0 }, model = `S_RE_STRONGBAR01X` },
			{ fields = { "CHEST", 0 }, model = `P_SDTHEATER_CHEST01X` },
			{ fields = { "HAMMER", 0 }, model = `P_SLEDGEHAMMER01X` },
			{ fields = { "Block", 0 }, model = `S_CINDERBLOCK01X` },
			{ fields = { "BOOK", 0 }, model = `S_RIPPABLEBOOK01X` }
		},
		sequence = {
			{ "PBL_SUCCESS", "pbl_Fail" }
		}
	},
	["SWORDDANCE"] = {
		animscene = { "script@shows@sword_dancer@act3_p1@action", 2, "s_Performance", false, true },
		curtain = "SAINTDENIS",
		entities = {
			{ fields = { "DANCER", 0 }, model = `CS_SWORDDANCER` },
			{ fields = { "Sword", 0 }, model = `P_SWORD01X` }
		},
		sequence = {
			{ "s_Breakout_DownStage", "s_Breakout_CenterStage" }
		}
	},


	["MOVIE"] = {
		animscene = { "( ͡° ͜ʖ ͡°)", 2, "pl_action", false, true },
		entities = {
			{ fields = { "PROJECTIONIST", 0 }, model = `S_M_M_MAGICLANTERN_01` },
			{ fields = { "SLIDE0", 0 }, model = `P_MAGICLANTERNSLIDE01X` },
			{ fields = { "SLIDE1", 0 }, model = `P_MAGICLANTERNSLIDE01X` },
			{ fields = { "SLIDE2", 0 }, model = `P_MAGICLANTERNSLIDE01X` },
			{ fields = { "SLIDE3", 0 }, model = `P_MAGICLANTERNSLIDE01X` },
			{ fields = { "SLIDE4", 0 }, model = `P_MAGICLANTERNSLIDE01X` }
		}
	}
}

Globals.Movies = {
	["BEAR"] = {
		clip = "PL_MLAN_BEAR",
		audio = "ML_Bear_Story_Soundset",
		animscene = "script@shows@magic_lantern@ig2_projectionist@thebear"
	},
	["JOSIAH"] = {
		clip = "PL_MLAN_JOSIAH_BLACKWATER",
		audio = "ML_Blackwater_Soundset",
		animscene = "script@shows@magic_lantern@ig2_projectionist@legendofblackwater"
	},
	["SECRET_OF_MANFLIGHT"] = {
		clip = "PL_MLAN_SECRET_OF_MANFLIGHT",
		audio = "ML_Man_Flight_Soundset",
		animscene = "script@shows@magic_lantern@ig2_projectionist@manflight"
	},
	["SAVIORS_AND_SAVAGES"] = {
		clip = "PL_MLAN_SAVIORS_AND_SAVAGES",
		audio = "ML_See_The_World_Soundset",
		animscene = "script@shows@magic_lantern@ig2_projectionist@saviorsandsavages"
	},
	["GHOST_STORY"] = {
		clip = "PL_MLAN_GHOST_STORY",
		audio = "ML_Ghost_Story_Soundset",
		animscene = "script@shows@magic_lantern@ig2_projectionist@ghastlyserenade"
	},
	["DIRECT_CURRENT_DAMNATION"] = {
		clip = "PL_TOON_DIRECT_CURRENT_DAMNATION",
		audio = "Cartoon_Direct_Current_Soundset"
	},
	["FARMERS_DAUGHTER"] = {
		clip = "PL_TOON_FARMERS_DAUGHTER",
		audio = "Cartoon_Farmers_Daughter_Soundset"
	},
	["MODERN_MEDICINE"] = {
		clip = "PL_TOON_MODERN_MEDICINE",
		audio = "Cartoon_Modern_Medicine_Soundset"
	},
	["WORLDS_STRONGEST_MAN"] = {
		clip = "PL_TOON_WORLDS_STRONGEST_MAN",
		audio = "Cartoon_Strongest_Man_Soundset"
	},
	["SKETCHING_FOR_SWEETHEART"] = {
		clip = "PL_TOON_SKETCHING_FOR_SWEETHEART",
		audio = "Cartoon_Sketching_For_Sweetheart_Soundset"
	},
	["BEAR_TENT"] = {
		clip = "PL_MLAN_BEAR",
		audio = "ML_Bear_Story_Soundset_Tent",
		animscene = "script@shows@magic_lantern@ig2_projectionist@thebear"
	},
	["JOSIAH_TENT"] = {
		clip = "PL_MLAN_JOSIAH_BLACKWATER",
		audio = "ML_Blackwater_Soundset_Tent",
		animscene = "script@shows@magic_lantern@ig2_projectionist@legendofblackwater"
	},
	["SECRET_OF_MANFLIGHT_TENT"] = {
		clip = "PL_MLAN_SECRET_OF_MANFLIGHT",
		audio = "ML_Man_Flight_Soundset_Tent",
		animscene = "script@shows@magic_lantern@ig2_projectionist@manflight"
	},
	["SAVIORS_AND_SAVAGES_TENT"] = {
		clip = "PL_MLAN_SAVIORS_AND_SAVAGES",
		audio = "ML_See_The_World_Soundset_Tent",
		animscene = "script@shows@magic_lantern@ig2_projectionist@saviorsandsavages"
	},
	["GHOST_STORY_TENT"] = {
		clip = "PL_MLAN_GHOST_STORY",
		audio = "ML_Ghost_Story_Soundset_Tent",
		animscene = "script@shows@magic_lantern@ig2_projectionist@ghastlyserenade"
	}
}

Globals.Projections = {
	["SAINTDENIS"] = {
		originPos = vector3(2688.55, -1361.38, 54.24),
		originRot = vector3(7.1, 0.0, 145.6),
		radius = 15.0,

		renderTarget = "bla_theater",
		targetModel = `SCRIPT_RT_VAL_MAGICLANTERN`,
		screenPos = vector3(2702.49, -1348.78, 49.61),
		screenRot = vector3(0.0, 0.0, 130.1),
		renderX = 0.5,
		renderY = 0.5,
		renderScaleX = 1.0,
		renderScaleY = 1.0,
		audiencePos = vector3(2697.2, -1353.5, 49.01),
		volume = 6.0
	},
	["VALENTINE"] = {
		originPos = vector3(-350.055, 701.392, 117.679),
		originRot = vector3(0.0, 0.0, 30.0),
		radius = 10.0,

		renderTarget = "bla_theater",
		targetModel = `SCRIPT_RT_VAL_MAGICLANTERN`,
		screenPos = vector3(-346.8974, 692.4412, 119.3474-1),
		screenRot = vector3(0.0, 0.0, 18.68-3.68),
		renderX = 0.5,
		renderY = 0.5,
		renderScaleX = 1.0,
		renderScaleY = 1.0,
		audiencePos = vector3(-348.45, 697.24, 118.46),
		volume = 1.5
	},
	["BLACKWATER"] = {
		originPos = vector3(-772.29, -1362.65, -45.32),
		originRot = vector3(7.1, 0.0, 145.6),
		radius = 15.0,

		renderTarget = "bla_theater",
		targetModel = `SCRIPT_RT_BLA_THEATER`,
		volume = 1.5,
		screenPos = vector3(-772.29, -1362.65, 45.32),
		screenRot = vector3(0.0, 0.0, 90.0),
		renderX = 0.5,
		renderY = 0.5,
		renderScaleX = 1.0,
		renderScaleY = 1.0,
		audiencePos = vector3(-778.2, -1362.5, 44.75),
		volume = 1.5
	}
}