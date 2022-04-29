local promptGroup = UipromptGroup:new("Test")

local prompt1 = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Test 1", promptGroup)
prompt1:setHoldMode(true)
prompt1.cooldown = 10

local prompt2 = Uiprompt:new(`INPUT_RELOAD`, "Test 2", promptGroup)
prompt2:setHoldMode(true)
prompt2.cooldown = 5

promptGroup:setOnHoldModeJustCompleted(function(group, prompt)
	CreateThread(function()
		local text = prompt:getText()

		prompt:setEnabled(false)

		for secs = prompt.cooldown, 1, -1 do
			prompt:setText(text .. " (" .. secs .. "s)")
			Wait(1000)
		end

		prompt:setText(text)

		prompt:setEnabled(true)
	end)
end)

UipromptManager:startEventThread()
