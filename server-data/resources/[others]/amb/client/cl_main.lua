local healing = false

local locations = {
    {x = -288.95, y =  812.84, z = 118.58, h = 163.1487},
    {x = -1803.17,y =   -432.19,z = 158.32, h = 38.70},
    {x = 2722.742,y =   -1234.177,z = 50.71943, h = 134.10},
    {x = 1369.78,y =   -1310.50,z = 77.43, h = 74.10},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k, v in pairs(locations) do
            if not DoesEntityExist(samueljackson) then
                RequestModel(GetHashKey("CS_SDDoctor_01"))

                while not HasModelLoaded(GetHashKey("CS_SDDoctor_01")) do
                    Wait(100)
                end

                samueljackson = CreatePed("CS_SDDoctor_01", v.x, v.y, v.z, v.h, false, true)
                SetPedRandomComponentVariation(samueljackson, 0)
                SetBlockingOfNonTemporaryEvents(samueljackson, true)
                SetEntityInvincible(samueljackson, true)
                SetPedCanBeTargettedByPlayer(samueljackson, PlayerPedId(), false)
                FreezeEntityPosition(samueljackson, true)
            end
        end
        for i = 1, #locations do

            if IsPlayerNearCoords(locations[i].x, locations[i].y, locations[i].z, 1) then
                print("test")

                print("test")
                if not healing then
                    DisplayNPCText("SAMUEL JACKSON", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
                    DisplayNPCText("Hej! Hvordan kan jeg hjælpe dig?", 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
                    TriggerEvent("vorp:TipBottom", "Tryk på [C] for at blive behandlet af lægen.", 2000)
                    if IsControlJustReleased(0, 0x9959A6F0) then
                        if IsEntityDead(PlayerPedId()) then
                            TriggerEvent('vorp:resurrectPlayer', PlayerPedId())
                            TriggerServerEvent('ambulancejob:CobrarRevivir')
		    				TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Det kostede 40$.", "generic_textures", "tick", 8000)
                        else
                            HealPlayer()
                            TriggerServerEvent('ambulancejob:CobrarRevivir')
		    				TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Det kostede 40$.", "generic_textures", "tick", 8000)
                        end
                    end
                end
            end
        end
    end
end)
--[[  --- STRAWBERRY
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if not DoesEntityExist(samueljackson) then
            RequestModel(GetHashKey("CS_SDDoctor_01"))

            while not HasModelLoaded(GetHashKey("CS_SDDoctor_01")) do
                Wait(100)
            end

            samueljackson = CreatePed("CS_SDDoctor_01", -1803.17, -432.19, 159.02, 38.70, false, true)
            SetPedRandomComponentVariation(samueljackson, 0)
            SetBlockingOfNonTemporaryEvents(samueljackson, true)
            SetEntityInvincible(samueljackson, true)
            SetPedCanBeTargettedByPlayer(samueljackson, PlayerPedId(), false)
        end

        if IsPlayerNearCoords(-1803.17, -432.19, 159.02, 1) then
            if not healing then
                DisplayNPCText("Abraham Lincoln", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
                DisplayNPCText("Hej! Hvordan kan jeg hjælpe dig?", 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
                TriggerEvent("vorp:Tip", "Tryk på [C] for at blive behandlet af lægen.", 100)
                if IsControlJustReleased(0, 0x9959A6F0) then
                    if IsEntityDead(PlayerPedId()) then
                        TriggerEvent('vorp:resurrectPlayer', PlayerPedId())
                        TriggerServerEvent('ambulancejob:CobrarRevivir')
                        TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Det kostede 40$.", "generic_textures", "tick", 8000)
                    else
                        HealPlayer()
                        TriggerServerEvent('ambulancejob:CobrarRevivir')
						TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Det kostede 40$.", "generic_textures", "tick", 8000)
                    end
                end
            end
        end
    end
end)
 --- RHODES
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if not DoesEntityExist(samueljackson) then
            RequestModel(GetHashKey("U_M_M_RHDDOCTOR_01"))

            while not HasModelLoaded(GetHashKey("U_M_M_RHDDOCTOR_01")) do
                Wait(100)
            end

            samueljackson = CreatePed("U_M_M_RHDDOCTOR_01", 1369.78, -1310.50, 78.13, 134.10, false, true)
            SetPedRandomComponentVariation(samueljackson, 0)
            SetBlockingOfNonTemporaryEvents(samueljackson, true)
            SetEntityInvincible(samueljackson, true)
            SetPedCanBeTargettedByPlayer(samueljackson, PlayerPedId(), false)
        end

        if IsPlayerNearCoords(1369.78, -1310.50, 78.13, 1) then
            if not healing then
                DisplayNPCText("Tommy Derry", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
                DisplayNPCText("Hej! Hvordan kan jeg hjælpe dig?", 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
                TriggerEvent("vorp:Tip", "Tryk på [C] for at blive behandlet af lægen.", 100)
                if IsControlJustReleased(0, 0x9959A6F0) then
                    if IsEntityDead(PlayerPedId()) then
                        TriggerEvent('vorp:resurrectPlayer', PlayerPedId())
                        TriggerServerEvent('ambulancejob:CobrarRevivir')
                        TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Det kostede 40$.", "generic_textures", "tick", 8000)
                    else
                        HealPlayer()
                        TriggerServerEvent('ambulancejob:CobrarRevivir')
						TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Det kostede 40$.", "generic_textures", "tick", 8000)
                    end
                end
            end
        end
    end
end)
 --- Saint Dennis
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if not DoesEntityExist(samueljackson) then
            RequestModel(GetHashKey("U_M_M_RHDDOCTOR_01"))

            while not HasModelLoaded(GetHashKey("U_M_M_RHDDOCTOR_01")) do
                Wait(100)
            end

            samueljackson = CreatePed("U_M_M_RHDDOCTOR_01", 2723.142, -1233.177, 51.41943, 74.10, false, true)
            SetPedRandomComponentVariation(samueljackson, 0)
            SetBlockingOfNonTemporaryEvents(samueljackson, true)
            SetEntityInvincible(samueljackson, true)
            SetPedCanBeTargettedByPlayer(samueljackson, PlayerPedId(), false)
        end

        if IsPlayerNearCoords(2722.742, -1234.177, 51.41943, 1) then
            if not healing then
                DisplayNPCText("John Dalton", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
                DisplayNPCText("Hej! Hvordan kan jeg hjælpe dig?", 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
                TriggerEvent("vorp:Tip", "Tryk på [C] for at blive behandlet af lægen.", 100)
                if IsControlJustReleased(0, 0x9959A6F0) then
                    if IsEntityDead(PlayerPedId()) then
                        TriggerEvent('vorp:resurrectPlayer', PlayerPedId())
                        TriggerServerEvent('ambulancejob:CobrarRevivir', 0, 40.0)
                        TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Det kostede 40$.", "generic_textures", "tick", 8000)
                    else
                        HealPlayer()
                        TriggerServerEvent('ambulancejob:CobrarRevivir')
						TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Det kostede 40$.", "generic_textures", "tick", 8000)
                    end
                end
            end
        end
    end
end) ]]

function IsPlayerNearCoords(x, y, z, radius)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < radius then
        return true
    end
end

function DisplayNPCText(text, s1, s2, x, y, r, g, b, font)
    SetTextScale(s1, s2)
    SetTextColor(r, g, b, 255)--r,g,b,a
    SetTextCentre(true)--true,false
    SetTextDropshadow(1, 0, 0, 0, 200)--distance,r,g,b,a
    SetTextFontForCurrentCommand(font)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

function HealPlayer()
    print("test")
    healing = true
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_FALL_ASLEEP"), 10000, true, false, false, false)
    Wait(10000)
    ClearPedTasks(PlayerPedId())
    Citizen.InvokeNative(0x50C803A4CD5932C5, true)
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, 100)
    TriggerEvent("vorp:NotifyLeft", "~t6~Du er blevet behandlet","Forhold dig nu sikkert derude.", "generic_textures", "tick", 8000)
	healing = false
end
