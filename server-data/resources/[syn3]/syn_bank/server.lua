local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('syn_bank:getinfo') 
AddEventHandler('syn_bank:getinfo', function(name)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local charidentifier = Character.charIdentifier
    exports["ghmattimysql"]:execute("SELECT money, gold FROM bank_users WHERE charidentifier = @charidentifier AND name = @name", { ["@charidentifier"] = charidentifier,["@name"] = name }, function(result)
        money = 0
        gold = 0
        if result[1] ~= nil then
            money = result[1].money
            gold = result[1].gold
        else
            local Parameters = { ['name'] = name,['charidentifier'] = charidentifier,['money'] = money,['gold'] = gold}
            exports.ghmattimysql:execute("INSERT INTO bank_users ( `name`,`charidentifier`,`money`,`gold`) VALUES ( @name, @charidentifier, @money, @gold)", Parameters)
        end
        local bankinfo = {money = money, gold = gold}
        TriggerClientEvent("syn_bank:recinfo",_source,bankinfo)
    end)
end)

RegisterServerEvent('syn_bank:depositcash') 
AddEventHandler('syn_bank:depositcash', function(amount,name)
    local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
    local charidentifier = Character.charIdentifier
    local money = Character.money
    if money >= amount then 
        Character.removeCurrency(0, amount)
        local Parameters = { ['charidentifier'] = charidentifier,['money'] = amount,['name'] = name}
        exports.ghmattimysql:execute("UPDATE bank_users Set money=money+@money WHERE charidentifier=@charidentifier AND name = @name", Parameters)
        TriggerClientEvent("vorp:TipRight", _source, Config.language.youdepo..amount, 10000) 
        Discord(Config.language.depoc,GetPlayerName(_source),amount,name)
    else
        TriggerClientEvent("vorp:TipRight", _source, Config.language.invalid, 10000) 
    end
    TriggerClientEvent("syn_bank:ready",_source)
end)

RegisterServerEvent('syn_bank:depositgold') 
AddEventHandler('syn_bank:depositgold', function(amount,name)
    local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
    local charidentifier = Character.charIdentifier
    local money = Character.gold
    if money >= amount then 
        Character.removeCurrency(1, amount)
        local Parameters = { ['charidentifier'] = charidentifier,['gold'] = amount,['name'] = name}
        exports.ghmattimysql:execute("UPDATE bank_users Set gold=gold+@gold WHERE charidentifier=@charidentifier AND name = @name", Parameters)
        TriggerClientEvent("vorp:TipRight", _source, Config.language.youdepog..amount, 10000) 
        Discord(Config.language.depog,GetPlayerName(_source),amount,name)
    else
        TriggerClientEvent("vorp:TipRight", _source, Config.language.invalid, 10000) 
    end
    TriggerClientEvent("syn_bank:ready",_source)
end)

RegisterServerEvent('syn_bank:withcash') 
AddEventHandler('syn_bank:withcash', function(amount,name)
    local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
    local charidentifier = Character.charIdentifier
    exports["ghmattimysql"]:execute("SELECT money FROM bank_users WHERE charidentifier = @charidentifier AND name = @name", { ["@charidentifier"] = charidentifier,["@name"] = name }, function(result)
        local money = result[1].money
        if money >= amount then 
            local Parameters = { ['charidentifier'] = charidentifier,['money'] = amount,['name'] = name}
            exports.ghmattimysql:execute("UPDATE bank_users Set money=money-@money WHERE charidentifier=@charidentifier AND name = @name", Parameters)
            Character.addCurrency(0, amount)
            TriggerClientEvent("vorp:TipRight", _source, Config.language.withdrew..amount, 10000)
            Discord(Config.language.withc,GetPlayerName(_source),amount,name)
        else
            TriggerClientEvent("vorp:TipRight", _source, Config.language.invalid, 10000) 
        end
        TriggerClientEvent("syn_bank:ready",_source)
    end)
end)

RegisterServerEvent('syn_bank:withgold') 
AddEventHandler('syn_bank:withgold', function(amount,name)
    local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
    local charidentifier = Character.charIdentifier
    exports["ghmattimysql"]:execute("SELECT gold FROM bank_users WHERE charidentifier = @charidentifier AND name = @name", { ["@charidentifier"] = charidentifier,["@name"] = name }, function(result)
        local gold = result[1].gold
        if gold >= amount then 
            local Parameters = { ['charidentifier'] = charidentifier,['gold'] = amount,['name'] = name}
            exports.ghmattimysql:execute("UPDATE bank_users Set gold=gold-@gold WHERE charidentifier=@charidentifier AND name = @name", Parameters)
            Character.addCurrency(1, amount)
            TriggerClientEvent("vorp:TipRight", _source, Config.language.withdrewg..amount, 10000)
            Discord(Config.language.withg,GetPlayerName(_source),amount,name)
        else
            TriggerClientEvent("vorp:TipRight", _source, Config.language.invalid, 10000) 
        end
        TriggerClientEvent("syn_bank:ready",_source)
    end)
end)



 

function Discord(title,name,description,location)
    local logs = ""
    local webhook = Config.adminwebhook
    local avatar = Config.webhookavatar
    local color = 3447003
    local title = title
    logs = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = description,
            ["footer"] = {["text"]=location}
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({["username"] = name ,["avatar_url"] = avatar ,embeds = logs}), { ['Content-Type'] = 'application/json' })
  end