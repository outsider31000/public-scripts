local target = -1
local targetInventory = {}
local targetWeapons = {}
local isHandcuffed = false
local defaultVehicle = -1
local initialized = false
local isboss = false
local societyMenuOpened = false
local playerJob
local isDead = IsPedDeadOrDying(PlayerPedId())
local policeOnDuty = true
local pjob
local dragStatus = {}
dragStatus.isDragged = false

local jailed = false


Citizen.CreateThread(function()
    while true do
        Wait(1)
        local sleep = true 
        for i,v in pairs(Marshal_Jobs) do
            if v == pjob then
                sleep = false 
                if IsControlPressed(0, 0x8AAA0AD4) then
                    if IsDisabledControlPressed(0, 0xE30CD707) then 
                        HandcuffPlayer()
                        Wait(1000)
                    end
                end
                if IsControlPressed(0, 0x8AAA0AD4) then
                    if IsDisabledControlPressed(0, 0x760A9C6F) then 
                        local closestPlayer, closestDistance = GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            TriggerServerEvent('lawmen:drag', GetPlayerServerId(closestPlayer))
                        end
                        Wait(1000)
                    end
                end
            end
        end
        if sleep then 
            Wait(5000)
        end
    end
end)
Citizen.CreateThread(function()
    Wait(1000)
    TriggerServerEvent("lawmen:checkmyjob")
end)

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    TriggerServerEvent("lawmen:checkmyjob")
    TriggerServerEvent("lawmen:check_jail")
end)

RegisterNetEvent("lawmen:onduty")
AddEventHandler("lawmen:onduty", function(duty)
    if not duty then
        policeOnDuty = false
    end
end)

WarMenu.CreateMenu('marshal_main', 'Police Menu')
WarMenu.CreateSubMenu('marshal_inventory', 'marshal_main')

RegisterNetEvent("lawmen:goonduty")
AddEventHandler("lawmen:goonduty", function()
    if policeOnDuty then
        TriggerEvent("vorp:TipRight", "You are already on Duty", 2000)
    else
        TriggerServerEvent('lawmen:goondutysv', GetPlayers())
    end
end)

RegisterNetEvent("lawmen:gooffduty")
AddEventHandler("lawmen:gooffduty", function()
    TriggerServerEvent("lawmen:gooffdutysv")
end)

RegisterNetEvent("lawmen:guncabinet")
AddEventHandler("lawmen:guncabinet", function()
    WarMenu.OpenMenu("marshal_weapons")
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('marshal_weapons', 'Gun Cabinet')
    WarMenu.SetSubTitle('marshal_weapons', 'Gun Cabinet')

    while true do
        if WarMenu.IsMenuOpened('marshal_weapons') then
            if WarMenu.Button("LeMat Revolver") then
                local ammo = {["AMMO_REVOLVER"] = 60}
                local comps = {['nothing'] = 0}
                WarMenu.CloseMenu()
                TriggerServerEvent("lawmen:guncabinet", "WEAPON_REVOLVER_LEMAT", ammo, comps)
            elseif WarMenu.Button("Evans Repeater") then
                local ammo = {["AMMO_REPEATER"] = 60}
                local comps = {["nothing"] = 0}
                WarMenu.CloseMenu()
                TriggerServerEvent("lawmen:guncabinet", "WEAPON_REPEATER_EVANS", ammo, comps)
            elseif WarMenu.Button("Exit") then
                WarMenu.CloseMenu()
            end

            WarMenu.Display()
        end
        Citizen.Wait(0)
    end
end)

