Item = {}

Item.count = nil
Item.limit = nil
Item.label = nil
Item.name = nil
Item.type = nil
Item.canUse = false
Item.canRemove = false
Item.desc = nil


function Item:setCount(amount)
	self.count = amount
end

function Item:getCount()
	return self.count
end

function Item:quitCount(amount)
	self.count = self.count - amount
end

function Item:addCount(amount)
	self.count = self.count + amount
end

function Item:subCount(amount)
	self.count = self.count - amount
end

function Item:setLimit(limit)
	self.limit = limit
end

function Item:getLimit()
	return self.limit
end

function Item:setLabel(label)
	self.label = label
end

function Item:getLabel()
	return self.label
end

function Item:setName(name)
	self.name = name
end

function Item:getName()
	return self.name
end

function Item:setType(type)
	self.type = type
end

function Item:getType()
	return self.type
end

function Item:setUsable(canUse)
	self.canUse = canUse
end

function Item:getUsable()
	return self.canUse
end

function Item:setCanRemove(canRemove)
	self.canRemove = canRemove
end

function Item:getCanRemove()
	return self.canRemove
end

function Item:setDesc(desc)
	self.desc = desc
end

function Item:getDesc()
	return self.desc
end

function Item:New (t)
	t = t or {}
	setmetatable(t, self)
	self.__index = self
	return t
end