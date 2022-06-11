VORP = exports.vorp_inventory:vorp_inventoryApi()


-- item for short weapon
Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VORP.RegisterUsableItem("cleanshort", function(data)
		local _source = source
		TriggerClientEvent('cleaning:startcleaningshort', data.source, cleaning)
		VORP.subItem(data.source,"cleanshort", 1)
	end)
end)