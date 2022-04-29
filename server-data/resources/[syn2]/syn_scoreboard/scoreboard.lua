local MyKey
TriggerEvent("chatL:addSuggestion", "/list", "Opens Scoreboard")


local open = false 

RegisterCommand("list", function()
	if not open then
        MyKey = GetGameTimer()
        TriggerServerEvent("redm_scoreboard:GetBoard", MyKey)
        open = true
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(5)
        if IsDisabledControlJustReleased(0, Config.key) then
            open = false
            DisplayHud(true)
            DisplayRadar(true)
            SendNUIMessage({
                meta = 'close'
            })
        end
    end
end)

RegisterNetEvent("redm_scoreboard:Show")
AddEventHandler("redm_scoreboard:Show", function(html, key,number)
    if MyKey == key then
        DisplayHud(false)
        DisplayRadar(false)
        local players = {}
        for _,v in pairs(html) do
            if Config.Ping then
                local id = tonumber(v[1])
                local name = v[2]
                local ping = tonumber(v[3])
                table.insert(players, 
                '<tr><td>'..id..'</td><td>'..name..'</td><td>'..ping..'<small>ms</small></td></tr>')
            else
                local id = tonumber(v[1])
                local name = v[2]
                table.insert(players, 
                '<tr><td>'..id..'</td><td>'..name..'</td></tr>'
                )
            end
        end
        SendNUIMessage({ text = table.concat(players),number = number })
    end
end)
