TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterCommand("bandana", function(source, args) 
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT compPlayer FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        local playeroutfits = {}
        if result[1] ~= nil then           
            _clothes        = result[1].compPlayer
            TriggerClientEvent("syn_verst:bandana",_source, _clothes)
        end
    end)
end)

RegisterCommand("sleeves", function(source, args) 
    local _source = source
    local user = VorpCore.getUser(_source).getUsedCharacter
    local comps = user.comps
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT compPlayer FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        local playeroutfits = {}
        if result[1] ~= nil then           
            _clothes        = result[1].compPlayer
            TriggerClientEvent("syn_verst:sleeves",_source, _clothes)
        end
    end)
end)
RegisterCommand("sleeves2", function(source, args) 
    local _source = source
    local user = VorpCore.getUser(_source).getUsedCharacter
    local comps = user.comps
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT compPlayer FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        local playeroutfits = {}
        if result[1] ~= nil then           
            _clothes        = result[1].compPlayer
            TriggerClientEvent("syn_verst:sleeves2",_source, _clothes)
        end
    end)
end)
