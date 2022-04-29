Config               = {}

Config.DrawDistance  = 10.0

Config.MarkerColor   = {r = 204, g = 204, b = 0}

Config.Blip          = {sprite = 311, color = 1}

Config.Districts = {
	[178647645] = {name = 'Roanoke'},
	[1308232528] = {name = 'Bluewater Marsh'},
	[2025841068] = {name = 'Bayou Nwa'},
	[-864275692] = {name = 'Scarlett Meadows'},
	[131399519] = {name = 'Heartlands'},
	[-120156735] = {name = 'GrizzliesEast'},
	[1835499550] = {name = 'Cumberland'},
	[1645618177] = {name = 'GrizzliesWest'},
	[822658194] = {name = 'bigvalley'},
	[1684533001] = {name = 'TallTrees'},
	[476637847] = {name = 'greatPlains'},
	[892930832] = {name = 'HennigansStead'},
	[-108848014] = {name = 'ChollaSprings'},
	[-2145992129] = {name = 'RioBravo'},
	[-2066240242] = {name = 'GaptoothRidge'},
} 

Config.Marker = {
 -- ["saint_denis"] = {name = 'Saint Denis', sprite = 0x3C5469D5, x = 2683.95, y = -1441.86, z = 46.16, h = 21.54},
 -- ["rhodes"] = {name = 'Rhodes', sprite = 0x3C5469D5, x = 1262.9, y = -1321.06, z = 76.89, h = 316.94},
 -- ["annesburg"] = {name = 'Annesburg', sprite = 0x3C5469D5, x = 2916.26, y = 1260.84, z = 44.47, h = 67.27},
 -- ["vanhorn"] = {name = 'Vanhorn', sprite = 0x3C5469D5, x = 2970.66, y = 572.16, z = 44.48, h = 81.94},
  ["valentine"] = {name = 'Valentine', sprite = 0x3C5469D5, x = -185.67, y = 641.71, z = 113.58, h = 57.98},
  ["strawberry"] = {name = 'Strawberry', sprite = 0x3C5469D5, x = -1763.13, y = -392.98, z = 156.38, h = 148.29},
  ["blackwater"] = {name = 'Blackwater',  sprite = 0x3C5469D5, x = -858.3, y = -1337.66, z = 44.49, h = 270.98},
  

}

Config.StageCoachSpawn = {
--  ["Saint Denis"] = {x = 2684.93, y = -1436.46, z = 46.07, h = 112.89},
 -- ["Rhodes"] = { x = 1269.4, y = -1315.75, z = 76.4, h = 38.42},
--  ["Annesburg"] = { x = 2913.53, y = 1263.97, z = 44.74, h = 153.37},
--  ["Vanhorn"] = { x = 2965.97, y = 572.61, z = 44.33, h = 173.01},
  ["Valentine"] = { x = -193.33, y = 639.68, z = 113.12, h = 327.9},
  ["Strawberry"] = { x = -1769.64, y = -393.05, z = 156.43, h = 232.66},
  ["Blackwater"] = { x = -864.22, y = -1337.21, z = 43.6, h = 176.63},
}

Config.Cams = {
	["Saint Denis"] = {
		["cam_a"] = {x = 2684.95, y = -1437.48, z = 45.73, h = 112.89},
		["cam_b"] = {x = 2684.95, y = -1436.48, z = 45.73, h = 112.89}
	},

	["Rhodes"] = { 
		["cam_a"] = {x = 1271.71, y = -1318.75, z = 79.4, h = 38.42},
		["cam_b"] = {x = 1269.4, y = -1315.75, z = 79.4, h = 38.42}
	},
	["Annesburg"] = {
		["cam_a"] = {x = 2909.55 , y = 1262.1, z = 44.74, h = 245.36},
		["cam_b"] = {x = 2905.34, y = 1253.29, z = 44.79, h = 294.15},
	},
	["Vanhorn"] = {
		["cam_a"] = {x = 2965.97, y = 576.61, z = 46.95, h = 173.01},
		["cam_b"] = {x = 2965.25 , y = 569.5, z = 46.95, h = 167.52},
	},
	["Valentine"] = {
		["cam_a"] = {x = -194.2, y = 644.65, z = 115.38, h = 229.64},
		["cam_b"] = {x = -195.4 , y = 635.94, z = 115.29, h = 326.09},
	},
	["Strawberry"] = {
		["cam_a"] = {x = -1769.8, y = -392.48, z = 157.5, h = 234.31},
		["cam_b"] = {x = -1766.58 , y = -394.86, z = 157.5, h = 243.83},
	},
	["Blackwater"] = {
		["cam_a"] = {x = -864.0 , y = -1332.54, z = 46.36, h = 176.63},
		["cam_b"] = {x = -864.39, y = -1337.25, z = 46.36, h = 176.68},
	},

}

