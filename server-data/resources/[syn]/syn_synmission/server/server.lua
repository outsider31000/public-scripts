local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('syn:AddSomeMoney')
AddEventHandler('syn:AddSomeMoney', function()
    local _source = source
    local price = Config.Price
    local xp = Config.Xp
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Character.addCurrency(0, price)
    Character.addXp(xp)
    VorpInv.addItem(source, "synpackage", 1)
end)

RegisterServerEvent("syn2:payout")
AddEventHandler("syn2:payout", function(cash, gold, xp)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    VorpInv.subItem(source, "syn", 10)
    Character.addCurrency(0, cash)
    Character.addCurrency(1, gold)
    Character.addXp(xp)
end)

RegisterServerEvent('syn:check')
AddEventHandler('syn:check', function()
    local _source = source
    count = VorpInv.getItemCount(source, "syn") 
    TriggerClientEvent("syn:true",_source, count)
end)


