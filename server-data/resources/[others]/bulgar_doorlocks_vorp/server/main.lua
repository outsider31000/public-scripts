local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local DoorInfo	= {}

RegisterServerEvent('bulgar_doorlocks_vorp:Load')
AddEventHandler('bulgar_doorlocks_vorp:Load', function()
	for k,v in pairs(DoorInfo) do
		TriggerClientEvent('bulgar_doorlocks_vorp:setState', -1, v.doorID, v.state)
	end
end)

RegisterServerEvent('bulgar_doorlocks_vorp:updatedoorsv')
AddEventHandler('bulgar_doorlocks_vorp:updatedoorsv', function(source, doorID, lockbreak, cb)
    local _source = source
	
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	
	TriggerClientEvent('bulgar_doorlocks_vorp:changedoor', _source, doorID)
end)

RegisterServerEvent('bulgar_doorlocks_vorp:updateState')
AddEventHandler('bulgar_doorlocks_vorp:updateState', function(doorID, state, cb)
    local _source = source
	
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	
	if type(doorID) ~= 'number' then
		return
	end
	
	DoorInfo[doorID] = {
		doorID = doorID,
		state = state
	}

	TriggerClientEvent('bulgar_doorlocks_vorp:setState', -1, doorID, state)
end)

VorpInv.RegisterUsableItem("consumable_lock_breaker", function(data)
	VorpInv.CloseInv(data.source)
	TriggerClientEvent("bulgar_doorlocks_vorp:opendoor", data.source, true)
end)

VorpInv.RegisterUsableItem("provision_jail_keys", function(data)
	VorpInv.CloseInv(data.source)
	TriggerClientEvent("bulgar_doorlocks_vorp:opendoor", data.source, false)
end)

RegisterServerEvent('bulgar_doorlocks_vorp:lockbreaker:break')
AddEventHandler('bulgar_doorlocks_vorp:lockbreaker:break', function()
    local _source = source
	local user = VorpCore.getUser(_source).getUsedCharacter
	VorpInv.subItem(_source, "consumable_lock_breaker", 1)
	TriggerClientEvent("vorp:TipBottom", _source, "Gosh Darnit!, My Lockbreaker broke!", 2000)
end)