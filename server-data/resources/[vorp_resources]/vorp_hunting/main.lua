local VORPCore = {}
local peltz = {}

Citizen.CreateThread(function()
    while not VORPCore do        
        TriggerEvent("getCore", function(core)
            VORPCore = core
        end)
        Citizen.Await(200)
    end
end)

RegisterNetEvent("vorp:SelectedCharacter") -- NPC loads after selecting character
AddEventHandler("vorp:SelectedCharacter", function(charid)
    startButchers()
end)

function startButchers() -- Loading Butchers Function
    for i,v in ipairs(Config.Butchers) do 
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

function drawTxt(text, x, y, fontscale, fontsize, r, g, b, alpha, textcentred, shadow) -- Text function
    local str = CreateVarString(10, "LITERAL_STRING", text)
    SetTextScale(fontscale, fontsize)
    SetTextColor(r, g, b, alpha)
    SetTextCentre(textcentred)
    if shadow then 
        SetTextDropshadow(1, 0, 0, 255)
    end
    SetTextFontForCurrentCommand(1)
    DisplayText(str, x, y)
end

function sellAnimal() -- Selling animal function
    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId()) -- ISPEDHOLDING
    local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
    local model = GetEntityModel(holding)
    local pedtype = GetPedType(holding)
    local horse = Citizen.InvokeNative(0x4C8B59171957BCF7,PlayerPedId())
    print("model",model)
    print("quality",quality)
    if horse ~= nil or horse ~= false then 
        if Citizen.InvokeNative(0xA911EE21EDF69DAF,horse) ~= false then
            local holding2 = Citizen.InvokeNative(0xD806CD2A4F2C2996,horse)
            local model2 = GetEntityModel(holding2)
            print("model2",model2)
            if Config.Animals[model2] ~= nil then -- Paying for animals
                local animal = Config.Animals[model2]
                local givenItem = animal.givenItem
                local money = animal.money
                local gold = animal.gold
                local rolPoints = animal.rolPoints
                local xp = animal.xp               
                TriggerServerEvent("vorp_hunting:giveReward", givenItem, money, gold, rolPoints, xp) 
                TriggerEvent("vorp:TipRight", Config.Language.AnimalSold, 4000) -- Sold notification
                DeleteEntity(holding2) 
                Citizen.InvokeNative(0x5E94EA09E7207C16, holding2)
                DeletePed(holding2)   
            end
        end
        if Citizen.InvokeNative(0x0CEEB6F4780B1F2F,horse,0) ~= false then
            for x,y in pairs(peltz) do 
                local pelt = Citizen.InvokeNative(0x0CEEB6F4780B1F2F,horse,0)
                local skinFound = false
                for k, v in pairs(Config.Animals) do 
                    local givenItem = v.givenItem
                    local money = v.money
                    local gold = v.gold
                    local rolPoints = v.rolPoints
                    local xp = v.xp               
                    if y.quality == v.perfect then -- Checking perfect quality                    
                        local multiplier = v.perfectQualityMultiplier
                        TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier)  
                        skinFound = true    
                    elseif y.quality == v.good then -- Checking good quality                    
                        local multiplier = v.goodQualityMultiplier
                        TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier)  
                        skinFound = true 
                    elseif y.quality == v.poor then -- Checking poor quality                    
                        local multiplier = v.poorQualityMultiplier
                        TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier) 
                        skinFound = true                 
                    end
                end
                if not skinFound then 
                    TriggerEvent("vorp:TipRight", Config.Language.NotInTheButcher, 4000) -- Notification when the animal isn't being sold in the butcher 
                else
                    TriggerEvent("vorp:TipRight", Config.Language.AnimalSold, 4000) -- Sold notification
                    Citizen.InvokeNative(0x627F7F3A0C4C51FF,horse,pelt)
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
            TriggerServerEvent("vorp_hunting:giveReward", givenItem, money, gold, rolPoints, xp) 
            TriggerEvent("vorp:TipRight", Config.Language.AnimalSold, 4000) -- Sold notification
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
                if quality == v.perfect then -- Checking perfect quality                    
                    local multiplier = v.perfectQualityMultiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier)  
                    skinFound = true    
                elseif quality == v.good then -- Checking good quality                    
                    local multiplier = v.goodQualityMultiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier)  
                    skinFound = true 
                elseif quality == v.poor then -- Checking poor quality                    
                    local multiplier = v.poorQualityMultiplier
                    TriggerServerEvent("vorp_hunting:giveReward", givenItem, money * multiplier, gold * multiplier, rolPoints * multiplier, xp * multiplier) 
                    skinFound = true                 
                end
            end
            if not skinFound then 
                TriggerEvent("vorp:TipRight", Config.Language.NotInTheButcher, 4000) -- Notification when the animal isn't being sold in the butcher 
            else
                TriggerEvent("vorp:TipRight", Config.Language.AnimalSold, 4000) -- Sold notification
                DeleteEntity(holding) 
                Citizen.InvokeNative(0x5E94EA09E7207C16, holding)
                DeletePed(holding)
            end            
        end     
    end
    if Citizen.InvokeNative(0xA911EE21EDF69DAF,horse) == false and holding == false and Citizen.InvokeNative(0x0CEEB6F4780B1F2F,horse,0) == false then
        TriggerEvent("vorp:TipRight", Config.Language.NotHoldingAnimal, 4000) -- Notification when you don't have an animal to sell
    end
    TriggerEvent("syn_clan:pelts",peltz)
