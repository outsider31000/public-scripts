local draggedBy = -1
local drag = false
local wasDragged = false

RegisterNetEvent("vorp_ml_policejob:drag")
AddEventHandler("vorp_ml_policejob:drag", function(_source)
    draggedBy = _source
    drag = not drag
end)

-- Dragging
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if drag then
            wasDragged = true
            AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(draggedBy)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        else
            if wasDragged then
                wasDragged = false
                DetachEntity(PlayerPedId(), true, false)    
            end
        end
    end
end)

Citizen.CreateThread(function()
    local checkbox2 = false
    WarMenu.CreateMenu('perso', _U('titulo'))
    WarMenu.SetSubTitle('perso', _U('subtitulo'))
    --WarMenu.CreateSubMenu('inv', 'perso', _U('sub_menu_1'))
    WarMenu.CreateSubMenu('inv1', 'perso', _U('sub_menu_2'))
    --WarMenu.CreateSubMenu('perso', 'perso', _U('select_option'))
    --WarMenu.CreateSubMenu('inv2', 'perso', _U('select_option'))

    while true do

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if WarMenu.IsMenuOpened('perso') then

            

            if WarMenu.MenuButton(_U('sub_menu_3'), 'inv1') then
            end
			
			if WarMenu.MenuButton(_U('sub_menu_1'), 'inv') then 
            end

            if WarMenu.MenuButton(_U('select_option'), 'inv2') then 
            end


            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('inv1') then
			
            if WarMenu.Button(_U('placa')) then
                local playerPed = PlayerPedId()
                Citizen.InvokeNative(0xD710A5007C2AC539, playerPed, 0x3F7F3587, 0) -- Set target category, here the hash is for badges
                Citizen.InvokeNative(0xCC8CA3E88256E58F, playerPed, 0, 1, 1, 1, 0) -- Actually remove the component
                if IsPedMale(playerPed) == 1 then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, playerPed, 0x1FC12C9C,true,true,true)
                else
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, playerPed, 0x929677D,true,true,true)
                end
            elseif WarMenu.Button(_U('badgeoff')) then
                local playerPed = PlayerPedId()
                Citizen.InvokeNative(0xD710A5007C2AC539, playerPed, 0x3F7F3587, 0) -- Set target category, here the hash is for badges
                Citizen.InvokeNative(0xCC8CA3E88256E58F, playerPed, 0, 1, 1, 1, 0) -- Actually remove the component
            
            elseif WarMenu.Button(_U('deletevehicle')) then
                local playerPed = PlayerPedId()
                TriggerEvent("wcrp:deleteVehicle") 
					
			elseif WarMenu.Button(_U('esposar')) then 
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                
                    TriggerServerEvent("vorp_ml_policejob:cuffplayer", GetPlayerServerId(closestPlayer))                    
                    --print('Metido correctamente')
                   
                end
            elseif WarMenu.Button(_U('drag')) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then

                    TriggerServerEvent("vorp_ml_policejob:drag", GetPlayerServerId(closestPlayer))

                end
            elseif WarMenu.Button(_U('meter')) then 
                local closestPlayer, closestDistance = GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    
                        TriggerServerEvent("vorp_ml_policejob:metervehiculo", GetPlayerServerId(closestPlayer))                    

                       
                end                   

            elseif WarMenu.Button(_U('sacar')) then 
                local closestPlayer, closestDistance = GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    
                        TriggerServerEvent("vorp_ml_policejob:sacarvehiculo", GetPlayerServerId(closestPlayer))                    
                       
                end
            elseif WarMenu.Button(_U('desesposar')) then
            local closestPlayer, closestDistance = GetClosestPlayer()
              if closestPlayer ~= -1 and closestDistance <= 3.0 then
              
                    TriggerServerEvent("vorp_ml_policejob:uncuffplayer", GetPlayerServerId(closestPlayer))
                    
                end
			elseif WarMenu.Button(_U('atar_lazo')) then
            local closestPlayer, closestDistance = GetClosestPlayer()
              if closestPlayer ~= -1 and closestDistance <= 3.0 then
              
                    TriggerServerEvent("vorp_ml_policejob:lassoplayer", GetPlayerServerId(closestPlayer))
                    
                end
			
            end
            WarMenu.Display()

        --[[elseif WarMenu.IsMenuOpened('inv2') then  
            if WarMenu.Button(_U('revive_player')) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    TriggerEvent("vorp:TipBottom", _U('no_nearby_players'), 3000)
                else
                    RevivePlayer(closestPlayer)
                end
            elseif WarMenu.Button(_U('heal_player')) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    TriggerEvent("vorp:TipBottom", _U('no_nearby_players'), 3000)
                else
                    HealPlayer(closestPlayer)
                end
            end
            WarMenu.Display()--]]
            
        elseif WarMenu.IsMenuOpened('inv') then   

            if WarMenu.Button(_U('sub_menu_1')) then
					SpawnHorse()
            end
            WarMenu.Display()

        elseif whenKeyJustPressed(keys["8"]) then 
           TriggerServerEvent("vorp_ml_policejob:checkjob")
        end
        
		
        Citizen.Wait(0)
    end
