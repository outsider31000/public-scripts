local CuttingPrompt
local active = false
local sleep = true
local ChoppedTrees = {}

local TreeGroup = GetRandomIntInRange(0, 0xffffff)

function Chop()
    Citizen.CreateThread(function()
        local str = 'Chop'
        CuttingPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(CuttingPrompt, Config.ChopPromptKey)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(CuttingPrompt, str)
        PromptSetEnabled(CuttingPrompt, true)
        PromptSetVisible(CuttingPrompt, true)
        PromptSetHoldMode(CuttingPrompt, true)
        PromptSetGroup(CuttingPrompt, TreeGroup)
        PromptRegisterEnd(CuttingPrompt)
    end)
end

Citizen.CreateThread(function()
    Chop()
    while true do
        Citizen.Wait(2)
        local sleep = true
        local playerped = PlayerPedId()
        if not IsPedOnMount(playerped) and not IsPedInAnyVehicle(playerped) and not IsPedDeadOrDying(playerped) then
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            for k,v in pairs(Config.Trees) do
            local tree = DoesObjectOfTypeExistAtCoords(x, y, z, 1.0, GetHashKey(v), true)
                if tree and not InArray(ChoppedTrees, tostring(v))then
                    sleep = false
                    if active == false then
                        local ChoppingGroupName  = CreateVarString(10, 'LITERAL_STRING', "Chop")
                        PromptSetActiveGroupThisFrame(TreeGroup, ChoppingGroupName)
                    end
                    if PromptHasHoldModeCompleted(CuttingPrompt) then
                        active = true
                        SetCurrentPedWeapon(playerped, GetHashKey("WEAPON_UNARMED"), true, 0, false, false)
                        Citizen.Wait(500)
                        TriggerServerEvent("vorp_lumberjack:axecheck", tostring(v))
                    end
                end
            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent("vorp_lumberjack:axechecked")
AddEventHandler("vorp_lumberjack:axechecked", function(tree)
    goChop(tree)
end)

RegisterNetEvent("vorp_lumberjack:noaxe")
AddEventHandler("vorp_lumberjack:noaxe", function()
    active = false
end)

function goChop(tree)
    EquipTool('p_axe02x','Swing')
    local swing = 0
    local swingcount = math.random(Config.MinSwing, Config.MaxSwing)
    ped = PlayerPedId()
    while hastool == true do
        FreezeEntityPosition(PlayerPedId(), true)
        if IsControlJustReleased(0, Config.CancelChopKey) or IsPedDeadOrDying(PlayerPedId()) then
            swing = 0
            table.insert(ChoppedTrees, tostring(tree))
            hastool = false
            Citizen.InvokeNative(0xED00D72F81CF7278, tool, 1, 1)
            DeleteObject(tool)
            Citizen.InvokeNative(0x58F7DB5BD8FA2288, ped) -- Cancel Walk Style
            active = false
        elseif IsControlJustReleased(0, Config.ChopTreeKey) then
            local randomizer =  math.random(Config.maxDifficulty,Config.minDifficulty)
            swing = swing + 1
            Anim(ped,"amb_work@world_human_tree_chop_new@working@pre_swing@male_a@trans","pre_swing_trans_after_swing",-1,0)
            local testplayer = exports["syn_minigame"]:taskBar(randomizer,7)
            if testplayer == 100 then 
                TriggerServerEvent('vorp_lumberjack:addItem')
            end
        end

        if swing == swingcount then
            table.insert(ChoppedTrees, tostring(tree))
            swing = 0
            hastool = false
            Citizen.InvokeNative(0xED00D72F81CF7278, tool, 1, 1)
            DeleteObject(tool)
            Citizen.InvokeNative(0x58F7DB5BD8FA2288, ped) -- Cancel Walk Style
            Citizen.CreateThread(function()
                Citizen.Wait(300000)
                table.remove(ChoppedTrees, GetArrayKey(ChoppedTrees, tostring(tree)))
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
    LMPrompt(prompttext, Config.ChopTreeKey, holdtowork)
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

function FPrompt(text, button, hold)
    Citizen.CreateThread(function()
        proppromptdisplayed=false
        PropPrompt=nil
        local str = text or "Put Away"
        local buttonhash = button or Config.CancelChopKey
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
        local buttonhash = button or Config.ChopTreeKey
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