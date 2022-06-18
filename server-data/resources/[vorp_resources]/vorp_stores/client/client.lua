------------------------------------------------------------------------------------------------------
-------------------------------------------- CLIENT --------------------------------------------------
local OpenStores
local CloseStores
local PlayerJob
local JobGrade
local PromptGroup = GetRandomIntInRange(0, 0xffffff)
local PromptGroup2 = GetRandomIntInRange(0, 0xffffff)
local isInMenu = false
MenuData = {}

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

---------------- BLIPS ---------------------
function AddBlip(Store)
    if Config.Stores[Store].blipAllowed then
        Config.Stores[Store].BlipHandle = N_0x554d9d53f696d002(1664425300, Config.Stores[Store].x,
            Config.Stores[Store].y, Config.Stores[Store].z)
        SetBlipSprite(Config.Stores[Store].BlipHandle, Config.Stores[Store].sprite, 1)
        SetBlipScale(Config.Stores[Store].BlipHandle, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, Config.Stores[Store].BlipHandle, Config.Stores[Store].BlipName)
    end
end

---------------- NPC ---------------------
function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(100)
    end
end

function SpawnNPC(Store)
    local v = Config.Stores[Store]
    LoadModel(v.NpcModel)
    if v.NpcAllowed then
        local npc = CreatePed(v.NpcModel, v.x, v.y, v.z, v.h, false, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)
        Wait(500)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        Config.Stores[Store].NPC = npc
    end
end

