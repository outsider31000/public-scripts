Citizen.CreateThread(function()
    WarMenu.CreateMenu('saloon', _U('saloon_menu'))
    WarMenu.SetSubTitle('saloon', _U('select_option'))
    WarMenu.CreateSubMenu('options', 'saloon', _U('select_option'))
    WarMenu.CreateSubMenu('horse_options', 'saloon', _U('select_option'))
    WarMenu.CreateMenu('saloon_house', _U('saloon_menu'))
    WarMenu.CreateSubMenu('options_house', 'saloon_house', _U('select_option'))
    WarMenu.CreateSubMenu('options2_house', 'saloon_house', _U('select_option2'))


    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(PlayerPedId(), true)
        for k,v in pairs(Config.SaloonLocations) do
            local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, false)
            if distance <= 1.5 then
                DrawTxt(_U('press_to'), 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, false)
                if IsControlJustReleased(0, 0xD9D0E1C0) then
                    TriggerServerEvent('smery_saloon:getjob', 'saloon_house')
                end
            end
        end
            if WarMenu.IsMenuOpened('saloon') then
                if WarMenu.MenuButton(_U('saloon_options'), 'options') then
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
            elseif WarMenu.IsMenuOpened('saloon_house') then
                if WarMenu.MenuButton(_U('saloon_options'), 'options_house') then
                elseif WarMenu.MenuButton(_U('change_clothes'), 'clothes_options') then
                elseif WarMenu.MenuButton(_U('select_option2'), 'options2_house') then
                end
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('horse_options') then
                if WarMenu.Button(_U('spawn_horse')) then
                    SpawnHorse()
                end
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('options_house') then
                if WarMenu.Button(_U('take_beer')) then
                    WarMenu.CloseMenu()
                    exports['progressBars']:startUI(8000, "Achat en cours...")
                    Citizen.Wait(8000)
                    TriggerServerEvent('smery_saloon:takebeer')
                elseif WarMenu.Button(_U('take_cognac')) then
                        WarMenu.CloseMenu()
                        exports['progressBars']:startUI(8000, "Achat en cours...")
                    Citizen.Wait(8000)
                    TriggerServerEvent('smery_saloon:takecognac')                        
                end
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('options2_house') then
                WarMenu.CloseMenu()
                WarMenu.Display()
            elseif WarMenu.IsMenuOpened('clothes_options') then
                if WarMenu.Button(_U('civil_clothes')) then
                    TriggerServerEvent("vorpcharacter:getPlayerSkin")
                elseif WarMenu.Button(_U('doctor_male')) then
                    ChangeClothes(GetHashKey("CS_SDDoctor_01"))
                elseif WarMenu.Button(_U('doctor_female')) then
                    ChangeClothes(GetHashKey("MSP_MARY1_FEMALES_01"))
                end
                --[[ WarMenu.Display()
            elseif IsControlJustReleased(0, 0x4AF4D473) then -- SUPR
                TriggerServerEvent('smery_saloon:getjob', 'saloon')]]
            end 
            Citizen.Wait(0)
        end
end)



    RegisterNetEvent('smery_saloon:auth')
    AddEventHandler('smery_saloon:auth', function(type)
        WarMenu.OpenMenu(type)
    end)
    
    RegisterNetEvent('smery_saloon:revive')
    AddEventHandler('smery_saloon:revive', function(closestPlayer)
        DoScreenFadeOut(800)
    
        while not IsScreenFadedOut() do
            Citizen.Wait(50)
        end
        
        Citizen.Wait(1200)
        TriggerEvent('vorp:resurrectPlayer', closestPlayer)
        DoScreenFadeIn(800)
    end)
    
    RegisterNetEvent('smery_saloon:heal')
    AddEventHandler('smery_saloon:heal', function(closestPlayer)
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
    for k,v in pairs(Config.Saloon1Locations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip'))
    end
end)
Citizen.CreateThread(function()
    for k,v in pairs(Config.Saloon2Locations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip1'))
    end
end)
Citizen.CreateThread(function()
    for k,v in pairs(Config.Saloon3Locations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip2'))
    end
end)
Citizen.CreateThread(function()
    for k,v in pairs(Config.Saloon4Locations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip3'))
    end
end)
Citizen.CreateThread(function()
    for k,v in pairs(Config.Saloon5Locations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip4'))
    end
end)
Citizen.CreateThread(function()
    for k,v in pairs(Config.Saloon6Locations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip5'))
    end
end)
Citizen.CreateThread(function()
    for k,v in pairs(Config.Saloon7Locations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip6'))
    end
end)
