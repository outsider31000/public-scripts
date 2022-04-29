local driving = false
local keys = { ['O'] = 0xF1301666, ['G'] = 0x5415BE48 }
   
-- Create Wagon Wheel Map Marker

Citizen.CreateThread(function()
    for _, marker in pairs(Config.Marker) do
        local blip = N_0x554d9d53f696d002(1664425300, marker.x, marker.y, marker.z)
        SetBlipSprite(blip, marker.sprite, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, marker.name)

    end  
end)

-- Spawn Buy Stage Coach NPC Location Trigger
Citizen.CreateThread(function()
    for _, zone in pairs(Config.Marker) do
        TriggerEvent("parks_stagecoach:CreateNPC", zone)
    end
end)  

-- Generate Job Giver NPC's
RegisterNetEvent("parks_stagecoach:CreateNPC")
AddEventHandler("parks_stagecoach:CreateNPC", function (zone)

    if not DoesEntityExist(npc) then
    
        local model = GetHashKey( "S_M_M_TrainStationWorker_01" )
        local coord = GetEntityCoords(PlayerPedId())
        RequestModel( model )

        while not HasModelLoaded( model ) do
            Wait(500)
        end
                
        npc = CreatePed( model, zone.x, zone.y, zone.z, zone.h,  false, true)
        Citizen.InvokeNative(0x283978A15512B2FE , npc, true )
    end
end)

-- Get District Hash
function GetDistrictHash()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local district_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 10)
    if district_hash then
        local district_name = Config.Districts[district_hash].name
        return district_name
    else
        return ""
    end
end

-- Get Current Town Name, Some Towns missing
function GetCurentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("roanoke") then
        return "Roanoke Ridge"
    elseif town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    else
        return ""
    end
end

-- Successful Drop Off / Pay Fare

RegisterNetEvent("parks_stagecoach:successful_dropoff")
AddEventHandler("parks_stagecoach:successful_dropoff", function (fare, npc_id)
    while true do
        TriggerServerEvent("parks_stagecoach:pay_fare", fare)
        local fare_paid = true
        RemoveBlip(p1)
        ClearGpsMultiRoute()
        passenger_spawned = false
        TriggerEvent("parks_stagecoach:StartCoachJob", zone_name, spawn_coach, passenger_spawned)
        Wait(30000)
        DeleteEntity(npc_id)
        
        if fare_paid == true then
            break
        end
    end
end)

-- Unuccessful Drop Off / No Fare Payment

RegisterNetEvent("parks_stagecoach:unsuccessful_dropoff")
AddEventHandler("parks_stagecoach:unsuccessful_dropoff", function (fare, npc_id)
    while true do
        local fare_paid = true
        RemoveBlip(p1)
        ClearGpsMultiRoute()
        passenger_spawned = false
        TriggerEvent("parks_stagecoach:StartCoachJob", zone_name, spawn_coach, passenger_spawned)
        Wait(30000)
        DeleteEntity(npc_id)
        
        if fare_paid == true then
            break
        end
    end
end)

-- PassengerOnboard
RegisterNetEvent("parks_stagecoach:PassengerOnboard")
AddEventHandler("parks_stagecoach:PassengerOnboard", function (zone_name, route, spawn_coach, repair_active)
 
    RemoveBlip(p1)
    ClearGpsMultiRoute()

    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(Config.PickUp[zone_name][route].x + 5, Config.PickUp[zone_name][route].y + 5, Config.PickUp[zone_name][route].z)
    AddPointToGpsMultiRoute(Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z)
    SetGpsMultiRouteRender(true)

    p1 = N_0x554d9d53f696d002(1664425300, Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z)
    SetBlipSprite(p1, Config.Destination[zone_name][route].sprite, 5)
    SetBlipScale(p1, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, p1, Config.Destination[zone_name][route].name)
    passenger_onboard = true
    
    while true do
    Wait(10)   

        local coach_health = GetVehicleBodyHealth(spawn_coach);
        local coach_drivable = IsVehicleDriveable(spawn_coach);
        
        current = GetEntityCoords(passenger)
        distance = GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, current, false)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local disctrict_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,10)

        town_name = GetCurentTownName()
        district_hash = GetDistrictHash()
        
        fare_amount = (distance / 1609.34) * 50
        fare_amount = string.format("%.0f", fare_amount)
        fare_amount = tonumber(fare_amount)

        if GetDistanceBetweenCoords(Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z, GetEntityCoords(passenger),false)<5 and passenger_onboard ~= false then
            
            Wait(100)
            local spawn_coach = GetVehiclePedIsIn(PlayerPedId(),false)
            TaskLeaveVehicle(passenger, spawn_coach, 0)
            TaskGoToCoordAnyMeans(passenger, Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y +40, Config.Destination[zone_name][route].z, 1.0, 0, 0, 786603, 0xbf800000)
            npc_id = GetPedIndexFromEntityIndex(passenger)
            TriggerEvent("parks_stagecoach:successful_dropoff", fare_amount, npc_id)
            passenger_onboard = false
            
        end       

        if IsEntityDead(passenger) then
            TriggerEvent("parks_stagecoach:unsuccessful_dropoff", 0, npc_id)
            passenger_onboard = false
        end

        if GetVehicleBodyHealth(spawn_coach) == 0 or IsVehicleDriveable(spawn_coach) == false then
            local repair_active = false
            TriggerEvent("parks_stagecoach:replace_stagecoach", spawn_coach, repair_active)
            TaskLeaveVehicle(passenger, spawn_coach, 0)
            TriggerEvent("parks_stagecoach:unsuccessful_dropoff", 0, npc_id, spawn_coach)
        end
    
        if passenger_onboard == false then
            break
        end
    end

