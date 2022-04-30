DB_Items = {}
InventoryService = {}
UserWeapons = {}
---@class UserInventory: table<string, Item>
UserInventory = {}
bulletsHash = {}

InventoryService.receiveItem = function (name, amount)
	if UserInventory[name] ~= nil then
		UserInventory[name]:addCount(amount)
		NUIService.LoadInv()
		return
	end
	
	UserInventory[name] = Item:New({
		count = amount,
		limit = DB_Items[name].limit,
	        label = DB_Items[name].label,
		name = name,
		type = "item_standard",
		canUse = true,
		canRemove = DB_Items[name].can_remove
	})
	NUIService.LoadInv()
end

InventoryService.removeItem = function (name, count)
	UserInventory[name]:quitCount(count)

	if UserInventory[name]:getCount() <= 0 then
		--UserInventory[name] = nil
		Utils.TableRemoveByKey(UserInventory, name)
	end

	NUIService.LoadInv()
end

InventoryService.receiveWeapon = function (id, propietary, name, ammos)
	local weaponAmmo = {}

	for type, amount in pairs(ammos) do
		weaponAmmo[type] = tonumber(amount)
	end


	if UserWeapons[id] == nil then
		local newWeapon = Weapon:New({
			id = id,
			propietary = propietary,
			name = name,
			label = Utils.GetWeaponLabel(name),
			ammo = weaponAmmo,
			used = false,
			used2 = false
		})

		UserWeapons[newWeapon:getId()] = newWeapon
		NUIService.LoadInv()
	end

end

InventoryService.onSelectedCharacter = function (charId)
	SetNuiFocus(false, false)
	SendNUIMessage({action= "hide"})
	print("Loading Inventory")
	TriggerServerEvent("vorpinventory:getItemsTable")
	Wait(300)
	TriggerServerEvent("vorpinventory:getInventory")
end

InventoryService.processItems = function (items)
	DB_Items = {}
	for _, item in pairs(items) do
		DB_Items[item.item] = {
			item = item.item,
			label = item.label,
			limit = item.limit,
			can_remove = item.can_remove,
			type = item.type,
			usable = item.usable
		}
	end
end

InventoryService.getLoadout = function (loadout)
	for _, weapon in pairs(loadout) do
		local weaponAmmo = json.decode(weapon.ammo)

		for type, amount in pairs(weaponAmmo) do
			weaponAmmo[type] = tonumber(amount)
		end

		local weaponUsed = false
		local weaponUsed2 = false

		if weapon.used == 1 then weaponUsed = true end
		if weapon.used2 == 1 then weaponUsed2 = true end

		if weapon.dropped == nil or weapon.dropped == 0 then
			local newWeapon = Weapon:New({
				id = tonumber(weapon.id),
				identifier = weapon.identifier,
				label = Utils.GetWeaponLabel(weapon.name),
				name = weapon.name,
				ammo = weaponAmmo,
				used = weaponUsed,
				used2 = weaponUsed2
			})
	
			UserWeapons[newWeapon:getId()] = newWeapon
	
			if newWeapon:getUsed() then
				Utils.useWeapon(newWeapon:getId())
			end
		end
	end
end

InventoryService.getInventory = function (inventory)
	UserInventory = {}
	
	if inventory ~= '' then
		local inventoryItems = json.decode(inventory)

		for _, item in pairs(DB_Items) do -- TODO reverse loop: Iterate on inventory item instead of DB_items. Should save some iterations
			local itemName = item.item
			if inventoryItems[itemName] ~= nil then
				local itemAmount = tonumber(inventoryItems[itemName])
				local itemLimit = tonumber(item.limit)
				local itemLabel = item.label
				local itemCanRemove = item.can_remove
				local itemType = item.type
				local itemCanUse = item.usable

				local newItem = Item:New({
					count = itemAmount,
					limit = itemLimit,
					label = itemLabel,
					name = itemName,
					type = itemType,
					canUse = itemCanUse,
					canRemove = itemCanRemove
				})

				UserInventory[itemName] = newItem
			end
		end
	end
end


-- Threads
Citizen.CreateThread(function()
	while true do
		Wait(500)

		local isArmed = Citizen.InvokeNative(0xCB690F680A3EA971, PlayerPedId(), 4)
		
		if isArmed then
			for _, weapon in pairs(UserWeapons) do
				if weapon:getUsed() then
					local ammo = weapon:getAllAmmo()
					for ammoName, _ in pairs(ammo) do
						local ammoQty = Citizen.InvokeNative(0x39D22031557946C1, PlayerPedId(), GetHashKey(ammoName))
						weapon:setAmmo(ammoName, ammoQty)
					end
				end
			end
		end
	end
end)
