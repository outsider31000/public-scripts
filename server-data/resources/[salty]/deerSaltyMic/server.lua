RegisterServerEvent("SaltyChat_SetVoiceRange")
AddEventHandler("SaltyChat_SetVoiceRange", function(range)
    local _source = source
    TriggerClientEvent("syn_voicechange",_source,range)
end)