-- Disable player actions
Citizen.CreateThread(function()
    TriggerServerEvent("lawmen:check_jail")

	while true do
		Citizen.Wait(0)

		if isHandcuffed then
			DisableControlAction(0, 0xB2F377E8, true) -- Attack
			DisableControlAction(0, 0xC1989F95, true) -- Attack 2
			DisableControlAction(0, 0x07CE1E61, true) -- Melee Attack 1
			DisableControlAction(0, 0xF84FA74F, true) -- MOUSE2
			DisableControlAction(0, 0xCEE12B50, true) -- MOUSE3
			DisableControlAction(0, 0x8FFC75D6, true) -- Shift
			DisableControlAction(0, 0xD9D0E1C0, true) -- SPACE
            DisableControlAction(0, 0xF3830D8E, true) -- J
            DisableControlAction(0, 0x80F28E95, true) -- L
            DisableControlAction(0, 0xDB096B85, true) -- CTRL
            DisableControlAction(0, 0xE30CD707, true) -- R
        elseif isHandcuffed and IsPedDeadOrDying(PlayerPedId()) then
            isHandcuffed = false
            ClearPedSecondaryTask(PlayerPedId())
            SetEnableHandcuffs(PlayerPedId(), false)
            DisablePlayerFiring(PlayerPedId(), false)
            SetPedCanPlayGestureAnims(PlayerPedId(), true)
            
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('lawmen:thejob')
AddEventHandler('lawmen:thejob', function(v)
    pjob = v
end)

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end
    
    return players
end

RegisterCommand("mmenu", function()
    TriggerServerEvent("lawmen:checkmyjob")
    while pjob == nil do 
        Wait(500)
    end
    for i,v in pairs(Marshal_Jobs) do
        if v == pjob then
            OpenMarshalMenu()
        end
    end
end)

RegisterCommand("jail", function(source, args, rawCommand)
    local target = args[1]
    local jailtime = args[2]
    TriggerServerEvent("lawmen:checkmyjob")
    while pjob == nil do 
        Wait(500)
    end
    for i,v in pairs(Marshal_Jobs) do
        if v == pjob then
            TriggerServerEvent('lawmen:JailPlayer', tonumber(target), tonumber(jailtime))
        end
    end
end)

RegisterCommand('unjail', function(source, args, rawCommand)
    local target = args[1]
    TriggerServerEvent("lawmen:checkmyjob")
    while pjob == nil do 
        Wait(500)
    end
    for i,v in pairs(Marshal_Jobs) do
        if v == pjob then
            TriggerServerEvent("lawmen:unjail", tonumber(target))
        end
    end
end)

RegisterNetEvent('lawmen:setBoss')
AddEventHandler('lawmen:setBoss', function(boss)
    isboss = boss
end)

function OpenMarshalMenu()
    Citizen.CreateThread(function()
        WarMenu.OpenMenu('marshal_main')
        while WarMenu.IsAnyMenuOpened() do
            Citizen.Wait(5)
            if WarMenu.IsMenuOpened("marshal_main") then
                if WarMenu.Button('Cuff / Uncuff') then
                    HandcuffPlayer()
                    WarMenu.CloseMenu()
                end
                if WarMenu.Button('Escort') then
                    local closestPlayer, closestDistance = GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        TriggerServerEvent('lawmen:drag', GetPlayerServerId(closestPlayer))
                        WarMenu.CloseMenu()
                    else
                        TriggerEvent("vorp:TipRight", "Not close enough", 2000)
                    end
                end
                if WarMenu.Button('Badge') then
                    if IsPedMale(PlayerPedId()) then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  0x1FC12C9C, true, true, true)
                    else
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  0x0929677D, true, true, true)
                    end
                    WarMenu.CloseMenu()
                end
                if WarMenu.Button('Badge2') then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  0x0A5074E9, true, true, true)
                end
                if WarMenu.Button('Exit') then
                    WarMenu.CloseMenu()
                end
                WarMenu.Display()
            end
        end
    end)
end

Citizen.CreateThread(function()
    local wasDragged

    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if isHandcuffed and dragStatus.isDragged then
            local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

            if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                if not wasDragged then
                    AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    wasDragged = true
                else
                    Citizen.Wait(1000)
                end
            else
                wasDragged = false
                dragStatus.isDragged = false
                DetachEntity(playerPed, true, false)
            end
        elseif wasDragged then
            wasDragged = false
            DetachEntity(playerPed, true, false)
        else
            Citizen.Wait(500)
        end
    end
end)

RegisterNetEvent('lawmen:drag')
AddEventHandler('lawmen:drag', function(copId)
    if isHandcuffed then
        dragStatus.isDragged = not dragStatus.isDragged
        dragStatus.CopId = copId
    end
end)

RegisterNetEvent("lawmen:JailPlayer")
AddEventHandler("lawmen:JailPlayer", function(time)
    local ped = PlayerPedId()
    local time_minutes = math.floor(time/60)
    for k, v in pairs(Jail) do
        if not jailed then
            DoScreenFadeOut(500)
            Citizen.Wait(600)
            SetEntityCoords(ped, v.x, v.y, v.z)
            FreezeEntityPosition(ped, true)
            jail_time = time
            jailed = true
            DoScreenFadeIn(500)
            Citizen.Wait(600)
            TriggerEvent("vorp:TipBottom", '~pa~Police~q~: You have been imprisoned for '..time_minutes..' minutes', 5000)
            FreezeEntityPosition(ped, false)
        end
    end
end)