end)

-- StartCoachJob
RegisterNetEvent("parks_stagecoach:StartCoachJob")
AddEventHandler("parks_stagecoach:StartCoachJob", function(zone_name, spawn_coach)
    driving = true
    zone_name = GetDistrictHash()
    local passenger_despawned = true
    route = math.random(2)
    player_loc = GetEntityCoords(PlayerPedId())
    passenger_onboard = false
    
    -- Set GPS route positions

    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(player_loc)
    AddPointToGpsMultiRoute(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z)
    SetGpsMultiRouteRender(true)

    p1 = N_0x554d9d53f696d002(1664425300, Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z)
    SetBlipSprite(p1, Config.PickUp[zone_name][route].sprite, 1)
    SetBlipScale(p1, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, p1, Config.PickUp[zone_name][route].name)
    
    while (passenger_despawned == true) do
    Wait(10)

            if GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z,GetEntityCoords(PlayerPedId()),false)<500 and passenger_despawned == true then

                local model = GetHashKey(Config.PickUp[zone_name][route].model)
                
                RequestModel( model )

                    while not HasModelLoaded( model ) do
                        Wait(500)
                    end
            if not DoesEntityExist(passenger) then
                passenger = CreatePed(model, Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, Config.PickUp[zone_name][route].h, true, true)
                Citizen.InvokeNative( 0x283978A15512B2FE , passenger, true )
                passenger_despawned = false
                Wait(10)
            end
                
            end
        if passenger_despawned == false then
            break
        end
    end
    
    
    while (passenger_onboard == false) do
    Wait(10)
        
        if GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, GetEntityCoords(PlayerPedId()),false)<10 then
            
            spawn_coach = GetVehiclePedIsIn(PlayerPedId(),false)
            
            SetEntityAsMissionEntity(spawn_coach, false, false)
            SetEntityAsMissionEntity(passenger, false, false)
            
            npc_group = GetPedRelationshipGroupHash(passenger)
            SetRelationshipBetweenGroups(1 , GetHashKey("PLAYER") , npc_group)

            Wait(500)       
            TaskEnterVehicle(passenger, spawn_coach, -1, 1, 1.0, 1, 0)

            passenger_onboard = true
            RemoveBlip(p1)
            TriggerEvent("parks_stagecoach:PassengerOnboard", zone_name, route, spawn_coach)

        end

        if passenger_onboard == true then
            break
        end
    end
end)            

-- Destroy Cams
function EndStageCoachCam()
    ClearFocus()

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam_a, false)
    DestroyCam(cam_b, false)

    cam_a = nil
    cam_b = nil

end

