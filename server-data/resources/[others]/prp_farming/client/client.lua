local myPlants = {}
local prompt, prompt2 = false, false
local DelPrompt
local PlantPrompt
SeedUsed = false

function SetupDelPrompt()
    Citizen.CreateThread(function()
        local str = 'Harvest'
        DelPrompt = PromptRegisterBegin()
        PromptSetControlAction(DelPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(DelPrompt, str)
        PromptSetEnabled(DelPrompt, false)
        PromptSetVisible(DelPrompt, false)
        PromptSetHoldMode(DelPrompt, true)
        PromptRegisterEnd(DelPrompt)
    end)
end

function SetupPlantPrompt()
    Citizen.CreateThread(function()
        local str = 'Plant'
        PlantPrompt = PromptRegisterBegin()
        PromptSetControlAction(PlantPrompt, 0x07CE1E61)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PlantPrompt, str)
        PromptSetEnabled(PlantPrompt, false)
        PromptSetVisible(PlantPrompt, false)
        PromptSetHoldMode(PlantPrompt, true)
        PromptRegisterEnd(PlantPrompt)
    end)
end

RegisterNetEvent('poke_planting:planto1')
AddEventHandler('poke_planting:planto1', function(hash1, hash2, hash3, item)
    if SeedUsed == true then 
        TriggerServerEvent("giveback", item)
    elseif SeedUsed == false then
        SeedUsed = true
        local myPed = PlayerPedId()
        local pHead = GetEntityHeading(myPed)
        local pos = GetEntityCoords(PlayerPedId(), true)
        local plant1 = GetHashKey(hash1)

        if not HasModelLoaded(plant1) then
            RequestModel(plant1)
        end

        while not HasModelLoaded(plant1) do
            Citizen.Wait(1)
        end

        local placing = true
        local tempObj = CreateObject(plant1, pos.x, pos.y, pos.z, true, true, false)
        SetEntityHeading(tempObj, pHead)
        SetEntityAlpha(tempObj, 51)
        AttachEntityToEntity(tempObj, myPed, 0, 0.0, 1.0, -0.7, 0.0, 0.0, 0.0, true, false, false, false, false)
        while placing do
            Wait(10)
            if prompt == false then
                PromptSetEnabled(PlantPrompt, true)
                PromptSetVisible(PlantPrompt, true)
                prompt = true
            end
            if PromptHasHoldModeCompleted(PlantPrompt) then
                PromptSetEnabled(PlantPrompt, false)
                PromptSetVisible(PlantPrompt, false)
                PromptSetEnabled(DelPrompt, false)
                PromptSetVisible(DelPrompt, false)
                prompt = false
                prompt2 = false
                local pPos = GetEntityCoords(tempObj, true)
                DeleteObject(tempObj)
                animacion()
                local object = CreateObject(plant1, pPos.x, pPos.y, pPos.z, true, true, false)
                myPlants[#myPlants+1] = {["object"] = object, ['x'] = pPos.x, ['y'] = pPos.y, ['z'] = pPos.z, ['stage'] = 1, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
                local plantCount = #myPlants
                PlaceObjectOnGroundProperly(myPlants[plantCount].object)
                SetEntityAsMissionEntity(myPlants[plantCount].object, true)
                SeedUsed = false
                break
            end
            if prompt2 == false then
                PromptSetEnabled(DelPrompt, true)
                PromptSetVisible(DelPrompt, true)
                prompt2 = true
            end
            if PromptHasHoldModeCompleted(DelPrompt) then
                PromptSetEnabled(PlantPrompt, false)
                PromptSetVisible(PlantPrompt, false)
                PromptSetEnabled(DelPrompt, false)
                PromptSetVisible(DelPrompt, false)
                prompt = false
                prompt2 = false
                DeleteObject(tempObj)
                break
            end
        end
	end
end)

RegisterNetEvent("seed:used")
AddEventHandler("seed:used", function()
    TriggerEvent("vorp:TipBottom", "You may not use more than one seed", 5000)
end)

RegisterNetEvent('poke_planting:regar1')
AddEventHandler('poke_planting:regar1', function(source)
    local pos = GetEntityCoords(PlayerPedId(), true)
    --local plant2 = GetHashKey("CRP_TOBACCOPLANT_AB_SIM")
    local object = nil
    local key = nil
    local hash1, hash2, hash3 = nil, nil, nil
    local planta = GetEntityCoords(object, true)
    local x, y, z = nil, nil, nil
    
    for k, v in ipairs(myPlants) do
        if v.stage == 1 then
            if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 2.0 then
                object = v.object
                key = k
                x, y, z = v.x, v.y, v.z
                hash1, hash2, hash3 = v.hash, v.hash2, v.hash3
                break
            end
        end
    end
    
    local plant2 = hash2
    
    if DoesEntityExist(object) then
        animacion2()
        DeleteObject(object)
        table.remove(myPlants, key)
        Wait(800)

        RequestModel(plant2)

        while not HasModelLoaded(plant2) do
            Citizen.Wait(1)
        end

        local object = CreateObject(plant2, x, y, z, true, true, false)
        myPlants[#myPlants+1] = {["object"] = object, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 2, ['timer'] = 500, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3}
        local plantCount = #myPlants
        PlaceObjectOnGroundProperly(myPlants[plantCount].object)
        SetEntityAsMissionEntity(myPlants[plantCount].object, true)
    end
end)

RegisterNetEvent('poke_planting:fin2')
AddEventHandler('poke_planting:fin2', function(object2, x, y, z, key, hash1, hash2, hash3)
    --local plant3 = GetHashKey("CRP_TOBACCOPLANT_AC_SIM")
    local planta2 = GetEntityCoords(object2, true)
    
    TriggerEvent("vorp:TipRight", "Your Plant has Matured!", 4000)
    DeleteObject(object2)
    table.remove(myPlants, key)
    Wait(800)
    
    local plant3 = hash3
    
    RequestModel(plant3)

    while not HasModelLoaded(plant3) do
        Citizen.Wait(1)
    end
    
    local object3 = CreateObject(plant3, x, y, z, true, true, false)
    PlaceObjectOnGroundProperly(object3)
    myPlants[#myPlants+1] = {["object"] = object3, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 3, ['prompt'] = false, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
    local plantCount = #myPlants
    PlaceObjectOnGroundProperly(myPlants[plantCount].object)
    SetEntityAsMissionEntity(myPlants[plantCount].object, true)
end)

function harvestPlant(key)
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
    TriggerEvent("vorp:TipRight", "Harvesting...", 10000)
    Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
	DeleteObject(myPlants[key].object)
	table.remove(myPlants, key)
end

Citizen.CreateThread(function()
    SetupPlantPrompt()
    --SetupDelPrompt()
    while true do
        Wait(1000)
        local pos = GetEntityCoords(PlayerPedId(), true)
        if myPlants[1] ~= nil then
            for k, v in ipairs(myPlants) do
                if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 160 then
                    if v.stage == 2 then
                        v.timer = v.timer-1
                        if v.timer == 0 then
                            v.stage = 3
                            local key = k
                            TriggerEvent('poke_planting:fin2', v.object, v.x, v.y, v.z, key, v.hash, v.hash2, v.hash3)
                        end
                    end    
                    if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) <= 2 then
                        if not v.prompt then
                            v.prompt = true
                        end
                    end
                        
                    if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) > 3 then
                        if v.prompt then
                            v.prompt = false
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if myPlants[1] ~= nil then
			local pos = GetEntityCoords(PlayerPedId(), true)
			for k, v in ipairs(myPlants) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 25.0 then
					if v.stage == 1 then
						DrawText3D(v.x, v.y, v.z, 'Water the Plant')
					end
					if v.stage == 2 then
						DrawText3D(v.x, v.y, v.z, 'Growing: ' .. v.timer)
					end
					if v.stage == 3 then
						DrawText3D(v.x, v.y, v.z, 'Press [~e~B~q~] to Harvest!')
					end
					if v.prompt then
						if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x4CC0E2FE) then
							local key = k
							harvestPlant(key)
							TriggerServerEvent("poke_planting:giveitem", v.hash3)
						end
					end
				end
			end
		end
	end
end)
		
function animacion()
	PromptSetEnabled(prompt, true)
	PromptSetVisible(prompt, true)
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_FARMER_RAKE'), 12000, true, false, false, false)
    TriggerEvent("vorp:TipRight", "Raking the Soil...", 3000)
    Wait(12000)
    ClearPedTasksImmediately(PlayerPedId())
	Wait(1000)
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_FARMER_WEEDING'), 9000, true, false, false, false)
    TriggerEvent("vorp:TipRight", "Planting Seeds...", 3000)
    Wait(9000)
    ClearPedTasksImmediately(PlayerPedId())
	PromptSetEnabled(prompt, false)
	PromptSetVisible(prompt, false)
end

function animacion2()
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_POUR_LOW'), 7000, true, false, false, false)
    TriggerEvent("vorp:TipRight", "Watering the Plant...", 7000)
    Wait(7000)
    ClearPedTasksImmediately(PlayerPedId())
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)

    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    --DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 52, 52, 52, 190, 0)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in ipairs(myPlants) do
			DeleteObject(v.object)
			table.remove(myPlants, k)
		end
	end
end)
