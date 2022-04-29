local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

Inventory = exports.vorp_inventory:vorp_inventoryApi()



RegisterCommand('med', function(source, args, rawCommand)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'doctor' then
        TriggerClientEvent('syn_medical:open', _source)
    else
        TriggerClientEvent("vorp:TipBottom", _source, _U('no_autorizado'), 4000) -- from server side
    end
end)


--[[ RegisterCommand('med2', function(source, args, rawCommand)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'police' or job == "marshal" then
        TriggerClientEvent('syn_medical:open', _source)
    else
        TriggerClientEvent("vorp:TipBottom", _source, _U('no_autorizado'), 4000) -- from server side
    end
end) ]]


RegisterServerEvent('syn_medical:getjob')
AddEventHandler('syn_medical:getjob', function(type)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'doctor' then
        TriggerClientEvent('syn_medical:auth', _source, type)
    else
        TriggerClientEvent("vorp:TipBottom", source, 'You need a Medical Certificate', 6000)    
    end
end)

RegisterServerEvent('syn_medical:reviveplayer')
AddEventHandler('syn_medical:reviveplayer', function(closestPlayer)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local count = Inventory.getItemCount(_source, "syringe")
    local job = Character.job
    if job == "police" or job == "marshal" then 
        TriggerClientEvent('syn_medical:revive', closestPlayer)
    end
    if job == 'doctor' and count > 0 then
        Inventory.subItem(_source, "syringe", 1)
        TriggerClientEvent('syn_medical:revive', closestPlayer)
    else
        TriggerClientEvent("vorp:TipBottom", _source, _U('do_not_have', _U('syringe')), 3000)
    end
end)

RegisterServerEvent('syn_medical:healplayer')
AddEventHandler('syn_medical:healplayer', function(closestPlayer)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local count = Inventory.getItemCount(_source, "bandage")
    local job = Character.job
    if job == 'doctor' and count > 0 then
        Inventory.subItem(_source, "bandage", 1)
        TriggerClientEvent('syn_medical:heal', closestPlayer)
    else
        TriggerClientEvent("vorp:TipBottom", _source, _U('do_not_have', _U('bandage')), 3000)
    end
end)

RegisterServerEvent('syn_medical:takeItems')
AddEventHandler('syn_medical:takeItems', function()
    local _source = source
    --Inventory.addItem(_source, "bandage", Config.giveItemCount)
    Inventory.addItem(_source, "syringe", Config.giveItemCount)
    local count = Inventory.getItemCount(_source, "syringe")
   -- local count2 = Inventory.getItemCount(_source, "bandage")
    if count > 0 then 
        TriggerClientEvent("vorp:TipBottom", source, 'You took 10 Syringes from Cabinet', 3000)
    end
end)

Citizen.CreateThread(function() 
    Wait(500)
    for i = 1, #Config.medicalitems do
        local index = i
        Inventory.RegisterUsableItem(Config.medicalitems[i]["Name"], function(data)
            TriggerClientEvent("medical:useItem", data.source, index)
            Inventory.subItem(data.source, Config.medicalitems[index]["Name"], 1)
            TriggerClientEvent("vorp:TipRight", data.source, Config.MSG..Config.medicalitems[index]["DisplayName"], 5000)
        end)
    end
end)

RegisterServerEvent('medical:giveback')
AddEventHandler('medical:giveback', function(item)
    local _source = source
    Inventory.addItem(_source, item, 1)
end)