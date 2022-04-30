Weapon = {}

Weapon.name = nil
Weapon.id = nil
Weapon.propietary = nil
Weapon.charId = nil
Weapon.used = false
Weapon.used2 = false
Weapon.ammo = {}
Weapon.components = {}

function Weapon:setUsed(isUsed)
	self.used = isUsed
end

function Weapon:getUsed()
	return self.used
end

function Weapon:setUsed2(isUsed)
	self.used2 = isUsed
end

function Weapon:getUsed2()
	return self.used2
end

function Weapon:setPropietary(propietary)
	self.propietary = propietary
end

function Weapon:getPropietary()
	return self.propietary
end

function Weapon:setCharId(charId)
	self.charId = charId
end

function Weapon:getCharId()
	return self.charId
end

function Weapon:setId(id)
	self.id = id
end

function Weapon:getId()
	return self.id
end

function Weapon:setName(name)
	self.name = name
end

function Weapon:getName()
	return self.name
end

function Weapon:getAllAmmo()
	return self.ammo
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
		table.remove(self.componentExists, componentExists)
		return true
	end
	return false
end

function Weapon:getAmmo(type) 
	return self.ammo[type]
end

function Weapon:addAmmo(type, amount)
	if self.ammo[type] ~= nil then
		self.ammo[type] = self.ammo[type] + amount
	else
		self.ammo[type] = tonumber(amount)
	end
	exports.ghmattimysql:execute('UPDATE loadout SET ammo = @ammo WHERE id=@id', { ['ammo'] = json.encode(self:getAllAmmo()), ['id'] = self.id})
end

function Weapon:setAmmo(type, amount)
	self.ammo[type] = tonumber(amount)
	exports.ghmattimysql:execute('UPDATE loadout SET ammo = @ammo WHERE id=@id', { ['ammo'] = json.encode(self:getAllAmmo()), ['id'] = self.id})
end

function Weapon:subAmmo(type, amount)
	if self.ammo[type] ~= nil then
		self.ammo[type] = self.ammo[type] - amount
		
		if self.ammo[type] <= 0 then
			self.ammo[type] = nil
		end
		exports.ghmattimysql:execute('UPDATE loadout SET ammo = @ammo WHERE id=@id', { ['ammo'] = json.encode(self:getAllAmmo()), ['id'] = self.id})
	end
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