-- Create a new subclass of Uiprompt which will have a cooldown period
local PromptWithCooldown = Uiprompt()

-- Add a new parameter to the constructor for the cooldown length
function PromptWithCooldown:new(controls, text, cooldown, group, enabled)
	local self = Uiprompt.new(self, controls, text, group, enabled)

	self.cooldown = cooldown

	return self
end

-- Add a new method, startCooldown
function PromptWithCooldown:startCooldown()
	self:setEnabled(false)
	local text = self:getText()

	Citizen.CreateThread(function()
		for secs = self.cooldown, 1, -1 do
			self:setText(text .. " (" .. secs .. "s)")
			Citizen.Wait(1000)
		end

		self:setText(text)
		self:setEnabled(true)
	end)
end

-- Create a further subclass of PromptWithCooldown
local TestPrompt = PromptWithCooldown()

-- TestPrompt is automatically set as a hold mode prompt
function TestPrompt:new(controls, text, cooldown, group, enabled)
	local self = PromptWithCooldown.new(self, controls, text, cooldown, group, enabled)

	self:setHoldMode(true)

	return self
end

-- Print a message and then use the startCooldown method inherited from PromptWithCooldown
function TestPrompt:onHoldModeJustCompleted()
	TriggerEvent("chat:addMessage", {args = {"Held " .. self:getText() .. "!"}})
	self:startCooldown()
end

local promptGroup = UipromptGroup:new("Test")

local prompt1 = TestPrompt:new(`INPUT_DYNAMIC_SCENARIO`, "Test 1", 5, promptGroup)
local prompt2 = TestPrompt:new(`INPUT_RELOAD`, "Test 2", 10, promptGroup)

UipromptManager:startEventThread()
