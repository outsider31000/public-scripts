-- Made by Blue 
local online = {}

keys = {
    -- Letter E
    ["Z"] = 0x26E9DC00,
}

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

local keyopen = false

Citizen.CreateThread( function()
    WarMenu.CreateMenu('players', 'Online players')
	while true do

        if WarMenu.IsMenuOpened('players') then
        
            for i = 1, #online do
                if WarMenu.Button("ID: "..online[i].no.."//  "..online[i].name.."  // PING: ".. online[i].pong) then
                end
            end

        end
        WarMenu.Display()
		Citizen.Wait(0)
	end
end)

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end

    return players
end


Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(0)
        if whenKeyJustPressed(keys["Z"]) then
            TriggerServerEvent("syn:players", GetPlayers())
            Citizen.Wait(200)
            WarMenu.OpenMenu('players')
        end  
    end
end) 

RegisterNetEvent("syn:paylerlist")
AddEventHandler("syn:paylerlist", function(players)
    online = players
end)
