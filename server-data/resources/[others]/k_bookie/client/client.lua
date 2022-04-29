local client_init = false
local client_spawned = false
local client_bookie_peds = false
local fighting = false
local fightended = false
local bettingactive = false
local winner = false
local namechange = false
local menuopen = false
local fair_fight = true
local selection = math.random(1,2)
local selection_amount = 10
--local isHosting = false {unused}
local distance_to_bookie = 999
local cnt_namedlist = tablelength(Config.named_ped_list)

Balance = {spent=0,won=0,lost=0,diff=0}
History = {}
Data = {}

---- [1] INIT Client Loop
-- FIRST ENTRY for Client
Citizen.CreateThread(function()
        Wait(20000)
        if not client_init then
            TriggerServerEvent('k_bookie:setHost', Citizen.InvokeNative(0x8DB296B814EDDA07))
        end
end)

---- [2] INIT Client
--- Populate Data
RegisterNetEvent('clientData')
AddEventHandler('clientData', function(_data)
    if type(_data) == 'table' then
        Data = _data
        client_init = true
    end
end)
-- Populates a key set by the Server
RegisterNetEvent('clientKey')
AddEventHandler('clientKey', function(key,value)
    Data[key] = value
end)

-- CLIENT PAYOUT / WINNER
RegisterNetEvent('clientPayout')
AddEventHandler('clientPayout', function(payout,amount,winner)
    print("You won " .. payout .. " with: $ " .. amount .. " @ " .. Config.players[winner].fake_name )
    History[#History+1] = "You won " .. payout .. " with: $ " .. amount .. " @ " .. Config.players[winner].fake_name
    Balance.won = Balance.won + payout
    Balance.diff = Balance.won - Balance.spent
    TriggerServerEvent('k_bookie:addCash', payout)
end)

-- CLIENT LOST BET
RegisterNetEvent('clientLost')
AddEventHandler('clientLost', function(payout,amount,winner)
    print("You lost " .. amount .. " @ " .. Config.players[winner].fake_name )
    History[#History+1] = "You lost " .. amount .. " @ " .. Config.players[winner].fake_name
    Balance.lost = Balance.lost + amount
    Balance.diff = Balance.won - Balance.spent
end)

RegisterNetEvent('respawnPlayers')
AddEventHandler('respawnPlayers', function()
    --print("Respawn Bookie Players")
    if Data["host"] ~= false and Data["host"] == GetPlayerServerId() then
        local ped_1 = Config.named_ped_list[math.random(1,cnt_namedlist)]
        local ped_2 = Config.named_ped_list[math.random(1,cnt_namedlist)]

        Config.players[1].model = ped_1.model
        Config.players[1].fake_name = ped_1.name
        Config.players[1].hp = ped_1.hp
        Config.players[2].model = ped_2.model
        Config.players[2].fake_name = ped_2.name
        Config.players[2].hp = ped_2.hp

        Data["players"][1].model = ped_1.model
        Data["players"][1].fake_name = ped_1.name
        Data["players"][1].hp = ped_1.hp
        Data["players"][2].model = ped_2.model
        Data["players"][2].fake_name = ped_2.name
        Data["players"][2].hp = ped_2.hp

        SpawnPeds(Config.players,true)
        bettingactive = true
        namechange = true --this is for resetting the PromptMenu
        --print("client [host] > server : k_bookie:setSpawned")
        TriggerServerEvent('k_bookie:setSpawned',true)
    end
    --Wait(2000)
    --print("client [all] > server : k_bookie:setData")
    TriggerServerEvent('k_bookie:setData',Data)
end)

RegisterNetEvent('clientSpawned')
AddEventHandler('clientSpawned', function(_spawned)
    spawned = _spawned
end)

---- INIT
Citizen.CreateThread(function()
    while true do
        Wait(1)
        -- do we need to spawn ?
        if client_init and not client_spawned then
            if Data["host"] ~= false and Data["host"] == GetPlayerServerId() then
               -- print("client [host] > SpawnPeds")
                SpawnPeds(Data["players"],true)
                SpawnPeds(Data["bookies"],false)
                bettingactive = true
                namechange = true -- added
            else
                SpawnPeds(Data["bookies"],false)
            end
            client_spawned = true
        end
        -- CLEAR TASK WHEN IS_PED_FLEEING ( bookie )
        -- ped still is panicked .. but no longer running .. need flag ?
        if client_spawned and client_init then
            if Citizen.InvokeNative(0xBBCCE00B381F8482, Data["bookies"][1].ped) then
                Citizen.InvokeNative(0xE1EF3C1216AFF2CD, Data["bookies"][1].ped, true, true)
            end
        end
    end
end)


--- Spawn Peds or Bookie
function SpawnPeds(peds,isPlayerPed)

    if type(peds) == 'table' then

        for k,v in pairs(peds) do
            local netMissionEntity = false
            local pedModel = GetHashKey(v.model)
            local pedHP = v.hp
            while not HasModelLoaded(pedModel) do
                Wait(500)
                modelrequest(pedModel)
            end

            local new_ped = CreatePed(pedModel, v.pos.X, v.pos.Y, v.pos.Z, v.pos.H, v.isNetwork, netMissionEntity)

            while not DoesEntityExist(new_ped) do
                Wait(300)
            end

            Citizen.InvokeNative(0x283978A15512B2FE, new_ped, true) -- _SET_RANDOM_OUTFIT_VARIATION [MANDATORY]
            FreezeEntityPosition(new_ped, true)
            TaskStandStill(new_ped, -1)

            -- Remove Weapon from ped until WEAPON_UNARMED is bestweapon
            while Citizen.InvokeNative(0x8483E98E8B888AE2,new_ped,true,true) ~= -1569615261 do
                local bestweapon = Citizen.InvokeNative(0x8483E98E8B888AE2,new_ped,true,true)
                Citizen.InvokeNative(0x4899CB088EDF59B8, new_ped, bestweapon, true, false)
            end

            if isPlayerPed then
                Data["players"][k].ped = new_ped
                SetPedMaxHealth(new_ped,pedHP)
                Citizen.InvokeNative(0x166E7CF68597D8B5,new_ped, pedHP) -- SET_ENTITY_MAX_HEALTH
                Citizen.InvokeNative(0xAC2767ED8BDFAB15,new_ped, pedHP,0) --_SET_ENTITY_HEALTH
            else
                Data["bookies"][k].ped = new_ped
                SetAmbientVoiceName(new_ped, v.voice)
                SetEntityInvincible(new_ped, true)
                client_bookie_peds = {}
                table.insert(client_bookie_peds, new_ped)
                SetEntityCanBeDamagedByRelationshipGroup(new_ped, false, `PLAYER`)
            end
            TriggerServerEvent('k_bookie:setData', Data)
            SetModelAsNoLongerNeeded(pedModel)

        end

    else
        print("peds is not a table in SpawnPeds()")
    end

end

--- Delete Peds or Bookies
function DelPeds(peds)
    if type(peds) == 'table' then
        for k,v in pairs(peds) do
            DeletePed(v.ped)
        end
    else
        print("peds is not a table in DelPeds()")
    end
end

-- PROMPT
local FightersGroup = GetRandomIntInRange(0, 0xffffff)
local Fightersprompt
function FightersPrompt()
    Citizen.CreateThread(function()
        local str = Config.start_control_name
        Fightersprompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(Fightersprompt, Config.start_control)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Fightersprompt, str)
        PromptSetEnabled(Fightersprompt, true)
        PromptSetVisible(Fightersprompt, true)
        PromptSetHoldMode(Fightersprompt, false)
        PromptSetGroup(Fightersprompt, FightersGroup)
        PromptRegisterEnd(Fightersprompt)
    end)
end

local FightersBetprompt
function FightersBetPrompt()
    Citizen.CreateThread(function()
        local str = Config.bet_control_name .. selection_amount
        FightersBetprompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(FightersBetprompt, Config.bet_control)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(FightersBetprompt, str)
        PromptSetEnabled(FightersBetprompt, true)
        PromptSetVisible(FightersBetprompt, true)
        PromptSetHoldMode(FightersBetprompt, false)
        PromptSetGroup(FightersBetprompt, FightersGroup)
        PromptRegisterEnd(FightersBetprompt)
    end)
end

local FightersNameprompt
function FightersNamePrompt()
    Citizen.CreateThread(function()
        local str = 'On ' .. tostring(Config.players[selection].fake_name)
        FightersNameprompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(FightersNameprompt, Config.select_control)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(FightersNameprompt, str)
        PromptSetEnabled(FightersNameprompt, true)
        PromptSetVisible(FightersNameprompt, true)
        PromptSetHoldMode(FightersNameprompt, false)
        PromptSetGroup(FightersNameprompt, FightersGroup)
        PromptRegisterEnd(FightersNameprompt)
    end)
end

-- PROMPT_ACTIVATION
local active = false
Citizen.CreateThread(function()
    FightersPrompt()
    FightersBetPrompt()
    FightersNamePrompt()
    while true do
        Wait(0)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local dist = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, Config.bookies[1].pos.X, Config.bookies[1].pos.Y, Config.bookies[1].pos.Z)
        distance_to_bookie = dist
        if dist < 2.0 and not active and not fighting and not fightended and bettingactive then
            _prompt_group_name = Config.prompt_group_name .. " ( pot: $ " .. Data["bets"]["pot"] .. " ) "
            local FightersGroupName  = CreateVarString(10, 'LITERAL_STRING', _prompt_group_name)
            PromptSetActiveGroupThisFrame(FightersGroup, FightersGroupName)
            if IsControlJustReleased(0, Config.start_control) then
                    TriggerServerEvent('k_bookie:getData', Data)
                    Wait(100)
                    local current_amount = 0
                    current_amount = current_amount + selection_amount
                    TriggerServerEvent('k_bookie:setBet',current_amount)
                end

                if IsControlJustReleased(0, Config.bet_control_down) then
                    --Wait(100)
                    selection_amount = selection_amount - Config.step
                    if selection_amount <= Config.min_bet then
                        selection_amount = Config.min_bet
                    end
                    PromptDelete(FightersBetprompt)
                    FightersBetPrompt()
                end

                if IsControlJustReleased(0, Config.bet_control) then
                    --Wait(100)
                    selection_amount = selection_amount + Config.step
                    if selection_amount >= Config.max_bet then
                        selection_amount = Config.max_bet
                    end
                    PromptDelete(FightersBetprompt)
                    FightersBetPrompt()
                end

                if IsControlJustReleased(0, Config.select_control) or IsControlJustReleased(0, Config.select_control_two) then
                    --Wait(100)
                    if selection == 1 then selection = 2 else
                        selection = 1
                    end
                    PromptDelete(FightersNameprompt)
                    FightersNamePrompt()
                end

            else
                active = false
        end
        if namechange then
            if Data["players"][1].fake_name then
                Config.players[1].fake_name = Data["players"][1].fake_name
                Config.players[2].fake_name = Data["players"][2].fake_name
                Config.players[1].model = Data["players"][1].model
                Config.players[2].model = Data["players"][2].model
            end
            PromptDelete(FightersNameprompt)
            FightersNamePrompt()
            namechange = false
        end
        if active then
            for k,v in pairs(Data["players"]) do
                local fighter = Data["players"][k]
                FreezeEntityPosition(fighter.ped, false)
                if k == 1 then TaskCombatPed(fighter.ped, Data["players"][2].ped) else
                    TaskCombatPed(fighter.ped, Data["players"][1].ped)
                end
                TaskStandStill(fighter.ped, 0)
            end
            fighting = true
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if client_spawned then

        local p1 = Data["players"][1].ped
        local p2 = Data["players"][2].ped
        local posa = GetEntityCoords(p1)
        local posb = GetEntityCoords(p2)

        if Config.show_names and distance_to_bookie < 20 and client_spawned and not fightended then
            DrawText3D(posa.x+0, posa.y,posa.z-1, Data["players"][1].fake_name)
            DrawText3D(posb.x+0, posb.y,posb.z-1, Data["players"][2].fake_name)
        end

        if distance_to_bookie < 20 and client_spawned then
            if IsControlJustReleased(0, Config.menu_control) then
                if not menuopen then ExecuteCommand('bookie_menu') else
                    ExecuteCommand('bookie_close')
                end
            end
        end

        if Config.show_bookie_pot and distance_to_bookie < 20 then
            local bookie = Config.bookies[1].pos
            DrawText3D(bookie.X, bookie.Y, bookie.Z+1, "POT : " .. Data["bets"]["pot"] .. " / " .. Config.max_pot )
        end

        if Config.debugger and client_spawned and distance_to_bookie < 20 then
            DrawText3D(posa.x,posa.y,posa.z-0.2,Data["players"][1].model.. "\n" ..  Data["players"][1].ped .. "\n" .. GetEntityHealth(Data["players"][1].ped)  )
            DrawText3D(posb.x,posb.y,posb.z-0.2,Data["players"][2].model.. "\n" ..  Data["players"][2].ped .. "\n" .. GetEntityHealth(Data["players"][2].ped)  )
        end

        -- if Config.debugger and client_spawned then
        --    DrawText(0.75,0.50, "fighting: "..tostring(fighting))
        --    DrawText(0.75,0.52, "fightended: "..tostring(fightended))
        --    DrawText(0.75,0.54, "bettingactive: "..tostring(bettingactive))
        --
        --    DrawText(0.75,0.60, "WINNER: "..tostring(winner))
        --    DrawText(0.75,0.62, "PED A BETS: "..tostring(Data["bets"][1]))
        --    DrawText(0.75,0.64, "PED B BETS: "..tostring(Data["bets"][2]))
        --    DrawText(0.75,0.66, "TOTAL POT: "..tostring(Data["bets"]["pot"]))
        --end

        if client_spawned and fighting then
            local deada = tostring(IsEntityDead(p1))
            local deadb = tostring(IsEntityDead(p2))

            if Citizen.InvokeNative(0xBBCCE00B381F8482, p1) then
                Citizen.InvokeNative(0xE1EF3C1216AFF2CD, p1, true, true)
                TaskCombatPed(p1, p2)
            end

            if Citizen.InvokeNative(0xBBCCE00B381F8482, p2) then
                Citizen.InvokeNative(0xE1EF3C1216AFF2CD, p2, true, true)
                TaskCombatPed(p2, p1)
            end

            -- IS ONE OF PEDS DEAD
            if deada ~= tostring(false) or deadb ~= tostring(false) then
                -- PED B = winner
                if deada ~= tostring(false) then -- PED B = winner
                    player = PlayerPedId()
                    sod = GetPedSourceOfDeath(p1)
                    fair_fight = true
                    if IsPedAPlayer(sod) then
                         fair_fight = false
                    end
                        winner = 2

                    Citizen.InvokeNative(0xBB9CE077274F6A1B,p2,1.0,1)
                else -- PED A = winner
                    player = PlayerPedId()
                    fair_fight = true
                    sod = GetPedSourceOfDeath(p2)
                    if IsPedAPlayer(sod) then
                        fair_fight = false
                    end
                        winner = 1

                    Citizen.InvokeNative(0xBB9CE077274F6A1B,p1,1.0,1)
                end
                fightended = true
                fighting = false
            end

        end

        end
    end
end)

