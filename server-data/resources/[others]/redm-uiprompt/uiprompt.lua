--- UI prompts and prompt groups

-- Treat 0 return value of some natives as falsey
local function toboolean(value)
	if not value or value == 0 then
		return false
	else
		return true
	end
end

-- Base class from which other classes are derived

local Class = {}

setmetatable(Class, {
	__call = function(self)
		self.__call = getmetatable(self).__call
		self.__index = self
		return setmetatable({}, self)
	end
})

function Class:new()
	return self()
end

--- System for automatically handling and cleaning up prompts and groups.
-- @type UipromptManager
UipromptManager = Class()
UipromptManager.prompts = {}
UipromptManager.groups = {}

-- Register a prompt
function UipromptManager:addPrompt(prompt)
	self.prompts[prompt] = true
end

-- Remove a prompt
function UipromptManager:removePrompt(object)
	if self.prompts[prompt] then
		self.prompts[prompt] = nil
	end
end

-- Register a group
function UipromptManager:addGroup(group)
	self.groups[group] = true
end

-- Remove a group
function UipromptManager:removeGroup(group)
	if self.groups[group] then
		self.groups[group] = nil
	end
end

--- Start an automatic event handling thread for all prompts and prompt groups.
--
-- To use a custom thread instead, call @{Uiprompt:handleEvents} or
-- @{UipromptGroup:handleEvents} every frame. This can be more efficient and
-- also allows passing extra data to any event handlers as arguments to these
-- methods.
--
-- @usage UipromptManager:startEventThread()
function UipromptManager:startEventThread()
	Citizen.CreateThread(function()
		while true do
			for group, _ in pairs(self.groups) do
				group:handleEvents()
			end

			for prompt, _ in pairs(self.prompts) do
				prompt:handleEvents()
			end

			Citizen.Wait(0)
		end
	end)
end

-- Clean up all registered prompts and groups.
function UipromptManager:delete()
	for group, _ in pairs(UipromptManager.groups) do
		group:delete()
	end

	for prompt, _ in pairs(UipromptManager.prompts) do
		prompt:delete()
	end
end

-- Automatically clean up when resource stops.
AddEventHandler("onResourceStop", function(resourceName)
	if GetCurrentResourceName() == resourceName then
		UipromptManager:delete()
	end
end)

--- A single UI prompt.
-- @type Uiprompt
Uiprompt = Class()

--- Create a new UI prompt.
-- @param controls An individual control or a table of controls associated with the prompt. The control name can be given as a string or hash.
-- @param text The text label of the prompt.
-- @param group An optional @{UipromptGroup} object or integer ID of a group to add this prompt to.
-- @param enabled Whether the prompt is enabled and visible immediately. Default is true.
-- @return A new Uiprompt object.
-- @usage local prompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Use")
-- @usage local prompt = Uiprompt:new("INPUT_DYNAMIC_SCENARIO", "Use")
-- @usage local prompt = Uiprompt:new({`INPUT_FRONTEND_UP`, `INPUT_FRONTEND_DOWN`}, "Up/Down")
-- @usage local prompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Use", promptGroup)
-- @usage local prompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Use", nil, false)
function Uiprompt:new(controls, text, group, enabled)
	local self = Class.new(self)

	self.handle = PromptRegisterBegin()

	if type(controls) ~= "table" then
		self.controls = {controls}
	else
		self.controls = controls
	end

	for _, control in ipairs(self.controls) do
		if type(control) == "string" then
			PromptSetControlAction(self.handle, GetHashKey(control))
		else
			PromptSetControlAction(self.handle, control)
		end
	end

	self:setText(text)

	if enabled == false then
		self:setEnabledAndVisible(false)
	end

	if group then
		self:setGroup(group)
	else
		UipromptManager:addPrompt(self)
	end

	PromptRegisterEnd(self.handle)

	return self
end

--- Get the raw handle of the prompt.
-- @return The integer handle of the prompt.
-- @usage local handle = prompt:getHandle()
function Uiprompt:getHandle()
	return self.handle
end

--- Get whether the prompt is active.
-- @return true or false
-- @usage if prompt:isActive() then ... end
function Uiprompt:isActive()
	return PromptIsActive(self.handle)
end

--- Get whether any control action is active
-- @return true or false
-- @usage if prompt:isControlActionActive() then ... end
function Uiprompt:isControlActionActive()
	for _, control in ipairs(self.controls) do
		if PromptIsControlActionActive(control) then
			return true
		end
	end

	return false
end

--- Get whether the prompt is enabled.
-- @return true or false
-- @usage if prompt:isEnabled() then ... end
function Uiprompt:isEnabled()
	return toboolean(PromptIsEnabled(self.handle))
