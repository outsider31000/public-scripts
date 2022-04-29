local knockedOut = false
local wait = 15
local count = 60

local function DisplayHelp(_message, x, y, w, h, enableShadow, col1, col2, col3, a, centre)

    local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

    SetTextScale(w, h)
    SetTextColor(col1, col2, col3, a)

    SetTextCentre(centre)

    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end

    Citizen.InvokeNative(0xADA9255D, 10);

    DisplayText(str, x, y)

end


local function ShowNotification( _message )
	local timer = 200
	while timer > 0 do
		DisplayHelp(_message, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
		Citizen.Wait(0)
	end
end


Citizen.CreateThread(function()
	while true do
		Wait(1)
		local myPed = PlayerPedId()
		--[[print(myPed)
		print(Citizen.InvokeNative(0x0317C947D062854E ,PlayerId()))
		print(Citizen.InvokeNative(0x4700A416E8324EF3  ,myPed))
		print(Citizen.InvokeNative(0x96C638784DB4C815   ,myPed))
		print(Citizen.InvokeNative(0x8154E470   ,PlayerId()))]]--
		if Citizen.InvokeNative(0x4E209B2C1EAD5159 ,myPed) then
			--print(GetEntityHealth(myPed))
			if GetEntityHealth(myPed) < 75 then
				SetPlayerInvincible(PlayerId(), true)
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				ShowNotification("~r~You Are Knocked Out")
				wait = 15
				knockedOut = true
				SetEntityHealth(myPed, 116)
			end
		end
		if knockedOut == true then
			SetPlayerInvincible(PlayerId(), true)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
					SetEntityHealth(myPed, GetEntityHealth(myPed)+4)
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
	end
end)

