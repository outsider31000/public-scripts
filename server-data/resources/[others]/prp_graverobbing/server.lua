VORP = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
    VORP.RegisterUsableItem("robbingkit", function(data)
        --VORP.subItem(source, "robbingkit", 1)
		TriggerClientEvent('GraveRobbing:TriggerRobbery', data.source)
	end)
end)

RegisterNetEvent('wcrp:graverobbingreward')
AddEventHandler('wcrp:graverobbingreward', function()
    --VORP.addItem(source, "oldbuckle", 1)

    --VORP.addItem(source, "oldwatch", 1)

    --VORP.addItem(source, "rubyring", 1)

    --VORP.addItem(source, "goldtooth", 1)

    VORP.addItem(source, "peacockfeather", 1)

    VORP.addItem(source, "piratecoin", 1)
end)