Config.StagecoachJobSprite = 1560611276 -- Stage Coach Job Blip sprite

Config.Coords = {
	vector3(1254.05, -1327.07, 76.89),
	vector3(2683.95, -1441.86, 46.16),
	vector3(2931.1, 1266.37, 1266.37)
}

Config.PickUp = {
	--[[ ["Braithwaite"] = {
		[1] = {name = 'Pick Up Point', model = "U_M_O_MaPWiseOldMan_01", sprite = 0xDDFBA6AB, x = 1875.4, y = -1853.53, z = 42.64, h = 61.03},
		[2]	= {name = 'Pick Up Point', model = "U_M_M_ISLBUM_01", sprite = 0xDDFBA6AB, x = 859.95, y = -1905.35, z = 44.17, h = 299.76},
	},
	["Caliga"] = {
		[1] = {name = 'Pick Up Point', model = "A_M_M_RANCHER_01", sprite = 0xDDFBA6AB, x = 1845.28, y = -1225.67, z= 42.02, h = 244.96},
		[2] = {name = 'Pick Up Point', model = "CS_braithwaitemaid", sprite = 0xDDFBA6AB, x = 1896.25, y = -1335.6, z= 42.75, h = 303.37},
	},
	["Cumberland"] = {
		[1] = {name = 'Pick Up Point', model = "A_M_O_SDUpperClass_01", sprite = 0xDDFBA6AB, x = 570.62, y = 1687.6, z = 186.46, h = 60.43},
		[2] = {name = 'Pick Up Point', model = "A_F_M_LowerSDTownfolk_03", sprite = 0xDDFBA6AB, x = -71.13, y = 1232.9, z = 170.05, h = 108.54},
	},
	["Saint Denis"] = {
		[1] = {name = 'Pick Up Point', model = "A_F_M_RhdProstitute_01", sprite = 0xDDFBA6AB, x = 2503.32, y = -1185.51, z = 49.22, h = 80.69},
		[2] = {name = 'Pick Up Point', model = "A_F_M_BTCObeseWomen_01", sprite = 0xDDFBA6AB, x = 2716.17, y = -1137.19, z = 50.24, h = 156.52},
	},

	["Scarlett Meadows"] = {
		[1] = {name = 'Pick Up Point', model = "A_F_M_BlWUpperClass_01", sprite = 0xDDFBA6AB, x = 1373.89, y = -1317.13, z = 77.37, h =  122.41},
		[2] = {name = 'Pick Up Point', model = "A_M_M_RhdTownfolk_02", sprite = 0xDDFBA6AB, x = 1059.16, y = -1130.54, z = 67.55, h =  126.78},	
	},
	["Annesburg"] = {
		[1] = {name = 'Pick Up Point', model = "U_M_M_BHT_MINEFOREMAN", sprite = 0xDDFBA6AB, x = 2859.54, y = 1354.76, z = 63.8, h = 178.0},
		[2] = {name = 'Pick Up Point', model = "CS_SOOTHSAYER", sprite = 0xDDFBA6AB, x = 2947.11, y = 1353.7, z = 44.1, h = 70.51},
	},
	["Roanoke"] = {
		[1] = {name = 'Pick Up Point', model = "A_M_M_SDObesemen_01", sprite = 0xDDFBA6AB, x = 2955.73, y = 523.55, z = 44.95, h = 262.07},
	},
	["Bayou Nwa"] = {
		[1] = {name = 'Pick Up Point', model = "U_F_O_WtCTownfolk_01", sprite = 0xDDFBA6AB, x = 2068.69, y = -845.95, z = 43.35, h = 353.97},
		[2] = {name = 'Pick Up Point', model = "A_M_O_BlWUpperClass_01", sprite = 0xDDFBA6AB, x = 2068.69, y = -845.95, z = 43.35, h = 353.97},
	}, ]]
	["Heartlands"] = {
		[1] = {name = 'Pick Up Point', model = "A_M_M_ValFarmer_01", sprite = 0xDDFBA6AB, x = -289.49, y = 673.03, z = 113.85, h = 135.03},
		[2] = {name = 'Pick Up Point', model = "A_M_M_VALDEPUTYRESIDENT_01", sprite = 0xDDFBA6AB, x = -293.99, y = 784.68, z = 119.3, h = 3.64},
		[3] = {name = 'Pick Up Point', model = "CS_FamousGunslinger_06", sprite = 0xDDFBA6AB, x = -818.85, y = 345.57, z = 96.91, h = 189.11},
	},
	["bigvalley"] = {
		[1] = {name = 'Pick Up Point', model = "U_M_M_VALBUTCHER_01", sprite = 0xDDFBA6AB, x = -1778.97, y = -439.08, z = 155.04, h = 31.37},
		[2] = {name = 'Pick Up Point', model = "A_F_M_MIDDLETRAINPASSENGERS_01", sprite = 0xDDFBA6AB, x = -1290.26, y = 400.48, z = 95.2, h = 241.22},
	},
	["greatPlains"] = {
		[1] = {name = 'Pick Up Point', model = "U_M_M_BHT_BLACKWATERHUNT", sprite = 0xDDFBA6AB, x = -832.59, y = -1395.7, z = 43.55, h = 186.92},
		[2] = {name = 'Pick Up Point', model = "A_M_M_CARDGAMEPLAYERS_01", sprite = 0xDDFBA6AB, x = -882.54, y = -1640.79, z = 68.2, h = 62.79},
	},
	["HennigansStead"] = {
		[1] = {name = 'Pick Up Point', model = "A_M_M_UniGunslinger_01", sprite = 0xDDFBA6AB, x = -2005.12, y = -2997.25, z = -5.29, h = 58.3},
		[2] = {name = 'Pick Up Point', model = "MBH_RHODESRANCHER_FEMALES_01", sprite = 0xDDFBA6AB, x = -2353.44, y = -2383.46, z = 62.23, h = 85.42,}
	}

}

