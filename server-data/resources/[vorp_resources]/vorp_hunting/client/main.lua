local peltz = {}
local prompts = GetRandomIntInRange(0, 0xffffff)
local playerJob


RegisterNetEvent("vorp:SelectedCharacter") -- NPC loads after selecting character
AddEventHandler("vorp:SelectedCharacter", function(charid)
    StartButchers()
end)

RegisterNetEvent('vorp_hunting:findjob')
AddEventHandler('vorp_hunting:findjob', function(job)
    playerJob = job
end)

RegisterNetEvent('vorp_hunting:finalizeReward')
AddEventHandler('vorp_hunting:finalizeReward', function(entity, horse)
    -- Remove Animal/Pelt
    if entity ~= nil then
        DeleteEntity(entity)
        Citizen.InvokeNative(0x5E94EA09E7207C16, entity) --Delete Entity
        DeletePed(entity)
    end

    -- Remove pelt from horse
    if horse ~= nil then
        Citizen.InvokeNative(0x627F7F3A0C4C51FF, horse.horse, horse.pelt)
    end
end)


function StartButchers() -- Loading Butchers Function
    for i, v in ipairs(Config.Butchers) do
        local x, y, z = table.unpack(v.coords)
        if Config.aiButcherped then
            -- Loading Model
            local hashModel = GetHashKey(v.npcmodel)
            if IsModelValid(hashModel) then
                RequestModel(hashModel)
                while not HasModelLoaded(hashModel) do
                    Wait(100)
                end
            else
                print(v.npcmodel .. " is not valid") -- Concatenations
            end
            -- Spawn Ped
            local npc = CreatePed(hashModel, x, y, z, v.heading, false, true, true, true)
            Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
            SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
            SetEntityCanBeDamaged(npc, false)
            SetEntityInvincible(npc, true)
            Wait(1000)
            FreezeEntityPosition(npc, true) -- NPC can't escape
            SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
        end
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, x, y, z) -- Blip Creation
        SetBlipSprite(blip, v.blip, true) -- Blip Texture
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.butchername) -- Name of Blip
    end
end

function awardQuality(quality, entity, horse, cb)
    local skinFound = false
    for k, v in pairs(Config.Animals) do
        if (quality == v.perfect) or (quality == v.good) or (quality == v.poor) then
			skinFound = k
			break -- no need to keep looping through the config; micro-optimizations ftw!
		end
    end

    if not skinFound then
        -- TriggerEvent("vorp:TipRight", Config.Language.NotInTheButcher, 4000) -- Notification when the animal isn't being sold in the butcher 
    else
        TriggerServerEvent("vorp_hunting:giveReward", "pelt", {model=skinFound,quality=quality,entity=entity,horse=horse}, false)
		cb()
    end
end

function SellAnimal() -- Selling animal function
    local horse = Citizen.InvokeNative(0x4C8B59171957BCF7, PlayerPedId())
    local alreadysoldanimal = false
    -- Logic for if a horse is detected
    if horse ~= nil and horse ~= false then
        -- Check if the horse is holding anything
        if Citizen.InvokeNative(0xA911EE21EDF69DAF, horse) ~= false then
            local holding2 = Citizen.InvokeNative(0xD806CD2A4F2C2996, horse) -- Get what the horse is holding
            local model2 = GetEntityModel(holding2)

            local quality2 = Citizen.InvokeNative(0x31FEF6A20F00B963, holding2)
            if Config.Animals[model2] ~= nil then -- Fallback for paying for non pelts
                alreadysoldanimal = true
                TriggerServerEvent("vorp_hunting:giveReward", "carcass", {model=model2,entity=holding2}, false)
            elseif (quality2 ~= false and quality2 ~= nil) then --Award pelt if pelt is on horse
                awardQuality(quality2, holding2, nil, function () 
                    alreadysoldanimal = true
                end)
            end
        elseif Citizen.InvokeNative(0x0CEEB6F4780B1F2F, horse, 0) ~= false then
            for x = #peltz, 1, -1 do
				y = peltz[x]
				local q = Citizen.InvokeNative(0x0CEEB6F4780B1F2F, horse, x - 1)
				awardQuality(q, nil, {horse = horse, pelt = q}, function () 
                    alreadysoldanimal = true
                end)

                table.remove(peltz, x)
			end
        end
    end

    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId()) -- ISPEDHOLDING
    if holding ~= false and alreadysoldanimal == false then -- Checking if you are holding an animal
        local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
    
        local model = GetEntityModel(holding)
        
        if holding ~= nil then
            local entityNetworkId = NetworkGetNetworkIdFromEntity(holding)
            SetNetworkIdExistsOnAllMachines(entityNetworkId, true)
            local entityId = NetworkGetEntityFromNetworkId(entityNetworkId)
            
            if not NetworkHasControlOfEntity(entityId) then
                NetworkRequestControlOfEntity(entityId)
                NetworkRequestControlOfNetworkId(entityNetworkId)
            end
        end

        if Config.Animals[model] ~= nil then -- Paying for animals
            alreadysoldanimal = true
			TriggerServerEvent("vorp_hunting:giveReward", "carcass", {model=model,entity=holding}, false)
        else -- Paying for skins
            awardQuality(quality, holding, nil, function ()
                alreadysoldanimal = true
            end)
        end
    end

    if (alreadysoldanimal == false) then
        if holding == false then
            TriggerEvent("vorp:TipRight", Config.Language.NotHoldingAnimal, 4000)
        else
            TriggerEvent("vorp:TipRight", Config.Language.NotInTheButcher, 4000)
        end
    end

    --TriggerEvent("syn_clan:pelts",peltz)