-- Check for cheating
Citizen.CreateThread(function ()
    while true do
    Wait(500)
        if client_spawned and Config.enable_guards then
        local deada = tostring(IsEntityDead(Data["players"][1].ped))
        local deadb = tostring(IsEntityDead(Data["players"][2].ped))

        -- IS ONE OF PEDS DEAD
        if deada ~= tostring(false) or deadb ~= tostring(false) then
            -- PED B = winner
            if deada ~= tostring(false) then -- PED B = winner
                player = PlayerPedId()
                TriggerGuard(Data["players"][1].ped, player)
            else -- PED A = winner
                player = PlayerPedId()
                TriggerGuard(Data["players"][2].ped, player)
            end

        end
    end
    end
end)

-- Trigger a Guard
function TriggerGuard(ped,player)
    local sod = GetPedSourceOfDeath(ped)
    if Config.guard[1].ped ~= nil then
        if not IsEntityDead(Config.guard[1].ped) then
            if sod == player then
                TaskCombatPed(Config.guard[1].ped, player)
                SetPedKeepTask(guard_ped,true)
            end
            return
        end
        SetEntityAsMissionEntity(Config.guard[1].ped, true, true)
        DeletePed(Config.guard[1].ped)
        Config.guard[1].ped = nil
    end
    local _player = player
    if sod == player then
        print("Ped Killed by a Player")
        local guard = Config.guard[1]
        print(guard.model, guard.pos.X, guard.pos.Y, guard.pos.Z, guard.pos.H, guard.isNetwork, false)

        local guardModel = GetHashKey(guard.model)
        while not HasModelLoaded(guardModel) do
            Wait(500)
            modelrequest(guardModel)
        end

        local guard_ped = CreatePed(guardModel, guard.pos.X, guard.pos.Y, guard.pos.Z, guard.pos.H, guard.isNetwork, false)

        while not DoesEntityExist(guard_ped) do
            Wait(300)
            print("Waiting for model")
        end
        Config.guard[1].ped = guard_ped

        local arma = GetHashKey(guard.weapon)
        GiveWeaponToPed_2(guard_ped, arma, 50, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
        SetCurrentPedWeapon(guard_ped, arma, true)
        Citizen.InvokeNative(0x283978A15512B2FE, guard_ped, true) -- _SET_RANDOM_OUTFIT_VARIATION [MANDATORY]
        Wait(1000)
        TaskCombatPed(guard_ped, _player)

        SetPedKeepTask(guard_ped,true)

    else
        --print("Ped Died!")
    end
    --
end

-- FIGHTENDED
Citizen.CreateThread(function ()
    while true do
        Wait(1000)
        if Citizen.InvokeNative(0x8DB296B814EDDA07) == 1 and Data["host"] == GetPlayerServerId() then
            if fightended then
                TriggerServerEvent('k_bookie:setKey','winner', winner)
                --"End of Fight: Winner is > " .. Data["players"][winner].fake_name)
                Wait(Config.time_till_next_match)
                DelPeds(Data["players"])
                Payout(winner)
                fightended = false
                TriggerServerEvent('k_bookie:setKey','winner', false)
            end
        end
    end
end)

