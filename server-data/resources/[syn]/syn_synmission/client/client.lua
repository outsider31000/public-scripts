-- stage1

local starting = false
local already = false
local count = {}
local createdped = {}
local pressing = false
local gpsx = 0.0
local gpsy = 0.0
local gpsz = 0.0



function missionstart()

--Elige el array de coordenadas(lugar)
	local randomNCoords = math.random(21)
	local chossenCoords = {}

	if randomNCoords == 1 then
		chossenCoords = Config.Coordenates.coords
	elseif randomNCoords == 2 then
		chossenCoords = Config.Coordenates.coords2
	elseif randomNCoords == 3 then
		chossenCoords = Config.Coordenates.coords3
	elseif randomNCoords == 4 then
		chossenCoords = Config.Coordenates.coords4
	elseif randomNCoords == 5 then
		chossenCoords = Config.Coordenates.coords5
	elseif randomNCoords == 6 then
		chossenCoords = Config.Coordenates.coords6
	elseif randomNCoords == 7 then
		chossenCoords = Config.Coordenates.coords7
	elseif randomNCoords == 8 then
		chossenCoords = Config.Coordenates.coords8
	elseif randomNCoords == 9 then
		chossenCoords = Config.Coordenates.coords9
	elseif randomNCoords == 10 then
		chossenCoords = Config.Coordenates.coords10
	elseif randomNCoords == 11 then
		chossenCoords = Config.Coordenates.coords11
	elseif randomNCoords == 12 then
		chossenCoords = Config.Coordenates.coords12
	elseif randomNCoords == 13 then
		chossenCoords = Config.Coordenates.coords13
	elseif randomNCoords == 14 then
		chossenCoords = Config.Coordenates.coords14
	elseif randomNCoords == 15 then
		chossenCoords = Config.Coordenates.coords15
	elseif randomNCoords == 16 then
		chossenCoords = Config.Coordenates.coords16
	elseif randomNCoords == 17 then
		chossenCoords = Config.Coordenates.coords17
	elseif randomNCoords == 18 then
		chossenCoords = Config.Coordenates.coords18
	elseif randomNCoords == 19 then
		chossenCoords = Config.Coordenates.coords19
	elseif randomNCoords == 20 then
		chossenCoords = Config.Coordenates.coords20
	elseif randomNCoords == 21 then
		chossenCoords = Config.Coordenates.coords21
	end

			  
	for k,item in pairs(chossenCoords) do
		
	--Take a random model
		local modelNumeroRandom = math.random(32)
		local modelRandom = Config.models[modelNumeroRandom].hash
		local _hash = GetHashKey(modelRandom)
		RequestModel(_hash)
		if not HasModelLoaded(_hash) then 
			RequestModel(_hash) 
		end
	
		while not HasModelLoaded(_hash) do 
			Citizen.Wait(1) 
		end
		

	--Take a random weapon
		local randomNumeroArma = math.random(22)
		local arma = Config.weapons[randomNumeroArma].hash

		createdped[k] = CreatePed(_hash, item.x, item.y, item.z, true, true, true, true)
		Citizen.InvokeNative(0x283978A15512B2FE, createdped[k], true)
		Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, createdped[k])
		gpsx = item.x
		gpsy = item.y
		gpsz = item.z
	--Give weapons to ped and equip them
		GiveWeaponToPed_2(createdped[k], arma, 10, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
		SetCurrentPedWeapon(createdped[k], arma, true)
	--Ped becomes agressive to the player
		TaskCombatPed(createdped[k],PlayerPedId())
		count[k] = createdped[k]
	end
	StartGpsMultiRoute(6, true, true)
        
    -- Add the points
    AddPointToGpsMultiRoute(gpsx, gpsy, gpsz)
    AddPointToGpsMultiRoute(gpsx, gpsy, gpsz)

    -- Set the route to render
	SetGpsMultiRouteRender(true)

	starting = true
	Wait(1000)
	Citizen.CreateThread(function()
		local x = #chossenCoords
		local pl = Citizen.InvokeNative(0x217E9DC48139933D)
		while starting == true do
			Citizen.Wait(0)
			for k,v in pairs(createdped) do
				if IsEntityDead(v) then
					if count[k] ~= nil then
						x = x - 1
						count[k] = nil
						if x == 0 then
							TriggerEvent("vorp:TipRight", Config.ObjectivesKilledMessage, 4000)
							TriggerServerEvent('syn:AddSomeMoney')
							stopmission()
						end
					end
				end
				if IsPlayerDead(pl) then
					TriggerEvent("vorp:TipRight", Config.DeadMessage, 4000)
					stopmission()
				end
			end
		end
	end)
end

function stopmission()
	Wait(5000)
	pressing = false
	starting = false
	already = false
	SetGpsMultiRouteRender(false)
	for k,v in pairs(createdped) do
		DeletePed(v)
		Wait(500)
	end
	table.remove{createdped}
	table.remove{count}
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function startdialog()
	Citizen.CreateThread(function()
	  local timetocheck = 600
		while timetocheck >= 0  do
			Citizen.Wait(0)
			DrawTxt(Config.KillingMessage, 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
			timetocheck = timetocheck - 1
		end
	end)
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, -777.03, -1217.2, 43.52, true)
		if betweencoords < 2.0 and not already then
			Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, -777.03, -1217.2, 42.52, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 100, 1, 1, 190, false, true, 2, false, false, false, false)

		--	DrawTxt(Config.HuntingMessage,0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
		DrawTxt("Press [~e~G~q~] to start a Syn Run", 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)

			if IsControlJustPressed(2, 0x760A9C6F) and not pressing then
				stopmission()
				pressing = true
				missionstart()
				startdialog()
				already = true
			end
		end
	end
end)


