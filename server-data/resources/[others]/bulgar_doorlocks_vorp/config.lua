Config = {}

Config.Doors = {
	id = {
		"P_GUNSMITHTRAPDOOR01X",
	}
}

Config.DoorList = {
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' },
		object = 1281919024,
		objCoords  = vector3(3366.871, -681.5262, 41.66911),
		textCoords  = vector3(3366.871, -681.5262, 41.66911),
		locked = false,
		objYaw = 49.99995803833,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, --Valentine Sheriff Front Door
		object = 1988748538,
		objCoords  = vector3(-276.04, 802.73, 118.41),
		textCoords  = vector3(-275.02, 802.84, 119.43),
		locked = false,
		objYaw = 10.0,
		distance = 1.5
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Sheriff Back Door
		object = 395506985,
		objCoords  = vector3(-275.85, 812.02, 118.41),
		textCoords  = vector3(-277.06, 811.83, 119.38),
		objYaw = -170.0,
		locked = false,
		distance = 1.5
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Cells (Rear Door)
		object = 1508776842,
		objCoords  = vector3(-270.7664, 810.0265, 118.3958),
		textCoords  = vector3(-270.5664, 808.9285, 119.19),
		objYaw = -80.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Cells (Main Door)
		object = 535323366,		
		objCoords  = vector3(-275.03, 809.27, 118.36),
		textCoords  = vector3(-274.89, 808.03, 119.39),
		objYaw = -80.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Cells (Left Door)
		object = 295355979,
		objCoords  = vector3(-273.47, 809.96, 118.36),
		textCoords  = vector3(-272.23, 810.1, 119.39),
		objYaw = 10.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Cells (Right Door)
		object = 193903155,
		objCoords  = vector3(-272.06, 808.25, 118.36),
		textCoords  = vector3(-273.3, 808.12, 119.39),
		objYaw = -170.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Bank (Gate to Hallway)
		object = 2343746133,
		objCoords  = vector3(-301.94, 771.75, 117.72),
		textCoords  = vector3(-303.02, 771.60, 118.47),
		objYaw = -170.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Bank (Teller Door)
		object = 1340831050,
		objCoords  = vector3(-311.75, 774.67, 117.72),
		textCoords  = vector3(-310.48, 774.92, 118.70),
		objYaw = 10.05,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Bank (Office Door - Teller Room)
		object = 3718620420,
		objCoords  = vector3(-311.06, 770.12, 117.7),
		textCoords  = vector3(-309.97, 770.20, 118.70),
		objYaw = 10.36,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Bank (Office Door - Hallway)
		object = 334467483,
		objCoords  = vector3(-302.93, 767.6, 117.69),
		textCoords  = vector3(-302.97, 768.61, 118.70),
		objYaw = 100.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Vault Door
		object = 576950805,
		objCoords  = vector3(-307.76, 766.34, 117.7),
		textCoords  = vector3(-306.60, 766.65, 118.70),
		objYaw = -170.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Bank (Rear Door)
		object = 2307914732,
		objCoords  = vector3(-301.51, 762.98, 117.73),
		textCoords  = vector3(-300.59, 763.20, 118.70),
		objYaw = 10.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Valentine Saloon (Rear Left Door)
		object = 1013933832,
		objCoords  = vector3(-238.9688873291,774.22943115234,117.14748382568),
		textCoords  = vector3(-238.9688873291,774.22943115234,117.14748382568),
		objYaw = 290.0,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'gunsmith' }, -- Valentine Gunsmith (Rear Door)
		object = 2042647667,
		objCoords  = vector3(-276.65576171875,776.60430908203,118.54555511475),
		textCoords  = vector3(-276.65576171875,776.60430908203,118.54555511475),
		objYaw = 179.99998474121,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Fort Wallace Jail Cell
		object = 4248740658,
		objCoords  = vector3(346.23724365234,1468.9339599609,178.72691345215),
		textCoords  = vector3(346.23724365234,1468.9339599609,178.72691345215),
		objYaw = 215.19097900391,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Fort Wallace Weapons Shelter Door
		object = 1223148325,
		objCoords  = vector3(363.3249, 1488.73, 179.6615),
		textCoords  = vector3(363.3249, 1488.73, 179.6615),
		objYaw = 104.99097442627,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Rhodes Bank Main Doors
		object = 3317756151,
		object2 = 3088209306,
		objCoords  = vector3(1296.2719726563,-1299.0120849609,76.03963470459),
		textCoords  = vector3(1295.363, -1298.380, 77.04),
		objYaw = 139.53230285645,
		objYaw2 = 319.59982299805,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Rhodes Bank Teller Door
		object = 1634148892,
		objCoords  = vector3(1295.7341308594,-1305.4748535156,76.033004760742),
		textCoords  = vector3(1295.7341308594,-1305.4748535156,76.033004760742),
		objYaw = 139.99998474121,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Rhodes Bank Hallway Door
		object = 2058564250,
		objCoords  = vector3(1285.1475830078,-1303.1185302734,76.040069580078),
		textCoords  = vector3(1285.1475830078,-1303.1185302734,76.040069580078),
		objYaw = 320.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Rhodes Bank Vault Door
		object = 3483244267,
		objCoords  = vector3(1282.5363769531,-1309.3159179688,76.036422729492),
		textCoords  = vector3(1282.5363769531,-1309.3159179688,76.036422729492),
		objYaw = 230.05541992188,
		locked = true,
		distance = 2.0
	},
	--[[ {
		authorizedJobs = { 'police', 'marshal', 'pinkerton' }, -- Rhodes Bank Rear Door
		object = 3142122679,
		objCoords  = vector3(1278.8559570313,-1310.4030761719,76.039642333984),
		textCoords  = vector3(1278.8559570313,-1310.4030761719,76.039642333984),
		objYaw = 319.73440551758,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton' }, -- Rhodes Bank Rear Door Gate
		object = 559643844,
		objCoords  = vector3(1279.419, -1311.433, 76.03201),
		textCoords  = vector3(1279.419, -1311.433, 76.03201),
		objYaw = 140.0,
		locked = true,
		distance = 2.0
	}, ]]
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Rhodes Sheriff Front Door
		object = 349074475,
		objCoords  = vector3(1359.71, -1305.97, 76.76),
		textCoords  = vector3(1358.42, -1305.71, 77.72),
		objYaw = 160.0,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Rhodes Sheriff Back Door
		object = 1614494720,
		objCoords  = vector3(1359.12, -1297.56, 76.78),
		textCoords  = vector3(1358.51, -1298.95,77.78),
		objYaw = -110.0,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Rhodes Jail Cell
		object = 1878514758,
		objCoords  = vector3(1357.26, -1301.58, 77.76),
		textCoords  = vector3(1357.26, -1301.58, 77.76),
		objYaw = 70.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Main Doors
		object = 1595076728,
		object2 = 1439227364,
		objCoords  = vector3(1012.2030029297,-1762.0412597656,46.599708557129),
		textCoords  = vector3(1011.147, -1761.94, 47.60),
		objYaw = 359.84088134766,
		objYaw2 = 359.78961181641,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Rear Main Doors
		object = 1620578985,
		object2 = 3222102077,
		objCoords  = vector3(1010.4942016602,-1779.3802490234,46.609394073486),
		textCoords  = vector3(1011.13, -1779.31, 47.60),
		objYaw = 0.0,
		objYaw2 = 0.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Right Side Double Doors (Front)
		object = 1299101427,
		object2 = 530930529,
		objCoords  = vector3(1000.0399169922,-1765.6871337891,46.62434387207),
		textCoords  = vector3(1000.09, -1765.00, 47.58),
		objYaw = 270.0,
		objYaw2 = 269.99993896484,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Right Side Double Doors (Middle)
		object = 785447352,
		object2 = 23338719,
		objCoords  = vector3(1000.0394897461,-1769.2019042969,46.623123168945),
		textCoords  = vector3(1000.25, -1768.49, 47.62),
		objYaw = 270.0,
		objYaw2 = 269.99993896484,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Right Side Double Doors (Rear)
		object = 1606293329,
		object2 = 1913469935,
		objCoords  = vector3(1000.0346679688,-1773.2373046875,46.626728057861),
		textCoords  = vector3(1000.29, -1772.52, 47.58),
		objYaw = 270.18923950195,
		objYaw2 = 269.72958374023,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Left Side Double Doors (Door 1)
		object = 1970779164,
		object2 = 2276841624,
		objCoords  = vector3(1022.5345458984,-1765.7020263672,46.624011993408),
		textCoords  = vector3(1022.56, -1765.02, 47.66),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Left Side Double Doors (Door 2)
		object = 2630222520,
		object2 = 2919540021,
		objCoords  = vector3(1022.5319213867,-1769.2026367188,46.623615264893),
		textCoords  = vector3(1022.29, -1768.59, 47.58),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Left Side Double Doors (Door 3)
		object = 606588923,
		object2 = 248030525,
		objCoords  = vector3(1022.5319213867,-1774.5867919922,46.624011993408),
		textCoords  = vector3(1022.58, -1773.90, 47.65),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Left Side Double Doors (Door 4)
		object = 3330577590,
		object2 = 825059846,
		objCoords  = vector3(1022.5319213867,-1777.7064208984,46.624011993408),
		textCoords  = vector3(1022.59, -1776.98, 47.65),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Main Double Doors Top (Front)
		object = 4142860936,
		object2 = 473912616,
		objCoords  = vector3(1012.2028808594,-1762.0411376953,51.012351989746),
		textCoords  = vector3(1011.10, -1761.94, 52.05),
		objYaw = 359.71206665039,
		objYaw2 = 0.30076456069946,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Main Double Doors Top Right (Door 1)
		object = 2443210508,
		object2 = 2744488746,
		objCoords  = vector3(1005.6744995117,-1761.9895019531,51.060958862305),
		textCoords  = vector3(1006.35, -1762.05, 52.09),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Main Double Doors Top Right Side (Door 1)
		object = 3195947259,
		object2 = 1799856783,
		objCoords  = vector3(1000.0388183594,-1763.5151367188,51.063438415527),
		textCoords  = vector3(999.90, -1764.20, 52.08),
		objYaw = 270.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Main Double Doors Top Right Side (Door 2)
		object = 1518993684,
		object2 = 426802898,
		objCoords  = vector3(1000.0388183594,-1767.8270263672,51.060958862305),
		textCoords  = vector3(1000.14, -1768.50, 52.05),
		objYaw = 270.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Main Double Doors Top Right Side (Door 3)
		object = 2645129384,
		object2 = 2420104661,
		objCoords  = vector3(1000.009765625,-1774.8167724609,51.060527801514),
		textCoords  = vector3(1000.18, -1775.58, 52.05),
		objYaw = 270.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Main Double Doors Top Left (Door 2)
		object = 121494125,
		object2 = 3046979385,
		objCoords  = vector3(1002.5340576172,-1761.9896240234,51.060958862305),
		textCoords  = vector3(1001.85, -1761.86, 52.08),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Left Side Double Doors Top Left (Door 1)
		object = 1909255102,
		object2 = 3386579929,
		objCoords  = vector3(1022.5201416016,-1767.8416748047,51.044216156006),
		textCoords  = vector3(1022.22, -1768.52, 52.04),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Left Side Double Doors Top Left (Door 2)
		object = 3879050174,
		object2 = 409697833,
		objCoords  = vector3(1022.520324707,-1776.1264648438,51.04598236084),
		textCoords  = vector3(1022.77, -1775.44, 52.05),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Braithwaite Manor Left Side Double Doors Top Left (Door 2)
		object = 3879050174,
		objCoords  = vector3(1022.520324707,-1776.1264648438,51.04598236084),
		textCoords  = vector3(1022.77, -1775.44, 52.05),
		objYaw = 90.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Saint Denis Jail Cell
		object = 3921310299,
		objCoords  = vector3(1115.868, -1989.719, 54.37629),
		textCoords  = vector3(1115.55, -1988.85, 55.35629),
		objYaw = 115.415,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Saint Denis Jail Cell
		object = 1995743734,
		objCoords  = vector3(2499.75, -1309.87, 47.95),
		textCoords  = vector3(2499.75, -1309.87, 48.95),
		objYaw = 180.35,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Saint Denis Jail Cell
		object = 2515591150,
		objCoords  = vector3(2503.63, -1309.87, 47.95),
		textCoords  = vector3(2503.63, -1309.87, 48.95),
		objYaw = 180.35,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Saint Denis Jail Cell
		object = 3365520707,
		objCoords  = vector3(2498.5, -1307.85, 47.95),
		textCoords  = vector3(2498.5, -1307.85, 48.95),
		objYaw = -360.35,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Saint Denis Doctor Surgery Door
		object = 1289094734,
		objCoords  = vector3(2727.434, -1229.163, 49.3678),
		textCoords  = vector3(2727.434, -1229.163, 49.3678),
		objYaw = 270.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Saint Denis Doctor/Pharmacy
		object = 586229709,
		objCoords  = vector3(2723.953125,-1227.0920410156,49.367786407471),
		textCoords  = vector3(2723.953125,-1227.0920410156,49.367786407471),
		objYaw = 270.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Saint Denis Doctor Back Door
		object = 1104407261,
		objCoords  = vector3(2725.1469726563,-1221.6247558594,49.367805480957),
		textCoords  = vector3(2725.1469726563,-1221.6247558594,49.367805480957),
		objYaw = 0.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'police', 'marshal', 'pinkerton', 'doctor' }, -- Saint Denis Pharmacy Front Doors
		object = 3723126486,
		object2 = 79213682,
		objCoords  = vector3(2715.9943847656,-1230.2332763672,49.371280670166),
		textCoords  = vector3(2716.2651367188, -1229.3813476563, 50.36576461792),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Annesburg Jail Cell (Right)
		object = 1502928852,
		objCoords  = vector3(2904.2734375,1314.3405761719,43.935844421387),
		textCoords  = vector3(2904.791, 1315.474, 44.96082),
		objYaw = 69.264205932617,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Annesburg Jail Cell (Left)
		object = 1657401918,
		objCoords  = vector3(2902.9602050781,1310.8717041016,43.935844421387),
		textCoords  = vector3(2903.478, 1312.005, 44.96082),
		objYaw = 69.264205932617,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Annesburg Sheriff Front Door
		object = 2212368673,
		objCoords  = vector3(2911.140625,1309.8092041016,43.928840637207),
		textCoords  = vector3(2911.140625,1309.8092041016,43.928840637207),
		objYaw = 69.545677185059,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Armadillo Sheriff Front Door
		object = 66424668,
		objCoords  = vector3(-3624.6982421875,-2605.4157714844,-14.351517677307),
		textCoords  = vector3(-3624.6982421875,-2605.4157714844,-14.351517677307),
		objYaw = 115.00002288818,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Armadillo Jail Cell Door (Right)
		object = 4235597664,
		objCoords  = vector3(-3619.1481933594,-2604.2065429688,-14.351593017578),
		textCoords  = vector3(-3618.697, -2605.369, -13.3268),
		objYaw = 295.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Armadillo Jail Cell Door (Left)
		object = 4016307508,
		objCoords  = vector3(-3620.9931640625,-2600.2490234375,-14.351593017578),
		textCoords  = vector3(-3620.542, -2601.411, -13.3268),
		objYaw = 295.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Armadillo Bank
		object = 3101287960,
		objCoords  = vector3(-3666.0139160156,-2620.8779296875,-14.569600105286),
		textCoords  = vector3(-3666.0139160156,-2620.8779296875,-14.569600105286),
		objYaw = 0.0,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Armadillo Bank (Teller Gate)
		object = 3550475905,
		objCoords  = vector3(-3661.1369628906,-2627.3623046875,-14.586261749268),
		textCoords  = vector3(-3661.1369628906,-2627.3623046875,-14.586261749268),
		objYaw = 180.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Armadillo Bank (Back Door)
		object = 1366165179,
		objCoords  = vector3(-3663.1545410156,-2638.9812011719,-14.571752548218),
		textCoords  = vector3(-3663.1545410156,-2638.9812011719,-14.571752548218),
		objYaw = 0.0,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Tumbleweed Jail Main Entrance
		object = 2735269038,
		objCoords  = vector3(-5527.6767578125,-2930.4975585938,-2.3662209510803),
		textCoords  = vector3(-5527.6767578125,-2930.4975585938,-2.3662209510803),
		objYaw = 205.0,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Tumbleweed Jail Cell Main
		object = 831345624,
		objCoords  = vector3(-5529.9135742188,-2925.0739746094,-2.3601191043854),
		textCoords  = vector3(-5529.463, -2926.236, -1.33514),
		objYaw = 295.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Tumbleweed Jail Cell Front
		object = 2677989449,
		objCoords  = vector3(-5531.462890625,-2921.751953125,-2.3601191043854),
		textCoords  = vector3(-5531.012, -2922.914, -1.33514),
		objYaw = 295.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'ranger' }, -- Tumbleweed Jail Cell Front
		object = 2984805596,
		objCoords  = vector3(-5532.9072265625,-2918.6538085938,-2.3601191043854),
		textCoords  = vector3(-5532.457, -2919.816, -1.33514),
		objYaw = 295.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Strawberry Jail Front Door
		object = 1821044729,
		objCoords  = vector3(-1806.6751708984,-350.31280517578,163.6475982666),
		textCoords  = vector3(-1806.6751708984,-350.31280517578,163.6475982666),
		objYaw = 245.07702636719,
		locked = false,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Strawberry Jail Rear Door
		object = 1514359658,
		objCoords  = vector3(-1812.6691894531,-345.08489990234,163.6475982666),
		textCoords  = vector3(-1812.6691894531,-345.08489990234,163.6475982666),
		objYaw = 244.99990844727,
		locked = true,
		distance = 3.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Strawberry Jail Cell
		object = 902070893,
		objCoords  = vector3(-1814.58, -353.71, 161.43),
		textCoords  = vector3(-1814.58, -353.71, 161.43),
		objYaw = -115.0,
		locked = true,
		distance = 1.5
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Strawberry Jail Cell
		object = 1207903970,
		objCoords  = vector3(-1811.40, -352.19, 161.39),
		textCoords  = vector3(-1811.40, -352.19, 161.39),
		objYaw = -26.0,
		locked = true,
		distance = 1.5
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Blackwater Bath House Secondary Door
		object = 815031507,
		objCoords  = vector3(-824.1289, -1322.801, 42.68617),
		textCoords  = vector3(-824.1289, -1321.801, 43.66617),
		objYaw = 90.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Blackwater Sheriff Back Door
		object = 2810801921,
		objCoords  = vector3(-769.14, -1268.75, 42.06),
		textCoords  = vector3(-769.14, -1269.75, 44.04),
		objYaw = -90.0,
		locked = false,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' },
		object = 2514996158,
		objCoords  = vector3(-765.75, -1263.47, 42.06),
		textCoords  = vector3(-765.75, -1263.47, 44.3),
		objYaw = 90.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' },
		object = 2167775834,
		objCoords  = vector3(-763.53, -1263.71, 42.06),
		textCoords  = vector3(-763.53, -1263.71, 44.3),
		objYaw = -90.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Blackwater Sheriff Front Door
		object = 3410720590,
		object2 = 3821185084,
		objCoords  = vector3(-757.05, -1268.49, 42.06),
		textCoords  = vector3(-757.05, -1269.34, 44.04),
		objYaw = 90.41,
		objYaw2 = 90.0,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'marshal', 'pinkerton', 'police'}, -- Valentine Doctors Office (Front Door)
		object = 3588026089,
		objCoords  = vector3(-282.81, 803.85, 118.39),
		textCoords  = vector3(-283.81, 803.85, 119.39),
		objYaw = -170.0,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'marshal', 'pinkerton', 'police'}, -- Valentine Doctors Office (Middle Door)
		object = 4067537969,
		objCoords  = vector3(-286.64199829102,809.78454589844,118.42121887207),
		textCoords  = vector3(-287.65, 809.76, 119.39),
		objYaw = 190.0,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'marshal', 'pinkerton', 'police' }, -- Valentine Doctors Office (Back Room Back Door)
		object = 3439738919,
		objCoords  = vector3(-281.18, 815.41, 118.39),
		textCoords  = vector3(-281.18, 816.2, 119.39),
		objYaw = 99.663230895996,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'marshal', 'pinkerton', 'police' }, -- Valentine Doctors Office (Back Room Door)
		object = 925575409,
		objCoords  = vector3(-290.72, 813.29, 118.41),
		textCoords  = vector3(-289.8, 813.29, 119.39),
		objYaw = 10.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'gunsmith' }, -- Valentine Gunshop Rear Door
		object = -1669881355,
		objCoords  = vector3(1326.038, -1326.383, 76.92236),
		textCoords  = vector3(1326.038, -1326.383, 76.92236),
		objYaw = 16.29368591309,
		locked = false,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'marshal', 'pinkerton', 'police' }, -- Saint Denis Bank Vault Door
		object = 1751238140,
		objCoords  = vector3(2643.301, -1300.427, 51.255841),
		textCoords  = vector3(2643.301, -1300.427, 51.255841),
		objYaw = 159.90571594238,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Saint Denis Bank Manager Double Doors
		object = 1634115439,
		object2 = 965922748,
		objCoords  = vector3(2646.983, -1300.896, 51.245381),
		textCoords  = vector3(2648.03, -1300.46, 52.24),
		objYaw = 204.7395324707,
		objYaw2 = 204.58697509766,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Saint Denis North Double Doors
		object = 2089945615,
		object2 = 2817024187,
		objCoords  = vector3(2640.176, -1286.343, 51.24601),
		textCoords  = vector3(2641.05, -1285.57, 52.26),
		objYaw = 204.83293151855,
		objYaw2 = 205.17900085449,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton' }, -- Saint Denis West Double Doors
		object = 2158285782,
		object2 = 1733501235,
		objCoords  = vector3(2637.798, -1298.037, 51.24601),
		textCoords  = vector3(2637.92, -1299.12, 52.24),
		objYaw = 294.84509277344,
		objYaw2 = 294.71026611328,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government Main Doors
		object = 2712742172,
		object2 = 1401130182,
		objCoords  = vector3(2402.515, -1095.564, 46.42542),
		textCoords  = vector3(2401.52, -1095.60, 47.42),
		objYaw = 179.99998474121,
		objYaw2 = 0.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government West Side (Door 1)
		object = 463894517,
		object2 = 1440476271,
		objCoords  = vector3(2387.719, -1092.577, 46.42515),
		textCoords  = vector3(2387.66, -1093.29, 47.44),
		objYaw = 270.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government West Side (Door 2)
		object = 4251106158,
		object2 = 895396725,
		objCoords  = vector3(2387.719, -1090.261, 46.42515),
		textCoords  = vector3(2387.66, -1090.86, 47.44),
		objYaw = 270.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government West Side (Door 3)
		object = 2430556805,
		object2 = 260726717,
		objCoords  = vector3(2387.719, -1087.927, 46.42515),
		textCoords  = vector3(2387.66, -1088.75, 47.44),
		objYaw = 270.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government West Side (Door 4)
		object = 515307058,
		object2 = 2191834640,
		objCoords  = vector3(2387.718, -1085.609, 46.42515),
		textCoords  = vector3(2387.66, -1086.25, 47.44),
		objYaw = 270.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'marshal', 'pinkerton', 'police', 'government' }, -- Saint Denis Government West Side (Door 5)
		object = 957998097,
		objCoords  = vector3(2387.85, -1083.439, 46.43348),
		textCoords  = vector3(2387.57, -1082.439, 47.42),
		objYaw = 90.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government Rear (Door 1 - Left to Right)
		object = 64755943,
		object2 = 1282026246,
		objCoords  = vector3(2406.744, -1071.16, 46.42515),
		textCoords  = vector3(2406.04, -1071.13, 47.42),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government Rear (Door 2)
		object = 1072042494,
		object2 = 1881469563,
		objCoords  = vector3(2403.08, -1071.16, 46.42515),
		textCoords  = vector3(2403.64, -1071.03, 47.42),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government Rear (Door 3)
		object = 4081383617,
		object2 = 3851050316,
		objCoords  = vector3(2402.107, -1071.16, 46.42515),
		textCoords  = vector3(2401.38, -1071.03, 47.42),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government Rear (Door 4)
		object = 4171676960,
		object2 = 714041173,
		objCoords  = vector3(2399.788, -1071.16, 46.42515),
		textCoords  = vector3(2399.11, -1071.03, 47.42),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government Rear (Door 5)
		object = 3301481377,
		object2 = 4111629364,
		objCoords  = vector3(2397.47, -1071.16, 46.42515),
		textCoords  = vector3(2396.77, -1071.03, 47.42),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government East Side (Door 1)
		object = 2049189737,
		object2 = 1214137310,
		objCoords  = vector3(2415.255, -1094.434, 46.42515),
		textCoords  = vector3(2415.65, -1093.79, 47.42),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government East Side (Door 2)
		object = 1462821251,
		object2 = 883203179,
		objCoords  = vector3(2415.255, -1091.952, 46.42515),
		textCoords  = vector3(2415.44, -1091.29, 47.42),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government East Side (Door 3)
		object = 1123170566,
		object2 = 287888768,
		objCoords  = vector3(2415.255, -1089.466, 46.42515),
		textCoords  = vector3(2415.64, -1088.81, 47.42),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government East Side (Door 4)
		object = 534737645,
		object2 = 4263849849,
		objCoords  = vector3(2415.251, -1086.98, 46.42515),
		textCoords  = vector3(2415.24, -1086.29, 47.42),
		objYaw = 90.0,
		objYaw2 = 90.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government East Side (Door 5)
		object = 681362779,
		object2 = 981199129,
		objCoords  = vector3(2415.545, -1084.083, 46.42515),
		textCoords  = vector3(2416.13, -1084.02, 47.42),
		objYaw = 0.0,
		objYaw2 = 0.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (South)
		object = 3763675028,
		object2 = 3191069522,
		objCoords  = vector3(2402.516, -1095.562, 51.43517),
		textCoords  = vector3(2401.29, -1095.73, 52.42),
		objYaw = 180.0,
		objYaw2 = 0.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (West - Door 1)
		object = 1837549341,
		object2 = 1181972723,
		objCoords  = vector3(2387.941, -1092.599, 51.43631),
		textCoords  = vector3(2387.78, -1093.28, 52.44),
		objYaw = 90.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (West - Door 2)
		object = 1359679014,
		object2 = 2612896650,
		objCoords  = vector3(2387.855, -1090.252, 51.43631),
		textCoords  = vector3(2387.66, -1090.95, 52.47),
		objYaw = 90.0,
		objYaw2 = 270.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (East - Door 1)
		object = 2456557508,
		object2 = 1863994303,
		objCoords  = vector3(2415.77, -1084.083, 51.4253),
		textCoords  = vector3(2416.49, -1084.05, 52.45),
		objYaw = 0.0,
		objYaw2 = 0.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (Rear - Door 1 - Left to Right)
		object = 3024919785,
		object2 = 993734236,
		objCoords  = vector3(2406.743, -1071.105, 51.42515),
		textCoords  = vector3(2405.91, -1071.00, 52.43),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (Rear - Door 2)
		object = 3738400142,
		object2 = 3431780609,
		objCoords  = vector3(2404.425, -1071.105, 51.42515),
		textCoords  = vector3(2403.82, -1070.82, 52.43),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (Rear - Door 3)
		object = 2189442277,
		object2 = 1881184294,
		objCoords  = vector3(2402.107, -1071.105, 51.42515),
		textCoords  = vector3(2401.45, -1071.30, 52.42),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (Rear - Door 4)
		object = 3130699033,
		object2 = 2833320358,
		objCoords  = vector3(2399.788, -1071.105, 51.42515),
		textCoords  = vector3(2399.11, -1071.06, 52.43),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government' }, -- Saint Denis Government 2nd Floor (Rear - Door 5)
		object = 3745412704,
		object2 = 3448492795,
		objCoords  = vector3(2397.474, -1071.105, 51.42515),
		textCoords  = vector3(2396.72, -1071.08, 52.43),
		objYaw = 180.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'doctor', 'police', 'marshal', 'pinkerton', 'government', 'bmgunsmith' }, -- Saint Denis Weapon Shop (Front Doors)
		object = 3283200993,
		object2 = 1057071735,
		objCoords  = vector3(2720.815, -1283.54, 48.63758),
		textCoords  = vector3(2720.40, -1282.44, 49.63),
		objYaw = 115.0,
		objYaw2 = 295.0,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'marshal', 'pinkerton', 'police', 'government', 'bmgunsmith' }, -- Saint Denis Weapon Shop (Rear Door)
		object = 841127028,
		objCoords  = vector3(2710.566, -1291.204, 48.6323),
		textCoords  = vector3(2710.68, -1290.21, 49.63),
		objYaw = 115.0,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = { 'doctor', 'marshal', 'pinkerton', 'police', 'government', 'bmgunsmith' }, -- Saint Denis Weapon Shop (Top Rear Door)
		object = 1180868565,
		objCoords  = vector3(2711.438, -1293.084, 59.45848),
		textCoords  = vector3(2711.92, -1293.65, 60.45),
		objYaw = 295.0,
		locked = true,
		distance = 2.0
	},
	{
		authorizedJobs = {'doctor', 'marshal', 'pinkerton', 'police', 'government', 'bmgunsmith' }, -- Saint Denis Weapon Shop (Top Rear Door)
		object = 393076024,
		objCoords  = vector3(1326.427734375, -1319.0665283203, 76.890922546387),
		textCoords  = vector3(1326.427734375, -1319.0665283203, 76.890922546387),
		objYaw = 345.0,
		locked = false,
		distance = 2.0
	},
	{
		authorizedJobs = {'doctor', 'police', 'pinkerton', 'gunsmith', 'government', 'bmgunsmith' }, -- Saint Denis Weapon Shop (Top Rear Door)
		object = 1410133961,
		objCoords  = vector3(1325.2141113281, -1323.6387939453, 76.89241027832),
		textCoords  = vector3(1325.2141113281, -1324.6387939453, 77.89),
		objYaw = 255.0,
		locked = true,
		distance = 2.0
	}
}