end

--- Enable or disable the prompt.
-- @param toggle true to enable, false to disable
-- @usage prompt:setEnabled(true)
function Uiprompt:setEnabled(toggle)
	PromptSetEnabled(self.handle, toggle)
	return self
end

--- Toggle visibility of the prompt.
-- @param toggle true to show, false to hide
function Uiprompt:setVisible(toggle)
	PromptSetVisible(self.handle, toggle)
	return self
end

--- Enable/disable and toggle visibility of the prompt.
-- @param toggle true to enable and show, false to disable and hide
function Uiprompt:setEnabledAndVisible(toggle)
	self:setEnabled(toggle)
	self:setVisible(toggle)
	return self
end

--- Check if prompt was just pressed.
-- @return true or false
-- @usage if prompt:isJustPressed() then ... end
function Uiprompt:isJustPressed()
	return PromptIsJustPressed(self.handle)
end

--- Check if prompt was just released.
-- @return true or false
-- @usage if prompt:isJustReleased() then ... end
function Uiprompt:isJustReleased()
	return PromptIsJustReleased(self.handle)
end

--- Check if prompt is pressed.
-- @return true or false
-- @usage if prompt:isPressed() then ... end
function Uiprompt:isPressed()
	return PromptIsPressed(self.handle)
end

--- Check if prompt is released.
-- @return true or false
-- @usage if prompt:isReleased() then ... end
function Uiprompt:isReleased()
	return PromptIsReleased(self.handle)
end

--- Check if prompt is valid.
-- @return true or false
-- @usage if prompt:isValid() then ... end
function Uiprompt:isValid()
	return PromptIsValid(self.handle)
end

--- Toggle standard mode on the prompt.
-- @param toggle true to enable standard mode, false to disable.
-- @usage prompt:setStandardMode(true)
function Uiprompt:setStandardMode(toggle)
	PromptSetStandardMode(self.handle, toggle)
	return self
end

--- Check if the prompt's standard mode is completed.
-- @usage if prompt:hasStandardModeCompleted() then ... end
function Uiprompt:hasStandardModeCompleted()
	return PromptHasStandardModeCompleted(self.handle)
end

--- Check if the prompt's standard mode was just completed.
-- @usage if prompt:hasStandardModeJustCompleted() then ... end
function Uiprompt:hasStandardModeJustCompleted()
	if self.awaitingStandardModeEnd then
		if not self:hasStandardModeCompleted() then
			self.awaitingStandardModeEnd = false
		end

		return false
	else
		if self:hasStandardModeCompleted() then
			self.awaitingStandardModeEnd = true
			return true
		else
			return false
		end
	end
end

--- Get whether this prompt has hold mode enabled.
-- @return true or false
-- @usage if prompt:hasHoldMode() then ... end
function Uiprompt:hasHoldMode()
	return PromptHasHoldMode(self.handle)
end

--- Toggle hold mode on the prompt.
-- @param toggle true to enable hold mode, false to disable
-- @usage prompt:setHoldMode(true)
function Uiprompt:setHoldMode(toggle)
	PromptSetHoldMode(self.handle, toggle)
	return self
end

--- Check if the prompt's hold mode is running.
-- @return true or false
-- @usage if prompt:isHoldModeRunning() then ... end
function Uiprompt:isHoldModeRunning()
	return PromptIsHoldModeRunning(self.handle)
end

--- Check if the prompt's hold mode is completed.
-- @return true or false
-- @usage if prompt:hasHoldModeCompleted() then ... end
function Uiprompt:hasHoldModeCompleted()
	return PromptHasHoldModeCompleted(self.handle)
end

--- Check if the prompt's hold mode was just completed.
-- @return true or false
-- @usage if prompt:hasHoldModeJustCompleted() then ... end
function Uiprompt:hasHoldModeJustCompleted()
	if self.awaitingHoldModeEnd then
		if not self:isHoldModeRunning() then
			self.awaitingHoldModeEnd = false
		end

		return false
	else
		if self:hasHoldModeCompleted() then
			self.awaitingHoldModeEnd = true
			return true
		else
			return false
		end
	end
end

--- Set mash mode on the prompt.
-- @param count The number of times the prompt must be mashed in order to complete.
-- @usage prompt:setMashMode(10)
function Uiprompt:setMashMode(count)
	PromptSetMashMode(self.handle, count)
	return self
end

--- Set indefinite mash mode on the prompt.
-- @usage prompt:setMashIndefinitelyMode()
function Uiprompt:setMashIndefinitelyMode()
	PromptSetMashIndefinitelyMode(self.handle)
	return self
end