-- Client Event for Wagon Spawn
RegisterNetEvent("parks_stagecoach:SpawnWagon")
AddEventHandler("parks_stagecoach:SpawnWagon", function (_model)
    
    DeleteVehicle(spawn_coach)
    RequestModel(_model)

    while not HasModelLoaded(_model) do
        Citizen.Wait(0)
    end

    zone_name = GetCurentTownName()
    district_name = GetDistrictHash()

    spawn_coach = CreateVehicle(_model, Config.StageCoachSpawn[zone_name].x, Config.StageCoachSpawn[zone_name].y, Config.StageCoachSpawn[zone_name].z, Config.StageCoachSpawn[zone_name].h, true, false)
    SetVehicleOnGroundProperly(spawn_coach)
    SetModelAsNoLongerNeeded(_model)
    
    local player = PlayerPedId()

    DoScreenFadeOut(500)

    cam_a = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
            SetCamCoord(cam_a,  Config.Cams[zone_name]["cam_a"].x, Config.Cams[zone_name]["cam_a"].y, Config.Cams[zone_name]["cam_a"].z)  
            SetCamRot(cam_a, 0.0, 0.0, Config.Cams[zone_name]["cam_a"].h,  true)

    cam_b = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
            SetCamCoord(cam_b,  Config.Cams[zone_name]["cam_b"].x, Config.Cams[zone_name]["cam_b"].y, Config.Cams[zone_name]["cam_b"].z)
            SetCamRot(cam_b, 0.0, 0.0, Config.Cams[zone_name]["cam_b"].h,  true)

    Wait(500)
    SetPedIntoVehicle(player, spawn_coach, -1)
    Wait(500)
    DoScreenFadeIn(500)

    SetCamActiveWithInterp(cam_a, cam_b, 2000, 1, 1)
    IsCinematicCamRendering(true)
    RenderScriptCams(1, 0, cam_a,  true,  true)
    Wait(3000)

    EndStageCoachCam()
    TriggerServerEvent("parks_stagecoach:StartCoachJobServer", zone_name, spawn_coach)

end)

-- Stop Driving Menu Event
RegisterNetEvent("parks_stagecoach:stop_driving")
AddEventHandler("parks_stagecoach:stop_driving", function (spawn_coach)
    
    local player = PlayerPedId()
    local spawn_coach = GetVehiclePedIsIn(PlayerPedId(),false)
    zone_name = GetDistrictHash()
    local coach_blip = GetBlipFromEntity(player)
    RemoveBlip(coach_blip)
    TaskLeaveVehicle(passenger, spawn_coach, 0)
    RemoveBlip(p1)
    ClearGpsMultiRoute()
    passenger_spawned = false
    driving = false
    TaskGoToCoordAnyMeans(passenger, Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y +40, Config.Destination[zone_name][route].z, 1.0, 0, 0, 786603, 0xbf800000)
    Wait(5000)
    DeleteEntity(passenger)
end)

-- Replace Wagon If Damaged
RegisterNetEvent("parks_stagecoach:replace_stagecoach")
AddEventHandler("parks_stagecoach:replace_stagecoach", function (spawn_coach, repair_active)
    local RepairCoachPrompt
    local repair

    function RepairCoach()
        Citizen.CreateThread(function()
            local str = 'Repair Stagecoach'
            RepairCoachPrompt = PromptRegisterBegin()
            PromptSetControlAction(RepairCoachPrompt, 0xDFF812F9)
            str = CreateVarString(10, 'LITERAL_STRING', str)
            PromptSetText(RepairCoachPrompt, str)
            PromptSetEnabled(RepairCoachPrompt, true)
            PromptSetVisible(RepairCoachPrompt, true)
            PromptSetHoldMode(RepairCoachPrompt, true)
            PromptSetGroup(RepairCoachPrompt, repair)
            PromptRegisterEnd(RepairCoachPrompt)
        end)
    end

    while true do
        Wait(10)
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawn_coach))<5 then
            if repair_active == false then
                RepairCoach()
                repair_active = true
            end
        
        elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(spawn_coach))>6 then
                if repair_active == true then
                    PromptDelete(RepairCoachPrompt)
                    repair_active = false
                end
        end

        if PromptHasHoldModeCompleted(RepairCoachPrompt) then
            local pos = GetEntityCoords(PlayerPedId())
            local pos_h = GetEntityHeading(PlayerPedId())
            
            -- THIS NEEDS TO BE CHANGED TO PLAYERS COACH MODEL AT TIME OF REPAIR

            local model = GetHashKey("WAGON06X")

            RequestModel( model )

            while not HasModelLoaded( model ) do
                Wait(500)
            end

            DeleteVehicle(spawn_coach)
            
            spawn_coach = CreateVehicle(model, pos.x + 3, pos.y + 3, pos.z + 3, pos_h, true, false)
            SetVehicleOnGroundProperly(spawn_coach)
            SetModelAsNoLongerNeeded(model)
            
            local player = PlayerPedId()
            DoScreenFadeOut(500)
            Wait(500)
            SetPedIntoVehicle(player, spawn_coach, -1)
            Wait(500)
            DoScreenFadeIn(500)

            TriggerEvent("parks_stagecoach:StartCoachJob", zone_name, spawn_coach)
        end 
    end