function resetBets()
    --print("client [host] > ResetBets()")
    Data["bets"][1] = 0
    Data["bets"][2] = 0
    Data["bets"]["pot"] = 0
    Data["bets"]["players"] = { }
    bettingactive = true
    winner = false
    fair_fight = true
    TriggerServerEvent('k_bookie:setData',Data)
end

function Payout(matchwinner)
    --print("client [host] > Payout()")
    local _winner = matchwinner
    local _fair_fight = fair_fight
    TriggerServerEvent('k_bookie:fightOver', tostring(_winner),_fair_fight)
    --Wait(4000) ? ??
    --- reset bets table
    resetBets()
end

-- Place Random [FAKE] bets
Citizen.CreateThread(function ()
    while true do
        Wait(1)
        if Citizen.InvokeNative(0x8DB296B814EDDA07) == 1 and client_spawned and Config.fake_bets and not fighting and not fightended then
        local randomW = math.random(15000,20000)
        Wait(randomW)
        if not active and not fighting and not fightended then
            local fake_better = GetRandomIntInRange(0, 1000)
            Wait(100)
            local fake_cnt = math.random(1,10)
            local fake_amount = fake_cnt * 5
            local fake_winner = math.random(1,2)
            Wait(100)

            if Data["bets"]["players"]['x'..fake_better] then
                current_amount = Data["bets"]["players"]['x'..fake_better].amount
            else
                current_amount = 0
                Data["bets"]["players"]['x'..fake_better] = {amount = 0, winner = fake_winner, playerid = fake_better, serverid = false }
            end

            Data["bets"]["players"]['x'..fake_better] = {}
            Data["bets"]["players"]['x'..fake_better].amount = tonumber(fake_amount)
            Data["bets"]["players"]['x'..fake_better].winner = fake_winner
            Data["bets"]["players"]['x'..fake_better].playerid = fake_better
            Data["bets"]["players"]['x'..fake_better].serverid = false

            Data["bets"][fake_winner] = tonumber(Data["bets"][fake_winner] + fake_amount)
            Data["bets"]["pot"] = Data["bets"][1] + Data["bets"][2]
            TriggerServerEvent('k_bookie:setData',Data)
        end
        if  Data["bets"]["pot"] >= Config.max_pot then
            active = true
        end
        if active then
            for k,v in pairs(Data["players"]) do
                local fighter = Data["players"][k]
                FreezeEntityPosition(fighter.ped, false)
                if k == 1 then
                    TaskCombatPed(fighter.ped, Data["players"][2].ped)
                else
                    TaskCombatPed(fighter.ped, Data["players"][1].ped)
                end
                TaskStandStill(fighter.ped, 0)
            end
            fighting = true
        end

        end
    end
end)