------------------ PROMPTS ------------------
function PromptSetUp()
    local str = _U("SubPrompt")
    OpenStores = PromptRegisterBegin()
    PromptSetControlAction(OpenStores, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(OpenStores, str)
    PromptSetEnabled(OpenStores, 1)
    PromptSetVisible(OpenStores, 1)
    PromptSetStandardMode(OpenStores, 1)
    PromptSetGroup(OpenStores, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, OpenStores, true)
    PromptRegisterEnd(OpenStores)
end

function PromptSetUp2()
    local str = _U("SubPrompt")
    CloseStores = PromptRegisterBegin()
    PromptSetControlAction(CloseStores, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(CloseStores, str)
    PromptSetEnabled(CloseStores, 1)
    PromptSetVisible(CloseStores, 1)
    PromptSetStandardMode(CloseStores, 1)
    PromptSetGroup(CloseStores, PromptGroup2)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, CloseStores, true)
    PromptRegisterEnd(CloseStores)

end

function CheckJob(table, element)
    for k, v in pairs(table) do
        if v == element then
            return true
        end
    end
    return false
end

------- STORES START ----------
Citizen.CreateThread(function()
    PromptSetUp()
    PromptSetUp2()

    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = true
        local dead = IsEntityDead(player)
        local hour = GetClockHours()

        if isInMenu == false and not dead then

            for storeId, storeConfig in pairs(Config.Stores) do
                if storeConfig.StoreHoursAllowed then
                    if hour >= storeConfig.StoreClose then
                        if Config.Stores[storeId].BlipHandle then
                            RemoveBlip(Config.Stores[storeId].BlipHandle)
                            Config.Stores[storeId].BlipHandle = nil
                        end
                        if Config.Stores[storeId].NPC then
                            DeleteEntity(Config.Stores[storeId].NPC)
                            DeletePed(Config.Stores[storeId].NPC)
                            SetEntityAsNoLongerNeeded(Config.Stores[storeId].NPC)
                            Config.Stores[storeId].NPC = nil
                        end
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                        local distance = #(coordsDist - coordsStore)

                        if (distance <= storeConfig.distanceOpenStore) then
                            sleep = false
                            local label2 = CreateVarString(10, 'LITERAL_STRING', _U("closed") .. storeConfig.StoreOpen .. _U("am") .. storeConfig.StoreClose .. _U("pm"))
                            PromptSetActiveGroupThisFrame(PromptGroup2, label2)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, CloseStores) then
                                Wait(100)
                                TriggerEvent("vorp:TipRight", _U("closed") .. storeConfig.StoreOpen .. _U("am") .. storeConfig.StoreClose .. _U("pm"), 3000)
                            end
                        end
                    elseif hour >= storeConfig.StoreOpen then
                        if not Config.Stores[storeId].BlipHandle and storeConfig.blipAllowed then
                            AddBlip(storeId)
                        end
                        if not Config.Stores[storeId].NPC and storeConfig.NpcAllowed then
                            SpawnNPC(storeId)
                        end
                        -- ## run this before distance check  no need to run a code that is no meant for the client ## --
                        if not next(storeConfig.AllowedJobs) then -- if jobs empty then everyone can use
                            local coordsDist = vector3(coords.x, coords.y, coords.z)
                            local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                            local distance = #(coordsDist - coordsStore)

                            if (distance <= storeConfig.distanceOpenStore) then -- check distance

                                sleep = false
                                local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)
                                PromptSetActiveGroupThisFrame(PromptGroup, label)

                                if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- iff all pass open menu
                                    OpenCategory(storeId)

                                    DisplayRadar(false)
                                    TaskStandStill(player, -1)
                                end

                            end

                        else -- job only

                            TriggerServerEvent("vorp_stores:getPlayerJob")

                            if CheckJob(storeConfig.AllowedJobs, PlayerJob) then
                                if tonumber(storeConfig.JobGrade) <= tonumber(JobGrade) then
                                    local distance = Vdist2(coords.x, coords.y, coords.z, storeConfig.x, storeConfig.y,
                                        storeConfig.z, true)

                                    if (distance <= storeConfig.distanceOpenStore) then
                                        sleep = false
                                        local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)

                                        PromptSetActiveGroupThisFrame(PromptGroup, label)
                                        if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then
                                            OpenCategory(storeId)

                                            DisplayRadar(false)
                                            TaskStandStill(player, -1)
                                        end
                                    end
                                end
                            end

                        end

                    end
                else
                    if not Config.Stores[storeId].BlipHandle and storeConfig.blipAllowed then
                        AddBlip(storeId)
                    end
                    if not Config.Stores[storeId].NPC and storeConfig.NpcAllowed then
                        SpawnNPC(storeId)
                    end
                    -- ## run this before distance check  no need to run a code that is no meant for the client ## --
                    if not next(storeConfig.AllowedJobs) then -- if jobs empty then everyone can use
                        local coordsDist = vector3(coords.x, coords.y, coords.z)
                        local coordsStore = vector3(storeConfig.x, storeConfig.y, storeConfig.z)
                        local distance = #(coordsDist - coordsStore)

                        if (distance <= storeConfig.distanceOpenStore) then -- check distance

                            sleep = false
                            local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)
                            PromptSetActiveGroupThisFrame(PromptGroup, label)

                            if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then -- iff all pass open menu
                                OpenCategory(storeId)

                                DisplayRadar(false)
                                TaskStandStill(player, -1)
                            end

                        end

                    else -- job only

                        TriggerServerEvent("vorp_stores:getPlayerJob")

                        if CheckJob(storeConfig.AllowedJobs, PlayerJob) then
                            if tonumber(storeConfig.JobGrade) <= tonumber(JobGrade) then
                                local distance = Vdist2(coords.x, coords.y, coords.z, storeConfig.x, storeConfig.y,
                                    storeConfig.z, true)

                                if (distance <= storeConfig.distanceOpenStore) then
                                    sleep = false
                                    local label = CreateVarString(10, 'LITERAL_STRING', storeConfig.PromptName)

                                    PromptSetActiveGroupThisFrame(PromptGroup, label)
                                    if Citizen.InvokeNative(0xC92AC953F0A982AE, OpenStores) then
                                        OpenCategory(storeId)

                                        DisplayRadar(false)
                                        TaskStandStill(player, -1)
                                    end
                                end
                            end
                        end

                    end
                end

            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