end)

-- COACHES ARRAY DATA
local Coaches = {
    
    {
        ['Text'] = "Basic Wagon - $0.",
        ['SubText'] = "",
        ['Desc'] = "It's free for a reason.",
        ['Param'] = {
            ['Name'] = "Borrowed Coach",
            ['Price'] = 0,
            ['Model'] = "WAGON06X"
        }
    },
    {
        ['Text'] = "Small Coach - $100",
        ['SubText'] = "",
        ['Desc'] = "It's got a roof and 2 seats.",
        ['Param'] = {
            ['Name'] = "Small Coach",
            ['Price'] = 100,
            ['Model'] = "COACH5"
        }
    },
    {
        ['Text'] = "Rough Davis Coach - $120.",
        ['SubText'] = "",
        ['Desc'] = "She's pretty tired looking.",
        ['Param'] = {
            ['Name'] = "Rough Davis Coach",
            ['Price'] = 120,
            ['Model'] = "STAGECOACH003X"
        }
    },
    {
        ['Text'] = "Large Rustic Wagon - $150.",
        ['SubText'] = "",
        ['Desc'] = "It has a cover and lots of space.",
        ['Param'] = {
            ['Name'] = "Large Rustic Wagon",
            ['Price'] = 150,
            ['Model'] = "WAGON02X"
        }
    },
    {
        ['Text'] = "Large Open Passenger Wagon - $450.",
        ['SubText'] = "",
        ['Desc'] = "It's free for a reason.",
        ['Param'] = {
            ['Name'] = "Large Open Passenger",
            ['Price'] = 450,
            ['Model'] = "WAGON03X"
        }
    },
    {
        ['Text'] = "Fancy Small Coach - $500",
        ['SubText'] = "",
        ['Desc'] = "The nicest small coach we sell.",
        ['Param'] = {
            ['Name'] = "Fancy Small Coach",
            ['Price'] = 500,
            ['Model'] = "COACH4"
        }
    },
        {
        ['Text'] = "Fancy Open Coach - $550.",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Name'] = "Fancy Open Coach",
            ['Price'] = 550,
            ['Model'] = "COACH6"
        }
    },
    {
        ['Text'] = "Boles Overland Medium Coach - $600.",
        ['SubText'] = "",
        ['Desc'] = "It's free for a reason.",
        ['Param'] = {
            ['Name'] = "STAGECOACH001X",
            ['Price'] = 600,
            ['Model'] = "STAGECOACH001X"
        }
    },
     {
        ['Text'] = "Davis Overland Large Coach - $600.",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Name'] = "Davis Overland",
            ['Price'] = 600,
            ['Model'] = "COACH2"
        }
    },
        {
        ['Text'] = "Davis Medium Coach - $625.",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Name'] = "Davis Medium",
            ['Price'] = 625,
            ['Model'] = "STAGECOACH002X"
        }
    },
    {
        ['Text'] = "Solid Roof Davis Medium Coach - $625.",
        ['SubText'] = "",
        ['Desc'] = "It's free for a reason.",
        ['Param'] = {
            ['Name'] = "Solid Roof Davis",
            ['Price'] = 625,
            ['Model'] = "STAGECOACH005X"
        }
    },
    {
        ['Text'] = "Fancy Medium Coach - $650.",
        ['SubText'] = "",
        ['Desc'] = "The nicest medium coach we sell.",
        ['Param'] = {
            ['Name'] = "Fancy Medium Coach",
            ['Price'] = 650,
            ['Model'] = "COACH3"
        }
    },
    {
        ['Text'] = "Large Davis Coach - $700.",
        ['SubText'] = "",
        ['Desc'] = "It's free for a reason.",
        ['Param'] = {
            ['Name'] = "Large Davis Coach",
            ['Price'] = 700,
            ['Model'] = "STAGECOACH006X"
        }
    },
    {
        ['Text'] = "Large Armoured Boles Coach - $1000.",
        ['SubText'] = "",
        ['Desc'] = "Noone is shooting out the windows.",
        ['Param'] = {
            ['Name'] = "Large Armoured Boles",
            ['Price'] = 1000,
            ['Model'] = "STAGECOACH004X"
        }
    },
   
}

