local promptGroup = UipromptGroup:new("Test")

Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Test 1", promptGroup):setHoldMode(true)
Uiprompt:new(`INPUT_RELOAD`, "Test 2", promptGroup):setHoldMode(true)

promptGroup:setOnHoldModeJustCompleted(function(group, prompt)
	TriggerEvent("chat:addMessage", {args={"You held " .. prompt:getText() .. "!"}})
end)

UipromptManager:startEventThread()
