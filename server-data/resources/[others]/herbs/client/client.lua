local CollectPrompt
local active = false
local oldBush = {}
local bush
local checkbush = 0

local Bushgroup = GetRandomIntInRange(0, 0xffffff)

function Collect()
    Citizen.CreateThread(function()
        local str = 'Collect'
        local wait = 0
        CollectPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(CollectPrompt, 0xD9D0E1C0)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(CollectPrompt, str)
        PromptSetEnabled(CollectPrompt, true)
        PromptSetVisible(CollectPrompt, true)
        PromptSetHoldMode(CollectPrompt, true)
        PromptSetGroup(CollectPrompt, Bushgroup)
        PromptRegisterEnd(CollectPrompt)
    end)
end

Citizen.CreateThread(function()
    Wait(2000)
    Collect()
    while true do
        Wait(1)
        local playerped = PlayerPedId()
        if checkbush < GetGameTimer() and not IsPedOnMount(playerped) and not IsPedInAnyVehicle(playerped) then
            bush = GetClosestBush()
            checkbush = GetGameTimer() + 500
        end
        if bush then
            if active == false then
                local BushgroupName  = CreateVarString(10, 'LITERAL_STRING', "Bush")
                PromptSetActiveGroupThisFrame(Bushgroup, BushgroupName)
            end
            if PromptHasHoldModeCompleted(CollectPrompt) then
                active = true
                oldBush[tostring(bush)] = true
                goCollect()
            end
        else

        end
    end
end)

function goCollect()
    local playerPed = PlayerPedId()
    RequestAnimDict("mech_pickup@plant@berries")
    while not HasAnimDictLoaded("mech_pickup@plant@berries") do
        Wait(100)
    end
    TaskPlayAnim(playerPed, "mech_pickup@plant@berries", "enter_lf", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
    Wait(800)
    TaskPlayAnim(playerPed, "mech_pickup@plant@berries", "base", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
    Wait(2300)
    TriggerServerEvent('vorp_picking:addItem')
    active = false
    ClearPedTasks(playerPed)
end

function GetClosestBush()
    local playerped = PlayerPedId()
    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, GetEntityCoords(playerped), 2.0, itemSet, 3, Citizen.ResultAsInteger())
    print(size)
    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            local model_hash = GetEntityModel(entity)
            if (model_hash ==  477619010 or model_hash ==  85102137 or model_hash ==  -1707502213) and not oldBush[tostring(entity)] then
                return entity
            end
        end
    else
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end
end