---- items category ------
function OpenCategory(storeId)
    MenuData.CloseAll()
    isInMenu = true

    local elements = {}

    for k, v in pairs(Config.Stores[storeId].category) do
        elements[#elements + 1] = {
            label = v,
            value = v,
            desc = _U("choose_category")
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId, {
        title = Config.Stores[storeId].storeName,
        subtext = _U("SubMenu"),
        align = Config.Align,
        elements = elements

    }, function(data, menu)
        OpenSubMenu(storeId, data.current.value)
    end, function(data, menu)
        menu.close()
        isInMenu = false
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)

end

-- sell only
function OpenSubMenu(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local elements = {}

    for k, v in pairs(Config.Stores[storeId].storeType) do
        elements[#elements + 1] = {
            label = v,
            value = v,
            desc = _U("chooseoption")
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title = Config.Stores[storeId].storeName,
        subtext = _U("SubMenu"),
        align = Config.Align,
        elements = elements,
        lastmenu = "OpenCategory"

    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        end

        if (data.current.value == "sell") then --translate here same as the config
            OpenSellMenu(storeId, category)

        end

        if (data.current.value == "buy") then --translate here same as the config
            OpenBuyMenu(storeId, category)
        end

    end, function(data, menu)
        menu.close()
        isInMenu = false
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)

end

-- sell
function OpenSellMenu(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local menuElements = {}
    local player = PlayerPedId()
    local storeConfig = Config.Stores[storeId]

    local elementIndex = 1

    for index, storeItem in ipairs(Config.SellItems[storeId]) do
        if storeItem.category == category then

            if storeItem.category == category then
                local ctp = ""
                if storeItem.currencyType == "gold" then
                    ctp = "#"
                else
                    ctp = "$"
                end
                menuElements[elementIndex] = {
                    itemHeight = "2vh",
                    label = "<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
                        storeItem.itemName .. ".png'><span style=margin-left:40px;font-size:25px;text-align:center;>" ..
                        storeItem.itemLabel .. "</span>",
                    value = "sell" .. tostring(elementIndex),
                    desc = "" ..
                        '<span style="font-family: crock; src:nui://menuapi/html/fonts/crock.ttf) format("truetype")</span>' ..
                        _U("sellfor") .. '<span style="margin-left:90px;">' .. '<span style="font-size:25px;">' .. ctp ..
                        '</span>' .. '<span style="font-size:30px;">' .. storeItem.sellprice ..
                        "</span><span style='color: Yellow;'>  " .. storeItem.currencyType .. "</span><br><br><br>" ..
                        storeItem.desc,
                    info = storeItem

                }

                elementIndex = elementIndex + 1
            end

        end

    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title = storeConfig.storeName,
        subtext = _U("sellmenu"),
        align = Config.Align,
        elements = menuElements,
        lastmenu = "OpenSubMenu"
    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        else

            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local sellPrice = data.current.info.sellprice

            local myInput = {
                type = "enableinput", -- dont touch
                inputType = "input",
                button = _U("confirm"), -- button name
                placeholder = _U("insertamount"), -- placeholdername
                style = "block", --- dont touch
                attributes = {
                    inputHeader = _U("amount"), -- header
                    type = "number", -- inputype text, number,date.etc if number comment out the pattern
                    pattern = "[0-9]", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                    title = _U("must"), -- if input doesnt match show this message
                    style = "border-radius: 10px; background-color: ; border:none;" -- style  the inptup
                }
            }
            if Config.Align == "center" then
                MenuData.CloseAll()
                ClearPedTasksImmediately(player)
                isInMenu = false
                DisplayRadar(true)
            end

            TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                local qty = tonumber(result)

                if qty ~= nil and qty ~= 0 and qty > 0 then

                    TriggerServerEvent("vorp_stores:sell", ItemLabel, ItemName, currencyType, sellPrice, qty) -- sell it

                else

                    TriggerEvent("vorp:TipRight", _U("insertamount"), 3000)

                end

            end)
        end
    end, function(data, menu)
        menu.close()
        ClearPedTasksImmediately(player)
        isInMenu = false
        DisplayRadar(true)
    end)

end

