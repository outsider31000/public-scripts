local VorpCore = {}
local VorpInv

local inventory = {}

if Config.vorp then
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)

    VorpInv = exports.vorp_inventory:vorp_inventoryApi()

    VorpInv.RegisterUsableItem("consumable_haycube", function(data)
        VorpInv.subItem(data.source, "consumable_haycube", 1)
        TriggerClientEvent("vorp:TipRight", data.source, "You're using some hay", 5000)
        TriggerClientEvent("syn:haycube", data.source)
    end)
    VorpInv.RegisterUsableItem("carrot", function(data)
        VorpInv.subItem(data.source, "carrot", 1)
        TriggerClientEvent("vorp:TipRight", data.source, "You're using some carrots", 5000)
        TriggerClientEvent("syn:carrot", data.source)
    end)
    VorpInv.RegisterUsableItem("horsebrush", function(data)
        TriggerClientEvent("syn:brush", data.source)
    end)
    VorpInv.RegisterUsableItem("stim", function(data)
        VorpInv.subItem(data.source, "stim", 1)
        TriggerClientEvent("vorp:TipRight", data.source, "You gave your horse stimulants", 5000)
        TriggerClientEvent("syn:horsestimulant", data.source)
    end)

elseif Config.redem then
    TriggerEvent("redemrp_inventory:getData",function(call)
        inventory = call
    end)

    RegisterServerEvent("RegisterUsableItem:haycube")
    AddEventHandler("RegisterUsableItem:haycube", function(source)
        local _source = source

        local ItemData = inventory.getItem(_source, "haycube")
        ItemData.RemoveItem(1)

        TriggerClientEvent("redem_roleplay:ShowSimpleRightText", _source, "You're using some hay", 5000)
        TriggerClientEvent("syn:haycube", _source)

    end)



    RegisterServerEvent("RegisterUsableItem:carrot")
    AddEventHandler("RegisterUsableItem:carrot", function(source)
        local _source = source

        local ItemData = inventory.getItem(_source, "Wild_Carrot")
        ItemData.RemoveItem(1)

        TriggerClientEvent("redem_roleplay:ShowSimpleRightText", _source, "You're using some carrots", 5000)
        TriggerClientEvent("syn:carrot", _source)

    end)

    RegisterServerEvent("RegisterUsableItem:horsebrush")
    AddEventHandler("RegisterUsableItem:horsebrush", function(source)
        local _source = source

        TriggerClientEvent("syn:brush", _source)

    end)

    
    RegisterServerEvent("RegisterUsableItem:stim")
    AddEventHandler("RegisterUsableItem:stim", function(source)
        local _source = source

        local ItemData = inventory.getItem(_source, "stim")
        ItemData.RemoveItem(1)

        TriggerClientEvent("redem_roleplay:ShowSimpleRightText", _source, "You gave your horse stimulants", 5000)
        TriggerClientEvent("syn:horsestimulant", _source)

    end)
    
end

