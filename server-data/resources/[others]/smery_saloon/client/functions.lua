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
            end
        end
    end
    return closestPlayer, closestDistance
end

function RevivePlayer(playerPed)
    local closestPlayerPed = GetPlayerPed(playerPed)
    if IsPedDeadOrDying(closestPlayerPed, 1) then
        local dic = "mech_revive@unapproved"
        local anim = "revive"
        loadAnimDict(dic)
        TaskPlayAnim(PlayerPedId(), dic, anim, 1.0, 8.0, 2000, 31, 0, true, true, false, false, true)
        --TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
        TriggerEvent("vorp:TipBottom", _U('revive_in_prog'), 2000)
        Wait(2000)
        ClearPedTasksImmediately(PlayerPedId())
        TriggerServerEvent('smery_saloon:revivePlayer', GetPlayerServerId(playerPed))
        WarMenu.CloseMenu()
    else
        TriggerEvent("vorp:TipBottom", _U('player_not_unconscious'), 3000)
    end
end

function HealPlayer(playerPed)
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
    TriggerEvent("vorp:TipBottom", _U('heal_in_prog'), 10000)
    Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
    TriggerServerEvent('smery_saloon:healPlayer', GetPlayerServerId(playerPed))
    WarMenu.CloseMenu()
end

function SpawnHorse()
    local ped = PlayerPedId()
    local model = GetHashKey("A_C_HORSE_ARABIAN_WHITE")
    loadModel(model)

    local pos = GetEntityCoords(ped, true)
    local myHorse = Citizen.InvokeNative(0xD49F9B0955C367DE, model, pos.x+5, pos.y+5, pos.z, 0.0, true, true, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, myHorse, true)
    Citizen.InvokeNative(0x9F3480FE65DB31B5, myHorse, 0)
    Citizen.InvokeNative(0x4AD96EF928BD4F9A, model)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, myHorse, 0x20359E53,true,true,true) --saddle
    Citizen.InvokeNative(0xD3A7B003ED343FD9, myHorse, 0x508B80B9,true,true,true) --blanket
    Citizen.InvokeNative(0xD3A7B003ED343FD9, myHorse, 0xF0C30271,true,true,true) --bag
    Citizen.InvokeNative(0xD3A7B003ED343FD9, myHorse, 0x12F0DF9F,true,true,true) --bedroll
    Citizen.InvokeNative(0xD3A7B003ED343FD9, myHorse, 0x67AF7302,true,true,true) --stirups
    Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, myHorse)
end

function ChangeClothes(hash)
    loadModel(hash)

    Citizen.InvokeNative(0xED40380076A31506, PlayerId(), hash, false)
	Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
	SetModelAsNoLongerNeeded(hash)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

function loadModel(model)
    RequestModel(model, true)
    while not HasModelLoaded(model) do
        Citizen.Wait(100)
    end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end