RegisterNetEvent("lawmen:UnjailPlayer")
AddEventHandler("lawmen:UnjailPlayer", function()
    local local_ped = PlayerPedId()
    local local_player = PlayerId()
    TriggerEvent("vorp:TipBottom", "~pa~Police~q~: You have been released from prison. Now straighten up and fly right!", 5000)
    jailed = false
    jail_time = 0
    SetEntityCoords(local_ped, Config.ExitFromJail.x, Config.ExitFromJail.y, Config.ExitFromJail.z)
    SetPlayerInvincible(local_player, false)
end)

Citizen.CreateThread(function ()
    while true do
        if jailed then
            DrawTxt('Imprisoned: '..jail_time..' seconds remaining', 0.38, 0.95, 0.4, 0.4, true, 255, 0, 0, 255, false)
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('lawmen:putinoutvehicle')
AddEventHandler('lawmen:putinoutvehicle', function()
    local ped = PlayerPedId()
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, vehicle, 16)
    else
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehicleCoords(coords)
        local seats = 1
        while seats <= 6 do
            if Citizen.InvokeNative(0xE052C1B1CAA4ECE4, vehicle, seats) then
                Citizen.InvokeNative(0xF75B0D629E1C063D, ped, vehicle, seats)
                break
            end
                if seats == 7 then
                    break
                end
            seats = seats + 1
        end
    end
end)

RegisterNetEvent("lawmen:cuffs")
AddEventHandler("lawmen:cuffs", function()
    HandcuffPlayer() 
end)

RegisterNetEvent("lawmen:lockpick")
AddEventHandler("lawmen:lockpick", function()
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local chance = math.random(1,100)
        print("chance", chance)
        if not isDead then
            if chance < 85 then
                local ped = PlayerPedId()
                local anim = "mini_games@story@mud5@cracksafe_look_at_dial@med_r@ped"
                local idle = "base_idle"
                local lr = "left_to_right"
                local rl = "right_to_left"
                RequestAnimDict(anim)
                while not HasAnimDictLoaded(anim) do
                    Citizen.Wait(50)
                end
                
                TaskPlayAnim(PlayerPedId(), anim, idle, 8.0, -8.0, -1, 32, 0, false, false, false)
                Citizen.Wait(1250)
                TaskPlayAnim(PlayerPedId(), anim, lr, 8.0, -8.0, -1, 32, 0, false, false, false)
                Citizen.Wait(325)
                TaskPlayAnim(PlayerPedId(), anim, idle, 8.0, -8.0, -1, 32, 0, false, false, false)
                Citizen.Wait(1250)
                TaskPlayAnim(PlayerPedId(), anim, rl, 8.0, -8.0, -1, 32, 0, false, false, false)
                Citizen.Wait(325)
                repeat
                    TriggerEvent("lawmen:lockpick")
                until(chance)
            end
            if chance >= 85 then
                local breakChance = math.random(1,10)
                print("breakChance", breakChance)
                if breakChance < 3 then
                    TriggerServerEvent("lawmen:lockpick:break")
                else
                    local ped = PlayerPedId()
                    local anim = "mini_games@story@mud5@cracksafe_look_at_dial@small_r@ped"
                    local open = "open"
                    RequestAnimDict(anim)
                    while not HasAnimDictLoaded(anim) do
                        Citizen.Wait(50)
                    end
                    TaskPlayAnim(PlayerPedId(), anim, open, 8.0, -8.0, -1, 32, 0, false, false, false)
                    Citizen.Wait(1250)
                    TriggerServerEvent('lawmen:lockpicksv', GetPlayerServerId(closestPlayer))
                end
            end
        end
    else
        TriggerEvent("vorp:TipRight", "No Player Nearby", 3000)
        return
    end
    
end)

