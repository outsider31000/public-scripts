local prompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Test")

prompt:setOnControlJustPressed(function()
	TriggerEvent("chat:addMessage", {args={"Pressed!"}})
end)

UipromptManager:startEventThread()