--stage2

local isDelivering = false
local JobNum
local modeltodelete
local delete = false
local p1 = nil
local p2 = nil
local p3 = nil
local p4 = nil
local timer = 0

-----blips
local blips = {
	{x=-179.51, y=627.02, z=114.09},
    {x=2939.25, y=1288.65, z=44.65},
    {x=-778.33, y=-1323.44, z=43.88},
    {x=-2324.89, y=-2406.17, z=63.85},
  }

  Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, -243818172, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('blip'))
    end  
end)

--------------native alt key press---
local DeliverPrompt
local hasAlreadyEnteredMarker, lastZone
local currentZone = nil
local sell = false
local active = false
local pressed = false

function SetupDeliverPrompt()
    Citizen.CreateThread(function()
        local str = 'Start Mission'
        DeliverPrompt = PromptRegisterBegin()
        PromptSetControlAction(DeliverPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(DeliverPrompt, str)
        PromptSetEnabled(DeliverPrompt, false)
        PromptSetVisible(DeliverPrompt, false)
        PromptSetHoldMode(DeliverPrompt, true)
        PromptRegisterEnd(DeliverPrompt)
    end)
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
          if currentZone then
              if active == false then
                  PromptSetEnabled(DeliverPrompt, true)
                  PromptSetVisible(DeliverPrompt, true)
                  active = true
              end
              if PromptHasHoldModeCompleted(DeliverPrompt) then
                  PromptSetEnabled(DeliverPrompt, false)
                  PromptSetVisible(DeliverPrompt, false)
                 	pressed = true
                  active = false
          currentZone = nil
        end
          else
        Citizen.Wait(500)
      end
    end
end)


Citizen.CreateThread(function()
    SetupDeliverPrompt()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local isInMarker, currentZone = false
  
		for k,v in pairs(Config.MainJob) do
			local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, false)
			if betweencoords < 2 then
                isInMarker  = true
                currentZone = 'delivery'
                lastZone    = 'delivery'
            end
        end
  
        if isInMarker and not hasAlreadyEnteredMarker then
        hasAlreadyEnteredMarker = true
		TriggerEvent('syn2:hasEnteredMarker', currentZone)
        end
    
        if not isInMarker and hasAlreadyEnteredMarker then
        hasAlreadyEnteredMarker = false
        TriggerEvent('syn2:hasExitedMarker', lastZone)
        end
    end
  
end)

local count2 = 0 

RegisterNetEvent("syn:true")
AddEventHandler("syn:true", function(count)
	count2 = count
end)



