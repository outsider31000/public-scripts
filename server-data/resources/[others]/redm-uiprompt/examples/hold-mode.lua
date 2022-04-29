function DrawText(text, x, y)
	SetTextScale(0.35, 0.35)
	SetTextColor(255, 255, 255, 255)
	SetTextDropshadow(1, 0, 0, 0, 200)
	SetTextFontForCurrentCommand(0)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

local prompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Hold Me")

prompt:setHoldMode(true)

prompt:setOnHoldModeRunning(function(prompt)
	if not prompt:hasHoldModeCompleted() then
		DrawText("Holding...", 0.5, 0.5)
	end
end)

prompt:setOnHoldModeCompleted(function(prompt)
	DrawText("Hold completed!", 0.5, 0.5)
end)

UipromptManager:startEventThread()
