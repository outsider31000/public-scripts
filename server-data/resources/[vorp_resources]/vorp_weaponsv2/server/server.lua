


TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent("syn_weapons:addcomp")
AddEventHandler("syn_weapons:addcomp", function(weaponid,added)
    local _source = source
    local User = VorpCore.getUser(source) 
    local Character = VorpCore.getUser(source).getUsedCharacter
    local components = json.encode(added)
    if weaponid ~= nil then
        local Parameters = { ['id'] = weaponid, ['comps'] = components } 
        exports.ghmattimysql:execute("UPDATE loadout Set comps=@comps WHERE id=@id", Parameters)
    end
end)

RegisterServerEvent("syn_weapons:weaponused")
AddEventHandler("syn_weapons:weaponused", function(data)
    local _source = source
    local id = data.id
    local next = next
    local hash = data.hash 
    exports.ghmattimysql:execute('SELECT comps, used2 FROM loadout WHERE id = @id ' , {['id'] = id}, function(result)
        if result[1] ~= nil then 
            local components = json.decode(result[1].comps)
            TriggerClientEvent("syn_weapons:givecomp",_source,components,id,hash)
        end
    end)
end)
RegisterServerEvent("vorpinventory:serverGiveWeapon2")
AddEventHandler("vorpinventory:serverGiveWeapon2", function(id,target)
    TriggerEvent("vorpCore:canCarryWeapons", tonumber(target), 1, function(canCarry)
        if canCarry then
            VorpInv.subWeapon(source, id)
            VorpInv.giveWeapon(target, id, 0)
            TriggerEvent("syn_weapons:checkweapon",id,target)
        end
    end)

end)
RegisterServerEvent("syn_weapons:checkweapon")
AddEventHandler("syn_weapons:checkweapon", function(id,target)
    Citizen.Wait(1000)
    exports.ghmattimysql:execute('SELECT identifier FROM loadout WHERE id = @id ' , {['id'] = id}, function(result)
        if result[1] ~= nil then 
            local identifier2 = result[1].identifier
            if identifier2 == "" then
                local Character2 = VorpCore.getUser(target).getUsedCharacter -- issued
                local identifier = Character2.identifier
                local charidentifier = Character2.charIdentifier
                exports.ghmattimysql:execute("UPDATE loadout Set identifier=@identifier WHERE id=@id", {['identifier'] = identifier,['id'] = id})
                exports.ghmattimysql:execute("UPDATE loadout Set charidentifier=@charidentifier WHERE id=@id", {['charidentifier'] = charidentifier,['id'] = id})
            end
        end
    end)
end)

RegisterServerEvent("syn_weapons:removeused")
AddEventHandler("syn_weapons:removeused", function(data)
    local _source = source
  local User = VorpCore.getUser(_source)
  local Character = User.getUsedCharacter
  local identifier = Character.identifier
  local charidentifier = Character.charIdentifier
  local used = 0
  local used2 = 0
  local Parameters = { ['identifier'] = identifier,['used'] = used,['used2'] = used2, ['charidentifier'] = charidentifier } 
  exports.ghmattimysql:execute("UPDATE loadout Set used=@used,used2=@used2 WHERE identifier=@identifier AND charidentifier = @charidentifier", Parameters) 
end)

RegisterServerEvent("syn_weapons:cleanup")
AddEventHandler("syn_weapons:cleanup", function()
    exports.ghmattimysql:execute("DELETE FROM loadout WHERE dropped=@dropped", { ['dropped'] = 1})
end)

RegisterServerEvent("vorpinventory:serverDropWeapon")
AddEventHandler("vorpinventory:serverDropWeapon", function(id)
local Parameters = { ['id'] = id, ['dropped'] = 1 } 
exports.ghmattimysql:execute("UPDATE loadout Set dropped=@dropped WHERE id=@id", Parameters)
end)

RegisterServerEvent("syn_weapons:onpickup")
AddEventHandler("syn_weapons:onpickup", function(id)
local Parameters = { ['id'] = id, ['dropped'] = 0 } 
exports.ghmattimysql:execute("UPDATE loadout Set dropped=@dropped WHERE id=@id", Parameters) 
end)

