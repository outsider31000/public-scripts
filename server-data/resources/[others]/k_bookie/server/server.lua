local VorpCore = {}
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local server_data = {
    [1] = nil,
    [2] = nil,
    ["players"] = Config.players,
    ["bookies"] = Config.bookies,
    ["bets"] = {
        [1] = 0,
        [2] = 0,
        ["pot"] = 0,
        ["players"] = {},
    },
    ["winner"] = false,
    ["host"] = false,
    ["source"] = false,
    ["test"] = "OK",
}

-- ROUND
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('k_bookie:setHost')
AddEventHandler('k_bookie:setHost', function(host)
    _source = source
    _host = host
    if _host == 1 then
        print(('Host == %s on id # %i'):format(host, _source)) -- Host found
        server_data['host'] = source
        server_data['source'] = source
        TriggerClientEvent('clientData',source, server_data)
    else
        print(('Host == %s on id # %i'):format(host, _source)) -- Not the host
        server_data['source'] = source
        TriggerClientEvent('clientData',source, server_data)
    end
end)

RegisterNetEvent('k_bookie:setBet')
AddEventHandler('k_bookie:setBet', function(bet)
    _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local currentMoney = Character.money
    if currentMoney > bet then
        TriggerClientEvent('clientPlaceBet',_source)
    else
        TriggerClientEvent('clientAlert',source,'not enough money')
    end

end)

-- sets a key in Data table on all clients
RegisterNetEvent('k_bookie:setKey')
AddEventHandler('k_bookie:setKey', function(key,value)
    _source = source
    _winner = tonumber(matchwinner)

    server_data[key] = value
    TriggerClientEvent('clientKey',-1, key,value)
end)

RegisterNetEvent('k_bookie:fightOver')
AddEventHandler('k_bookie:fightOver', function(matchwinner)
    _source = source
    _winner = tonumber(matchwinner)
    if server_data["host"] == _source then
        for k,v in pairs(server_data["bets"]["players"]) do

            if v.serverid ~= false then

                local _win = tonumber(_winner)
                local _amn = tonumber(v.amount)
                local _bets = tonumber(server_data["bets"][_win])
                local _pot = tonumber(server_data["bets"]["pot"])

                --- prints valid bets
                --print(_win, v.winner,_amn,_bets,_pot,v.serverid,v.playerid)

                if tonumber(v.winner) == _win then
                    local _perc = ( _amn / _bets ) * 100
                    local _win_amount = round((_perc * 1.00) * ( _pot / 100 ),2)
                    TriggerClientEvent('clientPayout',v.serverid, _win_amount, v.amount, v.winner)
                else
                    -- Lost Bet @TODO
                    TriggerClientEvent('clientLost',v.serverid, 0, v.amount, v.winner)
                end
            end
        end
    end
    TriggerClientEvent('respawnPlayers',_source)

end)

RegisterNetEvent('k_bookie:setSpawned')
AddEventHandler('k_bookie:setSpawned', function(spawned)
    _source = source
    TriggerClientEvent('clientSpawned',-1, spawned)
end)

RegisterNetEvent('k_bookie:setData')
AddEventHandler('k_bookie:setData', function(data)
    _source = source
    if server_data["host"] ~= false then
        server_data = data
    end
end)

RegisterNetEvent('k_bookie:getData')
AddEventHandler('k_bookie:getData', function()
    _source = source
    -- trigger on all connected clients.
    TriggerClientEvent('clientData',-1, server_data)
end)

RegisterNetEvent("k_bookie:addCash")
AddEventHandler("k_bookie:addCash",function(money)
    -- Add Money and or XP
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local _money = tonumber(money)
    Character.addCurrency(0,_money)
end)

RegisterNetEvent("k_bookie:removeCash")
AddEventHandler("k_bookie:removeCash",function(money)
    -- Add Money and or XP
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local _money = tonumber(money)
   
        --user.removeMoney(tonumber(_money))
        Character.removeCurrency(0,_money)
  
end)