end)




-- pd station
Citizen.CreateThread(function()
    local checkbox2 = false
    WarMenu.CreateMenu('perso2', _U('titulo'))
    WarMenu.SetSubTitle('perso2', _U('subtitulo'))
    WarMenu.CreateSubMenu('inv3', 'perso2', _U('sub_menu_5'))
    WarMenu.CreateSubMenu('inv4', 'perso2', _U('sub_menu_6'))
	WarMenu.CreateSubMenu('TP', 'perso2', _U('sub_menu_7'))

    while true do
        local sleep = true
        local ped = PlayerPedId()
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('perso2') then

            

            if WarMenu.MenuButton(_U('sub_menu_3'), 'inv3') then
            end

            if WarMenu.MenuButton(_U('sub_menu_6'), 'inv4') then
            end
			
			if WarMenu.MenuButton(_U('sub_menu_7'), 'TP') then
			end
		
		WarMenu.Display()
		
		elseif WarMenu.IsMenuOpened('TP') then
			if WarMenu.Button('Valentine') then
					SetEntityCoords(ped, -277.76,804.97,119.38)  
				elseif WarMenu.Button('Blackwater') then
					SetEntityCoords(ped, -764.14,-1270.92,44.04) 
				elseif WarMenu.Button('Strawberry') then
					SetEntityCoords(ped, -1811.91,-353.65,164.65) 
				elseif WarMenu.Button('Rhodes') then
					SetEntityCoords(ped, 1359.61,-1303.27,77.77)
				elseif WarMenu.Button('Tumbleweed') then
					SetEntityCoords(ped, -5530.48,-2928.49,-1.36)
				elseif WarMenu.Button('SaintDenis') then
					SetEntityCoords(ped, 2496.79,-1302.06,48.95)
			end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('inv3') then


			if WarMenu.Button(_U('poner_skin')) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)	
				
            elseif WarMenu.Button(_U('poner_skin2')) then
				seteazaModel('S_M_M_AmbientBlWPolice_01')
            elseif WarMenu.Button(_U('poner_skin3')) then
				seteazaModel('S_M_M_AmbientSDPolice_01') 
			elseif WarMenu.Button(_U('poner_skin4')) then
				seteazaModel('CS_rhodeputy_01')
			elseif WarMenu.Button(_U('poner_skin5')) then
				seteazaModel('S_M_M_VALDEPUTY_01')
				
            elseif WarMenu.Button(_U('poner_skin6')) then
                TriggerServerEvent("vorpcharacter:getPlayerSkin")
				end
				
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('inv4') then   

            if WarMenu.Button(_U('lasso')) then
                Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey("WEAPON_LASSO"), 500, true, 0)
				elseif WarMenu.Button(_U('revolver')) then
                Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey("WEAPON_REVOLVER_CATTLEMAN"), 500, true, 0)
			elseif WarMenu.Button(_U('repeater')) then
                Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey("WEAPON_REPEATER_HENRY"), 500, true, 0)
			elseif WarMenu.Button(_U('shotgun')) then
                Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey("WEAPON_SHOTGUN_PUMP"), 500, true, 0)
			elseif WarMenu.Button(_U('rifle')) then
                Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey("WEAPON_SNIPERRIFLE_ROLLINGBLOCK"), 500, true, 0)
			elseif WarMenu.Button(_U('lantern')) then
                Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey("WEAPON_MELEE_LANTERN_ELECTRIC"), 500, true, 0)
			elseif WarMenu.Button(_U('knife')) then
                Citizen.InvokeNative(0xB282DC6EBD803C75, PlayerPedId(), GetHashKey("WEAPON_MELEE_KNIFE"), 500, true, 0)
			
			
             end
			
            WarMenu.Display()
