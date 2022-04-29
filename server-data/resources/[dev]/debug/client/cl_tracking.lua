local entitiesToDraw = {}
local itemsToDraw = {}
local vehiclesToDraw = {}

local trackPeds = true
local trackVehicles = true
local trackEntities = true

Citizen.CreateThread(function()
    -- Surrounding Info / Tracking
    while Config.EnableTracking do
        Citizen.Wait(1)

        if IsControlJustReleased(2, 0x446258B6) then -- PageUp
            trackPeds = not trackPeds
            trackVehicles = not trackVehicles
        end
        if IsControlJustReleased(2, 0x3C3DD371) then -- PageDown
            trackEntities = not trackEntities
        end

        if trackEntities then
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)

            -- World - Ground / Walls / Rocks
            -- Below Player
            local shapeTest = StartShapeTestRay(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z - 5.0, 1, 1)
            local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
            if hit > 0 then
                TxtAtWorldCoord(endCoords.x, endCoords.y, endCoords.z, "Standing On: " .. tostring(entityHit), 0.15, 9)
            end

            -- World - Ground / Walls / Rocks
            -- Infront of Player
            local coordsf = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.5, 0.0)
            local shapeTest = StartShapeTestRay(coords.x, coords.y, coords.z, coordsf.x, coordsf.y, coordsf.z, 1)
            local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
            if hit > 0 then
                TxtAtWorldCoord(endCoords.x, endCoords.y, endCoords.z, "1: " .. tostring(entityHit), 0.3, 9)
            end
        end

        DrawTrackedInfo()
    end
end)

-- local volumeArea = CreateVolumeBox(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, DrawDistance * 2, DrawDistance * 2, DrawDistance * 2)
-- local volumeArea = CreateVolumeCylinder(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, DrawDistance, DrawDistance, DrawDistance)
local volumeArea = Citizen.InvokeNative(0xB3FB80A32BAE3065, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, DrawDistance, DrawDistance, DrawDistance) -- _CREATE_VOLUME_SPHERE
-- Citizen.InvokeNative(0x43F867EF5C463A53, volumeArea) -- _DELETE_VOLUME
local itemSet = CreateItemset(1)
Citizen.CreateThread(function()
    -- Surrounding Info / Tracking
    while Config.EnableTracking do
        Wait(500)
        local player = PlayerPedId()
        entitiesToDraw = {}
        itemsToDraw = {}
        foliageToDraw = {}
        vehiclesToDraw = {}
        local coords = GetEntityCoords(player)
        if volumeArea then
            -- 0x541B8576615C33DE SET_VOLUME_COORDS
            -- 0xA07CF1B21B56F041 SET_VOLUME_ROTATION
            -- 0xA46E98BDC407E23D  SET_VOLUME_SIZE
            Citizen.InvokeNative(0x541B8576615C33DE, volumeArea, coords.x, coords.y, coords.z) -- SET_VOLUME_COORDS
            -- 1 Peds
            -- 2 Vehicles
            -- 3 Entities
            if trackPeds then
                local itemsFound = Citizen.InvokeNative(0x886171A12F400B89, volumeArea, itemSet, 1) -- Get volume items into itemset
                if itemsFound then
                    n = 0
                    while n < itemsFound do
                        entitiesToDraw[(GetIndexedItemInItemset(n, itemSet))] = true
                        n = n + 1
                    end
                end
                Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet) -- Empty Item Set
            end
            if trackVehicles then
                local itemsFound = Citizen.InvokeNative(0x886171A12F400B89, volumeArea, itemSet, 2) -- Get volume items into itemset
                if itemsFound then
                    n = 0
                    while n < itemsFound do
                        vehiclesToDraw[(GetIndexedItemInItemset(n, itemSet))] = true
                        n = n + 1
                    end
                end
                Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet) -- Empty Item Set
            end
            if trackEntities then
                local itemsFound = Citizen.InvokeNative(0x886171A12F400B89, volumeArea, itemSet, 3) -- Get volume items into itemset
                if itemsFound then
                    n = 0
                    while n < itemsFound do
                        itemsToDraw[(GetIndexedItemInItemset(n, itemSet))] = true
                        n = n + 1
                    end
                end
                Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet) -- Empty Item Set
            end
        end

    end
end)

function DrawTrackedInfo()
    if trackPeds then
        for entity, active in pairs(entitiesToDraw) do
            if not DoesEntityExist(entity) then
                active = false
            end
            if active and IsEntityOnScreen(entity) then
                DrawEntityInfo(entity)
            end
        end
    end

    if trackEntities then
        for entity, active in pairs(itemsToDraw) do
            if not DoesEntityExist(entity) then
                active = false
            end
            if active and IsEntityOnScreen(entity) then
                DrawItemInfo(entity)
            end
        end
    end

    if trackVehicles then
        for entity, active in pairs(vehiclesToDraw) do
            if not DoesEntityExist(entity) then
                active = false
            end
            if active and IsEntityOnScreen(entity) then
                DrawVehicleInfo(entity)
            end
        end
    end
end
