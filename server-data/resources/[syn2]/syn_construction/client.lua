
local blips = {}
local jobpeds = {}
local inmenu = false
local spot 
local trustlevel 
local prop
local missionblip 
local missionstarted = false
local level
local proploc = {}
local constloc = {}
local pickup = false
local totaltasks
local tasksdone = 0
local quality
local taskloc = {}
local attached = false
local reward

RegisterNetEvent("syn_construction:closemenu")
AddEventHandler("syn_construction:closemenu", function()
    inmenu = false
end)

RegisterNetEvent("syn_construction:gettrustclient")
AddEventHandler("syn_construction:gettrustclient", function(trust)
    trustlevel = trust
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if attached then 
            local player = PlayerPedId()
            if IsPedRunning(player) or IsPedJumping(player) or IsControlJustReleased(0, Config.keys["E"]) or IsControlJustReleased(0, Config.keys["Q"])  then
                Wait(1000) 
                attached = false
                DetachEntity(prop,false,true)
                ClearPedTasks(player)
                DeleteObject(prop)
                TriggerEvent("syn_construction:resettask2")
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                if quality > 10 then 
                    quality = quality - 10
                    TriggerEvent("vorp:TipBottom", Config.Language.messedup, 4000)
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if missionstarted then
            local player = PlayerPedId()
            local coords = GetEntityCoords(player) 
            if level == 1 then 
                if not pickup and totaltasks ~= tasksdone then 
                    if GetDistanceBetweenCoords(coords, proploc.x, proploc.y, proploc.z, true) < 5  then
                        DrawText3D(proploc.x, proploc.y, proploc.z, Config.Language.pressgtopickup)
                        if IsControlJustReleased(0, Config.keys["G"]) then
                            pickup = true
                            local props = CreateObject(GetHashKey("p_woodplank04x"), coords.x, coords.y, coords.z, 1, 0, 1)
                            prop = props
                            SetEntityAsMissionEntity(prop,true,true)
                            RequestAnimDict("mech_carry_box")
                            while not HasAnimDictLoaded("mech_carry_box") do
                                Citizen.Wait(100)
                            end
                            Citizen.InvokeNative(0xEA47FE3719165B94, player,"mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0, 0, 0, 0)
                            Citizen.InvokeNative(0x6B9BBD38AB0796DF, prop,player,GetEntityBoneIndexByName(player,"SKEL_R_Finger12"), 0.20, 0.028, -0.15, 100.0, 205.0, 20.0, true, true, false, true, 1, true)
                            attached = true 
                            RemoveBlip(missionblip)
                            ClearGpsCustomRoute()
                            SetGpsCustomRouteRender(false, 16, 16)
                            TriggerEvent("syn_construction:setnexttask")
                            Wait(500)
                        end
                    end
                elseif pickup then 
                    if GetDistanceBetweenCoords(coords, taskloc.x, taskloc.y, taskloc.z, true) < 2  then
                        DrawText3D(taskloc.x, taskloc.y, taskloc.z, Config.Language.startconst)
                        if IsControlJustReleased(0, Config.keys["G"]) then
                            if attached then 
                                attached = false
                                DetachEntity(prop,false,true)
                                ClearPedTasks(player)
                                DeleteObject(prop)
                            end
                            Wait(500)
                            TaskStartScenarioInPlace(player, GetHashKey(taskloc.wa), 30000, true, false, false, false)
                            local testplayer = exports["syn_minigame"]:taskBar(4000,7)
                            local testplayer2
                            local testplayer3
                            local testplayer4
                            Wait(1000)
                            if testplayer == 100 then
                                testplayer2 = exports["syn_minigame"]:taskBar(3500,7)
                            end
                            Wait(1000)
                            if testplayer2 == 100 then
                                testplayer3 = exports["syn_minigame"]:taskBar(3200,7)
                            end
                            Wait(1000)
                            if testplayer3 == 100 then
                                testplayer4 = exports["syn_minigame"]:taskBar(2900,7)
                            end
                            if testplayer4 == 100 then 
                                tasksdone = tasksdone + 1
                                pickup = false
                                RemoveBlip(missionblip)
                                ClearGpsCustomRoute()
                                SetGpsCustomRouteRender(false, 16, 16)
                                if totaltasks ~= tasksdone then 
                                    TriggerEvent("syn_construction:resettask")
                                else
                                    TriggerEvent("vorp:TipBottom", Config.Language.finishedtasks, 4000)
                                end
                                ClearPedTasks(player)
                                Citizen.InvokeNative(0xFCCC886EDE3C63EC,PlayerPedId(),false,true)
                            else
                                if quality > 10 then 
                                    quality = quality - 10
                                    TriggerEvent("vorp:TipBottom", Config.Language.messedup, 4000)
                                end
                                ClearPedTasks(player)
                                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                                Citizen.InvokeNative(0xFCCC886EDE3C63EC,PlayerPedId(),false,true)
                            end
                            Wait(500)
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("syn_construction:resettask2")
AddEventHandler("syn_construction:resettask2", function()
    TriggerEvent("vorp:TipBottom", Config.Language.marked, 4000)
    pickup = false
    RemoveBlip(missionblip)
    ClearGpsCustomRoute()
    SetGpsCustomRouteRender(false, 16, 16)
    missionblip = N_0x554d9d53f696d002(1664425300, proploc.x, proploc.y, proploc.z)
    SetBlipSprite(missionblip, -924533810, 1)
    SetBlipScale(missionblip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, missionblip,Config.Language.pickup)
    Citizen.InvokeNative(0x662D364ABF16DE2F,missionblip,0x6F85C3CE) -- red color blip
    ClearGpsCustomRoute()
    StartGpsMultiRoute(0, true, true)
    AddPointToGpsMultiRoute(proploc.x, proploc.y, proploc.z)
    SetGpsCustomRouteRender(true, 8, 8)
end)

RegisterNetEvent("syn_construction:resettask")
AddEventHandler("syn_construction:resettask", function()
    TriggerEvent("vorp:TipBottom", Config.Language.marked, 4000)
    missionblip = N_0x554d9d53f696d002(1664425300, proploc.x, proploc.y, proploc.z)
    SetBlipSprite(missionblip, -924533810, 1)
    SetBlipScale(missionblip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, missionblip,Config.Language.pickup)
    Citizen.InvokeNative(0x662D364ABF16DE2F,missionblip,0x6F85C3CE) -- red color blip
    ClearGpsCustomRoute()
    StartGpsMultiRoute(0, true, true)
    AddPointToGpsMultiRoute(proploc.x, proploc.y, proploc.z)
    SetGpsCustomRouteRender(true, 8, 8)
end)

RegisterNetEvent("syn_construction:setnexttask")
AddEventHandler("syn_construction:setnexttask", function()
    taskloc = constloc[tasksdone+1]
    TriggerEvent("vorp:TipBottom", Config.Language.marked, 4000)
    missionblip = N_0x554d9d53f696d002(1664425300, taskloc.x, taskloc.y, taskloc.z)
    SetBlipSprite(missionblip, -924533810, 1)
    SetBlipScale(missionblip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, missionblip,Config.Language.dosomework)
    Citizen.InvokeNative(0x662D364ABF16DE2F,missionblip,0x6F85C3CE) -- red color blip
    ClearGpsCustomRoute()
    StartGpsMultiRoute(0, true, true)
    AddPointToGpsMultiRoute(taskloc.x, taskloc.y, taskloc.z)
    SetGpsCustomRouteRender(true, 8, 8)
end)



RegisterNetEvent("syn_construction:startjob")
AddEventHandler("syn_construction:startjob", function()
    --if 20 >= trustlevel then 
        quality = 100
        missionstarted = true
        level = 1
        proploc = Config.missions[spot].materialpickup
        constloc = Config.missions[spot].workspots
        reward = Config.missions[spot].reward
        totaltasks = keysx(constloc)
        TriggerEvent("vorp:TipBottom", Config.Language.marked, 4000)
        missionblip = N_0x554d9d53f696d002(1664425300, proploc.x, proploc.y, proploc.z)
    	SetBlipSprite(missionblip, -924533810, 1)
    	SetBlipScale(missionblip, 0.2)
    	Citizen.InvokeNative(0x9CB1A1623062F402, missionblip,Config.Language.pickup)
        Citizen.InvokeNative(0x662D364ABF16DE2F,missionblip,0x6F85C3CE) -- red color blip
        ClearGpsCustomRoute()
        StartGpsMultiRoute(0, true, true)
        AddPointToGpsMultiRoute(proploc.x, proploc.y, proploc.z)
        SetGpsCustomRouteRender(true, 8, 8)
    --end
end)



Citizen.CreateThread( function() 
    WarMenu.CreateMenu('construction', Config.Language.construction)
    while true do
        if WarMenu.IsMenuOpened('construction') then
            if WarMenu.Button(Config.Language.trust..trustlevel.."") then end
            if not missionstarted then 
                if WarMenu.Button(Config.Language.startjob) then 
                    TriggerEvent("syn_construction:startjob")
                    WarMenu.CloseMenu()
                end
            else
                if WarMenu.Button(Config.Language.finishwork) then 
                    if tasksdone > 0 then 
                        TriggerServerEvent("syn_construction:reward",quality,tasksdone,reward,totaltasks)
                        missionstarted = false 
                        tasksdone = 0
                        DeleteObject(prop)
                        RemoveBlip(missionblip)
                        ClearGpsCustomRoute()
                        SetGpsCustomRouteRender(false, 16, 16)
                        WarMenu.CloseMenu()
                    else
                        missionstarted = false 
                        DeleteObject(prop)
                        RemoveBlip(missionblip)
                        ClearGpsCustomRoute()
                        SetGpsCustomRouteRender(false, 16, 16)
                        WarMenu.CloseMenu()
                    end
                    WarMenu.CloseMenu()
                end
            end
        end
    WarMenu.Display()
    Citizen.Wait(0)
    end
end)




----------------------------
function keysx(table)
    local keys = 0
    for k,v in pairs(table) do
       keys = keys + 1
    end
    return keys
end
Citizen.CreateThread(function()
    Citizen.Wait(1000)
	for k,v in pairs(Config.constructioncompany) do 
		local blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
    	SetBlipSprite(blip, v.blipsprite, 1)
    	SetBlipScale(blip, 0.2)
    	Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.Name)
        table.insert(blips, blip)
        -----
        local hashModel = GetHashKey(v.npcmodel) 
        if IsModelValid(hashModel) then 
            RequestModel(hashModel)
            while not HasModelLoaded(hashModel) do                
                Wait(100)
            end
        end
        local npc = CreatePed(hashModel, v.Pos.x, v.Pos.y, v.Pos.z - 1.0,v.Pos.h, false, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
        SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)
        Wait(1000)
        FreezeEntityPosition(npc, true) -- NPC can't escape
        SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
        table.insert(jobpeds, npc)
	end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = true 
        for k, v in pairs(Config.constructioncompany) do
            if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5 and not inmenu then
                sleep = false
                DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z, Config.Language.constructionmenu)
                if IsControlJustReleased(0, Config.keys["G"]) then
                    TriggerServerEvent("syn_construction:gettrustserver")
                    Wait(500)
                    WarMenu.OpenMenu('construction') 
                    spot = k
                    inmenu = true
                   Wait(500)
                end
            end
        end
        if sleep then 
            Citizen.Wait(500)
        end
    end
end)


function drawtext(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then 
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
end


function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())  
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
	  SetTextScale(0.30, 0.30)
	  SetTextFontForCurrentCommand(1)
	  SetTextColor(255, 255, 255, 215)
	  SetTextCentre(1)
	  DisplayText(str,_x,_y)
	  local factor = (string.len(text)) / 225
	  DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
	end
end


function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end



RegisterNetEvent("vorp:SelectedCharacter")
    AddEventHandler("vorp:SelectedCharacter", function(charid)
        Citizen.Wait(1000)
    end)

    AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            Citizen.Wait(5000)
			
        end
    end
)

AddEventHandler("onResourceStop",function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for k,v in pairs(blips) do 
            RemoveBlip(v)
        end
        for k,v in pairs(jobpeds) do 
            DeletePed(v)   
        end
        DeleteObject(prop)
        RemoveBlip(missionblip)
        ClearGpsCustomRoute()
        SetGpsCustomRouteRender(false, 16, 16)
    end
end)