-- Warmenu List of Coaches to Buy with Server Event Params, saves to DB
function OpenBuyStageCoachMenu()
    WarMenu.OpenMenu('Stagecoach')
end

Citizen.CreateThread( function()
    WarMenu.CreateMenu('Stagecoach', 'Stagecoach')
    repeat
        if WarMenu.IsMenuOpened('Stagecoach') then
            for i = 1, #Coaches do
                if WarMenu.Button(Coaches[i]['Text'], Coaches[i]['SubText'], Coaches[i]['Desc']) then
                    TriggerServerEvent('parks_stagecoach:buy_stagecoach', Coaches[i]['Param'])
                    Citizen.Wait(500)
                    WarMenu.CloseMenu()
                end
            end
            WarMenu.Display()
        end
        Citizen.Wait(0)
    until false
end)


function OpenStageCoachMenu()
    WarMenu.OpenMenu('Stagecoach_MainMenu')
end

-- Buy Stage Coach Prompt Menu

local StageCoachPrompt
local active = false
local group 

function StageCoach()
    Citizen.CreateThread(function()
        local str = 'Stage Coach Co.'
        StageCoachPrompt = PromptRegisterBegin()
        PromptSetControlAction(StageCoachPrompt, 0xDFF812F9)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(StageCoachPrompt, str)
        PromptSetEnabled(StageCoachPrompt, true)
        PromptSetVisible(StageCoachPrompt, true)
        PromptSetHoldMode(StageCoachPrompt, true)
        PromptSetGroup(StageCoachPrompt, group)
        PromptRegisterEnd(StageCoachPrompt)
    end)
end

-- Main Stage Coach Menu Prompt Location Trigger
Citizen.CreateThread(function()
    while true do
    Wait(10)
        for _, zone in pairs(Config.Marker) do
            if GetDistanceBetweenCoords(zone.x, zone.y, zone.z,GetEntityCoords(PlayerPedId()),false)<2 then
                if active == false then
                    StageCoach()
                    menu_trigger_loc = zone.name
                    active = true

                end
            elseif GetDistanceBetweenCoords(zone.x, zone.y, zone.z,GetEntityCoords(PlayerPedId()),false)>1.5 and zone.name == menu_trigger_loc then
                if active == true then
                    Wait(200)
                    PromptDelete(StageCoachPrompt)
                    active = false
                end
            end
        end
        if PromptHasHoldModeCompleted(StageCoachPrompt) then
                        OpenStageCoachMenu()
                        PromptDelete(StageCoachPrompt)
                        active = true
        end
    end
end)

-- Warmenu Stop Driving Options
Citizen.CreateThread(function()
    WarMenu.CreateMenu('DrivingStatus', 'Coach Menu')
    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened('DrivingStatus') then
            WarMenu.Display()
            if WarMenu.Button("Stop Driving") then
                TriggerEvent("parks_stagecoach:stop_driving")
                WarMenu.CloseMenu()
                Wait(600)
                WarMenu.Display()
            elseif WarMenu.Button("Exit") then
                WarMenu.CloseMenu()
                Wait(600)
                WarMenu.Display()
            end
        end

    end
end)

-- Warmenu Start Driving Options
Citizen.CreateThread(function()
    WarMenu.CreateMenu('DrivingStatusFalse', 'Coach Menu')
    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened('DrivingStatusFalse') then
            WarMenu.Display()
            if WarMenu.Button("Start Driving") then
                TriggerServerEvent("parks_stagecoach:StartCoachJobServer", zone_name, spawn_coach, true)
                WarMenu.CloseMenu()
                Wait(600)
                WarMenu.Display()
            elseif WarMenu.Button("Store Coach") then
                WarMenu.CloseMenu()
                Wait(600)
                DeleteEntity(spawn_coach)
                WarMenu.Display()
            elseif WarMenu.Button("Exit") then
                WarMenu.CloseMenu()
                Wait(600)
                WarMenu.Display()
            end
        end
    end
end)

