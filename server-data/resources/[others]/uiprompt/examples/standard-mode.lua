local prompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Standard Mode Test")

prompt:setStandardMode(true)

prompt:setOnStandardModeJustCompleted(function()
	TriggerEvent("chat:addMessage", {args = {"Standard mode completed!"}})
end)

UipromptManager:startEventThread()
