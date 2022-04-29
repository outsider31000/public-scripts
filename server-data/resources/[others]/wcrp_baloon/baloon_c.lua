-- Spawn Balloon --------------------------------------------------------------------




local balloon = nil


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, -202.877, 739.99, 122.1846) < 3.0) then
            DrawTxt("Press [~e~SPACEBAR~q~] to Ride Baloon.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0xD9D0E1C0) then -- SPACEBAR
                TriggerEvent("SpawnBalloon")
                --print('openedwarmenu')

            end
        end
    end
end)

Citizen.CreateThread(function()
    
        local blip = N_0x554d9d53f696d002(1664425300, -202.877, 739.99, 122.1846)
        SetBlipSprite(blip, 2061546582, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Ride Baloon")


      --[[   local baloon = CreateObject(952582462, -202.877, 739.99, 122.1846, true, false, true)
            SetEntityHeading(baloon, 200.08)
            PlaceObjectOnGroundProperly(baloon)
            SetEntityAsMissionEntity(baloon) ]]
    
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
   SetTextScale(w, h)
   SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
   SetTextCentre(centre)
   if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
   Citizen.InvokeNative(0xADA9255D, 10);
   DisplayText(str, x, y)
end

RegisterNetEvent('SpawnBalloon')
AddEventHandler('SpawnBalloon', function()
    Citizen.CreateThread(function()

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local head = GetEntityHeading(playerPed)
        local hash = GetHashKey('hotAirBalloon01')

        while not HasModelLoaded(hash) do
            Wait(10)
            RequestModel(hash)
        end

        if DoesEntityExist(balloon) then
            SetEntityAsMissionEntity(balloon)
            DeleteEntity(balloon)
            balloon = nil
        end

        balloon = CreateVehicle(hash, coords.x, coords.y-2.0, coords.z, head, true, true)

    end)
end)

Citizen.CreateThread(function()
    while true do
        local wait = 500
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(playerPed)
        local driving = GetPedInVehicleSeat(vehicle, -1)
        if IsPedInFlyingVehicle(playerPed) and driving then
            wait = 5
            if IsControlPressed(0, 0x8FD015D8) then  -- W
                ApplyForceToEntity(vehicle, 0, 2.5, 0.0, 0.0, 1.0, 0.0, 0.0, 0, false, true, true, false, true)
            end
            if IsControlPressed(0, 0x7065027D) then -- A
                ApplyForceToEntity(vehicle, 0, 0.0, 2.5, 0.0, 1.0, 0.0, 0.0, 0, false, true, true, false, true)
            end
            if IsControlPressed(0, 0xD27782E3) then -- S
                ApplyForceToEntity(vehicle, 0, -2.5, 0.0, 0.0, 1.0, 0.0, 0.0, 0, false, true, true, false, true)
            end
            if IsControlPressed(0, 0xB4E465B4) then -- D
                ApplyForceToEntity(vehicle, 0, 0.0, -2.5, 0.0, 1.0, 0.0, 0.0, 0, false, true, true, false, true)
            end
        end
        Wait(wait)
    end
end)