VORP = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("goldpan", function(data)
		TriggerClientEvent('goldpanner:StartPaning', data.source)
	end)
end)


RegisterNetEvent("search")
AddEventHandler("search", function()
    local item2 = "fishbait"
    local item = "goldnugget"
    local r = math.random(1,10)
    local goldover = 1
    local goldover2 = 1
    local _source = source 
    if r < 2 then
        VORP.addItem(_source, item, goldover2)
        Wait(3000)
        TriggerClientEvent("vorp:TipBottom", _source, Config.oro_encontrado, 6000)

    elseif r >= 2 and 7 <= r then
        VORP.addItem(_source, item2, goldover)
        Wait(3000)
        TriggerClientEvent("vorp:TipBottom", _source, Config.oro_encontrado2, 6000)
    else
        TriggerClientEvent("vorp:TipBottom", _source, Config.oro_no_encontrado, 6000)
    end
end)