end

local varStringCasa = CreateVarString(10, "LITERAL_STRING", "Stow Pelt")
AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
        end
    end
)
RegisterNetEvent("vorp_hunting:pelts")
AddEventHandler("vorp_hunting:pelts", function(pelts)
    peltz = pelts
end)
function keys(table)
    local num = 0
    for k,v in pairs(table) do
        num = num + 1
    end
    return num
end

function letpass(item)
    for k,v in pairs(peltz) do 
        if v.holding == holding then 
            return false 
        end
    end
    return true 
end

Citizen.CreateThread(function()
    while true do
        Wait(2)
        local horse = Citizen.InvokeNative(0x4C8B59171957BCF7,PlayerPedId())
        if horse ~= nil then 
            local player = PlayerPedId()
            local playerCoords = GetEntityCoords(PlayerPedId()) 
            local horsecoords =  GetEntityCoords(horse) 
            local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
            local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
               local dist = GetDistanceBetweenCoords(playerCoords.x,playerCoords.y,playerCoords.z,horsecoords.x,horsecoords.y,horsecoords.z,0)
               if 2 > dist then 
                    local model = GetEntityModel(holding)
                    if holding ~= false and Config.Animals[model] == nil then
                        if Config.maxpelts > keys(peltz) then
                            if IsDisabledControlJustReleased(0,3809269511) then
                                if letpass(holding) then 
                                    table.insert(peltz, {
                                        holding = holding,
                                        quality = quality
                                    })
                                   -- TriggerEvent("syn_clan:pelts",peltz)
                                    Wait(500)
                                end
                            end
                            drawTxt("Press G to Stow", 0.5, 0.9, 0.7, 0.7, 255, 255, 255, 255, true, true)
                            if IsControlJustPressed(2, 0x760A9C6F) then
                                TaskPlaceCarriedEntityOnMount(PlayerPedId(),holding,horse,1)
                                table.insert(peltz, {
                                    holding = holding,
                                    quality = quality
                                })
                                --TriggerEvent("syn_clan:pelts",peltz) if you have clan
                                Wait(500)
                            end 
                        end
                    end
               end
        end
    end
 end)

Citizen.CreateThread(function()
    while true do
        local sleep = true
        for i,v in ipairs(Config.Butchers) do
            local playerCoords = GetEntityCoords(PlayerPedId())       
            if Vdist(playerCoords, v.coords) <= v.radius then -- Checking distance between player and butcher
                local job
                sleep = false
                drawTxt(v.pressToSell, 0.5, 0.9, 0.7, 0.7, 255, 255, 255, 255, true, true)
                if IsControlJustPressed(2, 0xD9D0E1C0) then
                    if Config.joblocked then 
                        TriggerEvent('vorp:ExecuteServerCallBack','vorp_hunting:getjob', function(result)  
                            job =   result
                        end)
                        while job == nil do 
                            Wait(100)
                        end
                        if job == v.butcherjob then 
                            sellAnimal()     
                            Citizen.Wait(200)
                        else
                            TriggerEvent("vorp:TipRight", Config.Language.notabutcher.." : "..v.butcherjob, 4000) 
                        end
                    else
                        sellAnimal()  
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
--[[ RegisterCommand("hunt", function(source, args, rawCommand)
    local playerCoords = GetEntityCoords(PlayerPedId()) 
     local farm2 = GetHashKey("a_c_alligator_01")       
     RequestModel(farm2)
     while not HasModelLoaded(farm2) do
         Wait(10)
     end
    farm2 = CreatePed("a_c_alligator_01", playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
    Citizen.InvokeNative(0x77FF8D35EEC6BBC4, farm2, 1, 0)
 end, false) ]]

 RegisterCommand("checkskin", function(source, args, rawCommand)
    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
    local model = GetEntityModel(holding)
    local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
    print("model",model)
    print("quality",quality)
 end, false)