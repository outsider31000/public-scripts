-- VorpInv = exports.vorp_inventory:vorp_inventoryApi()
-- VorpCore = {}
-- data = {}

-- TriggerEvent("getCore", function(core) VorpCore = core end)

-- Citizen.CreateThread(function()
--     Citizen.Wait(2000) 
--     VorpInv.RegisterUsableItem("banjo", function(data)
--         TriggerClientEvent('wcrp:banjo', data.source)
--     end)
-- end)