--- Get whether the prompt is using mash mode.
-- @return true or false
-- @usage if prompt:hasMashMode() then ... end
function Uiprompt:hasMashMode()
	return PromptHasMashMode(self.handle)
end

--- Get whether the prompt's mash mode has completed.
-- @return true or false
-- @usage if prompt:hasMashModeCompleted() then ... end
function Uiprompt:hasMashModeCompleted()
	return PromptHasMashModeCompleted(self.handle)
end

--- Get whether the prompt's mash mode was just completed.
-- @return true or false
-- @usage if prompt:hasMashModeJustCompleted() then ... end
function Uiprompt:hasMashModeJustCompleted()
	if self.awaitingMashModeEnd then
		if not self:hasMashModeCompleted() then
			self.awaitingMashModeEnd = false
		end

		return false
	else
		if self:hasMashModeCompleted() then
			self.awaitingMashModeEnd = true
			return true
		else
			return false
		end
	end
end

--- Get the text label of the prompt.
-- @return The text label of the UI prompt
-- @usage local text = prompt:getText()
function Uiprompt:getText()
	return self.text
end

--- Set the text label of the prompt.
-- @param text The new text for the UI prompt label
-- @usage prompt:setText("Hold")
function Uiprompt:setText(text)
	local str = CreateVarString(10, "LITERAL_STRING", text)
	PromptSetText(self.handle, str)
	self.text = text
	return self
end

--- Add the prompt to a prompt group.
-- @param group A @{UipromptGroup} object or integer ID of the group to add the prompt to.
-- @usage prompt:setGroup(promptGroup)
function Uiprompt:setGroup(group)
	if type(group) == "table" then
		group:addPrompt(self)
	else
		PromptSetGroup(self.handle, group)
		UipromptManager:addPrompt(self)
	end

	return self
end

-- Perform a control check for every control associated with the prompt.
function Uiprompt:doForEachControl(func, padIndex)
	for _, control in ipairs(self.controls) do
		if func(padIndex, control) then
			return true
		end
	end

	return false
end

--- Check if any of the controls associated with the prompt are pressed.
-- @param padIndex
-- @return true or false
-- @usage if prompt:isControlPressed(0) then ... end
function Uiprompt:isControlPressed(padIndex)
	return self:doForEachControl(IsControlPressed, padIndex)
end

--- Check if any of the controls associated with the prompt are released.
-- @param padIndex
-- @return true or false
-- @usage if prompt:isControlReleased(0) then ... end
function Uiprompt:isControlReleased(padIndex)
	return self:doForEachControl(IsControlReleased, padIndex)
end

--- Check if any of the controls associated with the prompt were just pressed.
-- @param padIndex
-- @return true or false
-- @usage if prompt:isControlJustPressed(0) then ... end
function Uiprompt:isControlJustPressed(padIndex)
	return self:doForEachControl(IsControlJustPressed, padIndex)
end

--- Check if any of the controls associated with the prompt were just released.
-- @param padIndex
-- @return true or false
-- @usage if prompt:isControlJustReleased(0) then ... end
function Uiprompt:isControlJustReleased(padIndex)
	return self:doForEachControl(IsControlJustReleased, padIndex)
end

--- Enable all control actions associated with the prompt.
-- @param padIndex
-- @usage prompt:enableControlAction(0)
function Uiprompt:enableControlAction(padIndex)
	for _, control in ipairs(self.controls) do
		EnableControlAction(padInex, control, true)
	end
	return self
end

--- Disable all control actions associated with the prompt.
-- @param padIndex
-- @usage prompt:disableControlAction(0)
function Uiprompt:disableControlAction(padIndex)
	for _, control in ipairs(self.controls) do
		DisableControlAction(padIndex, control, true)
	end
end

--- Set a handler that is executed when the prompt was just pressed.
-- @param handler Handler function
-- @usage prompt:setOnJustPressed(function(prompt, ...) ... end)
function Uiprompt:setOnJustPressed(handler)
	self.onJustPressed = handler
	return self
end

--- Set a handler that is executed when the prompt was just released.
-- @param handler Handler function
-- @usage prompt:setOnJustReleased(function(prompt, ...) ... end)
function Uiprompt:setOnJustReleased(handler)
	self.onJustReleased = handler
	return self
end

--- Set a handler that is executed when the prompt is pressed.
-- @param handler Handler function
-- @usage prompt:setOnPressed(function(prompt, ...) ... end)
function Uiprompt:setOnPressed(handler)
	self.onPressed = handler
	return self
end

--- Set a handler that is executed when the prompt is released.
-- @param handler Handler function
-- @usage prompt:setOnReleased(function(prompt, ...) ... end)
function Uiprompt:setOnReleased(handler)
	self.onReleased = handler
	return self
