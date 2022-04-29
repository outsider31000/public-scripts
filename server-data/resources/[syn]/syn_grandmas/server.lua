

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent("syn_grandma:revive")
AddEventHandler("syn_grandma:revive", function(price,gold)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local playercash = Character.money
    local gold2 = Character.gold
    if gold then 
        if gold2 >= price then 
            Character.removeCurrency(1, price)
            TriggerClientEvent('vorp:resurrectPlayer', _source)
            TriggerClientEvent("vorp:TipRight", _source, Config.Language.healed..price..Config.Language.gold, 5000)
        else
            TriggerClientEvent("vorp:TipRight", _source, Config.Language.nocash, 5000)
        end
    else
        if playercash >= price then 
            Character.removeCurrency(0, price)
            TriggerClientEvent('vorp:resurrectPlayer', _source)
            TriggerClientEvent("vorp:TipRight", _source, Config.Language.healed..price..Config.Language.cash, 5000)
        else
            TriggerClientEvent("vorp:TipRight", _source, Config.Language.nocash, 5000)
        end
    end
end)