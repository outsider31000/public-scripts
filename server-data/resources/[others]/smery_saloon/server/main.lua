Inventory = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('smery_saloon:getjob')
AddEventHandler('smery_saloon:getjob', function(type)
    local _source = source
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local job = user.job
        if job == 'saloon' then
            TriggerClientEvent('smery_saloon:auth', _source, type)
        end
    end)
end)

RegisterServerEvent('smery_saloon:revivePlayer')
AddEventHandler('smery_saloon:revivePlayer', function(closestPlayer)
    local _source = source
    local count = Inventory.getItemCount(_source, "syringe")
    if count > 0 then
        Inventory.subItem(_source, "syringe", 1)
        TriggerClientEvent('smery_saloon:revive', closestPlayer)
    else
        TriggerClientEvent("vorp:TipRight", _source, _U('do_not_have', _U('syringe')), 3000)
    end
end)

RegisterServerEvent('smery_saloon:healPlayer')
AddEventHandler('smery_saloon:healPlayer', function(closestPlayer)
    local _source = source
    local count = Inventory.getItemCount(_source, "bandage")
    if count > 0 then
        Inventory.subItem(_source, "bandage", 1)
        TriggerClientEvent('smery_saloon:heal', closestPlayer)
    else
        TriggerClientEvent("vorp:TipRight", _source, _U('do_not_have', _U('bandage')), 3000)
    end
end)


RegisterServerEvent('smery_saloon:takebeer')
AddEventHandler('smery_saloon:takebeer', function(user)
    local _source = source
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local money = user.money
        if money >= 1 then
    Inventory.addItem(_source, "beer", Config.giveItemCount)
    TriggerEvent("vorp:removeMoney", _source, 0, 1)
else
    TriggerClientEvent("vorp:TipRight", _source, _U('do_not_have', _U('beer')), 3000)
    end
end)
end)

RegisterServerEvent('smery_saloon:takecognac')
AddEventHandler('smery_saloon:takecognac', function(user)
    local _source = source
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local money = user.money
        if money >= 1 then
    Inventory.addItem(_source, "whisky", Config.giveItemCount)
    TriggerEvent("vorp:removeMoney", _source, 0, 1)
else
    TriggerClientEvent("vorp:TipRight", _source, _U('do_not_have', _U('cognac')), 3000)
end
end)
end)