end

--- Set a handler that is executed when any control associated with the prompt is pressed.
-- @param handler Handler function
-- @usage prompt:setOnControlPressed(function(prompt, ...) ... end)
function Uiprompt:setOnControlPressed(handler)
	self.onControlPressed = handler
	return self
end

--- Set a handler that is executed when any control associated with the prompt is released.
-- @param handler Handler function
-- @usage prompt:setOnControlReleased(function(prompt, ...) ... end)
function Uiprompt:setOnControlReleased(handler)
	self.onControlReleased = handler
	return self
end

--- Set a handler that is executed when any control associated with the prompt was just pressed.
-- @param handler Handler function
-- @usage prompt:setOnControlJustPressed(function(prompt, ...) ... end)
function Uiprompt:setOnControlJustPressed(handler)
	self.onControlJustPressed = handler
	return self
end

--- Set a handler that is executed when any control associated with the prompt was just released.
-- @param handler Handler function
-- @usage prompt:setOnControlJustReleased(function(prompt, ...) ... end)
function Uiprompt:setOnControlJustReleased(handler)
	self.onControlJustReleased = handler
	return self
end

--- Set a handler that is executed when the prompt's standard mode has completed.
-- @param handler Handler function
-- @usage prompt:setOnStandardModeCompleted(function(prompt, ...) ... end)
function Uiprompt:setOnStandardModeCompleted(handler)
	self.onStandardModeCompleted = handler
	return self
end

--- Set a handler that is executed when the prompt's standard mode has just completed.
-- @param handler Handler function
-- @usage prompt:setOnStandardModeJustCompleted(function(prompt, ...) ... end)
function Uiprompt:setOnStandardModeJustCompleted(handler)
	self.onStandardModeJustCompleted = handler
	return self
end

--- Set a handler that is executed when the prompt's hold mode is running.
-- @param handler Handler function
-- @usage prompt:setOnHoldModeRunning(function(prompt, ...) ... end)
function Uiprompt:setOnHoldModeRunning(handler)
	self.onHoldModeRunning = handler
	return self
end

--- Set a handler that is executed when the prompt's hold mode has completed.
-- @param handler Handler function
-- @usage prompt:setOnHoldModeCompleted(function(prompt, ...) ... end)
function Uiprompt:setOnHoldModeCompleted(handler)
	self.onHoldModeCompleted = handler
	return self
end

--- Set a handler that is executed when the prompt's hold mode has just completed.
-- @param handler Handler function
-- @usage prompt:setOnHoldModeCompleted(function(prompt, ...) ... end)
function Uiprompt:setOnHoldModeJustCompleted(handler)
	self.onHoldModeJustCompleted = handler
	return self
end

--- Set a handler that is executed when the prompt's mash mode has completed.
-- @param handler Handler function
-- @usage prompt:setOnMashModeCompleted(function(prompt, ...) ... end)
function Uiprompt:setOnMashModeCompleted(handler)
	self.onMashModeCompleted = handler
	return self
end

--- Set a handler that is executed when the prompt's mash mode has just completed.
-- @param handler Handler function
-- @usage prompt:setOnMashModeJustCompleted(function(prompt, ...) ... end)
function Uiprompt:setOnMashModeJustCompleted(handler)
	self.onMashModeJustCompleted = handler
	return self
end

--- Handle events for this prompt. Should be called every frame.
-- @param ... Variable number of extra arguments passed to the handlers for any events.
-- @usage prompt:handleEvents()
function Uiprompt:handleEvents(...)
	if self:isEnabled() then
		if self.onJustPressed and self:isJustPressed() then
			self:onJustPressed(...)
		end

		if self.onJustReleased and self:isJustReleased() then
			self:onJustReleased(...)
		end

		if self.onPressed and self:isPressed() then
			self:onPressed(...)
		end

		if self.onReleased and self:isReleased() then
			self:onReleased(...)
		end

		if self.onStandardModeCompleted and self:hasStandardModeCompleted() then
			self:onStandardModeCompleted()
		end

		if self.onStandardModeJustCompleted and self:hasStandardModeJustCompleted() then
			self:onStandardModeJustCompleted()
		end

		if self.onHoldModeRunning and self:isHoldModeRunning() then
			self:onHoldModeRunning(...)
		end

		if self.onHoldModeCompleted and self:hasHoldModeCompleted() then
			self:onHoldModeCompleted(...)
		end

		if self.onHoldModeJustCompleted and self:hasHoldModeJustCompleted() then
			self:onHoldModeJustCompleted(...)
		end

		if self.onMashModeCompleted and self:hasMashModeCompleted() then
			self:onMashModeCompleted(...)
		end

		if self.onMashModeJustCompleted and self:hasMashModeJustCompleted() then
			self:onMashModeJustCompleted(...)
		end

		if self.onControlPressed and self:isControlPressed(0) then
			self:onControlPressed(...)
		end

		if self.onControlReleased and self:isControlReleased(0) then
			self:onControlReleased(...)
		end

		if self.onControlJustPressed and self:isControlJustPressed(0) then
			self:onControlJustPressed(...)
		end

		if self.onControlJustReleased and self:isControlJustReleased(0) then
			self:onControlJustReleased(...)
		end
	end
