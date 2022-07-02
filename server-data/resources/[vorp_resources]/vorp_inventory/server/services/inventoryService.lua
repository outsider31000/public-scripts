InventoryService = {}
ItemPickUps = {}
MoneyPickUps = {}
GoldPickUps = {}
Core = {}

Citizen.CreateThread(function()
	TriggerEvent("getCore", function(core)
		Core = core;
	end)
end)

local processinguser = {}
function inprocessing(id)
	for k, v in pairs(processinguser) do
		if v == id then
			return true
		end
	end
	return false
end

function trem(id)
	for k, v in pairs(processinguser) do
		if v == id then
			table.remove(processinguser, k)
		end
	end
end

InventoryService.DropMoney = function(amount)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
		local userCharacter = Core.getUser(_source).getUsedCharacter
		local userMoney = userCharacter.money

		if amount <= 0 then
			TriggerClientEvent("vorp:TipRight", _source, _U("TryExploits"), 3000)
		elseif userMoney < amount then
			TriggerClientEvent("vorp:TipRight", _source, _U("NotEnoughMoney"), 3000)
		else
			userCharacter.removeCurrency(0, amount)

			TriggerClientEvent("vorpInventory:createMoneyPickup", _source, amount)
		end
		trem(_source)
	end
end

InventoryService.DropAllMoney = function()
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
		local userCharacter = Core.getUser(_source).getUsedCharacter
		local userMoney = userCharacter.money

		if userMoney > 0 then
			userCharacter.removeCurrency(0, userMoney)

			TriggerClientEvent("vorpInventory:createMoneyPickup", _source, userMoney)
		end
		trem(_source)
	end
end

InventoryService.giveMoneyToPlayer = function(target, amount)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
		local _target = target
		if Core.getUser(_source) == nil or Core.getUser(_target) == nil then
			trem(_source)
			return
		end
		local sourceCharacter = Core.getUser(_source).getUsedCharacter
		local targetCharacter = Core.getUser(_target).getUsedCharacter
		local sourceMoney = sourceCharacter.money

		if amount <= 0 then
			TriggerClientEvent("vorp:TipRight", _source, _U("TryExploits"), 3000)
			Wait(3000)
			TriggerClientEvent("vorp_inventory:ProcessingReady", _source)
		elseif sourceMoney < amount then
			TriggerClientEvent("vorp:TipRight", _source, _U("NotEnoughMoney"), 3000)
			Wait(3000)
			TriggerClientEvent("vorp_inventory:ProcessingReady", _source)
		else
			sourceCharacter.removeCurrency(0, amount)
			targetCharacter.addCurrency(0, amount)

			TriggerClientEvent("vorp:TipRight", _source, _U("YouPaid", tostring(amount), targetCharacter.firstname .. " " .. targetCharacter.lastname), 3000)
			TriggerClientEvent("vorp:TipRight", _target, _U("YouReceived", tostring(amount), sourceCharacter.firstname .. " " .. sourceCharacter.lastname), 3000)
			Wait(3000)
			TriggerClientEvent("vorp_inventory:ProcessingReady", _source)
		end
		trem(_source)
	end
end

InventoryService.DropGold = function(amount)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
	local userCharacter = Core.getUser(_source).getUsedCharacter
	local userGold = userCharacter.gold

	if amount <= 0 then
		TriggerClientEvent("vorp:TipRight", _source, _U("TryExploits"), 3000)
	elseif userGold < amount then
		TriggerClientEvent("vorp:TipRight", _source, _U("NotEnoughGold"), 3000)
	else
		userCharacter.removeCurrency(1, amount)

		TriggerClientEvent("vorpInventory:createGoldPickup", _source, amount)
	end
	trem(_source)
	end
end

InventoryService.DropAllGold = function()
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
	local userCharacter = Core.getUser(_source).getUsedCharacter
	local userGold = userCharacter.gold

	if userGold > 0 then
		userCharacter.removeCurrency(1, userGold)

		TriggerClientEvent("vorpInventory:createGoldPickup", _source, userGold)
	end
	trem(_source)
	end
end

