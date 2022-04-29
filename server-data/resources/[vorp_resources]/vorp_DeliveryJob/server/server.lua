local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterNetEvent("vorp_DeliveryJob:payout")
AddEventHandler("vorp_DeliveryJob:payout", function(cash, gold, xp)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Character.addCurrency(0, cash)
    --Character.addCurrency(1, gold)
    --Character.addXp(xp)
end)