RegisterNetEvent('clientPlaceBet')
AddEventHandler('clientPlaceBet', function()

    local _playerpedid = PlayerPedId()
    local _playerserverid = GetPlayerServerId()

    if Data["bets"]["players"][PlayerPedId()] then
        current_amount = Data["bets"]["players"][PlayerPedId()].amount
    else
        current_amount = 0
        Data["bets"]["players"][PlayerPedId()] = { amount = 0, winner = selection,playerid = _playerpedid,serverid = _playerserverid }
    end

    Data["bets"][selection] = Data["bets"][selection] + selection_amount
    Data["bets"]["pot"] = Data["bets"][1] + Data["bets"][2]
    Data["bets"]["players"][PlayerPedId()].amount = current_amount + selection_amount
    Data["bets"]["players"][PlayerPedId()].winner = selection
    Data["bets"]["players"][PlayerPedId()].playerid = _playerpedid
    Data["bets"]["players"][PlayerPedId()].serverid = _playerserverid

    if  Data["bets"]["pot"] >= Config.max_pot then
        active = true
    end
    TriggerServerEvent('k_bookie:setData', Data)
    print("You bet: " .. selection_amount .. " on " .. Data["players"][selection].fake_name .. " !")
    Balance.spent = Balance.spent + selection_amount
    Balance.diff = Balance.won - Balance.spent
    TriggerServerEvent('k_bookie:removeCash', selection_amount)
    bettingactive = false

end)