elseif (Vdist(coords.x, coords.y, coords.z, -764.84, -1271.85, 44.04) < 1.0) then
    sleep = false --blackw
               TriggerEvent("enter:pd")
               if whenKeyJustPressed(keys["B"]) then
			   TriggerServerEvent("vorp_ml_policejob:checkjob2")
               end
elseif (Vdist(coords.x, coords.y, coords.z, -279.591, 808.6804, 119.4801) < 1.0) then
    sleep = false --val
               TriggerEvent("enter:pd")
               if whenKeyJustPressed(keys["B"]) then
			   TriggerServerEvent("vorp_ml_policejob:checkjob2")
               end
elseif (Vdist(coords.x, coords.y, coords.z, -1811.91,-353.65,164.65) < 1.0) then 
    sleep = false --strw
               TriggerEvent("enter:pd")
               if whenKeyJustPressed(keys["B"]) then
			   TriggerServerEvent("vorp_ml_policejob:checkjob2")
               end
elseif (Vdist(coords.x, coords.y, coords.z, 1359.61,-1303.27,77.77) < 1.0) then
    sleep = false --rhod
               TriggerEvent("enter:pd")
               if whenKeyJustPressed(keys["B"]) then
			   TriggerServerEvent("vorp_ml_policejob:checkjob2")
               end
elseif (Vdist(coords.x, coords.y, coords.z, -5530.48,-2928.49,-1.36) < 1.0) then
    sleep = false --tweed
               TriggerEvent("enter:pd")
               if whenKeyJustPressed(keys["B"]) then
			   TriggerServerEvent("vorp_ml_policejob:checkjob2")
               end
elseif (Vdist(coords.x, coords.y, coords.z, 2496.79,-1302.06,48.95) < 1.0) then
    sleep = false--saintD
               TriggerEvent("enter:pd")
               if whenKeyJustPressed(keys["B"]) then
			   TriggerServerEvent("vorp_ml_policejob:checkjob2")
               end			   
             		   
			   
      end
      
     
        Citizen.Wait(0)
    
    end
if sleep then
    Citizen.Wait(1000)
end    
end)


function seteazaModel(name)
	local model = GetHashKey(name)
	local player = PlayerId()
	
	if not IsModelValid(model) then return end
	PerformRequest(model)
	
	if HasModelLoaded(model) then
		-- SetPlayerModel(player, model, false)
		Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	end
end

function PerformRequest(hash)
    RequestModel(hash, 0) -- RequestModel
    local times = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do -- HasModelLoaded
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0) -- RequestModel
        times = times + 1
        Citizen.Wait(0)
        if times >= 100 then break end
    end
end


RegisterNetEvent('enter:pd')
  AddEventHandler('enter:pd', function()
    SetTextScale(0.5, 0.5)
    --SetTextFontForCurrentCommand(1)
    local msg = _U('abrir_menu2')
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  end)
  
  RegisterNetEvent('vorp_ml_policejob:open2')
AddEventHandler('vorp_ml_policejob:open2', function(cb)
	WarMenu.OpenMenu('perso2')
	--print ("openmenu")
end)

RegisterNetEvent('vorp_ml_policejob:open')
AddEventHandler('vorp_ml_policejob:open', function(cb)
	WarMenu.OpenMenu('perso')
	--print ("openmenu")
end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

--Police Horse

local recentlySpawned = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if recentlySpawned > 0 then
            recentlySpawned = recentlySpawned - 1
        end
    end
end)

function SpawnHorse()
    local localPed = PlayerPedId()
    local randomHorseModel = math.random(1, #Config.Horses)
    local model = GetHashKey(Config.Horses[randomHorseModel])

    RequestModel(model, true)

    while not HasModelLoaded(model) do
        Citizen.Wait(100)
    end
    
    local forward = Citizen.InvokeNative(0x2412D9C05BB09B97, localPed)
    local pos = GetEntityCoords(localPed)
    local myHorse = Citizen.InvokeNative(0xD49F9B0955C367DE, model, pos.x, pos.y - 30, pos.z - 0.5, 180.0, true, true, true, true)
    TaskGoToEntity( myHorse, localPed, -1, 7.2, 2.0, 0, 0 )
	Citizen.InvokeNative(0x283978A15512B2FE, myHorse, true)
    SetPedAsGroupMember(myHorse, 0) --Citizen.InvokeNative(0x9F3480FE65DB31B5, myHorse, 0)
	SetModelAsNoLongerNeeded(model) -- Citizen.InvokeNative(0x4AD96EF928BD4F9A, model)
	Citizen.InvokeNative(0xD3A7B003ED343FD9, myHorse, 0x1EE21489, true, true, true)
    Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, myHorse)