InventoryService.giveGoldToPlayer = function(target, amount)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
	local _target = target
	if Core.getUser(_source) == nil or Core.getUser(_target) == nil then
		trem(_source)
		return
	end
	local sourceCharacter = Core.getUser(_source).getUsedCharacter
	local targetCharacter = Core.getUser(_target).getUsedCharacter
	local sourceGold = sourceCharacter.gold

	if amount <= 0 then
		TriggerClientEvent("vorp:TipRight", _source, _U("TryExploits"), 3000)
		Wait(3000)
		TriggerClientEvent("vorp_inventory:ProcessingReady", _source)
	elseif sourceGold < amount then
		TriggerClientEvent("vorp:TipRight", _source, _U("NotEnoughGold"), 3000)
		Wait(3000)
		TriggerClientEvent("vorp_inventory:ProcessingReady", _source)
	else
		sourceCharacter.removeCurrency(1, amount)
		targetCharacter.addCurrency(1, amount)

		TriggerClientEvent("vorp:TipRight", _source, _U("YouPaid", tostring(amount), targetCharacter.firstname .. " " .. targetCharacter.lastname), 3000)
		TriggerClientEvent("vorp:TipRight", _target, _U("YouReceived", tostring(amount), sourceCharacter.firstname .. " " .. sourceCharacter.lastname), 3000)
		Wait(3000)
		TriggerClientEvent("vorp_inventory:ProcessingReady", _source)
		end
		trem(_source)
	end
end

InventoryService.setWeaponBullets = function(weaponId, type, amount)
	if UsersWeapons[weaponId] ~= nil then
		UsersWeapons[weaponId]:setAmmo(type, amount)
	end
end

InventoryService.usedWeapon = function(id, _used, _used2)
	local used = 0
	local used2 = 0

	if _used then used = 1 end
	if _used2 then used2 = 1 end

	exports.ghmattimysql:execute('UPDATE loadout SET used = @used, used2 = @used2 WHERE id = @id', {
		['used'] = used,
		['used2'] = used2,
		['id'] = id
	}, function()
	end)
end

InventoryService.subItem = function(target, name, amount)
	local _source = target
	local sourceCharacter = Core.getUser(_source).getUsedCharacter
	local identifier = sourceCharacter.identifier

	if UsersInventories[identifier] ~= nil then
		if UsersInventories[identifier][name] ~= nil then
			if amount <= UsersInventories[identifier][name]:getCount() then
				UsersInventories[identifier][name]:quitCount(amount)
			end

			if UsersInventories[identifier][name]:getCount() == 0 then
				UsersInventories[identifier][name] = nil
			end
			InventoryAPI.SaveInventoryItemsSupport(_source)
		end
	end
end

InventoryService.addItem = function(target, name, amount)
	local _source = target
	local sourceCharacter = Core.getUser(_source).getUsedCharacter
	local identifier = sourceCharacter.identifier

	if UsersInventories[identifier] ~= nil then
		if UsersInventories[identifier][name] ~= nil then
			if amount > 0 then
				UsersInventories[identifier][name]:addCount(amount)
				InventoryAPI.SaveInventoryItemsSupport(_source)
			end
		else
			if svItems[name] ~= nil then
				UsersInventories[identifier][name] = Item:New({
					count = amount,
					limit = svItems[name]:getLimit(),
					label = svItems[name]:getLabel(),
					name = name,
					type = "item_inventory",
					canUse = svItems[name]:getCanUse(),
					canRemove = svItems[name]:getCanRemove(),
					desc = svItems[name]:getDesc()
				})
				InventoryAPI.SaveInventoryItemsSupport(_source)
			end
		end
	end
end

InventoryService.addWeapon = function(target, weaponId)
	local _source = target
	local sourceCharacter = Core.getUser(_source).getUsedCharacter
	local identifier = sourceCharacter.identifier
	local charId = sourceCharacter.charIdentifier

	if UsersWeapons[weaponId] ~= nil then
		UsersWeapons[weaponId]:setPropietary(identifier)
		exports.ghmattimysql:execute('UPDATE loadout SET identifier = @identifier, charidentifier = @charid WHERE id = @id', {
			['identifier'] = identifier,
			['charid'] = charId,
			['id'] = weaponId
		}, function()
		end)
	end
end

InventoryService.subWeapon = function(target, weaponId)
	local _source = target
	local sourceCharacter = Core.getUser(_source).getUsedCharacter
	local identifier = sourceCharacter.identifier
	local charId = sourceCharacter.charIdentifier

	if UsersWeapons[weaponId] ~= nil then
		UsersWeapons[weaponId]:setPropietary('')

		exports.ghmattimysql:execute('UPDATE loadout SET identifier = @identifier, charidentifier = @charid WHERE id = @id', {
			['identifier'] = identifier,
			['charid'] = charId,
			['id'] = weaponId
		}, function() end)
	end
end

