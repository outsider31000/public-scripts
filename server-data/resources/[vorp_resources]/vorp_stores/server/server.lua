--------------------------------------------------------------------------------------------------------------
--------------------------------------------- SERVER SIDE ----------------------------------------------------
local VORPcore = {}
local VORPinv

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VORPinv = exports.vorp_inventory:vorp_inventoryApi()

--------------------------------------------------------------------------------------------------------------
--------------------------------------------- SELL -----------------------------------------------------------

RegisterServerEvent('vorp_stores:sell')
AddEventHandler('vorp_stores:sell', function(label, name, type, price, qty)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local ItemName = name
    local ItemPrice = price
    local ItemLabel = label
    local currencyType = type
    local count = VORPinv.getItemCount(_source, ItemName)
    local quantity = qty
    local total = ItemPrice * quantity

    if count >= quantity then
        if currencyType == "cash" then
            VORPinv.subItem(_source, ItemName, quantity)
            Character.addCurrency(0, total)
            TriggerClientEvent("vorp:TipRight", _source, _U("yousold") .. quantity .. "" .. ItemLabel .. _U("fr") .. total .. _U("ofcash"), 3000)
        end

        if currencyType == "gold" then

            VORPinv.subItem(_source, ItemName, quantity)
            Character.addCurrency(1, total)
            TriggerClientEvent("vorp:TipRight", _source, _U("yousold") .. quantity .. "" .. ItemLabel .. _U("fr") .. total .. _U("ofgold"), 3000)
        end
    else
        TriggerClientEvent("vorp:TipRight", _source, _U("youdontsell"), 3000)
    end
end)

------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- BUY ---------------------------------------------------------------------

RegisterServerEvent('vorp_stores:buy')
AddEventHandler('vorp_stores:buy', function(label, name, type, price, qty)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local money = Character.money
    local gold = Character.gold
    local ItemName = name
    local ItemPrice = price
    local ItemLabel = label
    local currencyType = type
    local quantity = qty
    local total = ItemPrice * quantity

    TriggerEvent("vorpCore:canCarryItems", tonumber(_source), quantity, function(canCarry) -- chek inv space
        TriggerEvent("vorpCore:canCarryItem", tonumber(_source), ItemName, quantity,
            function(canCarry2) -- check item count
                if canCarry and canCarry2 then

                    if money >= total then
                        if currencyType == "cash" then

                            VORPinv.addItem(_source, ItemName, quantity)
                            Character.removeCurrency(0, total)

                            TriggerClientEvent("vorp:TipRight", _source, _U("youbought") .. quantity .. " " .. ItemLabel .. _U("fr") .. total .. _U("ofcash"),
                                3000)

                        end
                    else
                        TriggerClientEvent("vorp:TipRight", _source, _U("youdontcash"), 3000)
                    end

                    if gold >= total then
                        if currencyType == "gold" then
                            if gold >= ItemPrice then

                                VORPinv.addItem(_source, ItemName, quantity)
                                Character.removeCurrency(1, total)
                                TriggerClientEvent("vorp:TipRight", _source, _U("youbought") .. quantity .. "" .. ItemLabel .. _U("fr") .. total .. _U("ofgold"),
                                    3000)

                            else
                                TriggerClientEvent("vorp:TipRight", _source, _U("youdontgold"), 3000)
                            end

                        end
                    end

                else
                    TriggerClientEvent("vorp:TipRight", _source, _U("cantcarry"), 3000)
                end
            end)
    end)

end)

-------------------- GetJOB --------------------
RegisterServerEvent('vorp_stores:getPlayerJob')
AddEventHandler('vorp_stores:getPlayerJob', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local CharacterJob = Character.job
    local CharacterGrade = Character.jobGrade

    TriggerClientEvent('vorp_stores:sendPlayerJob', _source, CharacterJob, CharacterGrade)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for storeId, storeConfig in pairs(Config.Stores) do
        if storeConfig.RandomPrices then
            for index, storeItem in ipairs(Config.SellItems[storeId]) do
                Config.SellItems[storeId][index].sellprice = storeItem.randomprice

            end
            for index, storeItem in ipairs(Config.BuyItems[storeId]) do
                Config.BuyItems[storeId][index].buyprice = storeItem.randomprice
            end
        end
    end
end)

RegisterServerEvent('vorp_stores:GetRefreshedPrices')
AddEventHandler('vorp_stores:GetRefreshedPrices', function()
    local _source = source
    TriggerClientEvent('vorp_stores:RefreshStorePrices', _source, Config.SellItems, Config.BuyItems)
end)