RegisterServerEvent("syn_weapons:checkmoney")
AddEventHandler("syn_weapons:checkmoney", function(sum)
    local _source = source
    local Character = VorpCore.getUser(source).getUsedCharacter
    local money = Character.money
    local gold = Character.gold
    local total 
    if Config.customizationcurrency == 0 then 
        total = money - sum
    elseif Config.customizationcurrency == 1 then
        total = gold - sum
    end
    if total ~= nil then 
        if total >= 0 then 
            if Config.customizationcurrency == 0 then 
                Character.removeCurrency(0, sum)
            elseif Config.customizationcurrency == 1 then
                Character.removeCurrency(1, sum)
            end
            TriggerClientEvent("vorp:TipRight", _source, Config2.Language.craftingwepmods, 3000)
            TriggerClientEvent("syn_weapons:applymods",_source)
        else
            TriggerClientEvent("vorp:TipRight", _source, Config2.Language.cantafford, 3000)
            TriggerClientEvent("syn_weapons:nomods",_source)
        end
    end
end)

RegisterServerEvent("syn_weapons:getjob")
AddEventHandler("syn_weapons:getjob", function()
  local _source = source
  local User = VorpCore.getUser(_source)
  local Character = User.getUsedCharacter
  local identifier = Character.identifier
  local charidentifier = Character.charIdentifier
  local job = Character.job
  local rank = Character.jobGrade
  TriggerClientEvent("syn_weapons:findjob", _source,job,rank)
end)


function containsammo(table, element)
    for k, v in pairs(table) do
          if k == element then
            return true, v
        end
    end
  return false , 0
end

RegisterServerEvent("syn_weapons:removeallammoserver") -- new event 
AddEventHandler("syn_weapons:removeallammoserver", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT ammo FROM characters WHERE charidentifier = @charidentifier ' , {['charidentifier'] = charidentifier}, function(result)
		local ammo = json.decode(result[1].ammo)
        if next(ammo) ~= nil then 
            local Parameters = { ['charidentifier'] = charidentifier, ['ammo'] = json.encode({})}
            exports.ghmattimysql:execute("UPDATE characters Set ammo=@ammo  WHERE charidentifier=@charidentifier", Parameters)    
            TriggerEvent("vorpinventory:removeammo",_source) 
        end
    end)
end)

RegisterServerEvent("syn_weapons:getandcheckammo")
AddEventHandler("syn_weapons:getandcheckammo", function(player,key,qt,item,max)
    local _source = player 
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT ammo FROM characters WHERE charidentifier = @charidentifier ' , {['charidentifier'] = charidentifier}, function(result)
		local ammo = json.decode(result[1].ammo)
        local contains, count = containsammo(ammo, key)
        if contains then 
            if count >= max then 
                TriggerClientEvent("syn_weapons:givebackbox",_source,item)
            elseif (qt+count) >= max then 
                qt = max - count
            end
        end
        TriggerEvent("vorpCore:addBullets", _source, key, qt)
    end)
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    for k,v in pairs(Config3.ammo) do 
        for l,m in pairs(v) do 
            local guncheck2 = 0
            local playeritem = 0
            if m.guncheck2 ~= nil then
                guncheck2 = m.guncheck2
            end
            if m.playeritem ~= nil then 
                playeritem = m.playeritem
            end
            VorpInv.RegisterUsableItem(m.item, function(data)
    	    VorpInv.subItem(data.source, m.item, 1)
            if Config.updatedinventoryammo then 
                TriggerEvent("syn_weapons:getandcheckammo", data.source, m.key, m.qt,m.item,m.maxammo)
            else 
                TriggerClientEvent('syn_weapons:getgun', data.source,m.key,m.guncheck,m.qt,m.item,guncheck2,playeritem)
            end
            end) 
        end
    end
end)

function contains(table, element)
    for k, v in pairs(table) do
          if k == element then
            return true
        end
    end
  return false
  end

