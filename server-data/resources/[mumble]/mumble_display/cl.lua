local isTalking = false
local isMuted = false
local vRange = 8.0
local show = false 

function doUpdate()
	SendNUIMessage({
		show = show,  -- Disable hud if settings menu is active
		talking = isTalking,
		muted = isMuted,
		range = vRange
	})
end



RegisterNetEvent("syn_displayrange2")
AddEventHandler("syn_displayrange2", function(t)
	show = t
	SendNUIMessage({
		show = show,  -- Disable hud if settings menu is active
		talking = isTalking,
		muted = isMuted,
		range = vRange
	})
end)


RegisterNetEvent("syn_talking")
AddEventHandler("syn_talking", function(t)
	isTalking = t
	doUpdate()
end)

--[[ RegisterNetEvent("SaltyChat_MicStateChanged")
AddEventHandler("SaltyChat_MicStateChanged", function(t)
	isMuted = t
	doUpdate()
end) ]]

RegisterNetEvent("syn_changerange")
AddEventHandler("syn_changerange", function(t)
	if t == 1 then 
		vRange = 3.0
	elseif t == 2 then 
		vRange = 8.0
	elseif t == 3 then 
		vRange = 15.0
	elseif t ==4 then 
		vRange = 32.0
	end
	print("Your Voice Range Is: "..vRange)
	doUpdate()
end)


