local hud = true

RegisterCommand("hud", function(source, args, rawCommand)
    if hud then
        DisplayRadar(false)
        TriggerEvent("vorp:showUi", false)
        hud = false
    else
        DisplayRadar(true)
        TriggerEvent("vorp:showUi", true)
        hud = true
    end
end)
Citizen.CreateThread(function() -- disable auto-aim
    while true do
        Citizen.Wait(10)
        Citizen.InvokeNative(0xD66A941F401E7302, 3)
    end
end)
RegisterCommand("zone",function()
    local ped_coords = GetEntityCoords(PlayerPedId())
    local x,y,z =  table.unpack(ped_coords + vector3(0.0,0.0,0.0))
    zone = Citizen.InvokeNative(0x43AD8FC02B429D33,x,y,z,-1) --GetMapZoneAtCoords()
    print(zone)
end)

RegisterCommand("Stinky",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -166523388 , 1, 1, 0, 0)
end)

RegisterCommand("tip",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1457020913 , 1, 1, 0, 0)
end)--TipHat

RegisterCommand("Slit",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1256841324 , 1, 1, 0, 0)
end)--Slit Throut

RegisterCommand("SlwClp",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1023735814 , 1, 1, 0, 0)
end)--Slow Clap

RegisterCommand("Smh",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -653113914 , 1, 1, 0, 0)
end)--smh

RegisterCommand("Spit",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -2106738342, 1, 1, 0, 0)
end)--Spit

RegisterCommand("No",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1509171361, 1, 1, 0, 0)
end)--Thumbs Down

RegisterCommand("Yes",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 425751659, 1, 1, 0, 0)
end)--Thumbs Up

RegisterCommand("Wave",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -339257980, 1, 1, 0, 0)
end)--wave

RegisterCommand("Bird",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 969312568 , 1, 1, 0, 0)
end)--smh

RegisterCommand("dv", function()--Delete Vehicle
    local playerPed = PlayerPedId()
    local vehicle   = GetVehiclePedIsIn(playerPed, false)

    if IsPedInAnyVehicle(playerPed, true) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    end

    if DoesEntityExist(vehicle) then
        DeleteVehicle(vehicle)
    end
end)

RegisterCommand("dh", function()--Delete Vehicle
    local playerPed = PlayerPedId()
    local mount   = GetMount(PlayerPedId())

    if IsPedOnMount(playerPed) then
        DeleteEntity(mount)
    end

end)

RegisterNetEvent('syn:heal')
AddEventHandler('syn:heal', function(id)
    local closestPlayerPed = GetPlayerPed(id)
    print(closestPlayerPed)
    local health = GetAttributeCoreValue(closestPlayerPed, 0)
    local newHealth = health + 100
    local stamina = GetAttributeCoreValue(closestPlayerPed, 1)
    local newStamina = stamina + 100
    local health2 = GetEntityHealth(closestPlayerPed)
    local newHealth2 = health2 + 100
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 1, newStamina) --core
    TriggerServerEvent("fred_meta:setStatus", 100, 100, 10000)
    SetEntityHealth(closestPlayerPed, newHealth2)
end)

RegisterNetEvent('syn:godmode')
AddEventHandler('syn:godmode', function(id)
    god = GetPlayerInvincible(id)
    if god == false then 
        SetPlayerInvincible(id, true)
    else
        SetPlayerInvincible(id, false)
    end
    god2 = GetPlayerInvincible(id)
    print(god2)
end)

RegisterNetEvent('syn:tpm')
AddEventHandler('syn:tpm', function(source)
    local playerped = GetPlayerPed(source)
    local waypt = GetWaypointCoords()
     for height = 1, 1000 do
        SetEntityCoords(playerped, waypt.x, waypt.y, height + 0.0, true, true, true, false)
        local foundGround, zPos = GetGroundZAndNormalFor_3dCoord(waypt.x, waypt.y, height + 0.0)
        if foundGround then
            SetEntityCoords(playerped, waypt.x, waypt.y, height + 0.0, true, true, true, false)
            break
        end
        Citizen.Wait(5)
    end 
end)

--[[ RegisterCommand("bandana", function(source, args)
    if puesta then 
        Citizen.InvokeNative(0xAE72E7DF013AAA61,PlayerPedId(),GetHashKey("KIT_BANDANA"), GetHashKey("BANDANA_OFF_RIGHT_HAND"), 1, 0, -1082130432)
        Wait(700)
        -- Quitar bandana
        Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(),-972364774)
        Citizen.InvokeNative(0xCC8CA3E88256E58F,PlayerPedId(),0,1,1,1,false)
        puesta = false
    else
        Citizen.InvokeNative(0xAE72E7DF013AAA61,PlayerPedId(),GetHashKey("KIT_BANDANA"), GetHashKey("BANDANA_ON_RIGHT_HAND"), 1, 0, -1082130432)
        Wait(700)
        -- Poner bandana
        Citizen.InvokeNative(0x1902C4CFCC5BE57C,PlayerPedId(),-1100875244)
        Citizen.InvokeNative(0xCC8CA3E88256E58F,PlayerPedId(),0,1,1,1,false)
        puesta = true
    end
end) ]]