AddEventHandler('syn2:hasEnteredMarker', function(zone)
	currentZone     = zone
	TriggerServerEvent('syn:check')
end)
    
AddEventHandler('syn2:hasExitedMarker', function(zone)
      if active == true then
          PromptSetEnabled(DeliverPrompt, false)
          PromptSetVisible(DeliverPrompt, false)
		  active = false
		  pressed = false
      end
    currentZone = nil
end)

----------job start
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		--Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, -1792.18, -391.68, 43.58, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 100, 1, 1, 190, false, true, 2, false, false, false, false)
		for k,v in pairs(Config.MainJob) do
			local wag
			local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, false)
			if betweencoords < 2.2 then
				Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 100, 1, 1, 190, false, true, 2, false, false, false, false)
				-- DrawTxt("Press [E] to Start Mission", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
				if pressed  and count2 >= 10 then
						ResetMission()
						timer = 800000
						JobNum = k
						if JobNum == 1 then
							RemoveBlip(p1)
							p1 = N_0x554d9d53f696d002(1664425300, Config.Point3.x, Config.Point3.y, Config.Point3.z)
							SetBlipSprite(p1, -44057202, 1)
							Citizen.InvokeNative(0x9CB1A1623062F402, p1, "Delivery")
							isDelivering = true
							pressed = false
							wag = Config.Cart3
							wagon(wag)
							TriggerEvent("vorp:TipBottom", _U('punto_entrega', Config.StartWorking3), 10000) -- from server side

							StartGpsMultiRoute(6, true, true)
			
							-- Add the points
							AddPointToGpsMultiRoute(Config.Point3.x, Config.Point3.y, Config.Point3.z)

							-- Set the route to render
							SetGpsMultiRouteRender(true)
						elseif JobNum == 2 then
							RemoveBlip(p2)
							p2 = N_0x554d9d53f696d002(1664425300, Config.Point2.x, Config.Point2.y, Config.Point2.z)
							SetBlipSprite(p2, -44057202, 1)
							Citizen.InvokeNative(0x9CB1A1623062F402, p2, "Delivery")
							isDelivering = true
							pressed = false
							wag = Config.Cart2
							wagon(wag)
							TriggerEvent("vorp:TipBottom", _U('punto_entrega', Config.StartWorking2), 4000) -- from server side
							StartGpsMultiRoute(6, true, true)
			
							-- Add the points
							AddPointToGpsMultiRoute(Config.Point2.x, Config.Point2.y, Config.Point2.z)

							-- Set the route to render
							SetGpsMultiRouteRender(true)
						elseif JobNum == 3 then
							RemoveBlip(p3)
							p3 = N_0x554d9d53f696d002(1664425300, Config.Point3.x, Config.Point3.y, Config.Point3.z)
							SetBlipSprite(p3, -44057202, 1)
							Citizen.InvokeNative(0x9CB1A1623062F402, p3, "Delivery")
							isDelivering = true
							pressed = false
							wag = Config.Cart3
							wagon(wag)
							TriggerEvent("vorp:TipBottom", _U('punto_entrega', Config.StartWorking3), 4000) -- from server side
							StartGpsMultiRoute(6, true, true)
			
							-- Add the points
							AddPointToGpsMultiRoute(Config.Point3.x, Config.Point3.y, Config.Point3.z)

							-- Set the route to render
							SetGpsMultiRouteRender(true)
						elseif JobNum == 4 then
							RemoveBlip(p4)
							p4 = N_0x554d9d53f696d002(1664425300, Config.Point4.x, Config.Point4.y, Config.Point4.z)
							SetBlipSprite(p4, -44057202, 1)
							Citizen.InvokeNative(0x9CB1A1623062F402, p4, "Delivery")
							isDelivering = true
							pressed = false
							wag = Config.Cart4
							wagon(wag)
							TriggerEvent("vorp:TipBottom", _U('punto_entrega', Config.StartWorking4), 4000) -- from server side
							StartGpsMultiRoute(6, true, true)
			
							-- Add the points
							AddPointToGpsMultiRoute(Config.Point4.x, Config.Point4.y, Config.Point4.z)


							-- Set the route to render
							SetGpsMultiRouteRender(true)
						end
				elseif pressed and count2 < 10 then
					 
					TriggerEvent("vorp:TipBottom","not enough syn", 4000) -- from server side
					
				end
			end
		end
	end
end)

