RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    if Config.onesync then 
        TriggerServerEvent('instance_spawn:setNamed', 0)
    end
end)

AddEventHandler('playerSpawned', function()
    if Config.onesync then 
        TriggerServerEvent('instance_spawn:setNamed', tonumber(GetPlayerServerId(PlayerId()))+Config.bucketblock)
    end
end)