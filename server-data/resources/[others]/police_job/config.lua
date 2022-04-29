Config = {}

OffDutyJobs = {
    'offpolice',
    'offmarshal',

}

Marshal_Jobs = {
    'police',
    'marshal',

}

Config.MaxJailDistance = 200
Config.IncreaseSentence = false
Config.IncreaseTime = 2
Config.MaxCops = 40

Config.ExitFromJail = { ["x"] = -169.14, ["y"] = 629.3, ["z"] = 113.0 }

Jail = {
    { x = 3359.64, y = -668.57, z = 44.78 }
}

Marshal_DutyWeapons = {
    guns = {
        {label = "LeMat Revolver", weapon = "WEAPON_REVOLVER_LEMAT", ammo = {["AMMO_REVOLVER"] = 60}, comps = {['nothing'] = 0}},
        {label = "Evans Repeater", weapon = "WEAPON_REPEATER_EVANS", ammo = {["AMMO_REPEATER"] = 60}, comps = {["nothing"] = 0}}
    }
}

WeaponLabels = {
    ['WEAPON_REVOLVER_LEMAT'] = 'LEMAT REVOLVER',
}