end

--Police cuff


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


 RegisterNetEvent('vorp_ml_policejob:cuff')
AddEventHandler('vorp_ml_policejob:cuff', function()
		local playerPed = PlayerPedId()
        SetEnableHandcuffs(playerPed, true)
		    
		--print ("cuffplayer")
   
end)

--IsPedCuffed(playerPed, true)

 RegisterNetEvent('vorp_ml_policejob:uncuff')
AddEventHandler('vorp_ml_policejob:uncuff', function()
    local playerPed = PlayerPedId()
    UncuffPed(playerPed)
	
    --print ("uncuffplayer")
    
end)

RegisterNetEvent('vorp_ml_policejob:hogtie')
AddEventHandler('vorp_ml_policejob:hogtie', function()
	isLasso = not isLasso
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isLasso then
            TaskKnockedOutAndHogtied(playerPed, false, false)
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			DisplayRadar(false)
        elseif not isLasso then
            ClearPedTasksImmediately(playerPed, true, false)
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			DisplayRadar(true)
		end
	end)
end)

RegisterNetEvent('vorp_ml_policejob:meter')
AddEventHandler('vorp_ml_policejob:meter', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetVehicleCoords(coords)
    --print('Coche'..vehicle)
    --print('Coordenadas'..coords)
    local seats = 1 
    while seats <= 6 do
        if Citizen.InvokeNative(0xE052C1B1CAA4ECE4, vehicle, seats) then
            -- print('Vehiclue seat')
           
            Citizen.InvokeNative(0xF75B0D629E1C063D, ped, vehicle, seats)
            Citizen.InvokeNative(0x2381977DA948F8DC, 'wagonPrison01x', true)
            SetVehicleDoorsLockedForAllPlayers('wagonPrison01x', true)
            
            break
        end
            if seats == 7 then
                -- print('ESTO ESTA LLENO MUCHACHO')
                break
            end
        
        seats = seats + 1
        --print('asientos'..seats)
    end
end)

RegisterNetEvent('vorp_ml_policejob:sacar')
AddEventHandler('vorp_ml_policejob:sacar', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehicleCoords(coords)
    local inVehicle = GetVehiclePedIsIn(playerPed, false)
    local flag = 16
    TaskLeaveVehicle(playerPed, vehicle, flag)
end)

local distanceToCheck = 5.0

RegisterNetEvent('wcrp:deleteVehicle')
AddEventHandler('wcrp:deleteVehicle', function()

    local ped = PlayerPedId()
    local _source = source

    if DoesEntityExist(ped) and not IsEntityDead(ped) then
        local pos = GetEntityCoords(ped)
        if  IsPedSittingInAnyVehicle(ped) then

            local vehicle = GetVehiclePedIsIn(ped, false)

            if GetPedInVehicleSeat(vehicle, -1) == ped then
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
                if DoesEntityExist(vehicle) then
                    -- TriggerClientEvent("vorp:TipBottom", _source, 'Unable to delete vehicle try again', 4000)
                else
                    -- TriggerClientEvent("vorp:TipBottom", _source, 'Vehicle Deleted', 4000)
                end
            else
                -- TriggerClientEvent("vorp:TipBottom", _source, 'You must be in drivers seat', 4000) -- from server side
            end
        end
    end
end)

function deleteCar(entity)
    Citizen.InvokeNative(0xE20A909D8C4A70F8, Citizen.PointerValueIntInitialized(entity))
end

RegisterNetEvent('wcrp:deleteVehicleadmin')
AddEventHandler('wcrp:deleteVehicleadmin', function()

    local ped = PlayerPedId()
    local _source = source

    if DoesEntityExist(ped) and not IsEntityDead(ped) then
        local pos = GetEntityCoords(ped)
        if  IsPedSittingInAnyVehicle(ped) then

            local vehicle = GetVehiclePedIsIn(ped, false)

            if GetPedInVehicleSeat(vehicle, -1) == ped then
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
                if DoesEntityExist(vehicle) then
                    -- TriggerClientEvent("vorp:TipBottom", _source, 'Unable to delete vehicle try again', 4000)
                else
                    -- TriggerClientEvent("vorp:TipBottom", _source, 'Vehicle Deleted', 4000)
                end
            else
                -- TriggerClientEvent("vorp:TipBottom", _source, 'You must be in drivers seat', 4000) -- from server side
            end
        end
    end
end)