-- Warmenu Main Menu 
Citizen.CreateThread(function(HasStagecoaches)
    WarMenu.CreateMenu('Stagecoach_MainMenu', 'Coach Menu')
        WarMenu.CreateSubMenu('Stagecoach', 'Stagecoach_MainMenu', 'Buy a Stage Coach')
        WarMenu.CreateSubMenu('ListStagecoaches', 'Stagecoach_MainMenu', 'Owned Stage Coaches')
        WarMenu.CreateSubMenu('Exit', 'Stagecoach_MainMenu', 'Exit Coach Menu')

    while true do
        Citizen.Wait(0)
        if WarMenu.IsMenuOpened('Stagecoach_MainMenu') then

            if WarMenu.MenuButton('Buy Coach', 'Stagecoach') then OpenBuyStageCoachMenu() end
            if WarMenu.MenuButton('Owned Coaches', 'ListStagecoaches') then TriggerServerEvent('parks_stagecoach:loadstagecoach') end
            if WarMenu.MenuButton('Exit', 'Exit') then WarMenu.CloseMenu() Wait(600) end

            WarMenu.Display()
        end
    end
end)

-- List Coaches Menu Event
local Stagecoaches = {}

function OpenListStageCoachMenu(HasStagecoaches)    
    WarMenu.OpenMenu('ListStagecoaches')
end

RegisterNetEvent("parks_stagecoach:LoadCoachesMenu")
AddEventHandler("parks_stagecoach:LoadCoachesMenu", function(result)
    Stagecoaches = result
    WarMenu.OpenMenu('ListStagecoaches')
end)

Citizen.CreateThread( function()
    WarMenu.CreateMenu('ListStagecoaches', 'Coaches')
    WarMenu.SetSubTitle('ListStagecoaches', 'Coach list')
    while true do 
        if WarMenu.IsMenuOpened('ListStagecoaches') then
            for k, v in pairs(Stagecoaches) do 
                if WarMenu.Button(v['name']) then
                    TriggerEvent('parks_stagecoach:SpawnWagon', v['stagecoach'])
                    WarMenu.CloseMenu()
                    Wait(600)
                    WarMenu.Display()
                end
            end
            WarMenu.Display()
        end
        Citizen.Wait(0)
    end
end) 

-- Warmenu Driving Status Menu Options Switch
function OpenDrivingStatusMenu()
    if driving == true then
        WarMenu.OpenMenu('DrivingStatus')
    else
        WarMenu.OpenMenu('DrivingStatusFalse')
    end    
end

-- Calculate Fare Amount
function CalculateFare(passenger_pickup_coords, player_onboard, invehicle, driver)
    Citizen.CreateThread( function()
        while true do
            Citizen.Wait(10)
            local invehicle = GetPlayersInVehicle()
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            
            if invehicle then
                current = GetEntityCoords(PlayerPedId())
                distance = GetDistanceBetweenCoords(passenger_pickup_coords.x, passenger_pickup_coords.y, passenger_pickup_coords.z, current, false)
                fare_amount = (distance / 1609.34) * 50
                fare_amount = string.format("%.0f", fare_amount)
                fare_amount = tonumber(fare_amount)
                Wait(100)
                TriggerServerEvent("parks_stagecoach:pay_fare", fare_amount)
                break
            elseif invehicle == nil then
                Citizen.Wait(1000)
                TriggerServerEvent("parks_stagecoach:pay_fare", fare_amount)
                break
            end
        end
    end)
end

-- Check if players are in vehicle
function GetPlayersInVehicle()
    local players = GetActivePlayers()
    local ply = PlayerPedId()
    local returnablePlayers = {}
    local playerVehicle = GetVehiclePedIsIn(ply, false)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local vehicle = GetVehiclePedIsIn(target, false)
            if playerVehicle ~= 0 and playerVehicle == vehicle then
                table.insert(returnablePlayers, value)
            end
        end
    end
    
    return returnablePlayers[1] 

end
    
-- Check For Button Press Menu Open / Is a Player in Vehicle
Citizen.CreateThread(function(fare_amount)
    
    local active = false
    local player = PlayerPedId()
    local get_player_passenger_coords = false
    fare_amount = 0
    
    while true do
        Citizen.Wait(10)
        
        vehicle = GetVehiclePedIsIn(player)
        driver = GetPedInVehicleSeat(vehicle, -1)

        if vehicle and driver == player then
            
            local invehicle = GetPlayersInVehicle()

            if invehicle and get_player_passenger_coords == false then
                passenger_pickup_coords = GetEntityCoords(PlayerPedId())
                player_onboard = true
                CalculateFare(passenger_pickup_coords, player_onboard, invehicle, driver)
                get_player_passenger_coords = true
            
            elseif invehicle == nil then
                player_onboard = false              
                get_player_passenger_coords = false
            end
        end

        if IsControlJustReleased(0, keys['O']) then
            OpenDrivingStatusMenu()
        end

    end
end)