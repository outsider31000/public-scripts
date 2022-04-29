

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


RegisterServerEvent("syn_construction:gettrustserver")
AddEventHandler("syn_construction:gettrustserver", function()
    local _source = source
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT trust FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        if result[1] ~= nil then 
            local trust = result[1].trust
            TriggerClientEvent("syn_construction:gettrustclient",_source,trust)
        end
    end)
end)

RegisterServerEvent("syn_construction:reward")
AddEventHandler("syn_construction:reward", function(quality,tasksdone,reward,totaltasks)
    local _source = source
    if 10 > quality then 
        quality = 10
    end
    if tasksdone > totaltasks/2 then 
        local mult1 = tasksdone/totaltasks
        local mult2 = quality * 0.01
        local pay = (reward * mult1) * mult2
        local Character = VorpCore.getUser(_source).getUsedCharacter
        local identifier = Character.identifier
        local charidentifier = Character.charIdentifier
        Character.addCurrency(0, pay)
        TriggerClientEvent("vorp:TipRight", _source, Config.Language.paid..pay, 5000)
        local trust = 1
        exports.ghmattimysql:execute("UPDATE characters Set trust=trust+@trust WHERE identifier=@identifier AND charidentifier = @charidentifier", {['trust'] = trust,['identifier'] = identifier, ['charidentifier'] = charidentifier})
    else
        TriggerClientEvent("vorp:TipRight", _source, Config.Language.nowork, 5000)
    end
end)