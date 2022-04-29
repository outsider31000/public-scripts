-- Menu state
local showMenu = false
local animation 
local animscene
local handle
RegisterNetEvent('EmoteMenu:Open')
AddEventHandler('EmoteMenu:Open', function()
	for _, menuConfig in pairs(menuConfigs) do
            -- Check if menu should be enabled
	if menuConfig:enableMenu() then
		showMenu = true
		SendNUIMessage({
		type = 'init',
		data = menuConfig.data,
		resourceName = GetCurrentResourceName()
	})

                    -- set focus
		SetNuiFocus(true, true)

                    -- Play sound
		PlaySoundFrontend(-1, "NAV", "HUD_SHOP_SOUNDSET", 1)

                    -- Prevent menu from showing again until key is released
		while showMenu == true do Citizen.Wait(100) end
		Citizen.Wait(100)
		while IsControlJustReleased(0, keybindControl) do Citizen.Wait(100) end
    end
	end
end)

RegisterNetEvent("EmoteMenu:command")
AddEventHandler("EmoteMenu:command", function(command)
    ExecuteCommand(command)
end)
		
-- Keybind Lookup table
local keybindControls = {

    ["F6"] = 0x3C0A40F2,
}

local othercontrols = 
{
    ["G"] = 0x760A9C6F,
    ["F"] = 0xB2F377E8,

}
-- Main thread
Citizen.CreateThread(function()
    -- Update every frame
    while true do
        Citizen.Wait(0)
        -- Loop through all menus in config
        for _, menuConfig in pairs(menuConfigs) do
            -- Check if menu should be enabled
            if menuConfig:enableMenu() then
                -- When keybind is pressed toggle UI
                local keybindControl = keybindControls[menuConfig.data.keybind]
                if IsControlJustReleased(0, keybindControl) then
                    -- Init UI
                    showMenu = true
                    SendNUIMessage({
                        type = 'init',
                        data = menuConfig.data,
                        resourceName = GetCurrentResourceName()
                    })

                    -- set focus
                    SetNuiFocus(true, true)

                    -- Play sound
                    PlaySoundFrontend(-1, "NAV", "HUD_SHOP_SOUNDSET", 1)

                    -- Prevent menu from showing again until key is released
                    while showMenu == true do Citizen.Wait(100) end
                    Citizen.Wait(100)
                    while IsControlJustReleased(0, keybindControl) do Citizen.Wait(100) end
                end
            end
        end
    end
end)

