

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Wait(5000)
	ExecuteCommand('rc')
	FreezeEntityPosition(PlayerPedId(), true)
	SendNUIMessage({
		type = "Volde_startdisplay",
		display = true
	  })
end)

AddEventHandler("SaltyChat_TalkStateChanged", function(isTalking)
    if isTalking then
		FreezeEntityPosition(PlayerPedId(), false)
		SendNUIMessage({
			type = "Volde_startdisplay",
			display = false
		  })
    end
end)
