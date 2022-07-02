Weapon = {}

Weapon.name = nil
Weapon.label = nil
Weapon.id = nil
Weapon.propietary = nil
Weapon.ammo = {}
Weapon.components = {}
Weapon.used = false
Weapon.used2 = false
Weapon.desc = nil

function Weapon:UnequipWeapon()
	local hash = GetHashKey(self.name)
	self:setUsed(false)
	self:setUsed2(false)

	TriggerServerEvent("vorpinventory:setUsedWeapon", self.id, self:getUsed(), self:getUsed2())
	self:RemoveWeaponFromPed()

	Utils.cleanAmmo(self.id)
end

function Weapon:RemoveWeaponFromPed()
	RemoveWeaponFromPed(PlayerPedId(), GetHashKey(self.name), true, 0)
end

function Weapon:equipwep()
	local pattern = 'WEAPON_MELEE'
	if self.name:sub(1, #pattern) == pattern then
		Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey(self.name), 500, true, 0)
	else
		if self.used2 then
			-- GETTING THE EQUIPED WEAPON
			local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, 0, false)
			Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), weaponHash, 1, 1, 1, 2, false, 0.5, 1.0, 752097756, 0, true, 0.0)
			Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey(self.name), 1, 1, 1, 3, false, 0.5, 1.0, 752097756, 0, true, 0.0)
			Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), weaponHash, 0, 1, 0, 0)
			Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey(self.name), 0, 0, 0, 0)
		else
			GiveDelayedWeaponToPed(PlayerPedId(), GetHashKey(self.name), 0, true, 0)
		end
		--[[ SetPedAmmo(PlayerPedId(), GetHashKey(self.name), 0)
		for key, value in pairs(self.ammo) do
			SetPedAmmoByType(PlayerPedId(), GetHashKey(key), value)
		end ]]
	end
end

function Weapon:loadComponents()
	for _, value in pairs(self.components) do
		Citizen.InvokeNative(0x74C9090FDD1BB48E, PlayerPedId(), GetHashKey(value), GetHashKey(self.name), true)
	end
end

function Weapon:getAllComponents()
	return self.components
end

function Weapon:setComponent(component)
	table.insert(self.components, component)
end

function Weapon:quitComponent(component)
	local componentExists = FindIndexOf(self.components, component)
	if componentExists then
		table.remove(self.component, componentExists)
		return true
	end
	return false
end

function Weapon:getUsed()
	return self.used
end

function Weapon:getUsed2()
	return self.used2 
end

function Weapon:setUsed(used)
	self.used = used
	TriggerServerEvent("vorpinventory:setUsedWeapon", self.id, used, self.used2)
end

function Weapon:setUsed2(used2)
	self.used2 = used2
	TriggerServerEvent("vorpinventory:setUsedWeapon", self.id, self.used, used2)
end

function Weapon:getPropietary()
	return self.propietary
end

function Weapon:setPropietary(propietary)
	self.propietary = propietary
end

function Weapon:getId()
	return self.id
end

function Weapon:setId(id)
	self.id = id
end

function Weapon:getName()
	return self.name
end

function Weapon:setName(name)
	self.name = name
end

function Weapon:getAllAmmo()
	return self.ammo
end

function Weapon:getAmmo(type)
	if self.ammo[type] ~= nil then
		return self.ammo[type]
	end
	return 0
end

function Weapon:getTotalAmmoCount()
	local count = 0
	for _, value in pairs(self.ammo) do
		count = count + value
	end
	return count
end

function Weapon:setAmmo(type, amount)
	self.ammo[type] = tonumber(amount)
	TriggerServerEvent("vorpinventory:setWeaponBullets", self.id, type, amount)
end

function Weapon:addAmmo(type, amount)
	if self.ammo[type] ~= nil then
		self.ammo[type] = self.ammo[type] + tonumber(amount)
	else
		self.ammo[type] = tonumber(amount)
	end
end

function Weapon:subAmmo(type, amount)
	if self.ammo[type] ~= nil then
		self.ammo[type] = self.ammo[type] - tonumber(amount)

		if self.ammo[type] <= 0 then
			Utils.TableRemoveByKey(self.ammo, type)
			--self.ammo[type] = nil
		end
	end
end

function Weapon:getLabel()
	return self.label
end

function Weapon:New (t)
	t = t or {}
	setmetatable(t, self)
	self.__index = self
	return t
end

function FindIndexOf(table, value)
	for k,v in pairs(table) do
		if v == value then
			return k
		end
	end
	return false
end

function Weapon:setDesc(desc)
	self.desc = desc
end

function Weapon:getDesc()
	return self.desc
end