end

--- Clean up the prompt
-- @usage prompt:delete()
function Uiprompt:delete()
	UipromptManager:removePrompt(self)
	PromptDelete(self.handle)
end

--- A group of UI prompts
-- @type UipromptGroup
UipromptGroup = Class()

--- Create a new UI prompt group
-- @param text The text label for the prompt group
-- @param active Whether the group is active. Default is true.
-- @return A new UipromptGroup object
-- @usage local promptGroup = UipromptGroup:new("Interact")
function UipromptGroup:new(text, active)
	local self = Class.new(self)

	self.groupId = GetRandomIntInRange(0, 0xFFFFFF)
	self.text = text
	self.prompts = {}
	self.active = active ~= false

	UipromptManager:addGroup(self)

	return self
end

--- Get the raw group ID of the prompt group.
-- @return The integer group ID of the group.
-- @usage local groupId = promptGroup:getGroupId()
function UipromptGroup:getGroupId()
	return self.groupId
end

--- Display the prompt group. This must be called every frame.
-- @usage promptGroup:setActiveThisFrame()
function UipromptGroup:setActiveThisFrame()
	local str = CreateVarString(10, "LITERAL_STRING", self.text)
	PromptSetActiveGroupThisFrame(self.groupId, str)
	return self
end

--- Get the text label of the prompt group
-- @return The text label of the prompt group
-- @usage local text = promptGroup:getText()
function UipromptGroup:getText()
	return self.text
end

--- Set the text label of the prompt group
-- @param text The new label
-- @usage promptGroup:setText("Food")
function UipromptGroup:setText(text)
	self.text = text
	return self
end

--- Get a table of the individual prompts in the prompt group
-- @return A table of Uiprompt objects
-- @usage for _, prompt in ipairs(promptGroup:getPrompts()) do ... end
function UipromptGroup:getPrompts()
	return self.prompts
end

--- Add an existing prompt to the group.
-- @param prompt A @{Uiprompt} object or integer ID of a prompt to add to the group.
-- @return The prompt that was added to the group.
-- @usage promptGroup:addPrompt(prompt)
function UipromptGroup:addPrompt(prompt)
	if type(prompt) == "table" then
		UipromptManager:removePrompt(prompt)
		PromptSetGroup(prompt:getHandle(), self.groupId)
		table.insert(self.prompts, prompt)
	else
		PromptSetGroup(prompt, self.groupId)
	end

	return prompt
end

-- Do something for every prompt in the group
function UipromptGroup:doForEachPrompt(methodName, callback, ...)
	local result = false

	for _, prompt in ipairs(self.prompts) do
		if prompt[methodName](prompt, ...) then
			result = true

			if callback then
				callback(prompt)
			else
				break
			end
		end
	end

	return result
end

--- Check if any prompts in the group were just pressed.
-- @param callback An optional callback function that is executed for each prompt that was just pressed.
-- @return true or false
-- @usage if promptGroup:isJustPressed() then ... end
-- @usage promptGroup:isJustPressed(function(prompt) ... end)
function UipromptGroup:isJustPressed(callback)
	return self:doForEachPrompt("isJustPressed", callback)
end

--- Check if any prompts in the group were just released.
-- @param callback An optional callback function that is executed for each prompt that was just released.
-- @return true or false
-- @usage if promptGroup:isJustReleased() then ... end
-- @usage promptGroup:isJustReleased(function(prompt) ... end)
function UipromptGroup:isJustReleased(callback)
	return self:doForEachPrompt("isJustReleased", callback)
end

--- Check if any prompts in the group are pressed.
-- @param callback An optional callback function that is executed for each prompt that is pressed.
-- @return true or false
-- @usage if promptGroup:isPressed() then ... end
-- @usage promptGroup:isPressed(function(prompt) ... end)
function UipromptGroup:isPressed(callback)
	return self:doForEachPrompt("isPressed", callback)
end

