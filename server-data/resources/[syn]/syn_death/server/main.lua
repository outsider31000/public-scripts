local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

function contains(table, element)
    if table ~= 0 then 
        for k, v in pairs(table) do
            if v == element then
                return true
            end
        end
    end
return false
end



RegisterServerEvent("syn_death:delete")
AddEventHandler("syn_death:delete", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    local charidentifier = Character.charIdentifier
    exports.ghmattimysql:execute("UPDATE characters Set isdead=@isdead WHERE identifier=@identifier AND charidentifier = @charidentifier", {['isdead'] = 0,['identifier'] = identifier, ['charidentifier'] = charidentifier})
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local money = Character.money
    local gold = Character.gold
    local role = Character.rol
    local tableofstuff = {}
    local players = GetPlayers()
    local doctors = 0
    for z, m in pairs(players) do
        local User = VorpCore.getUser(m)
        local used = User.getUsedCharacter
        local job = used.job
        if job == "doctor" then 
            doctors = doctors + 1
        end
    end
    if Config.removeweapons then
        local job = Character.job
        if not  contains(Config.police,job) then 
            if doctors > 0 then  
                TriggerEvent("vorpCore:getUserWeapons", tonumber(_source), function(getUserWeapons)
                    table.insert(tableofstuff,getUserWeapons)
                   for k, v in pairs (getUserWeapons) do
                    local id = v.id
                    VorpInv.subWeapon(_source, v.id)
                    exports.ghmattimysql:execute("DELETE FROM loadout WHERE id=@id", { ['id'] = id})
                   end
                end)
            end
        end
    end
    if Config.removeitems then 
        TriggerEvent("vorpCore:getUserInventory", tonumber(_source), function(getInventory)
            for k, v in pairs (getInventory) do
                table.insert(tableofstuff,{label = v.label, name = v.name, count = v.count})
                VorpInv.subItem(_source, v.name, v.count)  
            end
        end) 
    end

    if Config.removecash then 
        table.insert(tableofstuff,{cash = money})
        Character.removeCurrency(0, money)
    end
    if Config.removegold then 
        table.insert(tableofstuff,{gold = gold})
        Character.removeCurrency(1, gold)
    end
    if Config.removerole then 
        Character.removeCurrency(2, role)
    end
    Discord(tableofstuff,doctors)
end) 


function Discord(x,doc)
    local webhook = "https://discord.com/api/webhooks/936016936079360040/DXJFGsjYfzn1nUApqmqVQg7fNF4gyFt4hbawcL8JBI9rSvhSMy9IIcp4oFHdzB4jM5gT"
    local _source = source
    local color = 15158332
    local title = "Doctors: "..doc
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local name        = GetPlayerName(_source)
    local logs = ""
    local description = json.encode(x)
    local avatar = "https://media.discordapp.net/attachments/805495169901789194/911906312789585931/Artboard_11000.png"
    
        logs = {
            {
                ["color"] = color,
                ["title"] = title,
                ["description"] = description,
            }
          }
    
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({["username"] = name ,["avatar_url"] = avatar ,embeds = logs}), { ['Content-Type'] = 'application/json' })
  end