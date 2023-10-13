local VorpCore
local VorpInv


TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VorpInv = exports.vorp_inventory:vorp_inventoryApi()


RegisterServerEvent("rm:askforshared")
AddEventHandler("rm:askforshared", function(playerid,type,coords1,heading1,coords2,heading2)
    local sharedinfo = {type=type,coords1=coords1,heading1=heading1,coords2=coords2,heading2=heading2}
    TriggerClientEvent("rm:recquestion",playerid,source,sharedinfo)
end)

RegisterServerEvent("rm:isok")
AddEventHandler("rm:isok", function(accept,sharedinfo,senderid)
    TriggerClientEvent("rm:ok",senderid,accept,sharedinfo)

end)

RegisterServerEvent("syn_walkanim:getwalk")
AddEventHandler("syn_walkanim:getwalk", function()
    local _source = source
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT walk FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        if result[1] ~= nil then 
            local walk = result[1].walk
            TriggerClientEvent("syn_walkanim:getwalk2",_source,walk)
        end
    end)
end)

RegisterServerEvent("syn_walkanim:setwalk")
AddEventHandler("syn_walkanim:setwalk", function(animation)
    local _source = source
    local walk = animation
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute("UPDATE characters Set walk=@walk WHERE identifier=@identifier AND charidentifier = @charidentifier", {['walk'] = walk,['identifier'] = identifier, ['charidentifier'] = charidentifier})
end)

