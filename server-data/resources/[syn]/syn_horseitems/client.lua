--TriggerEvent('syn:exp', Horse , Number to increase horse exp)       
local oncooldown = false 

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
        if oncooldown then
            Wait(300000)
            oncooldown = false 
        end
    end
end)


RegisterNetEvent("syn:carrot")
AddEventHandler("syn:carrot", function(source)
    local Ped = PlayerPedId()
    local onhorse = IsPedOnMount(Ped)
    local _source = source
    if onhorse then
        local horse = GetMount(Ped)
        TaskAnimalInteraction(Ped, horse, -224471938, GetHashKey("s_horsnack_haycube01x"), 0)
        local valueHealth = Citizen.InvokeNative(0x36731AC041289BB1, horse, 0)
        local valueStamina = Citizen.InvokeNative(0x36731AC041289BB1, horse, 1)
        if not tonumber(valueHealth) then valueHealth = 0 end
        if not tonumber(valueStamina) then valueStamina = 0 end
        Citizen.Wait(3500)
        Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, valueHealth + 15)
        Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, valueStamina + 15)
    end
    if not oncooldown then 
        oncooldown = true 
        TriggerEvent('syn:exp', horse, 2) -- horse exp increase by 5
    end
end)

RegisterNetEvent("syn:haycube")
AddEventHandler("syn:haycube", function(source)
    local Ped = PlayerPedId()
    local onhorse = IsPedOnMount(Ped)
    local _source = source
    if onhorse then
        local horse = GetMount(Ped)
        TaskAnimalInteraction(Ped, horse, -224471938, GetHashKey("s_horsnack_haycube01x"), 0)
        local valueHealth = Citizen.InvokeNative(0x36731AC041289BB1, horse, 0)
        local valueStamina = Citizen.InvokeNative(0x36731AC041289BB1, horse, 1)
        if not tonumber(valueHealth) then valueHealth = 0 end
        if not tonumber(valueStamina) then valueStamina = 0 end
        Citizen.Wait(3500)
        Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, valueHealth + 15)
        Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, valueStamina + 15)
    end
    if not oncooldown then 
        oncooldown = true 
        TriggerEvent('syn:exp', horse, 2) -- horse exp increase by 5
    end
end)

RegisterNetEvent("syn:carrot")
AddEventHandler("syn:carrot", function(source)

    local Ped = PlayerPedId()
    local onhorse = IsPedOnMount(Ped)
    local _source = source
    if onhorse then
        local horse = GetMount(Ped)
        TaskAnimalInteraction(Ped, horse, -224471938, GetHashKey("p_carrot02x"), 0) --Animazione
        local valueHealth = Citizen.InvokeNative(0x36731AC041289BB1, horse, 0)
        local valueStamina = Citizen.InvokeNative(0x36731AC041289BB1, horse, 1)
        if not tonumber(valueHealth) then valueHealth = 0 end
        if not tonumber(valueStamina) then valueStamina = 0 end
        Citizen.Wait(3500)
        Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, valueHealth + 30)
        Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, valueStamina + 30)
        if not oncooldown then 
            oncooldown = true 
            TriggerEvent('syn:exp', horse, 2) -- horse exp increase by 5
        end
    else
        TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
        Citizen.Wait(1000)
        TriggerEvent('srp:eat', 25)
        TriggerEvent('srp:drink', -5)
        local number = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 1)
        if number then
        print (number)
        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(),1, number + 25)
        else 
        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(),1, 25)
        end
        Citizen.Wait(1000)        
    end
    
end)

RegisterNetEvent("syn:horsestimulant")
AddEventHandler("syn:horsestimulant", function(source)
    local Ped = PlayerPedId()
    local onhorse = IsPedOnMount(Ped)
    local _source = source 
    local horse = GetMount(Ped)        
    TaskAnimalInteraction(PlayerPedId(), horse, -1355254781, GetHashKey("p_cs_syringe01x"), 0)
    local valueHealth = Citizen.InvokeNative(0x36731AC041289BB1, horse, 0)
    local valueStamina = Citizen.InvokeNative(0x36731AC041289BB1, horse, 1)   
    if not tonumber(valueHealth) then valueHealth = 0 end
    if not tonumber(valueStamina) then valueStamina = 0 end
    Citizen.Wait(3500)
    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, valueHealth + 35)
    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, valueStamina + 35)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, horse, 0, 1000.0)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, horse, 1, 1000.0)
    Citizen.InvokeNative(0x50C803A4CD5932C5, true) 
    Citizen.InvokeNative(0xD4EE21B7CC7FD350, true) 
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
    if not oncooldown then 
        oncooldown = true 
        TriggerEvent('syn:exp', horse, 10) -- horse exp increase by 20
    end
end)
        

RegisterNetEvent('syn:brush')
AddEventHandler('syn:brush', function(source)
    local _source = source
    local Ped = PlayerPedId()
    local horse = Citizen.InvokeNative(0x4C8B59171957BCF7, PlayerPedId())
    TriggerEvent("StressaPlayer", 10)
    local pCoords = GetEntityCoords(Ped)
    local cCoords = GetEntityCoords(horse)
    local Distanza = GetDistanceBetweenCoords(pCoords, cCoords)
        if Distanza < 2.0 then
        if Config.vorp then
            TriggerEvent("vorp:TipRight", "You used the brush", 5000)
        elseif Config.redem then
            TriggerEvent("redem_roleplay:ShowSimpleRightText", "You used the brush", 5000)    
        end
        TaskAnimalInteraction(Ped, horse, 554992710, GetHashKey("P_BRUSHHORSE02X"), 0)
        local valueHealth = Citizen.InvokeNative(0x36731AC041289BB1, horse, 0) 
        if not tonumber(valueHealth) then valueHealth = 0 end
        Citizen.Wait(3000)
        Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, valueHealth + 5) 
        Citizen.InvokeNative(0x6585D955A68452A5, horse) 
        Citizen.InvokeNative(0xB5485E4907B53019, horse) 
        else
            if Config.vorp then
                TriggerEvent("vorp:TipRight", "You are not near your horse", 3000) 
            elseif Config.redem then
                TriggerEvent("redem_roleplay:ShowSimpleRightText", "You are not near your horse", 3000) 
            end
            Wait(0)
        end
        if not oncooldown then 
            oncooldown = true 
            TriggerEvent('syn:exp', horse, 5) -- horse exp increase by 10
        end
end)
