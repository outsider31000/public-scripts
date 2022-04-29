local data = {}
Citizen.CreateThread(function()
    data = exports.vorp_inventory:vorp_inventoryApi()
end)



RegisterServerEvent("radialtrabajos:checkjob")
AddEventHandler("radialtrabajos:checkjob", function()
    local _source = source
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local job = user.job
        if job == 'doctor' then
        TriggerClientEvent('poke_medic:auth', _source)
        elseif job == 'police' then
        TriggerClientEvent('vorp_ml_policejob:open', _source)
            --TriggerClientEvent('', _source)
        --elseif user.job ~= nil and user.job.name == 'banda' then
                        --print("Si soy Doctor dame el puto menu")
                        --TriggerClientEvent('', _source)
                    end
    end)
end)