end

function Keys(table)
    local num = 0
    for k, v in pairs(table) do
        num = num + 1
    end
    return num
end

AddEventHandler("onResourceStop",
    function(resourceName)
    if resourceName == GetCurrentResourceName() then
        PromptDelete(prompts)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = Config.Language.press
    openButcher = PromptRegisterBegin()
    PromptSetControlAction(openButcher, Config.keys["G"])
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(openButcher, str)
    PromptSetEnabled(openButcher, 1)
    PromptSetVisible(openButcher, 1)
    PromptSetStandardMode(openButcher, 1)
    PromptSetHoldMode(openButcher, 1)
    PromptSetGroup(openButcher, prompts)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, openButcher, true)
    PromptRegisterEnd(openButcher)
end)

Citizen.CreateThread(function()
    while true do
        Wait(2)
        local player = PlayerPedId()
        local horse = Citizen.InvokeNative(0x4C8B59171957BCF7, player)
        if horse ~= nil then

            local playerCoords = GetEntityCoords(player)
            local horsecoords = GetEntityCoords(horse)
            local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, player)
            local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
            local dist = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, horsecoords.x, horsecoords.y, horsecoords.z, 0)

            if 2 > dist then
                local model = GetEntityModel(holding)
                if holding ~= false and Config.Animals[model] == nil then
                    if Config.maxpelts > Keys(peltz) then

                        local label = CreateVarString(10, 'LITERAL_STRING', Config.Language.stow)
                        PromptSetActiveGroupThisFrame(prompts, label)
                        if Citizen.InvokeNative(0xC92AC953F0A982AE, openButcher) then

                            TaskPlaceCarriedEntityOnMount(player, holding, horse, 1)
                            table.insert(peltz, {
                                holding = holding,
                                quality = quality
                            })

                            Wait(500)
                        end
                    end
                end
            end
        end
    end
end)

--  Check for Animals being skinned/plucked/stored
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)
        local size = GetNumberOfEvents(0)
        if size > 0 then
            for index = 0, size - 1 do
                local event = GetEventAtIndex(0, index)
                if event == 1376140891 then
                    local view = exports["vorp_hunting"]:DataViewNativeGetEventData(0, index, 3)
                    local pedGathered = view['2']
                    local ped = view['0']
                    local model = GetEntityModel(pedGathered)

                    -- Bool to let you know if animation/longpress was enacted.
                    local bool_unk = view['4']

                    -- Ensure the player who enacted the event is the one who gets the rewards
                    local player = PlayerPedId()
                    local playergate = player == ped

                    if model and playergate == true then
                        print('Animal Gathered: ' .. model) --remove this if you want
                    end
                    
                    if model and Config.SkinnableAnimals[model] ~= nil and playergate == true and bool_unk == 1 then
                        TriggerServerEvent("vorp_hunting:giveReward", "skinned", {model=model}, true)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = true
        for i, v in ipairs(Config.Butchers) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            if Vdist(playerCoords, v.coords) <= v.radius then -- Checking distance between player and butcher

                sleep = false
                local label = CreateVarString(10, 'LITERAL_STRING', Config.Language.sell)
                PromptSetActiveGroupThisFrame(prompts, label)

                if Citizen.InvokeNative(0xC92AC953F0A982AE, openButcher) then
                    if Config.joblocked then
                        TriggerServerEvent("vorp_hunting:getJob")

                        while playerJob == nil do
                            Wait(100)
                        end
                        if playerJob == v.butcherjob then
                            SellAnimal()
                            Citizen.Wait(200)
                        else
                            TriggerEvent("vorp:TipRight", Config.Language.notabutcher .. " : " .. v.butcherjob, 4000)
                        end
                    else
                        SellAnimal()
                        Citizen.Wait(200)
                    end
                    Citizen.Wait(1000)
                end
            end
        end
        if sleep then
            Citizen.Wait(500)
        end
        Citizen.Wait(1)
    end
end)


-----  useful to get hash from animals or pelts  ------------

RegisterCommand('animal', function(source, args, rawCommand)
    local ped = PlayerPedId()
    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
    local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
    local model = GetEntityModel(holding)
    local type = GetPedType(holding)
    local hash = GetHashKey(holding)

    if Config.DevMode then

        print('holding', holding)
        print('quality', quality)
        print('model', model)
        print('type', type)
        print('hash', hash)

    end
end, false)

----------- spawn an animal to make tests ------------------

RegisterCommand("hunt", function(source, args, rawCommand)
    local animal = args[1]
    local freeze = args[2]
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    
    if animal == nil then
        animal = 'a_c_goat_01'
    end

    if freeze == nil then
        freeze = '2000'
    end

    freeze = tonumber(freeze)

    if Config.DevMode then
        RequestModel(animal)
        while not HasModelLoaded(animal) do
            Wait(10)
        end

        animal = CreatePed(animal, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, animal, 1, 0)
        Wait(freeze)
        FreezeEntityPosition(animal,true)
    end
end, false)


