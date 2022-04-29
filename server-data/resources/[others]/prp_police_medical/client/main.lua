
function ScreenEffect(effect, time)
	AnimpostfxPlay(effect)
	Citizen.Wait(time)
	AnimpostfxStop(effect)
end

local oncooldown = false 

RegisterNetEvent("medical:useItem")
AddEventHandler("medical:useItem", function(index)
    TriggerEvent("vorp_inventory:CloseInv")
    local item = Config.medicalitems[index]
    if not oncooldown then 
        local testplayer = exports["syn_minigame"]:taskBar(item.diff,7)
        if testplayer == 100 then 
            oncooldown = true 
            TriggerEvent("fred_meta:consume",item["Hunger"],item["Thirst"],item["Metabolism"],item["InnerCoreStamina"],item["InnerCoreStaminaGold"],item["OuterCoreStaminaGold"],item["InnerCoreHealth"],item["InnerCoreHealthGold"],item["OuterCoreHealthGold"])
            local playerPed = PlayerPedId()
            RequestAnimDict("mech_inventory@item@stimulants@inject@quick")
            while not HasAnimDictLoaded("mech_inventory@item@stimulants@inject@quick") do
                Wait(100)
            end
            TaskPlayAnim(playerPed, "mech_inventory@item@stimulants@inject@quick", "quick_stimulant_inject_lhand", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
            Wait(5000)
            if (item["Effect"] ~= "") then
                ScreenEffect(item["Effect"], item["EffectDuration"])
            end
            ClearPedTasks(playerPed)
        else
            TriggerEvent("vorp:TipBottom", "You Botched The Treatment.", 4000)
        end
    else
        TriggerEvent("vorp:TipBottom", "You Have To Wait To Apply Treatment", 4000)
        TriggerServerEvent("medical:giveback",item.Name)
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(10)
        if oncooldown then 
            Wait(Config.cooldown)
            oncooldown = false 
        end
    end
end)


Citizen.CreateThread(function()
    WarMenu.CreateMenu('medic', _U('medic_menu'))
    WarMenu.SetSubTitle('medic', _U('select_option'))
    WarMenu.CreateSubMenu('options', 'medic', _U('select_option'))
    --WarMenu.CreateSubMenu('horse_options', 'medic', _U('select_option'))
    WarMenu.CreateMenu('medic_house', _U('medic_menu'))
    WarMenu.CreateSubMenu('options_house', 'medic_house', _U('select_option'))
    --WarMenu.CreateSubMenu('clothes_options', 'medic_house', _U('select_option'))


    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(PlayerPedId(), true)
        for k,v in pairs(Config.MedicLocations) do
            local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)
            if distance <= 1.5 then
                DrawTxt(_U('press_to'), 0.3, 0.95, 0.6, 0.4, true, 255, 255, 255, 255, false)
                if IsControlJustReleased(0, 0xD9D0E1C0) then
                    TriggerServerEvent('police_medical:getjob', 'medic_house')
                end
            end
        end
        if WarMenu.IsMenuOpened('medic') then
            if WarMenu.MenuButton(_U('medic_options'), 'options') then
            elseif WarMenu.MenuButton(_U('horse_options'), 'horse_options') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('options') then
            if WarMenu.Button(_U('revive_player')) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    TriggerEvent("vorp:TipBottom", _U('no_nearby_players'), 3000)
                else
                    RevivePlayer(closestPlayer)
                end
            elseif WarMenu.Button(_U('heal_player')) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    TriggerEvent("vorp:TipBottom", _U('no_nearby_players'), 3000)
                else
                    HealPlayer(closestPlayer)
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('medic_house') then
            if WarMenu.MenuButton(_U('medic_options'), 'options_house') then
            elseif WarMenu.MenuButton(_U('change_clothes'), 'clothes_options') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('horse_options') then
            if WarMenu.Button(_U('spawn_horse')) then
                SpawnHorse()
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('options_house') then
            if WarMenu.Button(_U('take_items')) then
                TriggerServerEvent('police_medical:takeItems')
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('clothes_options') then
            if WarMenu.Button(_U('civil_clothes')) then
                TriggerServerEvent("vorpcharacter:getPlayerSkin")
            elseif WarMenu.Button(_U('doctor_male')) then
                ChangeClothes(GetHashKey("CS_SDDoctor_01"))
            elseif WarMenu.Button(_U('doctor_female')) then
                ChangeClothes(GetHashKey("MSP_MARY1_FEMALES_01"))
            end
            WarMenu.Display()
        elseif IsControlJustReleased(0, 5) then -- SUPR
            --TriggerServerEvent('police_medical:getjob', 'medic')
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('police_medical:auth')
AddEventHandler('police_medical:auth', function(type)
    WarMenu.OpenMenu(type)
end)

RegisterNetEvent('police_medical:open')
AddEventHandler('police_medical:open', function(cb)
	WarMenu.OpenMenu('medic')
	--print ("openmenu")
end)


RegisterNetEvent('police_medical:revive')
AddEventHandler('police_medical:revive', function(closestPlayer)
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do
		Citizen.Wait(50)
    end
    
    Citizen.Wait(1200)
    TriggerEvent('vorp:resurrectPlayer', closestPlayer)
    DoScreenFadeIn(800)
end)

RegisterNetEvent('police_medical:heal')
AddEventHandler('police_medical:heal', function(closestPlayer)
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    local health = GetAttributeCoreValue(closestPlayerPed, 0)
    local newHealth = health + 50
    local stamina = GetAttributeCoreValue(closestPlayerPed, 1)
    local newStamina = stamina + 50
    local health2 = GetEntityHealth(closestPlayerPed)
    local newHealth2 = health2 + 50
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 1, newStamina) --core
    SetEntityHealth(closestPlayerPed, newHealth2)
end)



Citizen.CreateThread(function()
    for k,v in pairs(Config.MedicLocations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, -695368421, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip'))
    end
end)