--- Check if any prompts in the group are released.
-- @param callback An optional callback function that is executed for each prompt that is released.
-- @return true or false
-- @usage if promptGroup:isReleased() then ... end
-- @usage promptGroup:isReleased(function(prompt) ... end)
function UipromptGroup:isReleased(callback)
	return self:doForEachPrompt("isReleased", callback)
end

--- Check if any of the controls of any of the prompts in the group are pressed
-- @param padIndex
-- @param callback An optional callback function that is executed for each prompt that has a control pressed.
-- @return true or false
-- @usage if promptGroup:isControlPressed(0) then ... end
-- @usage promptGroup:isControlPressed(0, function(prompt) ... end)
function UipromptGroup:isControlPressed(padIndex, callback)
	return self:doForEachPrompt("doForEachControl", callback, IsControlPressed, padIndex)
end

--- Check if any of the controls of any of the prompts in the group are released
-- @param padIndex
-- @param callback An optional callback function that is executed for each prompt that has a control released.
-- @return true or false
-- @usage if promptGroup:isControlReleased(0) then ... end
-- @usage promptGroup:isControlReleased(0, function(prompt) ... end)
function UipromptGroup:isControlReleased(padIndex, callback)
	return self:doForEachPrompt("doForEachControl", callback, IsControlReleased, padIndex)
end

--- Check if any of the controls of any of the prompts in the group were just pressed
-- @param padIndex
-- @param callback An optional callback that is executed for each prompt that has a control that was just pressed.
-- @return true or false
-- @usage if promptGroup:isControlJustPressed(0) then ... end
-- @usage if promptGroup:isControlJustPressed(0, function(prompt) ... end)
function UipromptGroup:isControlJustPressed(padIndex, callback)
	return self:doForEachPrompt("doForEachControl", callback, IsControlJustPressed, padIndex)
end

--- Check if any of the controls of any of the prompts in the group were just released
-- @param padIndex
-- @param callback An optional callback that is executed for each prompt that has a control that was just released.
-- @return true or false
-- @usage if promptGroup:isControlJustReleased(0) then ... end
-- @usage promptGroup:isControlJustReleased(0, function(prompt) ... end)
function UipromptGroup:isControlJustReleased(padIndex, callback)
	return self:doForEachPrompt("doForEachControl", callback, IsControlJustReleased, padIndex)
end

--- Enable all control actions of all prompts in the group.
-- @param padIndex
-- @usage promptGroup:enableControlAction(0)
function UipromptGroup:enableControlAction(padIndex)
	for _, prompt in ipairs(self.prompts) do
		prompt:enableControlAction(padIndex)
	end
	return self
end

--- Disable all control actions of all prompts in the group.
-- @param padIndex
-- @usage promptGroup:disableControlAction(0)
function UipromptGroup:disableControlAction(padIndex)
	for _, prompt in ipairs(self.prompts) do
		prompt:disableControlAction(padIndex)
	end
	return self
end

--- Check if the standard mode of any of the prompts in the group has completed.
-- @param callback An optional callback function that is executed for each prompt who's standard mode has completed.
-- @usage if promptGroup:hasStandardModeCompleted() then ... end
-- @usage promptGroup:hasStandardModeCompleted(function(prompt) ... end)
function UipromptGroup:hasStandardModeCompleted(callback)
	return self:doForEachPrompt("hasStandardModeCompleted", callback)
end

--- Check if the standard mode of any of the prompts in the group has just completed.
-- @param callback An optional callback function that is executed for each prompt who's standard mode has just completed.
-- @usage if promptGroup:hasStandardModeJustCompleted() then ... end
-- @usage promptGroup:hasStandardModeJustCompleted(function(prompt) ... end)
function UipromptGroup:hasStandardModeJustCompleted(callback)
	return self:doForEachPrompt("hasStandardModeJustCompleted", callback)
end

--- Check if the hold mode of any of the prompts in the group is running.
-- @param callback An optional callback function that is executed for each prompt who's hold mode is running.
-- @return true or false
-- @usage if promptGroup:isHoldModeRunning() then ... end
-- @usage promptGroup:isHoldModeRunning(function(prompt) ... end)
function UipromptGroup:isHoldModeRunning(callback)
	return self:doForEachPrompt("isHoldModeRunning", callback)
end

--- Check if the hold mode of any of the prompts in the group has completed.
-- @param callback An optional callback function that is executed for each prompt who's hold mode has completed.
-- @return true or false
-- @usage if promptGroup:hasHoldModeCompleted() then ... end
-- @usage promptGroup:hasHoldModeCompleted(function(prompt) ... end)
function UipromptGroup:hasHoldModeCompleted(callback)
	return self:doForEachPrompt("hasHoldModeCompleted", callback)
end

