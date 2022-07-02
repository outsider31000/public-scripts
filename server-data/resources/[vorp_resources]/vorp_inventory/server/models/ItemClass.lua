Item = {}

Item.name = nil
Item.label = nil
Item.type = nil
Item.model = nil

Item.count = nil
Item.limit = nil

Item.weight = nil

Item.canUse = false 
Item.canRemove = false
Item.desc = nil
Item.dropOnDeath = false 

-- NAME
function Item:setName(name) 
	self.name = name
end

function Item:getName() 
	return self.name
end

-- LABEL
function Item:setLabel(label) 
	self.label = label
end

function Item:getLabel() 
	return self.label
end

-- TYPE
function Item:setType(type) 
	self.type = type
end

function Item:getType() 
	return self.type
end

-- Model
function Item:setModel(model)
	self.model = model
end

function Item:getModel()
	return self.model
end

-- COUNT
function Item:setCount(amount) 
	self.count = amount
end

function Item:getCount() 
	return self.count
end

function Item:addCount(amount) 
	if self.count + amount <= self.limit then
		self.count = self.count + amount
		return true
	end
	return false
end

function Item:quitCount(amount) 
	self.count = self.count - amount
end

-- LIMIT
function Item:setLimit(limit) 
	self.limit = limit
end

function Item:getLimit() 
	return self.limit
end

-- WEIGHT
function Item:setWeight(weight)
	self.weight = weight
end

function Item:getWeight()
	return self.weight
end

-- CanUse
function Item:setCanUse(canUse) 
	self.canUse = canUse
end

function Item:getCanUse() 
	return self.canUse
end

-- CanRemove
function Item:setCanRemove(canRemove) 
	self.canRemove = canRemove
end

function Item:getCanRemove() 
	return self.canRemove
end

-- Desc
function Item:setDesc(desc) 
	self.desc = desc
end

function Item:getDesc() 
	return self.desc
end

-- DropOnDeath
function Item:setDropOnDeath(dropOnDeath)
	self.dropOnDeath = dropOnDeath
end

function Item:getDropOnDeath()
	return self.dropOnDeath
end
 
function Item:New (t)
	t = t or {}
	setmetatable(t, self)
	self.__index = self
	return t
end