Config.Destination = {
--[[ 	["Braithwaite"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 2491.48, y = -1392.52, z = 45.69},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 1304.68, y = -1140.93, z = 81.24},
	},
	["Caliga"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 1010.56, y = -1735.45, z = 45.69},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 2404.27, y = -1267.46, z = 45.62},
	},
	["Cumberland"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 498.4, y = 586.89, z = 108.94},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = -194.99, y = 637.28, z = 113.1},
	},
	["Saint Denis"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 1396.99, y = -1161.1, z = 343.83},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 908.84, y = -1797.07, z = 42.82},
	},
	["Scarlett Meadows"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 1738.37, y = -1373.53, z = 44.05},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 1847.77, y = -1409.57, z = 41.41},
	},
	["Annesburg"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 2510.26, y = 2269.55, z = 176.4},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 2632.28, y = 1719.53, z = 113.11},
	},
	["Roanoke"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 2106.44, y = -595.35, z = 41.33},
	},
	["Bayou Nwa"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 2676.03, y = -1442.68, z = 45.98},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 1429.31, y = 342.87, z = 88.58},
	}, ]]
	["Heartlands"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = 364.23, y = 1457.29, z = 178.81},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = -390.93, y = -108.07, z = 44.72},
	},
	["bigvalley"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = -346.61, y = 766.38, z = 116.17},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = -1719.67, y = -67.46, z = 176.84},
	},
	["greatPlains"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = -1209.75, y = -1935.53, z = 42.82},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = -1422.66, y = -2287.78, z = 42.84},
	},
	["HennigansStead"] = {
		[1] = {name = 'Destination', sprite = 0xDDFBA6AB, x = -2464.3, y = -2848.31, z = 71.22},
		[2] = {name = 'Destination', sprite = 0xDDFBA6AB, x = -2970.71, y = -2276.58, z = 127.29},
	}
}

 