InventoryService.onPickup = function(obj)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
		local sourceCharacter = Core.getUser(_source).getUsedCharacter
		local identifier = sourceCharacter.identifier
		local charId = sourceCharacter.charIdentifier

		if ItemPickUps[obj] ~= nil then
			local name = ItemPickUps[obj].name
			local amount = ItemPickUps[obj].amount

			if ItemPickUps[obj].weaponid == 1 then

				if UsersInventories[identifier] ~= nil then
					if svItems[name]:getLimit() ~= -1 then

						if UsersInventories[identifier][name] ~= nil then
							local sourceItemCount = UsersInventories[identifier][name]:getCount()
							local totalAmount = amount + sourceItemCount

							if svItems[name]:getLimit() < totalAmount then
								TriggerClientEvent("vorp:TipRight", _source, _U("fullInventory"), 2000)
								return
							end
						end
					end

					if Config.MaxItemsInInventory.Items ~= 0 then
						local sourceInventoryItemCount = InventoryAPI.getUserTotalCount(identifier)
						sourceInventoryItemCount = sourceInventoryItemCount + amount

						if sourceInventoryItemCount > Config.MaxItemsInInventory.Items then
							TriggerClientEvent("vorp:TipRight", _source, _U("fullInventory"), 2000)
							return
						end
					end

					InventoryService.addItem(_source, name, amount)
					local title = _U('itempickup')
					local description = _U('itempickup2') .. amount .. " " .. name
					Discord(title, _source, description)
					TriggerClientEvent("vorpInventory:sharePickupClient", -1, name, ItemPickUps[obj].obj, amount, ItemPickUps[obj].coords, 2)
					TriggerClientEvent("vorpInventory:removePickupClient", -1, ItemPickUps[obj].obj)
					TriggerClientEvent("vorpInventory:receiveItem", _source, name, amount)
					TriggerClientEvent("vorpInventory:playerAnim", _source, obj)

					ItemPickUps[obj] = nil
				end
			else
				if Config.MaxItemsInInventory.Weapons ~= 0 then
					local sourceInventoryWeaponCount = InventoryAPI.getUserTotalCountWeapons(identifier, charId) + 1

					if sourceInventoryWeaponCount <= Config.MaxItemsInInventory.Weapons then
						local weaponId = ItemPickUps[obj].weaponid
						local weaponObj = ItemPickUps[obj].obj
						InventoryService.addWeapon(_source, weaponId)
						local title = _U('weppickup')
						local description = _U('itempickup2') .. UsersWeapons[weaponId]:getName()
						Discord(title, _source, description)
						TriggerEvent("syn_weapons:onpickup", weaponId)
						TriggerClientEvent("vorpInventory:sharePickupClient", -1, name, weaponObj, 1, ItemPickUps[obj].coords, 2, weaponId)
						TriggerClientEvent("vorpInventory:removePickupClient", -1, weaponObj)
						TriggerClientEvent("vorpInventory:receiveWeapon", _source, weaponId, UsersWeapons[weaponId]:getPropietary(), UsersWeapons[weaponId]:getName(), UsersWeapons[weaponId]:getAllAmmo())
						TriggerClientEvent("vorpInventory:playerAnim", _source, obj)
						ItemPickUps[obj] = nil
					else
						TriggerClientEvent("vorp:TipRight", _source, _U("fullInventoryWeapon"), 2000)
					end
				end
			end
		end
		trem(_source)
	end
end

InventoryService.onPickupMoney = function(obj)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
		if MoneyPickUps[obj] ~= nil then
			local moneyObj = MoneyPickUps[obj].obj
			local moneyAmount = MoneyPickUps[obj].amount
			local moneyCoords = MoneyPickUps[obj].coords

			TriggerClientEvent("vorpInventory:shareMoneyPickupClient", -1, moneyObj, moneyAmount, moneyCoords, 2)
			TriggerClientEvent("vorpInventory:removePickupClient", -1, moneyObj)
			TriggerClientEvent("vorpInventory:playerAnim", _source, moneyObj)
			TriggerEvent("vorp:addMoney", _source, 0, moneyAmount)
			MoneyPickUps[obj] = nil
		end
		trem(_source)
	end
end

InventoryService.onPickupGold = function(obj)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
	if GoldPickUps[obj] ~= nil then
		local goldObj = GoldPickUps[obj].obj
		local goldAmount = GoldPickUps[obj].amount
		local goldCoords = GoldPickUps[obj].coords

		TriggerClientEvent("vorpInventory:shareGoldPickupClient", -1, goldObj, goldAmount, goldCoords, 2)
		TriggerClientEvent("vorpInventory:removePickupClient", -1, goldObj)
		TriggerClientEvent("vorpInventory:playerAnim", _source, goldObj)
		TriggerEvent("vorp:addMoney", _source, 1, goldAmount)
		GoldPickUps[obj] = nil
	end
	trem(_source)