RegisterServerEvent("syn_weapons:addammo")
AddEventHandler("syn_weapons:addammo", function(wephash,qt,key,playeritem,item)
    local _source = source
    local User = VorpCore.getUser(source) -- Return User with functions and all characters
    local Character = VorpCore.getUser(source).getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    local used = 1
    local weapid
    local max
    local inventory = Character.inventory
    exports.ghmattimysql:execute('SELECT name,id,ammo FROM loadout WHERE identifier=@identifier AND charidentifier = @charidentifier ' , {['identifier'] = identifier, ['charidentifier'] = charidentifier}, function(result)
        if result[1] ~= nil then 
            for i=1, #result, 1 do
                if playeritem == 0 then
                    if GetHashKey(result[i].name) == wephash then
                        weapid = result[i].id
                    end
                elseif  playeritem ~= 0 then
                    for k,v in pairs(playeritem) do 
                        if v == result[i].name then
                            weapid = result[i].id
                        end
                    end
                end
            end
            for k,v in pairs(Config3.ammo) do
                for l,m in pairs(v) do
                    if m.key == key then 
                        max = m.maxammo
                    end
                end
            end
            if weapid ~= nil then
                exports.ghmattimysql:execute('SELECT ammo FROM loadout WHERE id = @id ' , {['id'] = weapid}, function(result)
                    if result[1] ~= nil then 
                        local ammo = json.decode(result[1].ammo)
                        if contains(ammo, key) then
                            if (ammo[key] + qt) > max then
                                
                                qt = max - ammo[key]
                                ammo[key] = max 
                            else
                                
                                ammo[key] = ammo[key] + qt
                            end
                        else
                            
                            ammo[key] = tonumber(qt)
                        end
                        if qt > 0 then
                            TriggerEvent("vorpCore:addBullets", _source, weapid, key, qt)
                            exports.ghmattimysql:execute("UPDATE loadout Set ammo=@ammo WHERE id=@id", { ['id'] = weapid, ['ammo'] = json.encode(ammo) })
                        else
                            TriggerClientEvent("syn_weapons:givebackbox",_source,item)
                        end
                    end
                end)
            else
                TriggerClientEvent("syn_weapons:givebackbox",_source,item)
            end
        end
    end)
end)

RegisterServerEvent("syn_weapons:givebackbox")
AddEventHandler("syn_weapons:givebackbox", function(item)
    local _source = source
    VorpInv.addItem(_source, item, 1)
end)

RegisterServerEvent("syn_weapons:givebackbox2")
AddEventHandler("syn_weapons:givebackbox2", function(item,label)
    local _source = source
    local ammo = {["nothing"] = 0}
    local components =  {["nothing"] = 0}
    if Config.syndual == nil then 
        Config.syndual = false 
    end
    if Config.syndual == false then 
        VorpInv.createWeapon(tonumber(_source), item, ammo, components)
    else
        VorpInv.createWeapon(tonumber(_source), item, label, ammo, components)
    end
end)

function contain(table, element)
    for k, v in pairs(table) do
          if v == element then
            return false
        end
    end
  return true
end

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" and webhook ~= 0 then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end


RegisterServerEvent("syn_weapons:buyweapon")
AddEventHandler("syn_weapons:buyweapon", function(itemtobuy,itemprice,itemlabel)
    if Config.syndual == nil then 
        Config.syndual = false 
    end
    local _source = source
    local User = VorpCore.getUser(source) -- Return User with functions and all characters
    local Character = VorpCore.getUser(source).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname
    local money = Character.money
    local total = money - itemprice
    TriggerEvent("vorpCore:canCarryWeapons", tonumber(_source), 1, function(canCarry)
        if canCarry then
            if total >= 0 then
                Character.removeCurrency(0, itemprice)
                local message = Config2.Language.syn_weapons..playername..Config2.Language.bought..itemtobuy
                SendWebhookMessage(Config.adminwebhook,message)
                local ammo = {["nothing"] = 0}
                local components =  {["nothing"] = 0}
                if Config.syndual == false then
                    VorpInv.createWeapon(tonumber(_source), itemtobuy:upper(), ammo, components)
                    TriggerClientEvent("vorp:TipRight", _source, Config2.Language.youboughta..itemlabel..Config2.Language.fors..itemprice..Config2.Language.dollar, 3000)
                else
                    VorpInv.createWeapon(tonumber(_source), itemtobuy, itemlabel)
                    TriggerClientEvent("vorp:TipRight", _source, Config2.Language.youboughta..itemlabel..Config2.Language.fors..Config2.Language.dollar..itemprice, 3000)
                end
            else
                TriggerClientEvent("vorp:TipRight", _source, Config2.Language.nomoney, 3000)
            end
        else
            TriggerClientEvent("vorp:TipRight", _source, Config2.Language.cantcarrywep, 3000)
        end
    end)
end)

