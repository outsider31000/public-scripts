function DrawText(text, x, y)
	SetTextScale(0.35, 0.35)
	SetTextColor(255, 255, 255, 255)
	SetTextDropshadow(1, 0, 0, 0, 200)
	SetTextFontForCurrentCommand(0)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

-- Create a new prompt group
local testGroup = UipromptGroup:new("Test group")

-- Multiple controls for one prompt
Uiprompt:new({`INPUT_FRONTEND_UP`, `INPUT_FRONTEND_DOWN`}, "Test 1", testGroup)

-- Single control for a prompt
Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Test 2", testGroup)

-- Specify the control name as a string, and enable hold mode for this prompt
Uiprompt:new("INPUT_RELOAD", "Test 3", testGroup):setHoldMode(true)

-- Event handler for a specific prompt
Uiprompt:new(`INPUT_INTERACT_ANIMAL`, "Test 4", testGroup):setOnControlPressed(function(prompt)
	DrawText("(Single) " .. prompt:getText() .. " is pressed!", 0.5, 0.45)
end)

-- Check if any controls for any prompts in the group are pressed
testGroup:setOnControlPressed(function(prompt)
	DrawText("(Group) " .. prompt:getText() .. " is pressed!", 0.5, 0.5)
end)

-- Check if the hold mode of any prompts in the group is running
testGroup:setOnHoldModeRunning(function(prompt)
	DrawText("Holding " .. prompt:getText() .. "...", 0.5, 0.55)
end)

-- Check if the hold mode of any prompts in the group has completed
testGroup:setOnHoldModeCompleted(function(prompt)
	DrawText("Hold completed for " .. prompt:getText() .. "!", 0.5, 0.6)
end)

RegisterCommand("uiprompt_test", function(source, args, raw)
	testGroup:setActive(not testGroup:isActive())
end)

UipromptManager:startEventThread()
