local car

local keys = {
    ["LEFT"] = 0xA65EBAB4,
    ["RIGHT"] = 0xDEB34313,
}
RegisterNetEvent('syn_cannon:spawncannon')
AddEventHandler('syn_cannon:spawncannon', function(type)
    if type == 1 then 
        local ped = PlayerPedId()
        local car_start = GetEntityCoords(ped)
        local car_name = "breach_cannon"
        local carHash = GetHashKey(car_name)
        RequestModel(carHash)

        while not HasModelLoaded(carHash) do
            Citizen.Wait(0)
        end
        car = CreateVehicle(carHash, car_start.x + 1, car_start.y + 1, car_start.z, GetEntityHeading(PlayerPedId()), true, false)
        SetVehicleOnGroundProperly(car)
        Wait(200)
        SetModelAsNoLongerNeeded(carHash) 

    elseif type == 2 then
        local ped = PlayerPedId()
        local car_start = GetEntityCoords(ped)
        local car_name = "hotchkiss_cannon"
        local carHash = GetHashKey(car_name)
        RequestModel(carHash)

        while not HasModelLoaded(carHash) do
            Citizen.Wait(0)
        end

        car = CreateVehicle(carHash, car_start.x + 1, car_start.y + 1, car_start.z, GetEntityHeading(PlayerPedId()), true, false)
        SetVehicleOnGroundProperly(car)
        Wait(200)
        SetModelAsNoLongerNeeded(carHash) 
    elseif type == 3 then
        print("test")
        local ped = PlayerPedId()
        local car_start = GetEntityCoords(ped)
        local car_name = "gatling_gun"
        local carHash = GetHashKey(car_name)
        RequestModel(carHash)

        while not HasModelLoaded(carHash) do
            Citizen.Wait(0)
        end

        car = CreateVehicle(carHash, car_start.x + 1, car_start.y + 1, car_start.z, GetEntityHeading(PlayerPedId()), true, false)
        SetVehicleOnGroundProperly(car)
        Wait(200)
        SetModelAsNoLongerNeeded(carHash) 
    elseif type == 4 then
        local ped = PlayerPedId()
        local car_start = GetEntityCoords(ped)
        local car_name = "gatlingMaxim02"
        local carHash = GetHashKey(car_name)
        RequestModel(carHash)

        while not HasModelLoaded(carHash) do
            Citizen.Wait(0)
        end

        car = CreateVehicle(carHash, car_start.x + 1, car_start.y + 1, car_start.z, GetEntityHeading(PlayerPedId()), true, false)
        SetVehicleOnGroundProperly(car)
        Wait(200)
        SetModelAsNoLongerNeeded(carHash) 

    end
end)




RegisterNetEvent('syn_cannon:rotate')
AddEventHandler('syn_cannon:rotate', function(rotation)
    if car ~= nil then 
        local pedRot = GetEntityHeading(car) + rotation
        SetEntityHeading(car, pedRot % 360)
    end

end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(10)
        if car ~= nil then 
            if whenKeyJustPressed(keys["LEFT"]) then
                local pedRot = GetEntityHeading(car) + 1
                SetEntityHeading(car, pedRot % 360)
            end
            if whenKeyJustPressed(keys["RIGHT"]) then
                local pedRot = GetEntityHeading(car) -1
                SetEntityHeading(car, pedRot % 360)
            end
        end
    end
end)