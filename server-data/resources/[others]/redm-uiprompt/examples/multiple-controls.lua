local prompt = Uiprompt:new({`INPUT_DYNAMIC_SCENARIO`, `INPUT_RELOAD`}, "Test")

prompt:setOnControlJustPressed(function()
	TriggerEvent("chat:addMessage", {args={"Pressed!"}})
end)

UipromptManager:startEventThread()
