Config = {}
local door_hashes = {
    -408139633,      -- BANCO DE VALENTINE
    -1652509687,     -- BANCO DE VALENTINE
    -1477943109,     -- BANCO DE SAINT DENIS
    2089945615,      -- BANCO DE SAINT DENIS
    -2136681514,     -- BANCO DE SAINT DENIS
    1733501235,      -- BANCO DE SAINT DENIS
    -977211145,      -- BANCO DE RHODES
    -1206757990,     -- BANCO DE RHODES
    531022111,       -- BANCO DE BLACKWATER
}

Citizen.CreateThread(function()
    for k,v in pairs(door_hashes) do 
        Citizen.InvokeNative(0xD99229FE93B46286,v,1,1,0,0,0,0)
        Citizen.InvokeNative(0x6BAB9442830C7F53,v,0) 
    end
end)

Config.DoorList = {
	{
		authorizedJobs = { 'police', 'marshal' }, -- Valentine Cells (Main Door)
		object = 535323366,		
		objCoords  = vector3(-275.03, 809.27, 118.36),
		textCoords  = vector3(-274.89, 808.03, 119.39),
		objYaw = -80.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'police', 'marshal' }, -- Valentine Cells (Left Door)
		object = 295355979,
		objCoords  = vector3(-273.47, 809.96, 118.36),
		textCoords  = vector3(-272.23, 810.1, 119.39),
		objYaw = 10.0,
		locked = true,
		distance = 1.0
	},
	{
		authorizedJobs = { 'police', 'marshal' }, -- Valentine Cells (Right Door)
		object = 193903155,
		objCoords  = vector3(-272.06, 808.25, 118.36),
		textCoords  = vector3(-273.3, 808.12, 119.39),
		objYaw = -170.0,
		locked = true,
		distance = 1.0
	},
	
}