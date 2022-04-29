local Models = {}
local Zones = {}

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    TriggerServerEvent("target:checkjob")
end)

RegisterNetEvent("target:jobchecked")
AddEventHandler("target:jobchecked", function(job)
    if job ~= nil then
        PlayerJob = job
    end
end)

Citizen.CreateThread(function()
    Wait(500)
    TriggerServerEvent("target:checkjob")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, Config.Keys["LALT"]) then
            --TriggerServerEvent("target:checkjob")
            SendNUIMessage({response = "openTarget"})
            local plyCoords = GetEntityCoords(PlayerPedId())
            local hit, coords, entity = RayCastGamePlayCamera(20.0)

            if hit == 1 then
                if GetEntityType(entity) ~= 0 then
                    for _,model in pairs(Models) do
                        if _ == GetEntityModel(entity) then
                            for k,v in ipairs(Models[_]["job"]) do
                                print(Models[_]["job"])
                                if (v == PlayerJob or v == "all") then
                                    if _ == GetEntityModel(entity) then
                                        if #(plyCoords - coords) <= Models[_]["distance"] then

                                            success = true

                                            SendNUIMessage({response = "validTarget", data = Models[_]["options"]})

                                            while success and targetActive do
                                                local plyCoords = GetEntityCoords(GetPlayerPed(-1))
                                                local hit, coords, entity = RayCastGamePlayCamera(20.0)

                                                DisablePlayerFiring(PlayerPedId(), true)

                                                if IsControlJustReleased(0, Config.Keys["LALT"]) then
                                                    SetNuiFocus(true, true)
                                                    SetCursorLocation(0.5, 0.5)
                                                end

                                                if GetEntityType(entity) == 0 or #(plyCoords - coords) > Models[_]["distance"] then
                                                    success = false
                                                end

                                                Citizen.Wait(1)
                                            end
                                            SendNUIMessage({response = "leftTarget"})
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                for _, zone in pairs(Zones) do
                    if Zones[_]:isPointInside(coords) then
                        for k,v in ipairs(Zones[_]["targetoptions"]["job"]) do
                            if v == PlayerJob or v == "all" then
                                if #(plyCoords - Zones[_].center) <= zone["targetoptions"]["distance"] then

                                    success = true

                                    SendNUIMessage({response = "validTarget", data = Zones[_]["targetoptions"]["options"]})
                                    while success do
                                        local plyCoords = GetEntityCoords(PlayerPedId())
                                        local hit, coords, entity = RayCastGamePlayCamera(20.0)

                                        DisablePlayerFiring(PlayerPedId(), true)

                                        if IsControlJustReleased(0, Config.Keys["LALT"]) then
                                            SetNuiFocus(true, true)
                                            SetCursorLocation(0.5, 0.5)
                                        elseif not Zones[_]:isPointInside(coords) or #(vector3(Zones[_].center.x, Zones[_].center.y, Zones[_].center.z) - plyCoords) > zone.targetoptions.distance then
                                        end
            
                                        if not Zones[_]:isPointInside(coords) or #(plyCoords - Zones[_].center) > zone.targetoptions.distance then
                                            success = false
                                        end
            

                                        Citizen.Wait(1)
                                    end
                                    SendNUIMessage({response = "leftTarget"})
                                end
                            end
                        end
                    end
                end
            end
            Citizen.Wait(250)
        else
            SendNUIMessage({response = "closeTarget"})
        end
    end
end)

--NUI CALL BACKS

RegisterNUICallback('selectTarget', function(data, cb)
    SetNuiFocus(false, false)
    TriggerEvent(data.event)
end)

RegisterNUICallback('closeTarget', function(data, cb)
    SetNuiFocus(false, false)
end)

--Functions from https://forum.cfx.re/t/get-camera-coordinates/183555/14

function RotationToDirection(rotation)
    local adjustedRotation =
    {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction =
    {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local destination =
    {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
    return b, c, e
end

--Exports

function AddCircleZone(name, center, radius, options, targetoptions)
    Zones[name] = CircleZone:Create(center, radius, options)
    Zones[name].targetoptions = targetoptions
end

function AddBoxZone(name, center, length, width, options, targetoptions)
    Zones[name] = BoxZone:Create(center, length, width, options)
    Zones[name].targetoptions = targetoptions
end

function AddPolyzone(name, points, options, targetoptions)
    Zones[name] = PolyZone:Create(points, options)
    Zones[name].targetoptions = targetoptions
end

function AddTargetModel(models, parameteres)
    for _, model in pairs(models) do
        Models[model] = parameteres
    end
end

exports("AddCircleZone", AddCircleZone)

exports("AddBoxZone", AddBoxZone)

exports("AddPolyzone", AddPolyzone)

exports("AddTargetModel", AddTargetModel)