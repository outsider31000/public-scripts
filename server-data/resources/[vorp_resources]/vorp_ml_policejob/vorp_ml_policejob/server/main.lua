local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)



-- RegisterCommand('dv', function(source, args, rawCommand)
--     local _source = source
--     local Character = VorpCore.getUser(_source).getUsedCharacter
--     local group = Character.group
--     if group == 'admin' then
--         TriggerClientEvent('wcrp:deleteVehicleadmin', _source)
--     else
--         TriggerClientEvent("vorp:TipRight", _source, _U('no_autorizado2'), 4000) -- from server side
--     end
-- end)

RegisterCommand('dv', function(source, args, rawCommand)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    
    TriggerClientEvent('wcrp:deleteVehicle', _source)
    
end)



RegisterCommand('pol', function(source, args, rawCommand)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'police' then
        TriggerClientEvent('vorp_ml_policejob:open', _source)
    else
        TriggerClientEvent("vorp:TipBottom", _source, _U('no_autorizado'), 4000) -- from server side
    end
end)

RegisterServerEvent("vorp_ml_policejob:checkjob")
AddEventHandler("vorp_ml_policejob:checkjob", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'police' then
        TriggerClientEvent('vorp_ml_policejob:open', _source)
    else
        TriggerClientEvent("vorp:Tip", _source, _U('no_autorizado'), 4000) -- from server side
    end
end)

RegisterServerEvent("vorp_ml_policejob:checkjob2")
AddEventHandler("vorp_ml_policejob:checkjob2", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'police' then
        TriggerClientEvent('vorp_ml_policejob:open2', _source)
    else
        TriggerClientEvent("vorp:Tip", _source, _U('no_autorizado'), 4000) -- from server side
    end
end)

-- drag
RegisterServerEvent('vorp_ml_policejob:drag')
AddEventHandler('vorp_ml_policejob:drag', function(target)
    local _source = source
    local _target = target
   
    if _target then
        if _target ~= _source then
            TriggerClientEvent("vorp_ml_policejob:drag", _target, _source)
        else
            TriggerClientEvent("vorp:TipBottom", _source, _U('nodrag'), 4000)
        end
    else
        TriggerClientEvent("vorp:TipBottom", _source, _U('norange'), 4000)
    end

end)

--cuff
RegisterServerEvent('vorp_ml_policejob:cuffplayer')
AddEventHandler('vorp_ml_policejob:cuffplayer', function(target)
    local _source = source
    local _target = target

    TriggerClientEvent('vorp_ml_policejob:cuff', _target)
    -- print('servercuff')
    TriggerClientEvent("vorp:TipBottom", _source, _U('poner_esposas'), 4000) -- from server side
end)

RegisterServerEvent('vorp_ml_policejob:metervehiculo')
AddEventHandler('vorp_ml_policejob:metervehiculo', function(target)
        TriggerClientEvent('vorp_ml_policejob:meter', target)
        -- print('servercuff')
        
end)

RegisterServerEvent('vorp_ml_policejob:sacarvehiculo')
AddEventHandler('vorp_ml_policejob:sacarvehiculo', function(target)
    TriggerClientEvent('vorp_ml_policejob:sacar', target)
    -- print('servercuff')
        
end)

RegisterServerEvent('vorp_ml_policejob:uncuffplayer')
AddEventHandler('vorp_ml_policejob:uncuffplayer', function(target)
    local _source = source
    local _target = target
    TriggerClientEvent('vorp_ml_policejob:uncuff', _target)
    -- print('serveruncuff')
    TriggerClientEvent("vorp:TipBottom", _source, _U('quitar_esposas'), 4000) -- from server side
end)

--lasso


RegisterServerEvent('vorp_ml_policejob:lassoplayer')
AddEventHandler('vorp_ml_policejob:lassoplayer', function(target)
    local _source = source
    local _target = target
    -- TriggerClientEvent('vorp_ml_policejob:lasso', target)
    TriggerClientEvent('vorp_ml_policejob:hogtie', _target)
    -- print('serverlasso')
    TriggerClientEvent("vorp:TipBottom", _source, _U('atado'), 4000) -- from server side
end)