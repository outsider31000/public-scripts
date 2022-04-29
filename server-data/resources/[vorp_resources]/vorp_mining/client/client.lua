local MinePrompt
local active = false
local sleep = true
local MinedRocks = {}

local RockGroup = GetRandomIntInRange(0, 0xffffff)

function Mine()
    Citizen.CreateThread(function()
        local str = 'Mine'
        MinePrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(MinePrompt, Config.MinePromptKey)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(MinePrompt, str)
        PromptSetEnabled(MinePrompt, true)
        PromptSetVisible(MinePrompt, true)
        PromptSetHoldMode(MinePrompt, true)
        PromptSetGroup(MinePrompt, RockGroup)
        PromptRegisterEnd(MinePrompt)
    end)
end

Citizen.CreateThread(function()
    Mine()
    while true do
        Citizen.Wait(2)
        local sleep = true
        local playerped = PlayerPedId()
        if not IsPedOnMount(playerped) and not IsPedInAnyVehicle(playerped) and not IsPedDeadOrDying(playerped) then
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            for k,v in pairs(Config.Rocks) do
            local rock = DoesObjectOfTypeExistAtCoords(x, y, z, 1.0, GetHashKey(v), true)
                if rock and not InArray(MinedRocks, tostring(v)) then
                    sleep = false
                    if active == false then
                        local MiningGrouName  = CreateVarString(10, 'LITERAL_STRING', "Mine")
                        PromptSetActiveGroupThisFrame(RockGroup, MiningGroupName)
                    end
                    if PromptHasHoldModeCompleted(MinePrompt) then
                        active = true
                        SetCurrentPedWeapon(playerped, GetHashKey("WEAPON_UNARMED"), true, 0, false, false)
                        Citizen.Wait(500)
                        TriggerServerEvent("vorp_mining:pickaxecheck", tostring(v))
                    end
                else

                end
            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent("vorp_mining:pickaxechecked")
AddEventHandler("vorp_mining:pickaxechecked", function(rock)
    goMine(rock)
end)

RegisterNetEvent("vorp_mining:nopickaxe")
AddEventHandler("vorp_mining:nopickaxe", function()
    active = false
end)

function goMine(prop)
    EquipTool('p_pickaxe01x', 'Swing')
    local swing = 0
    local swingcount = math.random(Config.MinSwing, Config.MaxSwing)
    while hastool == true do
        FreezeEntityPosition(PlayerPedId(), true)
        if IsControlJustReleased(10, Config.StopMiningKey) or IsPedDeadOrDying(PlayerPedId()) then
            swing = 0
            table.insert(MinedRocks, tostring(prop))
            hastool = false
            Citizen.InvokeNative(0xED00D72F81CF7278, tool, 1, 1)
            DeleteObject(tool)
            Citizen.InvokeNative(0x58F7DB5BD8FA2288, ped) -- Cancel Walk Style
            active = false
        elseif IsControlJustPressed(0, Config.MineRockKey) then
            local randomizer =  math.random(Config.maxDifficulty,Config.minDifficulty)
            swing = swing + 1
            Anim(ped,'amb_work@world_human_pickaxe_new@working@male_a@trans','pre_swing_trans_after_swing',-1,0)
            local testplayer = exports["syn_minigame"]:taskBar(randomizer,7)
            if testplayer == 100 then 
                TriggerServerEvent('vorp_mining:addItem')
            end
        end

        if swing == swingcount then
            table.insert(MinedRocks, tostring(prop))
            swing = 0
            hastool = false
            Citizen.InvokeNative(0xED00D72F81CF7278, tool, 1, 1)
            DeleteObject(tool)
            Citizen.InvokeNative(0x58F7DB5BD8FA2288, ped) -- Cancel Walk Style
            Citizen.CreateThread(function()
                Citizen.Wait(300000)
                table.remove(MinedRocks, GetArrayKey(MinedRocks, tostring(prop)))
            end)
        end
        Wait(5)
    end
    PromptSetEnabled(PropPrompt, false)
    PromptSetVisible(PropPrompt, false)
    PromptSetEnabled(UsePrompt, false)
    PromptSetVisible(UsePrompt, false)
    FreezeEntityPosition(PlayerPedId(), false)
    active = false
end

function EquipTool(toolhash, prompttext, holdtowork)
    hastool = false
    Citizen.InvokeNative(0x6A2F820452017EA2) -- Clear Prompts from Screen
    if tool then
        DeleteEntity(tool)
    end
    Wait(500)
    FPrompt()
    LMPrompt(prompttext, Config.MineRockKey, holdtowork)
    ped = PlayerPedId()
    tool = CreateObject(toolhash, GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,0.0), true, true, true)
    AttachEntityToEntity(tool, ped, GetPedBoneIndex(ped, 7966), 0.0,0.0,0.0,  0.0,0.0,0.0, 0, 0, 0, 0, 2, 1, 0, 0);
    Citizen.InvokeNative(0x923583741DC87BCE, ped, 'arthur_healthy')
    Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, "carry_pitchfork")
    Citizen.InvokeNative(0x2208438012482A1A, ped, true, true)
    ForceEntityAiAndAnimationUpdate(tool, 1)
    Citizen.InvokeNative(0x3A50753042B6891B, ped, "PITCH_FORKS")

    Wait(500)
    PromptSetEnabled(PropPrompt, true)
    PromptSetVisible(PropPrompt, true)
    PromptSetEnabled(UsePrompt, true)
    PromptSetVisible(UsePrompt, true)

    hastool = true
end

function FPrompt(text, button, hold)
    Citizen.CreateThread(function()
        proppromptdisplayed=false
        PropPrompt=nil
        local str = text or "Put Away"
        local buttonhash = button or Config.StopMiningKey
        local holdbutton = hold or false
        PropPrompt = PromptRegisterBegin()
        PromptSetControlAction(PropPrompt, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PropPrompt, str)
        PromptSetEnabled(PropPrompt, false)
        PromptSetVisible(PropPrompt, false)
        PromptSetHoldMode(PropPrompt, holdbutton)
        PromptRegisterEnd(PropPrompt)
        sleep = true
    end)
end

function LMPrompt(text, button, hold)
    Citizen.CreateThread(function()
        UsePrompt=nil
        local str = text or "Use"
        local buttonhash = button or Config.MineRockKey
        local holdbutton = hold or false
        UsePrompt = PromptRegisterBegin()
        PromptSetControlAction(UsePrompt, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(UsePrompt, str)
        PromptSetEnabled(UsePrompt, false)
        PromptSetVisible(UsePrompt, false)
        if hold then
            PromptSetHoldIndefinitelyMode(UsePrompt)
        end
        PromptRegisterEnd(UsePrompt)
    end)
end

function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
    Citizen.CreateThread(function()
        RequestAnimDict(dict)
        local dur = duration or -1
        local flag = flags or 1
        local intro = tonumber(introtiming) or 1.0
        local exit = tonumber(exittiming) or 1.0
        timeout = 5
        while (not HasAnimDictLoaded(dict) and timeout>0) do
            timeout = timeout-1
            if timeout == 0 then 
                print("Animation Failed to Load")
            end
            Citizen.Wait(300)
        end
        TaskPlayAnim(actor, dict, body, intro, exit, dur, flag --[[1 for repeat--]], 1, false, false, false, 0, true)
    end)
end

function GetArrayKey(array, value)
    for k,v in pairs(array) do
        if v == value then return k	end
    end
    return false
end

function InArray(array, item)
    for k,v in pairs(array) do
        if v == item then return true end
    end
    return false
end