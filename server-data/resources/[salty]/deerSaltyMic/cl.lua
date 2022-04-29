local isTalking = false
local isMuted = false
local vRange = 8.0
doDeath = false
isDead = false
hasProcessedDeath = false
local show = false 

function doUpdate()
	SendNUIMessage({
		show = show,  -- Disable hud if settings menu is active
		talking = isTalking,
		muted = isMuted,
		range = vRange
	})
end

--[[ Citizen.CreateThread(function()
	while true do
		Wait(10)
		if IsPauseMenuActive() and show then 
			show = false 
		end
	end
end) ]]

Citizen.CreateThread(function()
	while true do
		isDead = IsEntityDead(PlayerPedId())
		if hasProcessedDeath and not isDead then
			hasProcessedDeath = false
		end
		Citizen.Wait(1000)
	end
end)


Citizen.CreateThread(function()
	while true do
		if doDeath then
			if isDead and not hasProcessedDeath then
				hasProcessedDeath = true
				exports['saltychat']:SetRadioVolume(0.0)
			elseif not isDead and hasProcessedDeath then
				hasProcessedDeath = false
				exports['saltychat']:SetRadioVolume(100.0)
			end
		end
		doUpdate()
		Wait(100)
	end
end)

RegisterNetEvent("syn_displayrange")
AddEventHandler("syn_displayrange", function(t)
	if t == false then 
		SendNUIMessage({
			show = show,  -- Disable hud if settings menu is active
			talking = isTalking,
			muted = isMuted,
			range = vRange
		})
		show = true
	else
		SendNUIMessage({
			show = show,  -- Disable hud if settings menu is active
			talking = isTalking,
			muted = isMuted,
			range = vRange
		})
		show = false

	end
end)


RegisterNetEvent("SaltyChat_TalkStateChanged")
AddEventHandler("SaltyChat_TalkStateChanged", function(t)
	isTalking = t
	doUpdate()
end)

RegisterNetEvent("SaltyChat_MicStateChanged")
AddEventHandler("SaltyChat_MicStateChanged", function(t)
	isMuted = t
	doUpdate()
end)

RegisterNetEvent("syn_voicechange")
AddEventHandler("syn_voicechange", function(t)
	print("Your Voice Range Is: "..t)
	vRange = t
	doUpdate()
end)