-----------job finish
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if isDelivering then
			for k,v in pairs(Config.FinishJob) do
				local b2 = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, false)
				if b2 <= 20 and isDelivering then
							DrawTxt(_U('deliver'), 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
                    if whenKeyJustPressed(keys["X"]) then
                        if IsPedInAnyVehicle(playerPed, false) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            local model = GetEntityModel(vehicle)
                            if model == -824257932 then
								if JobNum == 1 then --and IsPedInVehicle(playerPed, veh, true)
                                    TriggerEvent("vorp:TipBottom", _U('recompensa', Config.Cash1, Config.Gold1, Config.Exp1), 4000) -- from server side
                                    TriggerServerEvent('syn2:payout', Config.Cash1, Config.Gold1, Config.Exp1)
									isDelivering = false
									JobNum = nil
									RemoveBlip(p1)
                                    deletewagon()
                                    SetGpsMultiRouteRender(false)
								end
							
								if JobNum == 2 then
									TriggerServerEvent('syn2:payout', Config.Cash2, Config.Gold2, Config.Exp2)
                                    TriggerEvent("vorp:TipBottom", _U('recompensa', Config.Cash2, Config.Gold2, Config.Exp2), 4000) -- from server side
									isDelivering = false
									JobNum = nil
									RemoveBlip(p2)
                                    deletewagon()
                                    SetGpsMultiRouteRender(false)
								end

								if JobNum == 3 then
                                    TriggerEvent("vorp:TipBottom", _U('recompensa', Config.Cash3, Config.Gold3, Config.Exp3), 4000) -- from server side
									TriggerServerEvent('syn2:payout', Config.Cash3, Config.Gold3, Config.Exp3)
									isDelivering = false
									JobNum = nil
									RemoveBlip(p3)
                                    deletewagon()
                                    SetGpsMultiRouteRender(false)
								end
									

								if JobNum == 4 then
                                    TriggerEvent("vorp:TipBottom", _U('recompensa', Config.Cash4, Config.Gold4, Config.Exp4), 4000) -- from server side                                    
                                    TriggerServerEvent('syn2:payout', Config.Cash4, Config.Gold4, Config.Exp4)
									isDelivering = false
									JobNum = nil
									RemoveBlip(p4)
                                    deletewagon()
                                    SetGpsMultiRouteRender(false)
                                end
                            else
                                TriggerEvent("vorp:TipBottom", _U('carro_incorrecto'), 4000) -- from server side
                            end
                        else
                            TriggerEvent("vorp:TipBottom", _U('subir_vehiculo'), 4000)
                        end
					end
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if isDelivering and timer <= 0 then
			isDelivering = false
			RemoveBlip(p1)
			RemoveBlip(p2)
			RemoveBlip(p3)
			RemoveBlip(p4)
			p1 = nil
			p2 = nil
			p3 = nil
			p4 = nil
			JobNum = nil
            deletewagon()
            SetGpsMultiRouteRender(false)
            TriggerEvent("vorp:TipBottom", _U('entrega_fallida'), 4000)
		else
			timer = timer - 1000
		end
	end
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end


function wagon(wag)
    local ped = PlayerPedId()
    local car_start = GetEntityCoords(ped)
    local car_name = "CART01"
    local carHash = GetHashKey(car_name)
    RequestModel(carHash)

    while not HasModelLoaded(carHash) do
        Citizen.Wait(0)
    end

    local car = CreateVehicle(carHash, wag.x, wag.y, wag.z, wag.h, true, false)
	SetVehicleOnGroundProperly(car)
	Wait(200)
    SetPedIntoVehicle(ped, car, -1)
	SetModelAsNoLongerNeeded(carHash)
	modeltodelete = car
end

function deletewagon()
	local entity = modeltodelete
    NetworkRequestControlOfEntity(entity)
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end
    SetEntityAsMissionEntity(entity, true, true)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
    
    if (DoesEntityExist(entity)) then 
		DeleteEntity(entity)
		modeltodelete = nil
	end
	modeltodelete = nil
end

function whenKeyJustPressed(key)  ---iscontorlpressed doesnt work in vehicles or some shit, this works
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

--prevents the native bugging if you restart script
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	RemoveBlip(p1)
	RemoveBlip(p2)
	RemoveBlip(p3)
	RemoveBlip(p4)
	p1 = nil
	p2 = nil
	p3 = nil
    p4 = nil
    SetGpsMultiRouteRender(false)
end)

