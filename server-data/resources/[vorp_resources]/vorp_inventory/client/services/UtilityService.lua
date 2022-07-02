Utils = {}

Utils.cleanAmmo = function(id)
	if next(UserWeapons[id]) ~= nil then
		SetPedAmmo(PlayerPedId(), GetHashKey(UserWeapons[id]:getName()), 0)

		for _, ammo in pairs(UserWeapons[id]:getAllAmmo()) do
			SetPedAmmoByType(PlayerPedId(), GetHashKey(_), 0)
		end
	end
end

Utils.useWeapon = function(id)
	if UserWeapons[id]:getUsed2() then
		local weaponHash = GetHashKey(UserWeapons[id]:getName())
		GiveWeaponToPed_2(PlayerPedId(), weaponHash, 0, true, true, 3, false, 0.5, 1.0, 752097756, false, 0, false)
		SetCurrentPedWeapon(PlayerPedId(), weaponHash, 0, 0, 0, 0)
		SetPedAmmo(PlayerPedId(), weaponHash, 0)

		for _, ammo in pairs(UserWeapons[id]:getAllAmmo()) do
			SetPedAmmoByType(PlayerPedId, GetHashKey(_), ammo)
			if Config.Debug then
				print(GetHashKey(_) .. ": " .. _ .. " " .. ammo)
			end
		end
	else
		Utils.oldUseWeapon(id)
	end
end

Utils.oldUseWeapon = function(id)
	local weaponHash = GetHashKey(UserWeapons[id]:getName())

	GiveWeaponToPed_2(PlayerPedId(), weaponHash, 0, true, true, 2, false, 0.5, 1.0, 752097756, false, 0, false)
	SetCurrentPedWeapon(PlayerPedId(), weaponHash, 0, 1, 0, 0)
	SetPedAmmo(PlayerPedId(), weaponHash, 0)
	for type, amount in pairs(UserWeapons[id]:getAllAmmo()) do
		SetPedAmmoByType(PlayerPedId(), GetHashKey(type), amount)
		if Config.Debug then
			print(GetHashKey(type) .. ": " .. type .. " " .. amount)
		end
	end

	UserWeapons[id]:setUsed(true)
	TriggerServerEvent("vorpinventory:setUsedWeapon", id, UserWeapons[id]:getUsed(), UserWeapons[id]:getUsed2())
end

Utils.addItems = function(name, amount)
	if next(UserInventory[name]) ~= nil then
		UserInventory[name]:addCount(amount)
	else
		UserInventory[name] = Item:New({
			count = amount,
			limit = DB_Items[name].limit,
			label = DB_Items[name].label,
			type = "item_standard",
			canUse = true,
			canRemove = DB_Items[name].can_remove,
			desc = DB_Items[name].desc
		})
	end
end


Utils.expandoProcessing = function(object)
	local _obj = {}
	for _, row in pairs(object) do
		_obj[_] = row
	end
	return _obj
end

Utils.getNearestPlayers = function()
	local closestDistance = 5.0
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, true, true)
	local closestPlayers = {}

	for _, player in pairs(GetActivePlayers()) do
		local target = GetPlayerPed(player)

		if target ~= playerPed then
			local targetCoords = GetEntityCoords(target, true, true)
			local distance = #(targetCoords - coords)

			if distance < closestDistance then
				table.insert(closestPlayers, player)
			end
		end
	end
	return closestPlayers
end

Utils.GetWeaponLabel = function(hash)
	for _, wp in pairs(Config.Weapons) do
		if wp.HashName == hash then
			return wp.Name
		end
	end
	return hash
end

Utils.GetWeaponDesc = function(hash)
	for k, v in pairs(Config.Weapons) do
		if v.HashName == hash then
			return v.Desc
		end
	end
	return hash
end

function Utils.TableRemoveByKey(table, key)
	local element = table[key]
	table[key] = nil
	return element
end

function Utils.GetHashreadableLabel(hash, weaponId)
	if weaponId <= 1 then
		if DB_Items[hash] ~= nil then
			return DB_Items[hash].label
		end
		return hash
	else
		return Utils.GetWeaponLabel(hash)
	end
end
