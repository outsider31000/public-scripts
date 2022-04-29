local dontrelease = false 
local releasecheck = false 
local distancebreak = 25
local timetobreak = 20 * 1000
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
                --playerid = GetPlayerServerId(players[i])
                tgt1 = GetPlayerPed(players[i])
            end
        end
    end
    return closestPlayer, closestDistance
 end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if releasecheck then
            local player = PlayerPedId()
            local closestped, distance = GetClosestPlayer()
            if distance >= distancebreak then 
                Wait(timetobreak)
                dontrelease = false 
            else
                dontrelease = true
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if dontrelease then
            DisableControlAction(0, 0x295175BF, true)
        end
        DisableControlAction(0, 0x6E9734E8, true)
        DisableControlAction(0, 0x9CC7A1A4, true) -- disable special ability
        local size = GetNumberOfEvents(0)   
        if size > 0 then
            for i = 0, size - 1 do
                local eventAtIndex = GetEventAtIndex(0, i)
                if eventAtIndex == GetHashKey("EVENT_CHALLENGE_GOAL_COMPLETE") or eventAtIndex == GetHashKey("EVENT_CHALLENGE_REWARD") or eventAtIndex == GetHashKey("EVENT_DAILY_CHALLENGE_STREAK_COMPLETED") then 
                    Citizen.InvokeNative(0x6035E8FBCA32AC5E)
                end
            end
        end
        local player = PlayerPedId()
        local hogtied =  Citizen.InvokeNative(0x3AA24CCC0D451379, player)
        if hogtied then
            releasecheck = true 
        else
            releasecheck = false 
        end
       --[[  Citizen.InvokeNative(0x5FB53015, 3) ]]
    end
end)

