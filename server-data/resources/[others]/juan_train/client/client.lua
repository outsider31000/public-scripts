local TRAIN_HASHES = {
--    -1719006020 -- PASSENGER AND CARGO TRAIN [Carts - 10] -- [This one is pretty fast too]
    987516329 -- SMALLER PASSENGER TRAIN - [Carts - 6]
}

CURRENT_TRAIN = nil

local stops = {
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -142.67,  ["y"] = 654.18,   ["z"] = 113.52, ["time"] = 120000, ["name"] = "Valentine Station"},
    {["dst"] = 400.0, ["dst2"] = 4.0, ["x"] = 2685.39,  ["y"] = -1480.33, ["z"] = 45.80,  ["time"] = 120000, ["name"] = "Saint Denis Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = 1197.48,  ["y"] = -1282.29, ["z"] = 76.45,  ["time"] = 120000, ["name"] = "Rhodes Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = -379.38,  ["y"] = -369.51,  ["z"] = 86.44,  ["time"] = 120000, ["name"] = "Flatneck Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -1118.27, ["y"] = -567.17,  ["z"] = 82.67,  ["time"] = 120000, ["name"] = "Riggs Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -1291.04, ["y"] = 440.69,   ["z"] = 94.36,  ["time"] = 120000, ["name"] = "Wallace Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = 610.54,   ["y"] = 1661.53,  ["z"] = 188.0,  ["time"] = 120000, ["name"] = "Bacchus Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = 2914.50,  ["y"] = 1238.53,  ["z"] = 44.73,  ["time"] = 120000, ["name"] = "Annesburg Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = 2879.30,  ["y"] = 592.75,   ["z"] = 57.84,  ["time"] = 120000, ["name"] = "Van Horn Tradin Post"}
} 




local trainspawned = false

Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(1000)
        local game = NetworkIsGameInProgress()
        if game == 1 then
            TriggerServerEvent('train:playerActivated')
            return
        end
    end
end)

RegisterNetEvent('Trainroute')
AddEventHandler('Trainroute', function(n)
    DeleteAllTrains()
    SetRandomTrains(false) 

        --this is requestmodel--
    local n = math.random(#TRAIN_HASHES)
    local trainHash = TRAIN_HASHES[n]
    local trainWagons = N_0x635423d55ca84fc8(trainHash)
    for wagonIndex = 0, trainWagons - 1 do
        local trainWagonModel = N_0x8df5f6a19f99f0d5(trainHash, wagonIndex)
        while not HasModelLoaded(trainWagonModel) do
            Citizen.InvokeNative(0xFA28FE3A6246FC30,trainWagonModel,1)
            Citizen.Wait(100)
        end
    end
    --spawn--
    local ped = PlayerPedId()
    local train = N_0xc239dbd9a57d2a71(trainHash, 48.70, 16.49, 102.56, 0, 1, 1, 1)
    local coords = GetEntityCoords(train)
    local trainV = vector3(coords.x, coords.y, coords.z)
    --Citizen.InvokeNative(0xBA8818212633500A, train, 0, 1) -- this makes the train undrivable for players
         
    --blip--
    local blipname = "Train"
    local bliphash = -399496385
    local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- BLIPADDFORENTITY
    SetBlipScale(blip, 1.5)
    --Citizen.InvokeNative(0x9CB1A1623062F402, blip, blipname) -- SetBlipNameFromPlayerString
    trainspawned = true
    CURRENT_TRAIN = train
    trainroute()
end)


function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end

    return players
end

function trainroute()
    while trainspawned == true do --this is the loop for the train to stop at stations
        for i = 1, #stops do
            local coords = GetEntityCoords(CURRENT_TRAIN)
            local trainV = vector3(coords.x, coords.y, coords.z)
            local distance = #(vector3(stops[i]["x"], stops[i]["y"], stops[i]["z"]) - trainV)
    
            --speed--
            local stopspeed = 0.0
            local cruisespeed = 5.0
            local fullspeed = 15.0
            if distance < stops[i]["dst"] then
                SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
                Wait(200)
                if distance < stops[i]["dst2"] then
                    SetTrainCruiseSpeed(CURRENT_TRAIN, stopspeed)
                    Wait(stops[i]["time"])
                    SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
                    Wait(10000)
                end
            elseif distance > stops[i]["dst"] then
                SetTrainCruiseSpeed(CURRENT_TRAIN, fullspeed)
                Wait(25)
            end
        end
    end
end
