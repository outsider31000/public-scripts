VORP = exports.vorp_inventory:vorp_inventoryApi()


VORP.RegisterUsableItem("cigarette", function(data)
	VORP.subItem(data.source, "cigarette", 1)
	TriggerClientEvent('prop:cigarettes', data.source)
end)

VORP.RegisterUsableItem("hairpomade", function(data)
	VORP.subItem(data.source, "hairpomade", 1)
	TriggerClientEvent('prop:hairpomade', data.source)
end)


VORP.RegisterUsableItem("cigar", function(data)
	VORP.subItem(data.source, "cigar", 1)
	TriggerClientEvent('prop:cigar', data.source)
end)

VORP.RegisterUsableItem("syn", function(data)
	
	count = VORP.getItemCount(data.source, "pipe")
	if count >= 1 then
		VORP.subItem(data.source, "syn", 1)
		TriggerClientEvent('prop:syn', data.source)
	else
		TriggerClientEvent("vorp:TipRight", data.source, "You need a pipe to smoke syn", 3000)
	end

end)

VORP.RegisterUsableItem("notebook", function(data)
	TriggerClientEvent('prop:ledger', data.source)
end)

VORP.RegisterUsableItem("pocket_watch", function(data)
	TriggerClientEvent('prop:watch', data.source)
end)

VORP.RegisterUsableItem("book", function(data)
	TriggerClientEvent('prop:book', data.source)
end)

VORP.RegisterUsableItem("pipe", function(data)
	TriggerClientEvent('prop:pipe', data.source)
end)

VORP.RegisterUsableItem("fan", function(data)
	TriggerClientEvent('prop:fan', data.source)
end)

VORP.RegisterUsableItem("chewingtobacco", function(data)
	VORP.subItem(data.source, "chewingtobacco", 1)
	TriggerClientEvent('prop:chewingtobacco', data.source)
end)


