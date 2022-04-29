BathingSessions = {}

RegisterServerEvent("rdr-bathing:canEnterBath")
AddEventHandler("rdr-bathing:canEnterBath", function(town)
    local _source = source
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local currentMoney = user.money

        if not BathingSessions[town] then
            if currentMoney >= Globals.Price then
              TriggerEvent("vorp:removeMoney", _source, 0, 1.00)
                BathingSessions[town] = _source
                TriggerClientEvent("rdr-bathing:StartBath", _source, town)
            else
                print("NOTIFICATION HERE")
            end
        else
            print("NOTIFICATION HERE")
        end

    end)
end)


RegisterServerEvent("rdr-bathing:canEnterDeluxeBath")
AddEventHandler("rdr-bathing:canEnterDeluxeBath", function(p1 , p2 , p3)
    local _source = source
    if BathingSessions[p2] == _source then

        TriggerEvent("vorp:getCharacter", _source, function(user)
            local currentMoney = user.money
              TriggerEvent("vorp:removeMoney", _source, 0, 5.00)
            if currentMoney >= Globals.Deluxe then
               
                TriggerClientEvent("rdr-bathing:StartDeluxeBath", _source , p1 , p2 , p3)
            else
                print("NOTIFICATION HERE")
				TriggerClientEvent("rdr-bathing:HideDeluxePrompt", _source)
            end


        end)
    end

end)


RegisterServerEvent("rdr-bathing:setBathAsFree")
AddEventHandler("rdr-bathing:setBathAsFree", function(town)
    if BathingSessions[town] == source then
        BathingSessions[town] = nil
    end
end)

AddEventHandler('playerDropped', function()
    for town,player in pairs(BathingSessions) do
        if player == source then
            BathingSessions[town] = nil
        end
    end
end)


