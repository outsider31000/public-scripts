
TriggerEvent("getCore",function(core)
    VorpCore = core
end)
VORP = exports.vorp_core:vorpAPI()
RegisterServerEvent("DiscordBot:playerDied")
AddEventHandler("DiscordBot:playerDied", function(msg,Weapon)
    local webhook = Config.webhook
    local message
    if Weapon ~= nil then
         message = msg.." Weapon: "..Weapon
    else
         message = msg
    end
    SendWebhookMessage(webhook,message)
end)
function SendWebhookMessage(webhook,message)
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end 
AddEventHandler('playerDropped', function(reason)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local isdead = Character.isdead  
    if isdead and Config.combatlog then
        local webhook = Config.webhook
        message = GetPlayerName(source) .. " Combat logged"
        SendWebhookMessage(webhook,message)
        isdead = nil
    end
end)