end
end

InventoryService.sharePickupServer = function(name, obj, amount, position, weaponId)
	TriggerClientEvent("vorpInventory:sharePickupClient", -1, name, obj, amount, position, 1, weaponId)

	ItemPickUps[obj] = {
		name = name,
		obj = obj,
		amount = amount,
		weaponid = weaponId,
		inRange = false,
		coords = position
	}
end

InventoryService.shareMoneyPickupServer = function(obj, amount, position)
	TriggerClientEvent("vorpInventory:shareMoneyPickupClient", -1, obj, amount, position, 1)

	MoneyPickUps[obj] = {
		name = _U("inventorymoneylabel"),
		obj = obj,
		amount = amount,
		inRange = false,
		coords = position
	}
end

InventoryService.shareGoldPickupServer = function(obj, amount, position)
	TriggerClientEvent("vorpInventory:shareGoldPickupClient", -1, obj, amount, position, 1)

	GoldPickUps[obj] = {
		name = _U("inventorygoldlabel"),
		obj = obj,
		amount = amount,
		inRange = false,
		coords = position
	}
end

InventoryService.DropWeapon = function(weaponId)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
		InventoryService.subWeapon(_source, weaponId)

		TriggerClientEvent("vorpInventory:createPickup", _source, UsersWeapons[weaponId]:getName(), 1, weaponId)
		trem(_source)
	end
end

InventoryService.DropItem = function(itemName, amount)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
		InventoryService.subItem(_source, itemName, amount)

		TriggerClientEvent("vorpInventory:createPickup", _source, itemName, amount, 1)
		trem(_source)
	end
end

InventoryService.GiveWeapon = function(weaponId, target)
	local _source = source
	if not inprocessing(_source) then
		table.insert(processinguser, _source)
		local _target = target

		if UsersWeapons[weaponId] ~= nil then
			InventoryAPI.giveWeapon(_target, weaponId, _source)
		end
		trem(_source)
	end
end


InventoryService.GiveItem = function(itemName, amount, target)
	local _source = source
	if not inprocessing(_source) then
		TriggerClientEvent("vorp_inventory:transactionStarted", _source)
		table.insert(processinguser, _source)
		local _target = target
		if Core.getUser(_source) == nil or Core.getUser(_target) == nil then
			trem(_source)
			return
		end
		local sourceCharacter = Core.getUser(_source).getUsedCharacter
		local targetCharacter = Core.getUser(_target).getUsedCharacter

		local sourceIdentifier = sourceCharacter.identifier
		local targetIdentifier = targetCharacter.identifier

		if UsersInventories[sourceIdentifier] == nil or UsersInventories[targetIdentifier] == nil or UsersInventories[sourceIdentifier][itemName] == nil then
			TriggerClientEvent("vorp:TipRight", _source, _U('itemerror'), 2000)
			TriggerClientEvent("vorp_inventory:transactionCompleted", _source)
			trem(_source)
			return
		end

		if UsersInventories[sourceIdentifier][itemName] == nil then
			TriggerClientEvent("vorp:TipRight", _source, _U("itemerror"), 2000)
			
			if Config.Debug then
				Log.error("ServerGiveItem: User " .. sourceCharacter.firstname .. ' ' .. sourceCharacter.lastname .. '#' .. _source .. ' ' .. 'inventory item ' .. itemName .. ' not found')
			end
		end

		local item = UsersInventories[sourceIdentifier][itemName]
		local targetItemAmount = 0
		local targetItemLimit = 0
		local targetInventoryItemCount = InventoryAPI.getUserTotalCount(targetIdentifier)
		local canGiveItemToTarget = true
		local targetItem = nil;

		if UsersInventories[targetIdentifier][itemName] ~= nil then
			targetItem = UsersInventories[targetIdentifier][itemName]
			targetItemAmount = targetItem:getCount()
			targetItemLimit = targetItem:getLimit()

			if targetItemAmount + amount > targetItemLimit then
				canGiveItemToTarget = false
			end
		end

		if targetInventoryItemCount + amount > Config.MaxItemsInInventory.Items then
			canGiveItemToTarget = false
		end

		if not canGiveItemToTarget then
			TriggerClientEvent("vorp:TipRight", _source, _U('fullInventoryGive'), 2000)
			TriggerClientEvent("vorp:TipRight", _target, _U('fullInventory'), 2000)
			TriggerClientEvent("vorp_inventory:transactionCompleted", _source)

			trem(_source)
			return
		end

		if targetItem ~= nil then
			targetItem:addCount(amount)
		else
			if svItems[itemName] ~= nil then
				UsersInventories[targetIdentifier][itemName] = Item:New({
					count = amount,
					limit = svItems[itemName]:getLimit(),
					label = svItems[itemName]:getLabel(),
					name = itemName,
					type = "item_inventory",
					canUse = svItems[itemName]:getCanUse(),
					canRemove = svItems[itemName]:getCanRemove(),
					desc = svItems[itemName]:getDesc()
				})
			else
				if Config.Debug then
					Log.error("ServerGiveItem: Server items does not contain " .. itemName .. ".")
				end
				TriggerClientEvent("vorp_inventory:transactionCompleted", _source)
				trem(_source)
				return
			end
		end

		InventoryAPI.SaveInventoryItemsSupport(_target)
		item:quitCount(amount)

		if item:getCount() == 0 then
			UsersInventories[sourceIdentifier][itemName] = nil
		end

		InventoryAPI.SaveInventoryItemsSupport(_source)

		TriggerClientEvent("vorpInventory:receiveItem", _target, itemName, amount)
		TriggerClientEvent("vorpInventory:removeItem", _source, itemName, amount)



		local ItemsLabel = svItems[itemName]:getLabel()
		--NOTIFY

		TriggerClientEvent("vorp:TipRight", _source, _U("yougive") .. amount .. _U("of") .. ItemsLabel .. "", 2000)
		TriggerClientEvent("vorp:TipRight", _target, _U("youreceive") .. amount .. _U("of") .. ItemsLabel .. "", 2000)
		TriggerEvent("vorpinventory:itemlog", _source, _target, itemName, amount)

		TriggerClientEvent("vorp_inventory:transactionCompleted", _source)

		trem(_source)
	end