--- Check if the hold mode of any of the prompts in the group has just completed.
-- @param callback An optional callback function that is executed for each prompt who's hold mode has just completed.
-- @return true or false
-- @usage if promptGroup:hasHoldModeJustCompleted() then ... end
-- @usage promptGroup:hasHoldModeJustCompleted(function(prompt) ... end)
function UipromptGroup:hasHoldModeJustCompleted(callback)
	return self:doForEachPrompt("hasHoldModeJustCompleted", callback)
end

--- Check if the mash mode of any of the prompts in the group has completed.
-- @param callback An optional callback function that is executed for each prompt who's mash mode has completed.
-- @return true or false
-- @usage if promptGroup:hasMashModeCompleted() then ... end
-- @usage promptGroup:hasMashModeCompleted(function(prompt) ... end)
function UipromptGroup:hasMashModeCompleted(callback)
	return self:doForEachPrompt("hasMashModeCompleted", callback)
end

--- Check if the mash mode of any of the prompts in the group has just completed.
-- @param callback An optional callback function that is executed for each prompt who's mash mode has just completed.
-- @return true or false
-- @usage if promptGroup:hasMashModeJustCompleted() then ... end
-- @usage promptGroup:hasMashModeJustCompleted(function(prompt) ... end)
function UipromptGroup:hasMashModeJustCompleted(callback)
	return self:doForEachPrompt("hasMashModeJustCompleted", callback)
end

--- Set a handler that is executed when any prompt in the group was just pressed.
-- @param handler Handler function
-- @usage promptGroup:setOnJustPressed(function(group, prompt, ...) ... end)
function UipromptGroup:setOnJustPressed(handler)
	self.onJustPressed = handler
	return self
end

--- Set a handler that is executed when any prompt in the group was just released.
-- @param handler Handler function
-- @usage promptGroup:setOnJustReleased(function(group, prompt, ...) ... end)
function UipromptGroup:setOnJustReleased(handler)
	self.onJustReleased = handler
	return self
end

--- Set a handler that is executed when any prompt in the group is pressed.
-- @param handler Handler function
-- @usage promptGroup:setOnPressed(function(group, prompt, ...) ... end)
function UipromptGroup:setOnPressed(handler)
	self.onPressed = handler
	return self
end

--- Set a handler that is executed when any prompt in the group is released.
-- @param handler Handler function
-- @usage promptGroup:setOnReleased(function(group, prompt, ...) ... end)
function UipromptGroup:setOnReleased(handler)
	self.onReleased = handler
	return self
end

--- Set a handler that is executed when any prompt in the group has completed its standard mode.
-- @param handler Handler function
-- @usage promptGroup:setOnStandardModeCompleted(function(group, prompt, ...) ... end)
function UipromptGroup:setOnStandardModeCompleted(handler)
	self.onStandardModeCompleted = handler
	return self
end

--- Set a handler that is executed when any prompt in the group has just completed its standard mode.
-- @param handler Handler function
-- @usage promptGroup:setOnStandarDModeJustCompleted(function(group, prompt, ...) ... end)
function UipromptGroup:setOnStandardModeJustCompleted(handler)
	self.onStandardModeJustCompleted = handler
	return self
end

--- Set a handler that is executed when any prompt in the group is running its hold mode.
-- @param handler Handler function
-- @usage promptGroup:setOnHoldModeRunning(function(group, prompt, ...) ... end)
function UipromptGroup:setOnHoldModeRunning(handler)
	self.onHoldModeRunning = handler
	return self
end

--- Set a handler that is executed when any prompt in the group has completed its hold mode.
-- @param handler Handler function
-- @usage promptGroup:setOnHoldModeCompleted(function(group, prompt, ...) ... end)
function UipromptGroup:setOnHoldModeCompleted(handler)
	self.onHoldModeCompleted = handler
	return self
end

--- Set a handler that is executed when any prompt in the group has just completed its hold mode.
-- @param handler Handler function
-- @usage promptGroup:setOnHoldModeJustCompleted(function(group, prompt, ...) ... end)
function UipromptGroup:setOnHoldModeJustCompleted(handler)
	self.onHoldModeJustCompleted = handler
	return self
end

--- Set a handler that is executed when any prompt in the group has completed its mash mode.
-- @param handler Handler function
-- @usage promptGroup:setOnMashModeCompleted(function(group, prompt, ...) ... end)
function UipromptGroup:setOnMashModeCompleted(handler)
	self.onMashModeCompleted = handler
	return self
end

--- Set a handler that is executed when any prompt in the group has just completed its mash mode.
-- @param handler Handler function
-- @usage promptGroup:setOnMashModeJustCompleted(function(group, prompt, ...) ... end)
function UipromptGroup:setOnMashModeJustCompleted(handler)
	self.onMashModeJustCompleted = handler
	return self