function ResetMission()
    RemoveBlip(p1)
    RemoveBlip(p2)
    RemoveBlip(p3)
    RemoveBlip(p4)
    p1 = nil
    p2 = nil
    p3 = nil
    p4 = nil
    SetGpsMultiRouteRender(false)
    isDelivering = false
	JobNum = nil
    deletewagon()
end



keys = {
    -- Letters
    ["A"] = 0x7065027D,
    ["B"] = 0x4CC0E2FE,
    ["C"] = 0x9959A6F0,
    ["D"] = 0xB4E465B4,
    ["E"] = 0xCEFD9220,
    ["F"] = 0xB2F377E8,
    ["G"] = 0x760A9C6F,
    ["H"] = 0x24978A28,
    ["I"] = 0xC1989F95,
    ["J"] = 0xF3830D8E,
    -- Missing K, don't know if anything is actually bound to it
    ["L"] = 0x80F28E95,
    ["M"] = 0xE31C6A41,
    ["N"] = 0x4BC9DABB, -- Push to talk key
    ["O"] = 0xF1301666,
    ["P"] = 0xD82E0BD2,
    ["Q"] = 0xDE794E3E,
    ["R"] = 0xE30CD707,
    ["S"] = 0xD27782E3,
    -- Missing T
    ["U"] = 0xD8F73058,
    ["V"] = 0x7F8D09B8,
    ["W"] = 0x8FD015D8,
    ["X"] = 0x8CC9CD42,
    -- Missing Y
    ["Z"] = 0x26E9DC00,

    -- Symbol Keys
    ["RIGHTBRACKET"] = 0xA5BDCD3C,
    ["LEFTBRACKET"] = 0x430593AA,
    -- Mouse buttons
    ["MOUSE1"] = 0x07CE1E61,
    ["MOUSE2"] = 0xF84FA74F,
    ["MOUSE3"] = 0xCEE12B50,
    ["MWUP"] = 0x3076E97C,
    -- Modifier Keys
    ["CTRL"] = 0xDB096B85,
    ["TAB"] = 0xB238FE0B,
    ["SHIFT"] = 0x8FFC75D6,
    ["SPACEBAR"] = 0xD9D0E1C0,
    ["ENTER"] = 0xC7B5340A,
    ["BACKSPACE"] = 0x156F7119,
    ["LALT"] = 0x8AAA0AD4,
    ["DEL"] = 0x4AF4D473,
    ["PGUP"] = 0x446258B6,
    ["PGDN"] = 0x3C3DD371,
    -- Function Keys
    ["F1"] = 0xA8E3F467,
    ["F4"] = 0x1F6D95E5,
    ["F6"] = 0x3C0A40F2,
    -- Number Keys
    ["1"] = 0xE6F612E4,
    ["2"] = 0x1CE6D9EB,
    ["3"] = 0x4F49CC4C,
    ["4"] = 0x8F9F9E58,
    ["5"] = 0xAB62E997,
    ["6"] = 0xA1FDE2A6,
    ["7"] = 0xB03A913B,
    ["8"] = 0x42385422,
    -- Arrow Keys
    ["DOWN"] = 0x05CA7C52,
    ["UP"] = 0x6319DB71,
    ["LEFT"] = 0xA65EBAB4,
    ["RIGHT"] = 0xDEB34313,
  }


-- RegisterCommand('checkv', function(source, args)
--     local playerPed = PlayerPedId()
--     local vehicle = GetVehiclePedIsIn(playerPed, false)
--     local model = GetEntityModel(vehicle)
--     if model == -824257932 then
--     end
-- end)