RegisterServerEvent("syn_weapons:buyammo")
AddEventHandler("syn_weapons:buyammo", function(itemtobuy,itemprice,count,itemlabel)
    local _source = source
    if count == nil then 
        count = 1
    end
    local User = VorpCore.getUser(source) -- Return User with functions and all characters
    local Character = VorpCore.getUser(source).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname
    local money = Character.money
    local take = itemprice * count
    local total = money - take
    TriggerEvent("vorpCore:canCarryItems", tonumber(_source), count, function(canCarry)
        TriggerEvent("vorpCore:canCarryItem", tonumber(_source), itemtobuy,count, function(canCarry2)
            if canCarry and canCarry2 then
                if total >= 0 then
                    Character.removeCurrency(0, take)
                    local message = Config2.Language.syn_weapons..playername..Config2.Language.bought..itemlabel
                    SendWebhookMessage(Config.adminwebhook,message)
                    VorpInv.addItem(_source, itemtobuy, count)
                    TriggerClientEvent("vorp:TipRight", _source, Config2.Language.youboughta..itemlabel..Config2.Language.fors..take..Config2.Language.dollar, 3000)
                else
                    TriggerClientEvent("vorp:TipRight", _source, Config2.Language.nomoney, 3000)
                end
            else
                TriggerClientEvent("vorp:TipRight", _source, Config2.Language.cantcarryitem, 3000)
            end
        end)
    end)
end)

RegisterServerEvent("syn_weapons:itemscheck")
AddEventHandler("syn_weapons:itemscheck", function(item,materials)
    local _source = source
    local checkingtable = {}
    local accepted
    local User = VorpCore.getUser(source) -- Return User with functions and all characters
    local Character = VorpCore.getUser(source).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname
    for k,v in pairs(materials) do 
       local count = VorpInv.getItemCount(_source, v.name)
        if count - v.amount >= 0 then
            accepted = "true"
        else
            accepted = "false"
        end
        table.insert(checkingtable, accepted)
    end
    if contain(checkingtable, "false") then
        TriggerEvent("vorpCore:canCarryItems", tonumber(_source), 1, function(canCarry)
            TriggerEvent("vorpCore:canCarryItem", tonumber(_source), item,1, function(canCarry2)
                if canCarry and canCarry2 then
                    TriggerClientEvent("syn_weapons:itemcheckpassed",_source,item)
                    TriggerClientEvent("vorp:TipRight", _source,Config2.Language.crafting, 3000)
                    local message = Config2.Language.syn_weapons..playername..Config2.Language.crafted..item
                    SendWebhookMessage(Config.adminwebhook,message)
                    for k,v in pairs(materials) do 
                        VorpInv.subItem(_source, v.name, v.amount)
                    end
                else
                    TriggerClientEvent("syn_weapons:itemcheckfailed",_source)
                    TriggerClientEvent("vorp:TipRight", _source, Config2.Language.cantcarryitem, 3000)
                end
            end)
        end)
    else
        TriggerClientEvent("syn_weapons:itemcheckfailed",_source)
        TriggerClientEvent("vorp:TipRight", _source, Config2.Language.nomaterial, 3000)
    end
end)

RegisterServerEvent("syn_weapons:itemscheck2")
AddEventHandler("syn_weapons:itemscheck2", function(label,item,materials)
    local _source = source
    local checkingtable = {}
    local accepted
    local User = VorpCore.getUser(source) -- Return User with functions and all characters
    local Character = VorpCore.getUser(source).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname

    for k,v in pairs(materials) do 
       local count = VorpInv.getItemCount(_source, v.name)
        if count - v.amount >= 0 then
            accepted = "true"
        else
            accepted = "false"
        end
        table.insert(checkingtable, accepted)
    end
    if contain(checkingtable, "false") then
        TriggerEvent("vorpCore:canCarryWeapons", tonumber(_source), 1, function(canCarry)
            if canCarry then
                TriggerClientEvent("syn_weapons:itemcheckpassed2",_source,item,label)
                TriggerClientEvent("vorp:TipRight", _source, Config2.Language.crafting, 3000)
                local message = Config2.Language.syn_weapons..playername..Config2.Language.crafted..label
                SendWebhookMessage(Config.adminwebhook,message)
                for k,v in pairs(materials) do 
                    VorpInv.subItem(_source, v.name, v.amount)
                end
            else
                TriggerClientEvent("syn_weapons:itemcheckfailed",_source)
                TriggerClientEvent("vorp:TipRight", _source, Config2.Language.cantcarrywep, 3000)
            end
        end)
    else
        TriggerClientEvent("syn_weapons:itemcheckfailed",_source)
        TriggerClientEvent("vorp:TipRight", _source, Config2.Language.nomaterial, 3000)
    end
end)


