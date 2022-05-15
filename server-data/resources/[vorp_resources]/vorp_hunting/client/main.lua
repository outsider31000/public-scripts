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

function SellAnimal() -- Selling animal function
    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId()) -- ISPEDHOLDING
    local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
    local model = GetEntityModel(holding)
    local horse = Citizen.InvokeNative(0x4C8B59171957BCF7, PlayerPedId())
    local entityNetworkId = NetworkGetNetworkIdFromEntity(holding)
    SetNetworkIdExistsOnAllMachines(entityNetworkId, true)
    local entityId = NetworkGetEntityFromNetworkId(entityNetworkId)
    if not NetworkHasControlOfEntity(entityId) then
        NetworkRequestControlOfEntity(entityId)
        NetworkRequestControlOfNetworkId(entityNetworkId)
    end

    if horse ~= nil or horse ~= false then
        if Citizen.InvokeNative(0xA911EE21EDF69DAF, horse) ~= false then
            local holding2 = Citizen.InvokeNative(0xD806CD2A4F2C2996, horse)
            local model2 = GetEntityModel(holding2)
            if Config.Animals[model2] ~= nil then -- Paying for animals
                local animal = Config.Animals[model2]
                local givenItem = animal.givenItem
                local money = animal.money
                local gold = animal.gold
                local rolPoints = animal.rolPoints
                local xp = animal.xp
                local givenAmount = animal.givenAmount
                TriggerServerEvent("vorp_hunting:giveReward", givenItem, money, gold, rolPoints, xp, givenAmount)
                TriggerEvent("vorp:TipRight", Config.Language.AnimalSold .. money .. Config.Language.dollar, 4000) -- Sold notification
                DeleteEntity(holding2)
                Citizen.InvokeNative(0x5E94EA09E7207C16, holding2)
                DeletePed(holding2)
            end
        end
        if Citizen.InvokeNative(0x0CEEB6F4780B1F2F, horse, 0) ~= false then
            for x, y in pairs(peltz) do
                local pelt = Citizen.InvokeNative(0x0CEEB6F4780B1F2F, horse, 0)
                local skinFound = false
                for k, v in pairs(Config.Animals) do
                    local givenItem = v.givenItem
                    local money = v.money
                    local gold = v.gold
                    local rolPoints = v.rolPoints
                    local xp = v.xp
                    local givenAmount = v.givenAmount
                    if y.quality == v.perfect then -- Checking perfect quality
                        local multiplier = v.perfectQualityMultiplier
                        local moneten = money * multiplier
                        TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier, givenAmount)
                        TriggerEvent("vorp:TipRight", Config.Language.AnimalSold .. moneten .. Config.Language.dollar, 4000)
                        skinFound = true
                    elseif y.quality == v.good then -- Checking good quality
                        local multiplier = v.goodQualityMultiplier
                        local moneten = money * multiplier
                        TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier, givenAmount)
                        TriggerEvent("vorp:TipRight", Config.Language.AnimalSold .. moneten .. Config.Language.dollar, 4000)
                        skinFound = true
                    elseif y.quality == v.poor then -- Checking poor quality
                        local multiplier = v.poorQualityMultiplier
                        local moneten = money * multiplier
                        TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier, givenAmount)
                        TriggerEvent("vorp:TipRight", Config.Language.AnimalSold .. moneten .. Config.Language.dollar, 4000)
                        skinFound = true
                    end
                end
                if not skinFound then
                    TriggerEvent("vorp:TipRight", Config.Language.NotInTheButcher, 4000) -- Notification when the animal isn't being sold in the butcher 
                else
                    Citizen.InvokeNative(0x627F7F3A0C4C51FF, horse, pelt)
                end
                table.remove(peltz, x)
            end
        end
    end
    if holding ~= false then -- Checking if you are holding an animal
        if Config.Animals[model] ~= nil then -- Paying for animals
            local animal = Config.Animals[model]
            local givenItem = animal.givenItem
            local money = animal.money
            local gold = animal.gold
            local rolPoints = animal.rolPoints
            local xp = animal.xp
            local givenAmount = animal.givenAmount
            TriggerServerEvent("vorp_hunting:giveReward", givenItem, money, gold, rolPoints, xp, givenAmount)
            TriggerEvent("vorp:TipRight", Config.Language.AnimalSold .. money .. Config.Language.dollar, 4000) -- Sold notification
            DeleteEntity(holding)
            Citizen.InvokeNative(0x5E94EA09E7207C16, holding)
            DeletePed(holding)
        else -- Paying for skins
            local skinFound = false
            for k, v in pairs(Config.Animals) do
                local givenItem = v.givenItem
                local money = v.money
                local gold = v.gold
                local rolPoints = v.rolPoints
                local xp = v.xp
                local givenAmount = v.givenAmount
                if quality == v.perfect then -- Checking perfect quality
                    local multiplier = v.perfectQualityMultiplier
                    local moneten = money * multiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier, givenAmount)
                    TriggerEvent("vorp:TipRight", Config.Language.AnimalSold .. moneten .. Config.Language.dollar, 4000)
                    skinFound = true
                elseif quality == v.good then -- Checking good quality
                    local multiplier = v.goodQualityMultiplier
                    local moneten = money * multiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier, givenAmount)
                    TriggerEvent("vorp:TipRight", Config.Language.AnimalSold .. moneten .. Config.Language.dollar, 4000)
                    skinFound = true
                elseif quality == v.poor then -- Checking poor quality
                    local multiplier = v.poorQualityMultiplier
                    local moneten = money * multiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier, givenAmount)
                    TriggerEvent("vorp:TipRight", Config.Language.AnimalSold .. moneten .. Config.Language.dollar, 4000)
                    skinFound = true
                end
            end
            if not skinFound then
                TriggerEvent("vorp:TipRight", Config.Language.NotInTheButcher, 4000) -- Notification when the animal isn't being sold in the butcher 
            else
                DeleteEntity(holding)
                Citizen.InvokeNative(0x5E94EA09E7207C16, holding)
                DeletePed(holding)

            end
        end
    end
    if Citizen.InvokeNative(0xA911EE21EDF69DAF, horse) == false and holding == false and Citizen.InvokeNative(0x0CEEB6F4780B1F2F, horse, 0) == false then
        TriggerEvent("vorp:TipRight", Config.Language.NotHoldingAnimal, 4000) -- Notification when you don't have an animal to sell
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

                    if model and Config.SkinnableAnimals[model] ~= nil and playergate == true and bool_unk == 1 then

                        print('Animal Gathered: ' .. model) --remove this if you want

                        local skinAnimal = Config.SkinnableAnimals[model]
                        local givenItem = skinAnimal.givenItem
                        local givenAmount = skinAnimal.givenAmount
                        local money = skinAnimal.money
                        local gold = skinAnimal.gold
                        local rolPoints = skinAnimal.rolPoints
                        local xp = skinAnimal.xp

                        local output = ''
                        -- Check array length of items
                        if #givenItem == 1 and #givenAmount == 1 then
                            if givenAmount[1] > 1 then
                                output = givenItem[1] .. 's'
                            else
                                output = givenItem[1]
                            end
                        else
                            output = 'Items'
                        end

                        TriggerServerEvent("vorp_hunting:giveReward", givenItem, money, gold, rolPoints, xp, givenAmount)

                        -- Alert item was added
                        TriggerEvent("vorp:TipRight", Config.Language.SkinnableAnimalstowed .. output, 4000)
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

    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local farm2 = `a_c_goat_01`

    if Config.DevMode then
        RequestModel(farm2)
        while not HasModelLoaded(farm2) do
            Wait(10)
        end

        farm2 = CreatePed("a_c_goat_01", playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
        Citizen.InvokeNative(0x77FF8D35EEC6BBC4, farm2, 1, 0)
        Wait(2000)
        FreezeEntityPosition(farm2,true)
    end
end, false)


