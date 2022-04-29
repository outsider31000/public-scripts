local promptGroup = UipromptGroup:new("Test")

Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Test 1", promptGroup)
Uiprompt:new(`INPUT_RELOAD`, "Test 2", promptGroup)

promptGroup:setOnControlJustPressed(function(group, prompt)
	TriggerEvent("chat:addMessage", {args={"You pressed " .. prompt:getText() .. "!"}})
end)

UipromptManager:startEventThread()