RegisterCommand("mainmenu", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = menuConfigs["mainmenu"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("job", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["job"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("clothingmenu", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["clothingmenu"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("he", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["he"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("other", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["other"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("animations", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["animations"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("walkstyle", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["walkstyle"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)


RegisterCommand('walkcasul', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_Casual"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkcrazy', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_Crazy"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkdrunk', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "mp_style_drunk"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkeasy', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_EasyRider"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkflamboyant', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_Flamboyant"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkgreenhorn', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_Greenhorn"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)



RegisterCommand('walkgunslinger', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_Gunslinger"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkinquisitive', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "mp_style_inquisitive"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkrefined', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_Refined"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walksilentType', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_SilentType"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkveteran', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "MP_Style_Veteran"
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)

RegisterCommand('walkremove', function(source, args, rawCommand)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,0,-1) 
    Wait(500)
    animation = "noanim"
    TriggerServerEvent("syn_walkanim:setwalk",animation)
end, false)



RegisterNetEvent("syn_walkanim:getwalk2")
AddEventHandler("syn_walkanim:getwalk2", function(walk)
    animation = walk
    if animation ~= "noanim" then 
        Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation,1,-1)
    end
end)

RegisterNetEvent("syn_walkanim:secondchance2")
AddEventHandler("syn_walkanim:secondchance2", function()
    TriggerServerEvent("syn_walkanim:secondchance")
end)



RegisterCommand("sleevesx", function(source, args, rawCommand)
    ExecuteCommand("sleeves")
    ExecuteCommand("clothingmenu")
end)

RegisterCommand("sleeves2x", function(source, args, rawCommand)
    ExecuteCommand("sleeves2")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("bandanax", function(source, args, rawCommand)
    ExecuteCommand("bandana")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("hatx", function(source, args, rawCommand)
    ExecuteCommand("hat")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("eyewearx", function(source, args, rawCommand)
    ExecuteCommand("eyewear")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("maskx", function(source, args, rawCommand)
    Citizen.InvokeNative(0xAE72E7DF013AAA61, PlayerPedId(), "", `BANDANA_OFF_RIGHT_HAND`, 1, 0, -1082130432)
    ExecuteCommand("mask")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("neckwearx", function(source, args, rawCommand)
    ExecuteCommand("neckwear")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("undressx", function(source, args, rawCommand)
    ExecuteCommand("undress")
    ExecuteCommand("clothingmenu")
end)


RegisterCommand("dressx", function(source, args, rawCommand)
    ExecuteCommand("dress")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("suspenderx", function(source, args, rawCommand)
    ExecuteCommand("suspender")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("vestx", function(source, args, rawCommand)
    ExecuteCommand("vest")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("coatx", function(source, args, rawCommand)
    ExecuteCommand("coat")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("ccoatx", function(source, args, rawCommand)
    ExecuteCommand("ccoat")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("bowx", function(source, args, rawCommand)
    ExecuteCommand("bow")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("armorx", function(source, args, rawCommand)
    ExecuteCommand("armor")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("ponchox", function(source, args, rawCommand)
    ExecuteCommand("poncho")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("cloackx", function(source, args, rawCommand)
    ExecuteCommand("cloack")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("glovex", function(source, args, rawCommand)
    ExecuteCommand("glove")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("ringsx", function(source, args, rawCommand)
    ExecuteCommand("rings")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("braceletx", function(source, args, rawCommand)
    ExecuteCommand("bracelet")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("accessoriesx", function(source, args, rawCommand)
    ExecuteCommand("accessories")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("necktiesx", function(source, args, rawCommand)
    ExecuteCommand("neckties")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("shirtx", function(source, args, rawCommand)
    ExecuteCommand("shirt")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("loadoutsx", function(source, args, rawCommand)
    ExecuteCommand("loadouts")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("satchelsx", function(source, args, rawCommand)
    ExecuteCommand("satchels")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("gunbeltaccsx", function(source, args, rawCommand)
    ExecuteCommand("gunbeltaccs")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("bucklex", function(source, args, rawCommand)
    ExecuteCommand("buckle")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("pantx", function(source, args, rawCommand)
    ExecuteCommand("pant")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("skirtx", function(source, args, rawCommand)
    ExecuteCommand("skirt")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("chapx", function(source, args, rawCommand)
    ExecuteCommand("chap")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("bootsx", function(source, args, rawCommand)
    ExecuteCommand("boots")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("spursx", function(source, args, rawCommand)
    ExecuteCommand("spurs")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("spatsx", function(source, args, rawCommand)
    ExecuteCommand("spats")
    ExecuteCommand("clothingmenu")
end)
RegisterCommand("gauntletsx", function(source, args, rawCommand)
    ExecuteCommand("gauntlets")
    ExecuteCommand("clothingmenu")
end)



RegisterCommand("dance1", function(source, args, rawCommand)
    local animDict = "amb_misc@world_human_drunk_dancing@male@male_b@idle_a"
    local animName = "idle_b"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance1", function(source, args, rawCommand)
    local animDict = "amb_misc@world_human_drunk_dancing@male@male_b@idle_a" 
    local animName = "idle_b" 
    local speed = 2.0 
    local speedX = 2.0
    local duration = -1 
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance2", function(source, args, rawCommand)
    local animDict = "script_mp@emotes@dance@drunk@b@male@unarmed@full"
    local animName = "fullbody"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance3", function(source, args, rawCommand)
    local animDict = "script_mp@emotes@dance@confident@b@male@unarmed@full"
    local animName = "fullbody"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance4", function(source, args, rawCommand)
    local animDict = "script_mp@emotes@dance@wild@b@male@unarmed@full" 
    local animName = "fullbody"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance5", function(source, args, rawCommand)
    local animDict = "script_mp@emotes@dance@drunk@a@male@unarmed@full"
    local animName = "fullbody"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance6", function(source, args, rawCommand)
    local animDict = "script_mp@emotes@dance@old@a@male@unarmed@full"
    local animName = "fullbody"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance7", function(source, args, rawCommand)
    local animDict = "script_mp@emotes@dance@confident@b@male@unarmed@full"
    local animName = "fullbody"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance8", function(source, args, rawCommand)
    local animDict = "script_mp@emotes@dance@carefree@a@male@unarmed@full"
    local animName = "fullbody"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("dance9", function(source, args, rawCommand)
    local animDict = "script_mp@emotes@dance@awkward@a@male@unarmed@full"
    local animName = "fullbody"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)








------------------------------------


RegisterCommand("howdy", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["howdy"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("handlinger", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["handlinger"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("skadet", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["skadet"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("danse", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["danse"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("stående", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["stående"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("gåstil", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["gåstil"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

RegisterCommand("blandet", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["blandet"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("mixed2", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["mixed2"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("submenu1", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu1"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("submenu2", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu2"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("submenu3", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu3"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("submenu4", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu4"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("submenu5", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu5"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("submenu6", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu6"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
RegisterCommand("submenu7", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["submenu7"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)
-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_SHOP_SOUNDSET", 1)

    -- Send ACK to callback function
    cb('ok')
end)

RegisterNUICallback('back', function(data, cb)
    if data.lastmenu ~= 0 then 
        ExecuteCommand(data.lastmenu)
    else
        showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_SHOP_SOUNDSET", 1)
    end
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('sliceclicked', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_SHOP_SOUNDSET", 1)

    -- Run command
    ExecuteCommand(data.command)

    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for testing
RegisterNUICallback('testprint', function(data, cb)
    -- Print message
    TriggerEvent('chatMessage', "[test]", {255,0,0}, data.message)

    -- Send ACK to callback function
    cb('ok')
end)

-- Stop command --
RegisterCommand('sa', function(source, args, rawCommand)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedTasks(PlayerPedId())
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
    if animscene ~= nil then 
        DeleteEntity(handle) 
        Citizen.InvokeNative(0x84EEDB2C6E650000, animscene)
    end
end, false)


-- Hilse Animationer --

RegisterCommand('gentletip', function(source, args, rawCommand)
    RequestAnimDict('mech_loco_m@character@dutch@fancy@unarmed@idle@_variations')
    while not HasAnimDictLoaded('mech_loco_m@character@dutch@fancy@unarmed@idle@_variations') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@character@dutch@fancy@unarmed@idle@_variations', 'idle_b', 1.0, -1.0, 2500, 31, 0, true, 0, false, 0, false)
    ExecuteCommand("howdy")
end, false)

RegisterCommand('neutralt', function(source, args, rawCommand)
    RequestAnimDict('mech_loco_m@character@nicholas_timmins@normal@unarmed@idle@variations@big_wave')
    while not HasAnimDictLoaded('mech_loco_m@character@nicholas_timmins@normal@unarmed@idle@variations@big_wave') do
        Citizen.Wait(100)
    end
    ExecuteCommand("howdy")
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@character@nicholas_timmins@normal@unarmed@idle@variations@big_wave', 'idle', 1.0, -1.0, 3000, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('diskrettip', function(source, args, rawCommand)
    RequestAnimDict('mech_loco_m@character@arthur@fidgets@hat@normal@unarmed@normal@left_hand')
    while not HasAnimDictLoaded('mech_loco_m@character@arthur@fidgets@hat@normal@unarmed@normal@left_hand') do
        Citizen.Wait(100)
    end
    ExecuteCommand("howdy")
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@character@arthur@fidgets@hat@normal@unarmed@normal@left_hand', 'hat_lhand_b', 1.0, -1.0, 1500, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('hypedvink', function(source, args, rawCommand)
    local emoteType = 'KIT_EMOTE_GREET_GENTLEWAVE_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
    ExecuteCommand("howdy")
end, false)

RegisterCommand('gentlevink', function(source, args, rawCommand)
    local emoteType = 'KIT_EMOTE_GREET_WAVENEAR_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
    ExecuteCommand("howdy")
end, false)

RegisterCommand('venligvink', function(source, args, rawCommand)
    local emoteType = 'KIT_EMOTE_GREET_SUBTLE_WAVE_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
    ExecuteCommand("howdy")
end, false)

RegisterCommand('sarkastisk', function(source, args, rawCommand)
    RequestAnimDict('ai_gestures@gen_female@standing@silent')
    while not HasAnimDictLoaded('ai_gestures@gen_female@standing@silent') do
        Citizen.Wait(100)
    end
    ExecuteCommand("howdy")
    TaskPlayAnim(PlayerPedId(), 'ai_gestures@gen_female@standing@silent', 'silent_neutral_wave_r_001', 1.0, -1.0, 1500, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('ydmyg', function(source, args, rawCommand)
    local emoteType = 'KIT_EMOTE_GREET_RESPECTFUL_BOW_1'
    local emoteclass = Action
    ExecuteCommand("howdy")
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('diskretvink', function(source, args, rawCommand)
    RequestAnimDict('ai_gestures@gen_female@standing@silent')
    while not HasAnimDictLoaded('ai_gestures@gen_female@standing@silent') do
        Citizen.Wait(100)
    end
    ExecuteCommand("howdy")
    TaskPlayAnim(PlayerPedId(), 'ai_gestures@gen_female@standing@silent', 'silent_flirty_greet_r_001', 1.0, -1.0, 1500, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('fancybuk', function(source, args, rawCommand)
    local emoteType = 'KIT_EMOTE_GREET_FANCY_BOW_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
    ExecuteCommand("howdy")
end, false)

RegisterCommand('svirphat', function(source, args, rawCommand)
    local emoteType = 'KIT_EMOTE_GREET_HAT_FLICK_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
    ExecuteCommand("howdy")
end, false)

RegisterCommand('tiphat', function(source, args, rawCommand)
    local emoteType = 'KIT_EMOTE_GREET_HAT_TIP_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
    ExecuteCommand("howdy")
end, false)

RegisterCommand('smooth', function(source, args, rawCommand)
    RequestAnimDict('ai_gestures@arthur@standing@speaker@rt_hand')
    while not HasAnimDictLoaded('ai_gestures@arthur@standing@speaker@rt_hand') do
        Citizen.Wait(100)
    end
    ExecuteCommand("howdy")
    TaskPlayAnim(PlayerPedId(), 'ai_gestures@arthur@standing@speaker@rt_hand', 'greet_cocky_l_003', 1.0, -1.0, 1000, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('nik', function(source, args, rawCommand)
    RequestAnimDict('ai_gestures@gen_female@standing@silent')
    while not HasAnimDictLoaded('ai_gestures@gen_female@standing@silent') do
        Citizen.Wait(100)
    end
    ExecuteCommand("howdy")
    TaskPlayAnim(PlayerPedId(), 'ai_gestures@gen_female@standing@silent', 'silent_neutral_greet_f_002', 1.0, -1.0, 1500, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('tough', function(source, args, rawCommand)
    local emoteType = 'KIT_EMOTE_GREET_TOUGH_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
    ExecuteCommand("howdy")
end, false)




-- Handlinger --

RegisterCommand('sove', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('amb_rest@prop_human_sleep_leanto_tent@front@female_a@stand_enter')
        while not HasAnimDictLoaded('amb_rest@prop_human_sleep_leanto_tent@front@female_a@stand_enter') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@prop_human_sleep_leanto_tent@front@female_a@stand_enter', 'enter_front_lf', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
        Citizen.Wait(11000)
        RequestAnimDict('amb_rest@prop_human_sleep_leanto_tent@front@female_a@trans')
        while not HasAnimDictLoaded('amb_rest@prop_human_sleep_leanto_tent@front@female_a@trans') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@prop_human_sleep_leanto_tent@front@female_a@trans', 'a_trans_sleep_ground_arm_a', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
        Citizen.Wait(18000)
        RequestAnimDict('amb_rest@world_human_sleep_ground@arm@female_a@idle_a')
        while not HasAnimDictLoaded('amb_rest@world_human_sleep_ground@arm@female_a@idle_a') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_sleep_ground@arm@female_a@idle_a', 'idle_c', 8.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    else
        print('male')
        RequestAnimDict('amb_rest@world_human_sleep_ground@arm@player_temp@enter')
        while not HasAnimDictLoaded('amb_rest@world_human_sleep_ground@arm@player_temp@enter') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_sleep_ground@arm@player_temp@enter', 'enter_right', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
        Citizen.Wait(18000)
        RequestAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_c')
        while not HasAnimDictLoaded('amb_rest@world_human_sleep_ground@arm@male_b@idle_c') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_sleep_ground@arm@male_b@idle_c', 'idle_g', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end
end, false)


RegisterCommand('sidde', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('amb_rest@prop_human_sleep_leanto_tent@front@female_a@stand_enter')
        while not HasAnimDictLoaded('amb_rest@prop_human_sleep_leanto_tent@front@female_a@stand_enter') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@prop_human_sleep_leanto_tent@front@female_a@stand_enter', 'enter_front_lf', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
        Citizen.Wait(11500)
        RequestAnimDict('amb_rest@prop_human_sleep_leanto_tent@left@female_a@base')
        while not HasAnimDictLoaded('amb_rest@prop_human_sleep_leanto_tent@left@female_a@base') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@prop_human_sleep_leanto_tent@left@female_a@base', 'base', 8.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    else
        print('male')
        RequestAnimDict('amb_camp@world_camp_jack_es_fire_sit_ground@male_a@stand_enter')
        while not HasAnimDictLoaded('amb_camp@world_camp_jack_es_fire_sit_ground@male_a@stand_enter') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_camp@world_camp_jack_es_fire_sit_ground@male_a@stand_enter', 'enter_back_lf', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
        Citizen.Wait(8800)
        RequestAnimDict('amb_camp@world_camp_jack_es_fire_sit_ground@male_a@idle_d')
        while not HasAnimDictLoaded('amb_camp@world_camp_jack_es_fire_sit_ground@male_a@idle_d') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_camp@world_camp_jack_es_fire_sit_ground@male_a@idle_d', 'idle_j', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end
end, false)

RegisterCommand('gidsel', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('mini_hostage')
    while not HasAnimDictLoaded('mini_hostage') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mini_hostage', 'gped_host_knl_pre', 1.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(3500)
    RequestAnimDict('mini_hostage')
    while not HasAnimDictLoaded('mini_hostage') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mini_hostage', 'gped_host_knl_idl', 8.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('pege', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'loop_0', 1.0, -1.0, 9999999999, 30, 0, true, 0, false, 0, false)
end, false) 

RegisterCommand('græde', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'cry_loop', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('overgiv', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('mech_busted@unapproved')
    while not HasAnimDictLoaded('mech_busted@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_busted@unapproved', 'idle_2_hands_up', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(4000)
    RequestAnimDict('script_proc@robberies@unapproved')
    while not HasAnimDictLoaded('script_proc@robberies@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_busted@unapproved', 'idle_b', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('hænderop', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('mech_loco_f@generic@reaction@handsup@unarmed@normal')
        while not HasAnimDictLoaded('mech_loco_f@generic@reaction@handsup@unarmed@normal') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(),'mech_loco_f@generic@reaction@handsup@unarmed@normal', 'loop', 1.0, 1.0, 9999999999, 31, 0, true, 0, false, 0, false)
    else
        print('male')
        RequestAnimDict('mech_loco_m@generic@reaction@handsup@unarmed@tough')
        while not HasAnimDictLoaded('mech_loco_m@generic@reaction@handsup@unarmed@tough') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@reaction@handsup@unarmed@tough', 'loop', 1.0, 1.0, 9999999999, 31, 0, true, 0, false, 0, false)
    end
end, false)

RegisterCommand('sørge', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'hostage_fallstoknees', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(1400)
    RequestAnimDict('script_proc@robberies@shop@rhodes@gunsmith@inside_basement_reshoot')
    while not HasAnimDictLoaded('script_proc@robberies@shop@rhodes@gunsmith@inside_basement_reshoot') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_proc@robberies@shop@rhodes@gunsmith@inside_basement_reshoot', 'cry_loop_captor', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('fuld', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_re@crashed_wagon')
    while not HasAnimDictLoaded('script_re@crashed_wagon') do 
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_re@crashed_wagon', 'male_drunk_action', 1.0, 1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('fanget', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_proc@robberies@unapproved')
    TaskPlayAnim(PlayerPedId(), 'script_proc@robberies@unapproved', 'stand_prisoner_cell_idle_a', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('dækning', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'windowwasher_shot_reaction', 1.0, -1.0, 9999999999, 2, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('søge', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'guard_patrol@idle_e', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('hidkald', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('script_common@wave@female@unapproved')
        while not HasAnimDictLoaded('script_common@wave@female@unapproved') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(),'script_common@wave@female@unapproved', 'wave_b', 1.0, 1.0, 5500, 1, 0, true, 0, false, 0, false)
    else
        print('male')
        RequestAnimDict('script_common@wave@male@unapproved')
        while not HasAnimDictLoaded('script_common@wave@male@unapproved') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'script_common@wave@male@unapproved', 'wave_idle_c', 1.0, 1.0, 6000, 1, 0, true, 0, false, 0, false)
    end
end, false)

RegisterCommand('fagter', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('script_common@wave@female@unapproved')
        while not HasAnimDictLoaded('script_common@wave@female@unapproved') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(),'script_common@wave@female@unapproved', 'wave_a', 1.0, 1.0, 4000, 1, 0, true, 0, false, 0, false)
    else
        print('male')
        RequestAnimDict('script_common@wave@male@unapproved')
        while not HasAnimDictLoaded('script_common@wave@male@unapproved') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'script_common@wave@male@unapproved', 'wave_idle_d', 1.0, 1.0, 3000, 1, 0, true, 0, false, 0, false)
    end
end, false)

RegisterCommand('vige', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_common@crowd_control@unapproved@a@intro')
    while not HasAnimDictLoaded('script_common@crowd_control@unapproved@a@intro') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'script_common@crowd_control@unapproved@a@intro', 'intro_ped_d', 1.0, 1.0, 3000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(3000)
    RequestAnimDict('script_common@crowd_control@unapproved@a@ped_d@cower')
    while not HasAnimDictLoaded('script_common@crowd_control@unapproved@a@ped_d@cower') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@crowd_control@unapproved@a@ped_d@cower', 'cower', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('betjening', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_common@service_bell@unapproved')
    while not HasAnimDictLoaded('script_common@service_bell@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'script_common@service_bell@unapproved', 'enter', 1.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(800)
    RequestAnimDict('script_common@service_bell@unapproved')
    TaskPlayAnim(PlayerPedId(), 'script_common@service_bell@unapproved', 'base', 8.0, 1.0, 2000, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('bankpå', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('amb_misc@world_human_door_knock@male_a@idle_c')
        while not HasAnimDictLoaded('amb_misc@world_human_door_knock@male_a@idle_c') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(),'amb_misc@world_human_door_knock@male_a@idle_c', 'idle_h', 1.0, 1.0, 9999999999, 1, 0, true, 0, false, 0, false)

    else

        print ('male')
        RequestAnimDict('amb_misc@world_human_door_knock@male_a@idle_c')
        while not HasAnimDictLoaded('amb_misc@world_human_door_knock@male_a@idle_c') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_door_knock@male_a@idle_c', 'idle_g', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end
end, false)

RegisterCommand('svede', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('mech_loco_m@generic@fidgets@hot')
    while not HasAnimDictLoaded('mech_loco_m@generic@fidgets@hot') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@fidgets@hot', 'both_hands_fanning_02', 1.0, -1.0, 999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('fryse', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    RequestAnimDict('script_re@lost_man')
    while not HasAnimDictLoaded('script_re@lost_man') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'script_re@lost_man', 'idle', 1.0, 1.0, 999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('pisse', function(source, args, rawCommand)
    ExecuteCommand("handlinger")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('ai_gestures@arthur@standing@speaker')
        while not HasAnimDictLoaded('ai_gestures@arthur@standing@speaker') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'ai_gestures@arthur@standing@speaker', 'embarassed_nod_f_001', 2000, true, false, false, false)
    else
        print('male')
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("world_human_pee"), 9999999999,true,false, false, false)
    end
end, false)




-- Skadet Animationer

RegisterCommand('armen', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@injured@unarmed@right_arm@idle')
    while not HasAnimDictLoaded('mech_loco_m@generic@injured@unarmed@right_arm@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@injured@unarmed@right_arm@idle', 'idle', 1.0, -1.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('skulder', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@character@arthur@injured@left_shoulder@unarmed@idle')
    while not HasAnimDictLoaded('mech_loco_m@character@arthur@injured@left_shoulder@unarmed@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@character@arthur@injured@left_shoulder@unarmed@idle', 'idle', 1.0, -1.0, 9999999, 31, 0, true, 0, false, 0, false)
 end, false)

RegisterCommand('benet', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@injured@unarmed@left_leg@idle')
    while not HasAnimDictLoaded('mech_loco_m@generic@injured@unarmed@left_leg@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@injured@unarmed@left_leg@idle', 'idle', 1.0, -1.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('brystet', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@injured@unarmed@chest@idle')
    while not HasAnimDictLoaded('mech_loco_m@generic@injured@unarmed@chest@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@injured@unarmed@chest@idle', 'idle', 1.0, -1.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('hovedet', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@injured@unarmed@head@idle')
    while not HasAnimDictLoaded('mech_loco_m@generic@injured@unarmed@head@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@injured@unarmed@head@idle', 'idle', 1.0, -1.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('halsen', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@injured@unarmed@critical_neck_right@idle')
    while not HasAnimDictLoaded('mech_loco_m@generic@injured@unarmed@critical_neck_right@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@injured@unarmed@critical_neck_right@idle', 'idle', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('ryggen', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@injured@unarmed@critical_back@idle')
    while not HasAnimDictLoaded('mech_loco_m@generic@injured@unarmed@critical_back@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@injured@unarmed@critical_back@idle', 'idle', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('syg', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('amb_wander@upperbody_idles@sick@both_arms@male_a@idle_a')
    while not HasAnimDictLoaded('amb_wander@upperbody_idles@sick@both_arms@male_a@idle_a') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_wander@upperbody_idles@sick@both_arms@male_a@idle_a', 'idle_c', 1.0, -1.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('utilpas', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('script_story@fin2@ig@ig2_chase_cleet')
    while not HasAnimDictLoaded('script_story@fin2@ig@ig2_chase_cleet') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_story@fin2@ig@ig2_chase_cleet', 'civilian_injured_loop_a_civilian', 1.0, -1.0, 9999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('klørsig', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@special@unarmed@itchy@idle')
    while not HasAnimDictLoaded('mech_loco_m@generic@special@unarmed@itchy@idle') do 
    Citizen.Wait(100)
end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@special@unarmed@itchy@idle', 'idle_intro', 1.0, -1.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('kastop', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_vomit@male_a@idle_b') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_vomit@male_a@idle_b', 'idle_f', 1.0, -1.0, 99999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('kollaps', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('script_story@gua2@ig@ig_walkcollapse')
    while not HasAnimDictLoaded('script_story@gua2@ig@ig_walkcollapse') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_story@gua2@ig@ig_walkcollapse', 'gua2_collapse_rf', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('lide1', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@injured@unarmed@critical_ground@idle@_variations@d')
    while not ('mech_loco_m@generic@injured@unarmed@critical_ground@idle@_variations@d') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@injured@unarmed@critical_ground@idle@_variations@d', 'idle', 9.0, 9.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('lide2', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('mech_loco_m@generic@injured@unarmed@critical_ground@idle@_variations@e')
    while not HasAnimDictLoaded('mech_loco_m@generic@injured@unarmed@critical_ground@idle@_variations@e') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@injured@unarmed@critical_ground@idle@_variations@e', 'idle', 9.0, 9.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('døende', function(source, args, rawCommand)
    ExecuteCommand("skadet")
    RequestAnimDict('amb_misc@world_human_indian_sick_dying@male@male_b@enter')
    while not HasAnimDictLoaded('amb_misc@world_human_indian_sick_dying@male@male_b@enter') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'amb_misc@world_human_indian_sick_dying@male@male_b@enter', 'enter', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(7000)
    RequestAnimDict('amb_misc@world_human_indian_sick_dying@male@male_a@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_indian_sick_dying@male@male_a@idle_a') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'amb_misc@world_human_indian_sick_dying@male@male_a@idle_a', 'idle_c', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)
 


-- Stå Animationer

RegisterCommand('nervøs', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('script_rc@rmyr4@unapproved@scared')
    while not HasAnimDictLoaded('script_rc@rmyr4@unapproved@scared') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_rc@rmyr4@unapproved@scared', 'idle', 1.0, -1.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('vagt', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'stand_guard@idle_a', 1.0, 1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('hyped', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'protest_female_idle_c', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('forførende', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('amb_work@world_human_whore@female_a@wip_base')
    while not HasAnimDictLoaded('amb_work@world_human_whore@female_a@wip_base') do
    Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'amb_work@world_human_whore@female_a@wip_base', 'wip_base', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('feminint', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('mech_loco_f@character@karen@normal@unarmed@idle')
    while not HasAnimDictLoaded('mech_loco_f@character@karen@normal@unarmed@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_f@character@karen@normal@unarmed@idle', 'idle_intro', 1.0, -1.0, 1000, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(1000)
    RequestAnimDict('mech_loco_f@character@karen@normal@unarmed@idle')
    while not HasAnimDictLoaded('mech_loco_f@character@karen@normal@unarmed@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_f@character@karen@normal@unarmed@idle', 'idle', 1.0, -1.0, 99999999, 1, 0, true, 0, false, 0, false)
end, false)


RegisterCommand('forvirret', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'security_look_around@idle_c', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)
 
RegisterCommand('careless', function(source, args, rawCommand)
    ExecuteCommand("stående")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('mech_loco_f@character@abigail@normal@unarmed@idle@_variations@a')
        while not HasAnimDictLoaded('mech_loco_f@character@abigail@normal@unarmed@idle@_variations@a') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(),'mech_loco_f@character@abigail@normal@unarmed@idle@_variations@a', 'idle', 1.0, 1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    else

        print ('male')
        RequestAnimDict('script_common@other@unapproved')
        while not HasAnimDictLoaded('script_common@other@unapproved') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'drug_dealer_idle_d', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
    end
end, false)

RegisterCommand('opgivende', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'idle_d', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('afventende', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('script_common@other@unapproved')
    while not HasAnimDictLoaded('script_common@other@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'door_deal_wait_buyer', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('krydsarme', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('mech_skin@buck@butcher')
    while not HasAnimDictLoaded('mech_skin@buck@butcher') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'mech_skin@buck@butcher', 'trans_to_stoic_butcher', 1.0, -1.0, 999999999, 30, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('hænderside', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('script_amb@stores@store_waist_stern_guy')
    while not HasAnimDictLoaded('script_amb@stores@store_waist_stern_guy') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'script_amb@stores@store_waist_stern_guy', 'base', 1.0, -1.0, 999999999, 31, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('hænderbælte', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('mech_loco_m@character@arthur@casual@unarmed@normal_to_casual')
    while not HasAnimDictLoaded('mech_loco_m@character@arthur@casual@unarmed@normal_to_casual') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@character@arthur@casual@unarmed@normal_to_casual', 'idle_transition', 1.0, -1.0, 2500, 1, 0, true, 0, false, 0, false)
    Citizen.Wait(2500)
    RequestAnimDict('mech_loco@generic@spectator@b@streamed_idles')
    while not HasAnimDictLoaded('mech_loco@generic@spectator@b@streamed_idles') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco@generic@spectator@b@streamed_idles', 'idle_c', 1.0, -1.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('badass', function(source, args, rawCommand)
    ExecuteCommand("stående")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('amb_rest@world_human_badass@male_a@idle_b')
        while not HasAnimDictLoaded('amb_rest@world_human_badass@male_a@idle_b') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(),'amb_rest@world_human_badass@male_a@idle_b', 'idle_f', 1.0, 1.0, 5500, 1, 0, true, 0, false, 0, false)
        Citizen.Wait(5500)
        RequestAnimDict('amb_rest@world_human_badass@male_a@idle_a')
        while not HasAnimDictLoaded('amb_rest@world_human_badass@male_a@idle_a') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_badass@male_a@idle_a', 'idle_a', 1.0, 1.0, 9999999999, 1, 0, true, 0, false, 0, false)

    else

        print('male')
        RequestAnimDict('amb_rest@world_human_badass@male_a@idle_b')
        while not HasAnimDictLoaded('amb_rest@world_human_badass@male_a@idle_b') do
            Citizen.Wait(100) 
        end
        TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_badass@male_a@idle_b', 'idle_f', 1.0, 1.0, 6000, 1, 0, true, 0, false, 0, false)
        Citizen.Wait(6000)
        local ped = PlayerPedId()
        local scenario = "WORLD_HUMAN_BADASS"
        ClearPedTasksImmediately(ped)
        TaskStartScenarioInPlace(ped, GetHashKey(scenario), -1)

    end
end, false)

RegisterCommand('utålmodig', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('amb_misc@world_human_waiting_impatient@male_d@idle_b')
    while not HasAnimDictLoaded('amb_misc@world_human_waiting_impatient@male_d@idle_b') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'amb_misc@world_human_waiting_impatient@male_d@idle_b', 'idle_d', 1.0, 1.0, 999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('beruset', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('mech_loco_m@generic@drunk@unarmed@idle_moderate_drunk')
    while not HasAnimDictLoaded('mech_loco_m@generic@drunk@unarmed@idle_moderate_drunk') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'mech_loco_m@generic@drunk@unarmed@idle_moderate_drunk', 'idle', 1.0, 1.0, 999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('klar', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('ai_react@react_look_layers@base_emotions@brave')
    while not HasAnimDictLoaded('ai_react@react_look_layers@base_emotions@brave') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'ai_react@react_look_layers@base_emotions@brave', 'direct', 1.0, -1.0, 999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('vred', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('ai_react@react_look_layers@base_emotions@angry')
    while not HasAnimDictLoaded('ai_react@react_look_layers@base_emotions@angry') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'ai_react@react_look_layers@base_emotions@angry', 'direct', 1.0, -1.0, 999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('trist', function(source, args, rawCommand)
    ExecuteCommand("stående")
    RequestAnimDict('mech_loco_m@generic@emotion@unarmed@sad@idle')
    while not HasAnimDictLoaded('mech_loco_m@generic@emotion@unarmed@sad@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@generic@emotion@unarmed@sad@idle', 'idle', 1.0, -1.0, 999999999, 1, 0, true, 0, false, 0, false)
end, false)



-- Blandet

RegisterCommand('puha', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_TAUNT_YOUSTINK_1'
    local emoteclass = Taunt
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('tak', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    RequestAnimDict('script_common@thank@female@unapproved')
    while not HasAnimDictLoaded('script_common@thank@female@unapproved') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(),'script_common@thank@female@unapproved', 'thank_c', 1.0, 1.0, 6000, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('please', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    RequestAnimDict('script_re@lost_man')
    while not HasAnimDictLoaded('script_re@lost_man') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'script_re@lost_man', 'i_made_it_thanks_again', 1.0, -1.0, 2800, 1, 0, true, 0, false, 0, false)
 end, false)

RegisterCommand('rolignu', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    RequestAnimDict('mech_loco_m@character@arthur@calming@unarmed@idle')
    while not HasAnimDictLoaded('mech_loco_m@character@arthur@calming@unarmed@idle') do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), 'mech_loco_m@character@arthur@calming@unarmed@idle', 'idle', 1.0, -1.0, 999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('trussel', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_TAUNT_THROAT_SLIT_1'
    local emoteclass = Taunt
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('udfordre', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_TAUNT_VERSUS_1'
    local emoteclass = Taunt
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('thumbsdown', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_REACTION_THUMBSDOWN_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('thumbsup', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_GREET_THUMBSUP_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('Klap', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    if not IsPedMale(PlayerPedId()) then
        print('female')
        RequestAnimDict('ai_gestures@gen_female@standing@silent@script')
        while not HasAnimDictLoaded('ai_gestures@gen_female@standing@silent@script') do
            Citizen.Wait(100)
        end
        TaskPlayAnim(PlayerPedId(), 'ai_gestures@gen_female@standing@silent@script', 'silent_clap_f_001', 1.0, -1.0, 999999999, 1, 0, true, 0, false, 0, false)

    else 

        print('male')
        RequestAnimDict('ai_gestures@gen_male@standing@silent@script')
        while not HasAnimDictLoaded('ai_gestures@gen_male@standing@silent@script') do
            Citizen.Wait(100)
        end

    end
end, false)

RegisterCommand('grineaf', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_REACTION_POINTLAUGH_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('grine', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_REACTION_JOVIAL_LAUGH_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('shh', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_REACTION_HUSH_YOUR_MOUTH_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('yeeha', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_REACTION_YEEHAW_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('flex', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_ACTION_FLEX_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('fuckdig', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_TAUNT_FLIP_OFF_1'
    local emoteclass = Taunt
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('luftkys', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_ACTION_BLOW_KISS_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('følgmed', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_ACTION_FOLLOW_ME_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('satans', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_ACTION_HISSYFIT_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('fightme', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_TAUNT_PROVOKE_1'
    local emoteclass = Taunt
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('holdøje', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_TAUNT_IM_WATCHING_YOU_1'
    local emoteclass = Taunt
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('kylling', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_TAUNT_CHICKEN_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('gorilla', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_TAUNT_GORILLA_CHEST_1'
    local emoteclass = Taunt
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('spejl', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local ped = PlayerPedId()
    local scenario = "WORLD_HUMAN_POCKET_MIRROR"
    ClearPedTasksImmediately(ped)
    TaskStartScenarioInPlace(ped, GetHashKey(scenario), -1)
end)

RegisterCommand('lusket', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_ACTION_SCHEME_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('tjekur', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    local emoteType = 'KIT_EMOTE_ACTION_CHECK_POCKET_WATCH_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('notesblok', function(source, args, rawCommand)
    ExecuteCommand("blandet")
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("world_human_write_notebook"), 9999999999,true,false, false, false)
end, false)



-- Danse Animationer

RegisterCommand('dakavet', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_AWKWARD_A_1'
    local emoteclass = Taunt
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dubekymret', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_CAREFREE_B_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dsmart', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_CONFIDENT_A_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dfuld', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_DRUNK_A_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dsimpelt', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_DRUNK_B_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dformelt', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_FORMAL_A_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dyndefuldt', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_GRACEFUL_A_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dbesværet', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_OLD_A_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dhyped', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_WILD_A_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dvildt', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_WILD_B_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dselvsikkert', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_DANCE_CONFIDENT_B_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('djig', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_ACTION_PROSPECTOR_JIG_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)

RegisterCommand('dmuntert', function(source, args, rawCommand)
    ExecuteCommand("danse")
    local emoteType = 'KIT_EMOTE_REACTION_SHUFFLE_1'
    local emoteclass = Action
    TaskEmote(PlayerPedId(), emoteClass, 2, GetHashKey(emoteType), true, true, true, true, true)
end, false)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsControlJustPressed(0,0x8CC9CD42)) and IsInputDisabled(0)  then
            local ped = PlayerPedId()
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then  
                RequestAnimDict( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" )    
                while ( not HasAnimDictLoaded( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" ) ) do 
                    Citizen.Wait( 100 )
                end
                if IsEntityPlayingAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
                    DisablePlayerFiring(ped, true)
                    ClearPedSecondaryTask(ped)
                else
                    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
                    DisablePlayerFiring(ped, true)
                    TaskPlayAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 2.0, -1.0, 120000, 31, 0, true, 0, false, 0, false)
                end
            end
        end
    end
end)

local pointing = false 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlPressed(0, 0x80F28E95) then -- B
            if pointing then 
                pointing = false 
                ClearPedSecondaryTask(PlayerPedId())
            elseif not pointing then 
                pointing = true 
                RequestAnimDict('script_common@other@unapproved')
                while not HasAnimDictLoaded('script_common@other@unapproved') do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'loop_0', 1.0, -1.0, 9999999999, 30, 0, true, 0, false, 0, false)
            end
            Wait(500)
        end

    end

end)
RegisterCommand("shared", function(source, args, rawCommand)
    -- Wait for next frame just to be safe
    Citizen.Wait(0)

    -- Init UI and set focus
    showMenu = true
    SendNUIMessage({
        type = 'init',
        data = subMenuConfigs["shared"].data,
        resourceName = GetCurrentResourceName()
    })
    SetNuiFocus(true, true)
end, false)

local asked1 = false 
local asked2 = false 
local senderid 
local sharedinfo = {}

RegisterNetEvent("rm:recquestion")
AddEventHandler("rm:recquestion", function(y,x)
    senderid = y
    sharedinfo = x
    asked2 = true 
end)

RegisterNetEvent("rm:ok")
AddEventHandler("rm:ok", function(y,x)
    asked1 = false 
   if y then 
        local info = sharedconfigs[x.type]
        local coords = x.coords1
        local heading = x.heading1
        local dict = info.dict1
        local anim = info.anim1
        local flag = info.flag
        local playerPed = PlayerPedId()
        Citizen.InvokeNative(0x203BEFFDBE12E96A,playerPed,coords.x,coords.y,coords.z-1,heading)
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(100)
        end
        TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, 120000, flag, 0, true, 0, false, 0, false)
   end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if asked2 then 
            drawtext("Someone is Asking you to "..sharedconfigs[sharedinfo.type].label, 0.15, 0.13, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
            drawtext("G to accept, F to Decline", 0.15, 0.16, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
            if IsControlJustReleased(0, othercontrols["G"]) then
                asked2 = false 
                local accept = true 
                TriggerServerEvent("rm:isok",accept,sharedinfo,senderid)
                local info = sharedconfigs[sharedinfo.type]
                local coords = sharedinfo.coords2
                local heading = sharedinfo.heading2
                local dict = info.dict2
                local anim = info.anim2
                local flag = info.flag
                local playerPed = PlayerPedId()
                Citizen.InvokeNative(0x203BEFFDBE12E96A,playerPed,coords.x,coords.y,coords.z-1,heading)
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(playerPed, dict, anim, 8.0, 8.0, 120000, flag, 0, true, 0, false, 0, false)
            end
            if IsControlJustReleased(0, othercontrols["F"]) then
                asked2 = false 
                local accept = false 
                TriggerServerEvent("rm:isok",accept,sharedinfo,senderid)
            end
        end
    end
end)
function drawtext(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then 
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
end
RegisterCommand('shareddance1', function(source, args, rawCommand)
    if not asked1 then 
        local closestPlayer, closestDistance, playerid, tgt1 = GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 5.0  then
            asked1 = true 
            local heading1 = GetEntityHeading(PlayerPedId())
            local coords1 = GetEntityCoords(PlayerPedId())
            local heading2 = GetEntityHeading(PlayerPedId()) - 180
            local coords2 = coords1 + (GetEntityForwardVector(PlayerPedId())/2)
            TriggerServerEvent("rm:askforshared",playerid,"shareddance1",coords1,heading1,coords2,heading2)
        end
    end
end, false)

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])
        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
                playerid = GetPlayerServerId(players[i])
                tgt1 = GetPlayerPed(players[i])
            end
        end
    end
    return closestPlayer, closestDistance,  playerid, tgt1
end


---------------------


RegisterCommand("drunk1", function(source, args, rawCommand)
    TriggerEvent('wwrp:drunk1')
end)
    
RegisterNetEvent('wwrp:drunk1')
AddEventHandler('wwrp:drunk1', function()
    loadAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_a@idle_b', 'idle_e', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_drunk_dancing@male@male_a@idle_b')
end)
------
RegisterCommand("sitground2", function(source, args, rawCommand)
    TriggerEvent('wwrp:sitground2')
end)
    
RegisterNetEvent('wwrp:sitground2')
AddEventHandler('wwrp:sitground2', function()
    loadAnimDict('amb_camp@world_camp_fire_sit_ground@male_c@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb_camp@world_camp_fire_sit_ground@male_c@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_camp@world_camp_fire_sit_ground@male_c@idle_a')
end)
------
RegisterCommand("sleep1", function(source, args, rawCommand)
    TriggerEvent('wwrp:sleep1')
end)
    
RegisterNetEvent('wwrp:sleep1')
AddEventHandler('wwrp:sleep1', function()
    loadAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
    TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_sleep_ground@arm@male_b@idle_b', 'idle_f', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
end)
------
RegisterCommand("leanrail1", function(source, args, rawCommand)
    TriggerEvent('wwrp:leanrail1')
end)
    
RegisterNetEvent('wwrp:leanrail1')
AddEventHandler('wwrp:leanrail1', function()
    loadAnimDict('amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c')
    TaskPlayAnim(PlayerPedId(), 'amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c', 'idle_g', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_rest_lean@world_human_lean_fence_fwd_check_out_livestock@male_e@idle_c')
end)
------
RegisterCommand("writeledger1", function(source, args, rawCommand)
    TriggerEvent('wwrp:writeledger1')
end)
    
RegisterNetEvent('wwrp:writeledger1')
AddEventHandler('wwrp:writeledger1', function()
    loadAnimDict('amb_work@world_human_write_notebook@female_a@idle_c')
    TaskPlayAnim(PlayerPedId(), 'amb_work@world_human_write_notebook@female_a@idle_c', 'idle_g', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_work@world_human_write_notebook@female_a@idle_c')
end)
------
RegisterCommand("idle1", function(source, args, rawCommand)
    TriggerEvent('wwrp:idle1')
end)
    
RegisterNetEvent('wwrp:idle1')
AddEventHandler('wwrp:idle1', function()
    loadAnimDict('amb_misc@world_human_stand_waiting@female_a@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_stand_waiting@female_a@idle_a', 'idle_a', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_stand_waiting@female_a@idle_a')
end)
------
RegisterCommand("idle2", function(source, args, rawCommand)
    TriggerEvent('wwrp:idle2')
end)

RegisterNetEvent('wwrp:idle2')
AddEventHandler('wwrp:idle2', function()
    loadAnimDict('amb_misc@world_human_stand_waiting@female_a@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_stand_waiting@female_a@idle_a', 'idle_b', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_stand_waiting@female_a@idle_a')
end)
------
RegisterCommand("cough1", function(source, args, rawCommand)
    TriggerEvent('wwrp:cough1')
end)
    
RegisterNetEvent('wwrp:cough1')
AddEventHandler('wwrp:cough1', function()
    loadAnimDict('amb_misc@world_human_coughing@male_c@wip_base')
    TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_coughing@male_c@wip_base", "wip_base", 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_coughing@male_c@wip_base')
end)
------
RegisterCommand("puke1", function(source, args, rawCommand)
    TriggerEvent('wwrp:puke1')
end)
    
RegisterNetEvent('wwrp:puke1')
AddEventHandler('wwrp:puke1', function()
    loadAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
    TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_vomit@male_a@idle_b", "idle_f", 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
end)
------
RegisterCommand("dance1", function(source, args, rawCommand)
    TriggerEvent('wwrp:dance1')
end)
    
RegisterNetEvent('wwrp:dance1')
AddEventHandler('wwrp:dance1', function()
    loadAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_a', 'idle_c', 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_a')
end)

--- EMOTE MENU
RegisterCommand("stinky1", function(source, args, rawCommand)
    TriggerEvent('wwrp:stinky1')
    ExecuteCommand("mixed2")
end)
    
RegisterNetEvent('wwrp:stinky1')
AddEventHandler('wwrp:stinky1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -166523388, 1, 1, 0, 0)
end)
------
RegisterCommand("wave1", function(source, args, rawCommand)
    TriggerEvent('wwrp:wave1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:wave1')
AddEventHandler('wwrp:wave1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -339257980, 1, 1, 0, 0)
end)
------
RegisterCommand("thumbsup1", function(source, args, rawCommand)
    TriggerEvent('wwrp:thumbsup1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:thumbsup1')
AddEventHandler('wwrp:thumbsup1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 425751659, 1, 1, 0, 0)
end)
------
RegisterCommand("thumbsdown1", function(source, args, rawCommand)
    TriggerEvent('wwrp:thumbsdown1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:thumbsdown1')
AddEventHandler('wwrp:thumbsdown1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1509171361, 1, 1, 0, 0)
end)
------
RegisterCommand("draw1", function(source, args, rawCommand)
    TriggerEvent('wwrp:draw1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:draw1')
AddEventHandler('wwrp:draw1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1639456476, 1, 1, 0, 0)
end)
------
RegisterCommand("damn1", function(source, args, rawCommand)
    TriggerEvent('wwrp:damn1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:damn1')
AddEventHandler('wwrp:damn1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 354512356, 1, 1, 0, 0)
end)
------
RegisterCommand("idlespit1", function(source, args, rawCommand)
    TriggerEvent('wwrp:idlespit1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:idlespit1')
AddEventHandler('wwrp:idlespit1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -2106738342, 1, 1, 0, 0)
end)
------
RegisterCommand("yes1", function(source, args, rawCommand)
    TriggerEvent('wwrp:yes1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:yes1')
AddEventHandler('wwrp:yes1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -822629770, 1, 1, 0, 0)
end)
------
RegisterCommand("no1", function(source, args, rawCommand)
    TriggerEvent('wwrp:no1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:no1')
AddEventHandler('wwrp:no1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -653113914, 1, 1, 0, 0)
end)
------
RegisterCommand("slowclap1", function(source, args, rawCommand)
    TriggerEvent('wwrp:slowclap1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:slowclap1')
AddEventHandler('wwrp:slowclap1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1023735814, 1, 1, 0, 0)
end)
------
RegisterCommand("tada1", function(source, args, rawCommand)
    TriggerEvent('wwrp:tada1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:tada1')
AddEventHandler('wwrp:tada1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -462132925, 1, 1, 0, 0)
end)
------
RegisterCommand("blowkiss1", function(source, args, rawCommand)
    TriggerEvent('wwrp:blowkiss1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:blowkiss1')
AddEventHandler('wwrp:blowkiss1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1927505461, 1, 1, 0, 0)
end)
------
RegisterCommand("boast1", function(source, args, rawCommand)
    TriggerEvent('wwrp:boast1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:boast1')
AddEventHandler('wwrp:boast1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1252070669, 1, 1, 0, 0)
end)
------
RegisterCommand("hellyeah1", function(source, args, rawCommand)
    TriggerEvent('wwrp:hellyeah1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:hellyeah1')
AddEventHandler('wwrp:hellyeah1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -402959, 1, 1, 0, 0)
end)
------
RegisterCommand("flex1", function(source, args, rawCommand)
    TriggerEvent('wwrp:flex1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:flex1')
AddEventHandler('wwrp:flex1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -773960361, 1, 1, 0, 0)
end)
------
RegisterCommand("followme1", function(source, args, rawCommand)
    TriggerEvent('wwrp:followme1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:followme1')
AddEventHandler('wwrp:followme1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1115379199, 1, 1, 0, 0)
end)
------
RegisterCommand("hissyfit1", function(source, args, rawCommand)
    TriggerEvent('wwrp:hissyfit1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:hissyfit1')
AddEventHandler('wwrp:hissyfit1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 796723886, 1, 1, 0, 0)
end)
------
RegisterCommand("letsgo1", function(source, args, rawCommand)
    TriggerEvent('wwrp:letsgo1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:letsgo1')
AddEventHandler('wwrp:letsgo1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1593752891, 1, 1, 0, 0)
end)
------
RegisterCommand("applause1", function(source, args, rawCommand)
    TriggerEvent('wwrp:applause1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:applause1')
AddEventHandler('wwrp:applause1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -221241824, 1, 1, 0, 0)
end)
------
RegisterCommand("letscraft1", function(source, args, rawCommand)
    TriggerEvent('wwrp:letscraft1')
    ExecuteCommand("mixed2")

end)
 
RegisterNetEvent('wwrp:letscraft1')
AddEventHandler('wwrp:letscraft1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -415456998, 1, 1, 0, 0)
end)
------
RegisterCommand("wannafish1", function(source, args, rawCommand)
    TriggerEvent('wwrp:wannafish1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:wannafish1')
AddEventHandler('wwrp:wannafish1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1159716480, 1, 1, 0, 0)
end)
------
RegisterCommand("playcards1", function(source, args, rawCommand)
    TriggerEvent('wwrp:playcards1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:playcards1')
AddEventHandler('wwrp:playcards1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -843470756, 1, 1, 0, 0)
end)
------
RegisterCommand("lookdistance1", function(source, args, rawCommand)
    TriggerEvent('wwrp:lookdistance1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:lookdistance1')
AddEventHandler('wwrp:lookdistance1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 935157006, 1, 1, 0, 0)
end)
------
RegisterCommand("lookyonder1", function(source, args, rawCommand)
    TriggerEvent('wwrp:lookyonder1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:lookyonder1')
AddEventHandler('wwrp:lookyonder1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 7918540, 1, 1, 0, 0)
end)
------
RegisterCommand("point1", function(source, args, rawCommand)
    TriggerEvent('wwrp:point1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:point1')
AddEventHandler('wwrp:point1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 486225122, 1, 1, 0, 0)
end)
------
RegisterCommand("posseup1", function(source, args, rawCommand)
    TriggerEvent('wwrp:posseup1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:posseup1')
AddEventHandler('wwrp:posseup1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 474409519, 1, 1, 0, 0)
end)
------
RegisterCommand("prospectorjig1", function(source, args, rawCommand)
    TriggerEvent('wwrp:prospectorjig1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:prospectorjig1')
AddEventHandler('wwrp:prospectorjig1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1307697675, 1, 1, 0, 0)
end)
------
RegisterCommand("scheme1", function(source, args, rawCommand)
    TriggerEvent('wwrp:scheme1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:scheme1')
AddEventHandler('wwrp:scheme1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 589481092, 1, 1, 0, 0)
end)
------
RegisterCommand("shootemup1", function(source, args, rawCommand)
    TriggerEvent('wwrp:shootemup1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:shootemup1')
AddEventHandler('wwrp:shootemup1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1639456476, 1, 1, 0, 0)
end)
------
RegisterCommand("shootthesky1", function(source, args, rawCommand)
    TriggerEvent('wwrp:shootthesky1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:shootthesky1')
AddEventHandler('wwrp:shootthesky1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1939251934, 1, 1, 0, 0)
end)
------
RegisterCommand("letsstop1", function(source, args, rawCommand)
    TriggerEvent('wwrp:letsstop1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:letsstop1')
AddEventHandler('wwrp:letsstop1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1691237868, 1, 1, 0, 0)
end)
------
RegisterCommand("fancybow1", function(source, args, rawCommand)
    TriggerEvent('wwrp:fancybow1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:fancybow1')
AddEventHandler('wwrp:fancybow1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -2121881035, 1, 1, 0, 0)
end)
------
RegisterCommand("gentlewave1", function(source, args, rawCommand)
    TriggerEvent('wwrp:gentlewave1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:gentlewave1')
AddEventHandler('wwrp:gentlewave1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 901097731, 1, 1, 0, 0)
end)
------
RegisterCommand("goodtoseeya1", function(source, args, rawCommand)
    TriggerEvent('wwrp:goodtoseeya1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:goodtoseeya1')
AddEventHandler('wwrp:goodtoseeya1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 523585988, 1, 1, 0, 0)
end)
------
RegisterCommand("hattipping1", function(source, args, rawCommand)
    TriggerEvent('wwrp:hattipping1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:hattipping1')
AddEventHandler('wwrp:hattipping1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1457020913, 1, 1, 0, 0)
end)
------
RegisterCommand("heyyou1", function(source, args, rawCommand)
    TriggerEvent('wwrp:heyyou1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:heyyou1')
AddEventHandler('wwrp:heyyou1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 831975651, 1, 1, 0, 0)
end)
------
RegisterCommand("respectfulbow1", function(source, args, rawCommand)
    TriggerEvent('wwrp:respectfulbow1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:respectfulbow1')
AddEventHandler('wwrp:respectfulbow1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1801715172, 1, 1, 0, 0)
end)
------
RegisterCommand("toughguynod1", function(source, args, rawCommand)
    TriggerEvent('wwrp:toughguynod1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:toughguynod1')
AddEventHandler('wwrp:toughguynod1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1879954891, 1, 1, 0, 0)
end)
------
RegisterCommand("begformercy1", function(source, args, rawCommand)
    TriggerEvent('wwrp:begformercy1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:begformercy1')
AddEventHandler('wwrp:begformercy1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 164860528, 1, 1, 0, 0)
end)
------
RegisterCommand("howdareyou1", function(source, args, rawCommand)
    TriggerEvent('wwrp:howdareyou1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:howdareyou1')
AddEventHandler('wwrp:howdareyou1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1802342943, 1, 1, 0, 0)
end)
------
RegisterCommand("gag1", function(source, args, rawCommand)
    TriggerEvent('wwrp:gag1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:gag1')
AddEventHandler('wwrp:gag1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1118911493, 1, 1, 0, 0)
end)
------
RegisterCommand("hushyourmouth1", function(source, args, rawCommand)
    TriggerEvent('wwrp:hushyourmouth1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:hushyourmouth1')
AddEventHandler('wwrp:hushyourmouth1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1644757697, 1, 1, 0, 0)
end)
------
RegisterCommand("pointandlaugh1", function(source, args, rawCommand)
    TriggerEvent('wwrp:pointandlaugh1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:pointandlaugh1')
AddEventHandler('wwrp:pointandlaugh1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 803206066, 1, 1, 0, 0)
end)
------
RegisterCommand("imhit1", function(source, args, rawCommand)
    TriggerEvent('wwrp:imhit1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:imhit1')
AddEventHandler('wwrp:imhit1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -110352861, 1, 1, 0, 0)
end)
------
RegisterCommand("weep1", function(source, args, rawCommand)
    TriggerEvent('wwrp:weep1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:weep1')
AddEventHandler('wwrp:weep1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 81347960, 1, 1, 0, 0)
end)
------
RegisterCommand("whome1", function(source, args, rawCommand)
    TriggerEvent('wwrp:whome1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:whome1')
AddEventHandler('wwrp:whome1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 329631369, 1, 1, 0, 0)
end)
------
RegisterCommand("yeehaw1", function(source, args, rawCommand)
    TriggerEvent('wwrp:yeehaw1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:yeehaw1')
AddEventHandler('wwrp:yeehaw1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 445839715, 1, 1, 0, 0)
end)
------
RegisterCommand("gonnacry1", function(source, args, rawCommand)
    TriggerEvent('wwrp:gonnacry1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:gonnacry1')
AddEventHandler('wwrp:gonnacry1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 246916594, 1, 1, 0, 0)
end)
------
RegisterCommand("chicken1", function(source, args, rawCommand)
    TriggerEvent('wwrp:chicken1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:chicken1')
AddEventHandler('wwrp:chicken1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1825177171, 1, 1, 0, 0)
end)
------
RegisterCommand("flipoff1", function(source, args, rawCommand)
    TriggerEvent('wwrp:flipoff1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:flipoff1')
AddEventHandler('wwrp:flipoff1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 969312568, 1, 1, 0, 0)
end)
------
RegisterCommand("watchinyou1", function(source, args, rawCommand)
    TriggerEvent('wwrp:watchinyou1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:watchinyou1')
AddEventHandler('wwrp:watchinyou1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -553424129, 1, 1, 0, 0)
end)
------
RegisterCommand("bringiton1", function(source, args, rawCommand)
    TriggerEvent('wwrp:bringiton1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:bringiton1')
AddEventHandler('wwrp:bringiton1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1533402397, 1, 1, 0, 0)
end)
------
RegisterCommand("throatslit1", function(source, args, rawCommand)
    TriggerEvent('wwrp:throatslit1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:throatslit1')
AddEventHandler('wwrp:throatslit1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1256841324, 1, 1, 0, 0)
end)
------
RegisterCommand("warcry1", function(source, args, rawCommand)
    TriggerEvent('wwrp:warcry1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:warcry1')
AddEventHandler('wwrp:warcry1', function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 987239450, 1, 1, 0, 0)
end)
--- SCENARIO MENU
RegisterCommand("guitar1", function(source, args, rawCommand)
    TriggerEvent('wwrp:guitar1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:guitar1')
AddEventHandler('wwrp:guitar1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_SIT_GUITAR`, 360000, true, false, false, false)
end)
------
RegisterCommand("trumpet1", function(source, args, rawCommand)
    TriggerEvent('wwrp:trumpet1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:trumpet1')
AddEventHandler('wwrp:trumpet1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_TRUMPET`, 360000, true, false, false, false)
end)
------
RegisterCommand("sitground1", function(source, args, rawCommand)
    TriggerEvent('wwrp:sitground1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:sitground1')
AddEventHandler('wwrp:sitground1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `GENERIC_SIT_GROUND_SCENARIO`, 360000, true, false, false, false)
end)
------
RegisterCommand("crouchinspect1", function(source, args, rawCommand)
    TriggerEvent('wwrp:crouchinspect1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:crouchinspect1')
AddEventHandler('wwrp:crouchinspect1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `MP_LOBBY_WORLD_HUMAN_CROUCH_INSPECT`, 360000, true, false, false, false)
end)
------
RegisterCommand("starestoic1", function(source, args, rawCommand)
    TriggerEvent('wwrp:starestoic1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:starestoic1')
AddEventHandler('wwrp:starestoic1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `MP_LOBBY_WORLD_HUMAN_STARE_STOIC`, 360000, true, false, false, false)
end)
------
RegisterCommand("sternidles1", function(source, args, rawCommand)
    TriggerEvent('wwrp:sternidles1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:sternidles1')
AddEventHandler('wwrp:sternidles1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `MP_LOBBY_WORLD_HUMAN_STERNGUY_IDLES`, 360000, true, false, false, false)
end)
------
RegisterCommand("badass1", function(source, args, rawCommand)
    TriggerEvent('wwrp:badass1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:badass1')
AddEventHandler('wwrp:badass1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_BADASS`, 360000, true, false, false, false)
end)
------
RegisterCommand("bartender1", function(source, args, rawCommand)
    TriggerEvent('wwrp:bartender1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:bartender1')
AddEventHandler('wwrp:bartender1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_BARTENDER_CLEAN_GLASS`, 360000, true, false, false, false)
end)
------
RegisterCommand("broom1", function(source, args, rawCommand)
    TriggerEvent('wwrp:broom1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:broom1')
AddEventHandler('wwrp:broom1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_BROOM`, 360000, true, false, false, false)
end)
------
RegisterCommand("coffee1", function(source, args, rawCommand)
    TriggerEvent('wwrp:coffee1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:coffee1')
AddEventHandler('wwrp:coffee1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_COFFEE_DRINK`, 360000, true, false, false, false)
end)
------
RegisterCommand("walllean1", function(source, args, rawCommand)
    TriggerEvent('wwrp:walllean1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:walllean1')
AddEventHandler('wwrp:walllean1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_LEAN_BACK_WALL`, 360000, true, false, false, false)
end)
------
RegisterCommand("impatient1", function(source, args, rawCommand)
    TriggerEvent('wwrp:impatient1')
    ExecuteCommand("mixed2")

end)
    
RegisterNetEvent('wwrp:impatient1')
AddEventHandler('wwrp:impatient1', function()
    TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_WAITING_IMPATIENT`, 360000, true, false, false, false)
end)
------

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
end

_IsAnimSceneStarted = function(animscene)
	return Citizen.InvokeNative(0xCBFC7725DE6CE2E0, animscene, true)
end
_IsAnimSceneLoaded = function(animscene)
	return Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0)
end
_IsAnimSceneFinished = function(animscene)
	return (Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) == 1.0)
end
_GetAnimsceneProgress = function(animscene)
	return Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat())
end

RegisterCommand("snakedance", function(source, args, rawCommand)
    --[[ animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, "script@shows@snake_dancer@act1_p1@action", "PL_DANCE", false, true) --// _CREATE_ANIM_SCENE / ->f_48
    local coords = GetEntityCoords(PlayerPedId())
    SetAnimSceneOrigin(animscene, coords.x,coords.y,coords.z-2.5, vector3(0.0, 0.0, 3.5), 1);
    if IsModelInCdimage(`A_C_SNAKEREDBOA10FT_01`) then
        while not HasModelLoaded(`A_C_SNAKEREDBOA10FT_01`) do RequestModel(`A_C_SNAKEREDBOA10FT_01`) Citizen.Wait(10) end
    end
    handle = CreatePed(`A_C_SNAKEREDBOA10FT_01`, vector3(0.0, 0.0, -500.0), 0.0, false, false, true, true)
    SetEntityInvincible(handle,true)			
    Citizen.InvokeNative(0x283978A15512B2FE, handle, true)
    SetAnimSceneEntity(animscene, "DANCER", PlayerPedId(), 0)
    SetAnimSceneEntity(animscene, "SNAKE", handle, 0)
    SetModelAsNoLongerNeeded(`A_C_SNAKEREDBOA10FT_01`)
    LoadAnimScene(animscene)  
	while not _IsAnimSceneLoaded(animscene) do Citizen.Wait(10) end
    StartAnimScene(animscene)
    FadeAnimSceneAudioOut(animscene,0)
    SetAnimScenePlaybackList(animscene, "PL_DANCE")
	Citizen.InvokeNative(0x15598CFB25F3DC7E, animscene, "PL_DANCE", true)
    while not _IsAnimSceneFinished(animscene) do Citizen.Wait(10) end
    DeleteEntity(handle) 
    Citizen.InvokeNative(0x84EEDB2C6E650000, animscene)
    animscene = nil ]]
    local animDict = "script_shows@snakedancer@act1_p1"
    local animName = "dance_dancer"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("firedance", function(source, args, rawCommand)
    local animDict = "script_shows@firebreather@act2_p1"
    local animName = "dancer_dance"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)
RegisterCommand("cancan", function(source, args, rawCommand)
    local animDict = "script_shows@cancandance@p2"
    local animName = "cancandance_p2_fem1"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)

RegisterCommand("sword", function(source, args, rawCommand)
    local animDict = "script_shows@sworddance@act3_p1"
    local animName = "dancer_sworddance"
    local speed = 2.0
    local speedX = 2.0
    local duration = -1
    local flags = 1

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, speed, speedX, duration, flags, 0, 0, 0, 0 )
    RemoveAnimDict(animDict) 
end)
