local promptGroup = UipromptGroup:new("Teleport")

local guaPrompt = Uiprompt:new(`INPUT_INTERACT_ANIMAL`, "To Guarma", promptGroup)
guaPrompt:setHoldMode(true)
guaPrompt.coords = vector3(1268.31, -6853.53, 43.31)
guaPrompt.heading = 240.00

local valPrompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "To Valentine", promptGroup)
valPrompt:setHoldMode(true)
valPrompt.coords = vector3(-183.61, 648.32, 113.57)
valPrompt.heading = 68.20

local rhoPrompt = Uiprompt:new(`INPUT_RELOAD`, "To Rhodes", promptGroup)
rhoPrompt:setHoldMode(true)
rhoPrompt.coords = vector3(1240.31, -1289.46, 76.91)
rhoPrompt.heading = 301.61

promptGroup:setOnHoldModeCompleted(function(group, prompt, playerPed)
	DoScreenFadeOut(1000)
	Wait(1000)

	SetEntityCoordsNoOffset(playerPed, prompt.coords)
	SetEntityHeading(playerPed, prompt.heading)
	Wait(1000)

	DoScreenFadeIn(1000)
	Wait(1000)
end)

CreateThread(function()
	while true do
		local playerPed = PlayerPedId()

		if not IsPedDeadOrDying(playerPed) then
			promptGroup:handleEvents(playerPed)
		end

		Wait(0)
	end
end)
