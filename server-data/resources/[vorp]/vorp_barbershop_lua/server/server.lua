



TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()




RegisterServerEvent('vorp_barbershop:getinfo')
AddEventHandler('vorp_barbershop:getinfo', function()
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT skinPlayer FROM characters WHERE charidentifier = @charidentifier', {['charidentifier'] = u_charid}, function(result)
        if result[1] ~= nil then           
          skin        = result[1].skinPlayer
          TriggerClientEvent("vorp_barbershop:recinfo", _source, skin)
        end
    end)
end)

RegisterServerEvent('vorp_barbershop:payforservice')
AddEventHandler('vorp_barbershop:payforservice', function(amount,hair,beard)
    local _source = source 
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local cash = Character.money
    local paid = false 
    if (cash - amount) >= 0 then 
        Character.removeCurrency(0, amount)
        paid = true 
        TriggerClientEvent("vorp:TipRight", _source, language.youpaid..amount, 10000) 
        local newcomps = {}
        if beard ~= nil then 
            newcomps["Beard"] = beard
        end
        newcomps["Hair"] = hair
        local newcompsjson = json.encode(newcomps)
        TriggerEvent("vorpcharacter:setPlayerSkinChange", _source, newcompsjson)
    else
        TriggerClientEvent("vorp:TipRight", _source, language.nomoney, 10000) 
    end
    TriggerClientEvent("vorp_barbershop:apply",_source,paid)
end)
