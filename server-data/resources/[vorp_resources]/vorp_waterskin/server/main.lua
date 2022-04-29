VORP = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("waterskin", function(data)
		TriggerClientEvent('waterskin:collection', data.source)
	end)
end)


RegisterNetEvent("watercollect")
AddEventHandler("watercollect", function()
    local item = "dirtywater"
    local watergiven = math.random(1,10)
    local _source = source 
    VORP.addItem(_source, item, watergiven)
    Wait(1)
    TriggerClientEvent("vorp:TipRight", _source, 'You found ' ..watergiven.. ' ~t3~Dirty Water~q~', 6000)
end)