function DrawTxt(text, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", text)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
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

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if jailed then
            Wait(60000)
            TriggerServerEvent('lawmen:savetime', player_server_id, jail_time)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if jailed then
            local ped = PlayerPedId()
            local local_player = PlayerId()
            local player_coords = GetEntityCoords(ped, true)

            for k,v in pairs(Jail) do
                if GetDistanceBetweenCoords(player_coords, v.x, v.y, v.z, true) > Config.MaxJailDistance then
                    SetEntityCoords(ped, v.x, v.y, v.z)
                    FreezeEntityPosition(ped, true)
                    Citizen.Wait(1000)
                    FreezeEntityPosition(ped, false)
                    if Config.IncreaseSentence then
                        local player_server_id = GetPlayerServerId(PlayerId())
                        jail_time = jail_time + Config.IncreaseTime*60
                        TriggerServerEvent('lawmen:increasetime', player_server_id, jail_time, Config.IncreaseTime*60)
                    end
                end
            end

            if not GetPlayerInvincible(local_player) then
                SetPlayerInvincible(local_player, true)
            end
            if jail_time < 1 then
                local player_server_id = GetPlayerServerId(PlayerId())
                TriggerServerEvent("lawmen:unjail", player_server_id)
            else
                jail_time = jail_time - 1
            end
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

function FinePlayer()
    WarMenu.CloseMenu()
    local player = onscreenKeyboard('PLAYER_ID')
    if not tonumber(player) then
        TriggerEvent("vorp:TipRight", "Invalid Player ID", 10000)
        return
    elseif not NetworkIsPlayerActive(GetPlayerServerId(player)) then
        TriggerEvent("vorp:TipRight", "Player Not Online", 10000)
        return
    end

    Citizen.Wait(200)
    local amount = onscreenKeyboard('AMOUNT')
    if not tonumber(amount) then
        TriggerEvent("vorp:TipRight", "Invalid Amount", 10000)
        return
    elseif tonumber(amount) < 0 then
        TriggerEvent("vorp:TipRight", "Invalid Amount", 10000)
        return
    end

    TriggerServerEvent('lawmen:FinePlayer', tonumber(player), tonumber(amount))
end

function PutInOutVehicle()
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('lawmen:putinoutvehicle', GetPlayerServerId(closestPlayer))
    else
        TriggerEvent("vorp:TipRight", "No Player Nearby", 2000)
        return
    end
end

function CheckID()
    local player = tonumber(onscreenKeyboard('PLAYER_ID'))
    if not tonumber(player) then
        TriggerEvent("vorp:TipRight", "Invalid Player ID", 10000)
        return
    elseif not NetworkIsPlayerActive(GetPlayerFromServerId(player)) then
        TriggerEvent("vorp:TipRight", "Player Not Online", 10000)
        return
    end

    TriggerServerEvent('lawmen:GetID', tonumber(player))
end

function HandcuffPlayer()
    local closestPlayer, closestDistance = GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('lawmen:handcuff', GetPlayerServerId(closestPlayer))
    else
        TriggerEvent("vorp:TipRight", "No Player Nearby", 10000)
        return
    end
end

function onscreenKeyboard(defaultTitle)
	local _return = nil

	DisplayOnscreenKeyboard(1,"FMMC_KEY_TIP8", "", defaultTitle, "", "", "", 9)
	while true do
		DisableAllControlActions(0)
		Citizen.Wait(0)

		if UpdateOnscreenKeyboard() == 1 then
			_return = GetOnscreenKeyboardResult()
			break
		elseif UpdateOnscreenKeyboard() == 2 or UpdateOnscreenKeyboard() == 3 then
			break
		end
	end

	return _return
end

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

RegisterNetEvent('lawmen:handcuff')
AddEventHandler('lawmen:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isHandcuffed then
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
		end
	end)
end)

RegisterNetEvent('lawmen:lockpicked')
AddEventHandler('lawmen:lockpicked', function()
    local playerPed = PlayerPedId()
    ClearPedSecondaryTask(playerPed)
    SetEnableHandcuffs(playerPed, false)
    DisablePlayerFiring(playerPed, false)
    SetPedCanPlayGestureAnims(playerPed, true)
    isHandcuffed = false
end)

function lockpick()
    local ped = PlayerPedId()
    local anim = "mini_games@story@mud5@cracksafe_look_at_dial@med_r@ped"
    local idle = "base_idle"
    local lr = "left_to_right"
    local rl = "right_to_left"
    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
        Citizen.Wait(50)
    end
    
    TaskPlayAnim(PlayerPedId(), anim, idle, 8.0, -8.0, -1, 32, 0, false, false, false)
    Citizen.Wait(1250)
    TaskPlayAnim(PlayerPedId(), anim, lr, 8.0, -8.0, -1, 32, 0, false, false, false)
    Citizen.Wait(325)
    TaskPlayAnim(PlayerPedId(), anim, idle, 8.0, -8.0, -1, 32, 0, false, false, false)
    Citizen.Wait(1250)
    TaskPlayAnim(PlayerPedId(), anim, rl, 8.0, -8.0, -1, 32, 0, false, false, false)
    Citizen.Wait(325)
end