end

--- Set a handler that is executed when any control of any prompt in the group was just pressed.
-- @param handler Handler function
-- @usage promptGroup:setOnControlJustPressed(function(group, prompt, ...) ... end)
function UipromptGroup:setOnControlJustPressed(handler)
	self.onControlJustPressed = handler
	return self
end

--- Set a handler that is executed when any control of any prompt in the group was just released.
-- @param handler Handler function
-- @usage promptGroup:setOnControlJustReleased(function(group, prompt, ...) ... end)
function UipromptGroup:setOnControlJustReleased(handler)
	self.onControlJustReleased = handler
	return self
end

--- Set a handler that is executed when any control of any prompt in the group is pressed.
-- @param handler Handler function
-- @usage promptGroup:setOnControlPressed(function(group, prompt, ...) ... end)
function UipromptGroup:setOnControlPressed(handler)
	self.onControlPressed = handler
	return self
end

--- Set a handler that is executed when any control of any prompt in the group is released.
-- @param handler Handler function
-- @usage promptGroup:setOnControlReleased(function(group, prompt, ...) ... end)
function Uiprompt:setOnControlReleased(handler)
	self.onControlReleased = handler
	return self
end

--- Get whether the group is active.
-- @return true or false
-- @usage if promptGroup:isActive() then ... end
function UipromptGroup:isActive()
	return self.active
end

--- Set whether the group is active.
-- @return true or false
-- @usage promptGroup:setActive(true)
function UipromptGroup:setActive(toggle)
	self.active = toggle
	return self
end

--- Handle events for all prompts in the group (should be called every frame)
-- @param ... Variable number of extra arguments passed to the handlers for any events.
-- @usage promptGroup:handleEvents()
function UipromptGroup:handleEvents(...)
	if not self:isActive() then
		return
	end

	self:setActiveThisFrame()

	for _, prompt in ipairs(self.prompts) do
		if prompt:isEnabled() then
			if self.onJustPressed and prompt:isJustPressed() then
				self:onJustPressed(prompt, ...)
			end

			if self.onJustReleased and prompt:isJustReleased() then
				self:onJustReleased(prompt, ...)
			end

			if self.onPressed and prompt:isPressed() then
				self:onPressed(prompt, ...)
			end

			if self.onReleased and prompt:isReleased() then
				self:onReleased(prompt, ...)
			end

			if self.onStandardModeCompleted and prompt:hasStandardModeCompleted() then
				self:onStandardModeCompleted(prompt, ...)
			end

			if self.onStandardModeJustCompleted and prompt:hasStandardModeJustCompleted() then
				self:onStandardModeJustCompleted(prompt, ...)
			end

			if self.onHoldModeRunning and prompt:isHoldModeRunning() then
				self:onHoldModeRunning(prompt, ...)
			end

			if self.onHoldModeCompleted and prompt:hasHoldModeCompleted() then
				self:onHoldModeCompleted(prompt, ...)
			end

			if self.onHoldModeJustCompleted and prompt:hasHoldModeJustCompleted() then
				self:onHoldModeJustCompleted(prompt, ...)
			end

			if self.onMashModeCompleted and prompt:hasMashModeCompleted() then
				self:onMashModeCompleted(prompt, ...)
			end

			if self.onMashModeJustCompleted and prompt:hasMashModeJustCompleted() then
				self:onMashModeJustCompleted(prompt, ...)
			end

			if self.onControlJustPressed and prompt:isControlJustPressed(0) then
				self:onControlJustPressed(prompt, ...)
			end

			if self.onControlJustReleased and prompt:isControlJustReleased(0) then
				self:onControlJustReleased(prompt, ...)
			end

			if self.onControlPressed and prompt:isControlPressed(0) then
				self:onControlPressed(prompt, ...)
			end

			if self.onControlReleased and prompt:isControlReleased(0) then
				self:onControlReleased(prompt, ...)
			end

			prompt:handleEvents(...)
		end
	end
end

--- Enable or disable all prompts in the group.
-- @param toggle true to enable, false to disable
-- @usage promptGroup:setEnabled(false)
function UipromptGroup:setEnabled(toggle)
	for _, prompt in ipairs(self.prompts) do
		prompt:setEnabled(toggle)
	end
	return self
end

--- Clean up all prompts in the prompt group
-- @usage promptGroup:delete()
function UipromptGroup:delete()
	UipromptManager:removeGroup(self)

	for _, prompt in ipairs(self.prompts) do
		prompt:delete()
	end
end