--- buy
function OpenBuyMenu(storeId, category)
    MenuData.CloseAll()
    isInMenu = true
    local menuElements = {}
    local player = PlayerPedId()
    local storeConfig = Config.Stores[storeId]

    local elementIndex = 1

    for index, storeItem in ipairs(Config.BuyItems[storeId]) do

        if storeItem.category == category then
            local ctp = ""
            if storeItem.currencyType == "gold" then
                ctp = "#"
            else
                ctp = "$"
            end

            menuElements[elementIndex] = {

                label = "<img style='max-height: 40px;max-width: 40px;float: left;text-align: center;margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
                    storeItem.itemName .. ".png'><span style=margin-left:40px;font-size:25px;text-align:center;>" ..
                    storeItem.itemLabel .. "</span>",
                value = "sell" .. tostring(elementIndex),
                desc = "" ..
                    '<span style="font-family: crock; src:nui://menuapi/html/fonts/crock.ttf) format("truetype")</span>' ..
                    _U("buyfor") .. '<span style="margin-left:90px;">' .. '<span style="font-size:25px;">' .. ctp ..
                    '</span>' .. '<span style="font-size:30px;">' .. storeItem.buyprice ..
                    "</span><span style='color:Yellow;'>  " .. storeItem.currencyType .. "</span><br><br><br>" ..
                    storeItem.desc,
                info = storeItem

            }

            elementIndex = elementIndex + 1

        end

    end

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi' .. storeId .. category, {
        title = storeConfig.storeName,
        subtext = "buy menu",
        align = Config.Align,
        elements = menuElements,
        lastmenu = "OpenSubMenu"

    }, function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger](storeId, category)
        else

            local ItemName = data.current.info.itemName
            local ItemLabel = data.current.info.itemLabel
            local currencyType = data.current.info.currencyType
            local buyPrice = data.current.info.buyprice

            local myInput = {
                type = "enableinput", -- dont touch
                inputType = "input",
                button = _U("confirm"), -- button name
                placeholder = _U("insertamount"), -- placeholdername
                style = "block", --- dont touch
                attributes = {
                    inputHeader = _U("amount"), -- header
                    type = "number", -- inputype text, number,date.etc if number comment out the pattern
                    pattern = "[0-9]", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                    title = _U("must"), -- if input doesnt match show this message
                    style = "border-radius: 10px; background-color: ; border:none;" -- style  the inptup
                }
            }
            if Config.Align == "center" then
                MenuData.CloseAll()
                ClearPedTasksImmediately(player)
                isInMenu = false
                DisplayRadar(true)
            end

            TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)

                local qty = tonumber(result)
                if qty ~= nil and qty ~= 0 and qty > 0 then

                    TriggerServerEvent("vorp_stores:buy", ItemLabel, ItemName, currencyType, buyPrice, qty) -- sell it
                else
                    TriggerEvent("vorp:TipRight", _U("insertamount"), 3000)
                end

            end)

        end
    end, function(data, menu)
        menu.close()
        ClearPedTasksImmediately(player)
        isInMenu = false
        DisplayRadar(true)
    end)

end

RegisterNetEvent("vorp_stores:sendPlayerJob")
AddEventHandler("vorp_stores:sendPlayerJob", function(Job, grade)
    PlayerJob = Job
    JobGrade = grade
end)

RegisterNetEvent("vorp_stores:RefreshStorePrices")
AddEventHandler("vorp_stores:RefreshStorePrices", function(SellItems, BuyItems)
    print("refresh")
    Config.SellItems = SellItems
    Config.BuyItems = BuyItems
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Wait(1000)
    TriggerServerEvent("vorp_stores:GetRefreshedPrices")
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if isInMenu == true then
        ClearPedTasksImmediately(PlayerPedId())
        PromptDelete(OpenStores)
        MenuData.CloseAll()
    end
    for i, v in pairs(Config.Stores) do
        if v.BlipHandle then
            RemoveBlip(v.BlipHandle)
        end
        if v.NPC then
            DeleteEntity(v.NPC)
            DeletePed(v.NPC)
            SetEntityAsNoLongerNeeded(v.NPC)
        end
    end
end)