end

InventoryService.getItemsTable = function()
	local _source = source

	if DB_Items ~= nil then
		TriggerClientEvent("vorpInventory:giveItemsTable", _source, DB_Items)
	end
end

InventoryService.getInventory = function()
	local _source = source
	local sourceCharacter = Core.getUser(_source).getUsedCharacter

	if sourceCharacter == nil then
		return
	end

	local sourceIdentifier = sourceCharacter.identifier
	local sourceCharId = sourceCharacter.charIdentifier
	local sourceInventory = json.decode(sourceCharacter.inventory)

	local characterInventory = {}

	if sourceInventory ~= nil then
		for _, item in pairs(DB_Items) do -- TODO reverse loop: Iterate on inventory item instead of DB_items. Should save some iterations STILL TODO?
			if sourceInventory[item.item] ~= nil then
				local newItem = Item:New({
					count = tonumber(sourceInventory[item.item]),
					limit = item.limit,
					label = item.label,
					name = item.item,
					type = item.type,
					canUse = item.usable,
					canRemove = item.can_remove,
					desc = item.desc,
				})
				characterInventory[item.item] = newItem
			end
		end
	end
	UsersInventories[sourceIdentifier] = characterInventory

	TriggerClientEvent("vorpInventory:giveInventory", _source, json.encode(sourceInventory))

	exports.ghmattimysql:execute('SELECT * FROM loadout WHERE identifier = @identifier AND charidentifier = @charid', {
		['identifier'] = sourceIdentifier,
		['charid'] = sourceCharId,
	},
		function(result)
			if result ~= nil then
				for _, weapon in pairs(result) do
					local db_Ammo = json.decode(weapon.ammo)
					local weaponAmmo = {}
					local used = false
					local used2 = false

					for _, ammo in pairs(db_Ammo) do
						weaponAmmo[_] = ammo
					end

					if weapon.used == 1 then used = true end
					if weapon.used2 == 1 then used2 = true end

					if weapon.dropped == nil or weapon.dropped == 0 then
						local newWeapon = Weapon:New({
							id = weapon.id,
							propietary = weapon.identifier,
							name = weapon.name,
							ammo = weaponAmmo,
							used = used,
							used2 = used2,
							charId = sourceCharId,
						})
						UsersWeapons[newWeapon:getId()] = newWeapon
					end
				end
				TriggerClientEvent("vorpInventory:giveLoadout", _source, result)
			end
		end)
end