RegisterNetEvent('clientAlert')
AddEventHandler('clientAlert', function(msg)
    print(msg)
end)

-- update nui
Citizen.CreateThread(function ()
    while true do
        Wait(100)
        if client_spawned then
            Wait(1000)
            SendNUIMessage({
                type = 'refresh',
                playerid = PlayerPedId(),
                data = Data,
                history = History,
                balance = Balance,
            })
        end
    end
end)

-- ADD BLIP
-- see: https://filmcrz.github.io/blips/
Citizen.CreateThread(function()
    Wait(100)
    local blip = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, Config.bookies[1].pos.X, Config.bookies[1].pos.Y, Config.bookies[1].pos.Z)
    SetBlipSprite(blip, -1389658546)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.prompt_group_name)
end)

RegisterCommand("bookie_menu", function(source, args, rawCommand)
    menuopen = true
    SendNUIMessage({
        data = Data,
        type = 'show',
    })
    SetNuiFocus(false, false)
end, false)

RegisterNUICallback('closeNui', function(data, cb)
    menuopen = false
    SendNUIMessage({
        type = 'close',
    })
    SetNuiFocus(false, false)
end)

RegisterCommand("bookie_close", function(source, args, rawCommand)
    menuopen = false
    SendNUIMessage({
        type = 'close',
    })
    SetNuiFocus(false, false)
end, false)


--- DEV COMMANDS
--- bdel ( NO ARGS ) to delete all peds
RegisterCommand("bookie_del", function(source, args, rawCommand)
    TriggerServerEvent('k_bookie:getData')
    Wait(500)
    print("deleting peds")
    DelPeds(Data["players"])
    DelPeds(Data["bookies"])
end, false)

-- bkill ( arg[1] == 1 or 2 ) to kill a player ped
RegisterCommand("bookie_kill", function(source, args, rawCommand)
    local pedtokill = args[1]
    local targetped = Data["players"][tonumber(pedtokill)].ped
    print(targetped)
    Citizen.InvokeNative(0xAC2767ED8BDFAB15,targetped,0,0)
end, false)

RegisterCommand("bookie_start", function(source, args, rawCommand)
    active = true
end, false)


--- bres ( NO ARGS ) to respawn peds
RegisterCommand("bookie_respawn", function(source, args, rawCommand)
    DelPeds(Data["players"])
    TriggerEvent('respawnPlayers')
end, false)