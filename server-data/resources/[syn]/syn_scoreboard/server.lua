-- Made by Blue 

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("syn:players")
AddEventHandler("syn:players", function(ptable)
    local players = {}
    local _source = source
    for _, i in ipairs(ptable) do
        local User = VorpCore.getUser(i)
        local ping = GetPlayerPing(i)
        local used = User.getUsedCharacter
        table.insert(players, {
            no          = i,
            name        = GetPlayerName(i),
            pong  = ping,
          })

        TriggerClientEvent("syn:paylerlist", _source, players)
    end

    
    
end)

