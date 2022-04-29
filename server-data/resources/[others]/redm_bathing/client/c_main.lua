BathingPed = nil
local inbath = false 

local othercontrols = 
{
    ["G"] = 0x760A9C6F,
    ["F"] = 0xB2F377E8,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
		local playerCoords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(playerCoords, -319.0, 762.52, 117.43, true) < 1 then
            drawtext("Press G To Exit", 0.15, 0.13, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
			if IsControlJustReleased(0, othercontrols["G"]) then
				SetEntityCoords(PlayerPedId(),-320.5,762.26,116.43)
			end
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


Citizen.CreateThread(function()
	CreateBlips()
	CloseBathDoors()
	if RegisterPrompts() then
		local bath = nil

		while true do
			bath = GetClosestConsumer()

			if bath then
				if not PromptsEnabled then TogglePrompts({ "START_BATHING" }, true) end
				if PromptsEnabled then
					if IsPromptCompleted("START_BATHING") then
						Action("START_BATHING", bath)
					end
				end
			else 
				if PromptsEnabled then TogglePrompts({ "START_BATHING" }, false) end
				Citizen.Wait(250) 
			end

			Citizen.Wait(100)
		end
	end
end)

local playerCoords = nil
GetClosestConsumer = function()
	playerCoords = GetEntityCoords(PlayerPedId())

	for townName,data in pairs(Config.BathingZones) do
        if Vdist(playerCoords, data.consumer) < 1.0 then
			return townName
		end
    end
	return nil
end

RegisterNetEvent('rdr-bathing:StartBath')
AddEventHandler('rdr-bathing:StartBath', function(town)
	inbath = true 
	if Config.BathingZones[town] then
		SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true, 0, true, true)

		LoadAllStreamings()

		LoadModel(`P_CS_RAG02X`)
		local rag = CreateObject(`P_CS_RAG02X`, GetEntityCoords(PlayerPedId()), false, false, false, false, true)
		table.insert(Config.CreatedEntries, { type = "PED", handle = rag })
		SetModelAsNoLongerNeeded(`P_CS_RAG02X`)

		SetPedCanLegIk(PlayerPedId(), false)
		SetPedLegIkMode(PlayerPedId(), 0)
		ClearPedTasksImmediately(PlayerPedId(), true, true)

		local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0, "s_regular_intro", false, true)
		SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
		SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)
		
		LoadAnimScene(animscene)  
		while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED

		TriggerMusicEvent("MG_BATHING_START")
		StartAnimScene(animscene)

		while Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) <= 0.3 do Citizen.Wait(0) end
		UndressCharacter()

		while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(0) end

		local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
		table.insert(Config.CreatedEntries, { type = "CAM", handle = cam })

		N_0x69d65e89ffd72313(true, true)
        SetCamCoord(cam, GetFinalRenderedCamCoord(), 0.0, 0.4, 0.5)
        SetCamRot(cam, GetFinalRenderedCamRot(1), 1)
        SetCamFov(cam, GetFinalRenderedCamFov())
        RenderScriptCams(true, true, 0, true, false, 0)

		TogglePrompts({ "STOP_BATHING", "REQUEST_DELUXE_BATHING", "SCRUB" }, true)

		TriggerEvent("rdr-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { PlayerPedId(), "Script_Mini_Game_Bathing_Regular", `CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR`, `DEFAULT`, "BATHING" })
		TriggerEvent("rdr-bathing:TASK_MOVE_NETWORK_ADVANCED_BY_NAME_WITH_INIT_PARAMS", { rag, "Script_Mini_Game_Bathing_Regular", `CLIPSET@MINI_GAMES@BATHING@REGULAR@RAG`, `DEFAULT`, "BATHING", { Config.BathingZones[town].rag.x, Config.BathingZones[town].rag.y, Config.BathingZones[town].rag.z }, Config.BathingZones[town].rag.w })	
		ForceEntityAiAndAnimationUpdate(rag, true);
		Citizen.InvokeNative(0x55546004A244302A, PlayerPedId())

		local holdTime, bathMode = 0, 1
		while DoesCamExist(cam) do
			while not IsTaskMoveNetworkReadyForTransition(PlayerPedId()) do Citizen.Wait(100) end

			if IsPromptEnabled("SCRUB") and bathMode == #Config.BathingModes+1 then TogglePrompts({ "SCRUB" }, false) end
			if IsControlPressed(0, `INPUT_CONTEXT_X`) and IsPromptEnabled("SCRUB") then
				if IsPromptEnabled("REQUEST_DELUXE_BATHING") then TogglePrompts({ "REQUEST_DELUXE_BATHING" }, false) end

				while GetTaskMoveNetworkState(PlayerPedId()) ~= "Scrub_Idle" do
					RequestTaskMoveNetworkStateTransition(PlayerPedId(), "Scrub_Idle");
					RequestTaskMoveNetworkStateTransition((DoesEntityExist(BathingPed) and BathingPed) or rag, "Scrub_Idle");

					Citizen.Wait(200)
				end

				while IsControlPressed(0, `INPUT_CONTEXT_X`) do
					if IsPromptCompleted("SCRUB") then
						if DoesEntityExist(BathingPed) and not Config.BathingModes[bathMode].deluxe then 
							bathMode = bathMode+1	
						end
						
						holdTime = holdTime + (Config.BathingModes[bathMode].hold_power or 0.01)

						if GetTaskMoveNetworkState(PlayerPedId()) ~= Config.BathingModes[bathMode].transition then
							SetCurrentCleaniest(rag, 0.0)

							RequestTaskMoveNetworkStateTransition(PlayerPedId(), Config.BathingModes[bathMode].transition);
							RequestTaskMoveNetworkStateTransition((DoesEntityExist(BathingPed) and BathingPed) or rag, Config.BathingModes[bathMode].transition);					
						end

						SetTaskMoveNetworkSignalFloat(PlayerPedId(), "scrub_freq", Config.BathingModes[bathMode].scrub_freq);
						SetTaskMoveNetworkSignalFloat((DoesEntityExist(BathingPed) and BathingPed) or rag, "scrub_freq", Config.BathingModes[bathMode].scrub_freq);

						SetCurrentCleaniest(rag, holdTime)

						if holdTime >= 1.0 then
							holdTime = 0.0

							if bathMode+1 > #Config.BathingModes then
								--GAME.PostToastNotification("bath_house", "Jesteś już czysty/a jak łza!", "Możesz opuścić wannę lub zostać i się odpręyć w gorącej wodzie.")  // link own notifications
								TogglePrompts({ "REQUEST_DELUXE_BATHING", "SCRUB" }, false)							
								
								ClearPedEnvDirt(PlayerPedId())
								ClearPedBloodDamage(PlayerPedId())
								N_0xe3144b932dfdff65(PlayerPedId(), 0.0, -1, 1, 1)
								ClearPedDamageDecalByZone(PlayerPedId(), 10, "ALL")
								Citizen.InvokeNative(0x7F5D88333EE8A86F, PlayerPedId(), 1)

								bathMode = #Config.BathingModes+1
								if DoesEntityExist(BathingPed) then
									Citizen.Wait(750) ExitPremiumBath(animscene, town, cam, true)
								end
							else bathMode = bathMode+1 end

							break 
						end
					end

					Citizen.Wait(100)
				end
				while not IsTaskMoveNetworkReadyForTransition(PlayerPedId()) do Citizen.Wait(10) end

				local resetTo = (((bathMode == #Config.BathingModes+1) or DoesEntityExist(BathingPed)) and "Bathing" or "Scrub_Idle")
				while GetTaskMoveNetworkState(PlayerPedId()) ~= resetTo do
					SetCurrentCleaniest(rag, 1.0)
					
					while GetTaskMoveNetworkState(PlayerPedId()) ~= "Scrub_Idle" do
						RequestTaskMoveNetworkStateTransition(PlayerPedId(), "Scrub_Idle");
						RequestTaskMoveNetworkStateTransition((DoesEntityExist(BathingPed) and BathingPed) or rag, "Scrub_Idle");

						Citizen.Wait(200)
					end

					if resetTo ~= "Scrub_Idle" and (DoesEntityExist(BathingPed) and not IsControlPressed(0, `INPUT_CONTEXT_X`) or not DoesEntityExist(BathingPed)) then
						RequestTaskMoveNetworkStateTransition(PlayerPedId(), "Bathing");
						RequestTaskMoveNetworkStateTransition((DoesEntityExist(BathingPed) and BathingPed) or rag, "Bathing");
					elseif resetTo ~= "Scrub_Idle" and DoesEntityExist(BathingPed) and IsControlPressed(0, `INPUT_CONTEXT_X`) then
						resetTo = "Scrub_Idle"
					end

					Citizen.Wait(500)
				end
			end

			if IsPromptCompleted("REQUEST_DELUXE_BATHING") then
				Action("REQUEST_DELUXE_BATHING", animscene, town, cam) 
			end

			if IsPromptCompleted("STOP_BATHING") then
				Action("STOP_BATHING", animscene, town, cam)
				
			end

			Citizen.Wait(10)
		end
	end
end)

RegisterCommand("exitbath", function(source, args)
	if inbath then 
		RenderScriptCams(false, false, 0, true, false, 0)
		DestroyCam(cam) 
		ExecuteCommand('rc')
		ExecuteCommand('sa')
		SetEntityCoords(PlayerPedId(),-320.5,762.26,116.43)
		UnloadAllStreamings()
		TriggerMusicEvent("MG_BATHING_STOP")
		TriggerServerEvent("rdr-bathing:setBathAsFree", town)
		TogglePrompts("ALL", false)
		N_0x69d65e89ffd72313(false, false)
		Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
		SetPedCanLegIk(PlayerPedId(), true)
		SetPedLegIkMode(PlayerPedId(), 2)
		inbath = false 
	end
end)

ExitBathing = function(animscene, town, cam)
	inbath = false 
	if DoesEntityExist(BathingPed) then
		ExitPremiumBath(animscene, town, cam)
		return
	end

	if Citizen.InvokeNative(0x25557E324489393C, animscene) then 
		Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE
	end

	local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0,  "s_regular_outro", false, true)
	SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
	SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)

	LoadAnimScene(animscene)  
	while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED
	StartAnimScene(animscene)

	if DoesCamExist(cam) then 
		RenderScriptCams(false, false, 0, true, false, 0)
		DestroyCam(cam) 
	end

	while Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) <= 0.35 do Citizen.Wait(1) end
	DressCharacter()

	while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_FINISHED
	
	UnloadAllStreamings()
	N_0x69d65e89ffd72313(false, false)
	TriggerMusicEvent("MG_BATHING_STOP")
	Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
	TriggerServerEvent("rdr-bathing:setBathAsFree", town)

	if DoesEntityExist(Citizen.InvokeNative(0xE5822422197BBBA3, animscene, "Female", false)) then
		DeletePed(Citizen.InvokeNative(0xE5822422197BBBA3, animscene, "Female", false))
	end

	SetPedCanLegIk(PlayerPedId(), true)
	SetPedLegIkMode(PlayerPedId(), 2)
end
RegisterNetEvent('rdr-bathing:StartDeluxeBath')
AddEventHandler('rdr-bathing:StartDeluxeBath', function(animscene, town, cam)
	if not IsPedMale(PlayerPedId()) then
		if not Citizen.InvokeNative(0x25557E324489393C, animscene) then return end
		Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE

		local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0,  "s_deluxe_intro", false, true)
		SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
		SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)
		
		LoadModel(Config.BathingZones[town].guy)
		BathingPed = CreatePed(Config.BathingZones[town].guy, GetEntityCoords(PlayerPedId())-vector3(0.0, 0.0, -5.0), 0.0, false, false, true, true)
		table.insert(Config.CreatedEntries, { type = "PED", handle = BathingPed })
		Citizen.InvokeNative(0x283978A15512B2FE, BathingPed, true)
		SetAnimSceneEntity(animscene, "Female", BathingPed, 0)
		SetModelAsNoLongerNeeded(Config.BathingZones[town].guy)

		LoadAnimScene(animscene)  
		while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED
		PlaySoundFrontend("BATHING_DOOR_KNOCK_MASTER", 0, true, 0)
		Citizen.Wait(1000)
		StartAnimScene(animscene)

		RenderScriptCams(false, false, 0, true, false, 0)

		while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_FINISHED
		Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE

		TriggerEvent("rdr-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { PlayerPedId(), "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@DELUXE@ARTHUR`, `DEFAULT`, "BATHING" })
		TriggerEvent("rdr-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { BathingPed, "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@DELUXE@MAID`, `DEFAULT`, "BATHING" })	
			
		TogglePrompts({ "STOP_BATHING", "SCRUB" }, true)

		RenderScriptCams(true, true, 0, true, false, 0)
	else
		if not Citizen.InvokeNative(0x25557E324489393C, animscene) then return end
		Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE

		local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0,  "s_deluxe_intro", false, true)
		SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
		SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)
		
		LoadModel(Config.BathingZones[town].lady)
		BathingPed = CreatePed(Config.BathingZones[town].lady, GetEntityCoords(PlayerPedId())-vector3(0.0, 0.0, -5.0), 0.0, false, false, true, true)
		table.insert(Config.CreatedEntries, { type = "PED", handle = BathingPed })
		Citizen.InvokeNative(0x283978A15512B2FE, BathingPed, true)
		SetAnimSceneEntity(animscene, "Female", BathingPed, 0)
		SetModelAsNoLongerNeeded(Config.BathingZones[town].lady)

		LoadAnimScene(animscene)  
		while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED
		PlaySoundFrontend("BATHING_DOOR_KNOCK_MASTER", 0, true, 0)
		Citizen.Wait(1000)
		StartAnimScene(animscene)

		RenderScriptCams(false, false, 0, true, false, 0)

		while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_FINISHED
		Citizen.InvokeNative(0x84EEDB2C6E650000, animscene) --// _DELETE_ANIM_SCENE

		TriggerEvent("rdr-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { PlayerPedId(), "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@DELUXE@ARTHUR`, `DEFAULT`, "BATHING" })
		TriggerEvent("rdr-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { BathingPed, "Script_Mini_Game_Bathing_Deluxe", `CLIPSET@MINI_GAMES@BATHING@DELUXE@MAID`, `DEFAULT`, "BATHING" })	
			
		TogglePrompts({ "STOP_BATHING", "SCRUB" }, true)

		RenderScriptCams(true, true, 0, true, false, 0)
	end
end)

RegisterNetEvent('rdr-bathing:HideDeluxePrompt')
AddEventHandler('rdr-bathing:HideDeluxePrompt', function()
	TogglePrompts({ "REQUEST_DELUXE_BATHING" }, false)
end)

ExitPremiumBath = function(animscene, town, cam, disableScrub)
	local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.BathingZones[town].dict, 0,  "s_deluxe_outro", false, true)
	SetAnimSceneEntity(animscene, "ARTHUR", PlayerPedId(), 0)
	SetAnimSceneEntity(animscene, "Female", BathingPed, 0)
	SetAnimSceneEntity(animscene, "Door", N_0xf7424890e4a094c0(Config.BathingZones[town].door, 0), 0)

	LoadAnimScene(animscene)  
	while not Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_LOADED
	StartAnimScene(animscene)

	RenderScriptCams(false, false, 0, true, false, 0)

	while not Citizen.InvokeNative(0xD8254CB2C586412B, animscene, true) do Citizen.Wait(10) end --// _IS_ANIM_SCENE_FINISHED

	TriggerEvent("rdr-bathing:TASK_MOVE_NETWORK_BY_NAME_WITH_INIT_PARAMS", { PlayerPedId(), "Script_Mini_Game_Bathing_Regular", `CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR`, `DEFAULT`, "BATHING" })
	TriggerEvent("rdr-bathing:TASK_MOVE_NETWORK_ADVANCED_BY_NAME_WITH_INIT_PARAMS", { rag, "Script_Mini_Game_Bathing_Regular", `CLIPSET@MINI_GAMES@BATHING@REGULAR@RAG`, `DEFAULT`, "BATHING", { Config.BathingZones[town].rag.x, Config.BathingZones[town].rag.y, Config.BathingZones[town].rag.z }, Config.BathingZones[town].rag.w })	
		
	TogglePrompts({ "STOP_BATHING", "SCRUB" }, true)
	if IsPromptEnabled("SCRUB") and disableScrub then TogglePrompts({ "SCRUB" }, false) end

	RenderScriptCams(true, true, 0, true, false, 0)
	DeletePed(BathingPed)
end

LoadModel = function(model)
	while not HasModelLoaded(model) do RequestModel(model) Citizen.Wait(10) end
end

LoadAllStreamings = function()
	RequestAnimDict("MINI_GAMES@BATHING@REGULAR@ARTHUR");
	RequestAnimDict("MINI_GAMES@BATHING@REGULAR@RAG");
	RequestAnimDict("MINI_GAMES@BATHING@DELUXE@ARTHUR");
	RequestAnimDict("MINI_GAMES@BATHING@DELUXE@MAID");

	RequestClipSet("CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR");
	RequestClipSet("CLIPSET@MINI_GAMES@BATHING@REGULAR@RAG");
	RequestClipSet("CLIPSET@MINI_GAMES@BATHING@DELUXE@ARTHUR");
	RequestClipSet("CLIPSET@MINI_GAMES@BATHING@DELUXE@MAID");

	Citizen.InvokeNative(0x2B6529C54D29037A, "Script_Mini_Game_Bathing_Regular");
	Citizen.InvokeNative(0x2B6529C54D29037A, "Script_Mini_Game_Bathing_Deluxe");
end

UnloadAllStreamings = function()
	RemoveAnimDict("MINI_GAMES@BATHING@REGULAR@ARTHUR");
	RemoveAnimDict("MINI_GAMES@BATHING@REGULAR@RAG");
	RemoveAnimDict("MINI_GAMES@BATHING@DELUXE@ARTHUR");
	RemoveAnimDict("MINI_GAMES@BATHING@DELUXE@MAID");

	RemoveClipSet("CLIPSET@MINI_GAMES@BATHING@REGULAR@ARTHUR");
	RemoveClipSet("CLIPSET@MINI_GAMES@BATHING@REGULAR@RAG");
	RemoveClipSet("CLIPSET@MINI_GAMES@BATHING@DELUXE@ARTHUR");
	RemoveClipSet("CLIPSET@MINI_GAMES@BATHING@DELUXE@MAID");

	Citizen.InvokeNative(0x57A197AD83F66BBF, "Script_Mini_Game_Bathing_Regular");
	Citizen.InvokeNative(0x57A197AD83F66BBF, "Script_Mini_Game_Bathing_Deluxe");
end

UndressCharacter = function() --// link own undress logic
	ExecuteCommand('undress')
end

DressCharacter = function() --// link own dress logic
	ExecuteCommand('rc')
end

SetCurrentCleaniest = function(rag, value)
	SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Right_Arm", value);
	SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Left_Arm", value);
	SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Left_Leg", value);
	SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Right_Leg", value);
	SetTaskMoveNetworkSignalFloat(PlayerPedId(), "Cleanliness_Head", value);

	SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Right_Arm", value);
	SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Left_Arm", value);
	SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Left_Leg", value);
	SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Right_Leg", value);
	SetTaskMoveNetworkSignalFloat(rag, "Cleanliness_Head", value);

	if DoesEntityExist(BathingPed) then
		SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Right_Arm", value);
		SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Left_Arm", value);
		SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Left_Leg", value);
		SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Right_Leg", value);
		SetTaskMoveNetworkSignalFloat(BathingPed, "Cleanliness_Head", value);
	end
end

Action = function(name, p1, p2, p3)
	TogglePrompts("ALL", false)

	if (name == "START_BATHING") then
		TriggerServerEvent("rdr-bathing:canEnterBath", p1)
	elseif (name == "REQUEST_DELUXE_BATHING") then
		TriggerServerEvent("rdr-bathing:canEnterDeluxeBath", p1 , p2 , p3)
	elseif (name == "STOP_BATHING") then
		ExitBathing(p1, p2, p3)
	end

	Citizen.Wait(500)
end

--[[ Prompts ]]--
RegisterPrompts = function()
    local newTable = {}

    for i=1, #Config.Prompts do
        local prompt = Citizen.InvokeNative(0x04F97DE45A519419, Citizen.ResultAsInteger())
        Citizen.InvokeNative(0x5DD02A8318420DD7, prompt, CreateVarString(10, "LITERAL_STRING", Config.Prompts[i].label))
        Citizen.InvokeNative(0xB5352B7494A08258, prompt, Config.Prompts[i].control or 0xDFF812F9)
        Citizen.InvokeNative(0x94073D5CA3F16B7B, prompt, Config.Prompts[i].time or 1000)

        Citizen.InvokeNative(0xF7AA2696A22AD8B9, prompt)

        Citizen.InvokeNative(0x8A0FB4D03A630D21, prompt, false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, prompt, false)

        table.insert(Config.CreatedEntries, { type = "PROMPT", handle = prompt })
        newTable[Config.Prompts[i].id] = prompt
    end

    Config.Prompts = newTable
    return true
end
TogglePrompts = function(data, state)
    for index,prompt in pairs((data ~= "ALL" and data) or Config.Prompts) do
        if Config.Prompts[(data ~= "ALL" and prompt) or index] then
            Citizen.InvokeNative(0x8A0FB4D03A630D21, (data ~= "ALL" and Config.Prompts[prompt]) or prompt, state)
            Citizen.InvokeNative(0x71215ACCFDE075EE, (data ~= "ALL" and Config.Prompts[prompt]) or prompt, state)
        end
    end
    PromptsEnabled = state
end
IsPromptCompleted = function(name)
    if Config.Prompts[name] then
        return Citizen.InvokeNative(0xE0F65F0640EF0617, Config.Prompts[name])
    end return
end
IsPromptEnabled = function(name)
    if Config.Prompts[name] then
		return PromptIsEnabled(Config.Prompts[name])
    end return
end

--[[ Blips ]]--
CreateBlips = function()
	for townName,data in pairs(Config.BathingZones) do
        Citizen.Wait(10)
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 0xB04092F8, data.consumer)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, CreateVarString(10, "blip_bath_house"))
        SetBlipSprite(blip, `blip_bath_house`)

        table.insert(Config.CreatedEntries, { type = "BLIP", handle = blip })
    end
end

--[[ Doors ]]--
CloseBathDoors = function()
	for townName,data in pairs(Config.BathingZones) do
        if data.door then
			if not IsDoorRegisteredWithSystem(data.door) then
                Citizen.InvokeNative(0xD99229FE93B46286, data.door, 1, 1, 0, 0, 0, 0)
				DoorSystemSetDoorState(data.door, 1)     
            end
		end
    end	  
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        for i=1, #Config.CreatedEntries do
            if Config.CreatedEntries[i].type == "PED" then
                if DoesEntityExist(Config.CreatedEntries[i].handle) then DeleteEntity(Config.CreatedEntries[i].handle) end
            elseif Config.CreatedEntries[i].type == "BLIP" then
                RemoveBlip(Config.CreatedEntries[i].handle)
            elseif Config.CreatedEntries[i].type == "PROMPT" then
                Citizen.InvokeNative(0x00EDE88D4D13CF59, Config.CreatedEntries[i].handle)
			elseif Config.CreatedEntries[i].type == "CAM" then
				if DoesCamExist(Config.CreatedEntries[i].handle) then RenderScriptCams(false, false, 0, false, false, false) DestroyCam(Config.CreatedEntries[i].handle) end
            end
        end
	end
end)

--[[

void func_217(int iParam0)
{
	if (iParam0->f_15 == 0)
	{
		switch (iParam0->f_115)
		{
			case 1:
				if (!GRAPHICS::DOES_PARTICLE_FX_LOOPED_EXIST(&(iParam0->f_120[0])))
				{
					iParam0->f_120[0] = GRAPHICS::START_PARTICLE_FX_LOOPED_ON_PED_BONE("scr_mg_bathing_foam_head", Global_35, 0f, 0f, 0f, 0f, 0f, 0f, 21030, 0.4f, false, false, false);
				}
				if (!GRAPHICS::DOES_PARTICLE_FX_LOOPED_EXIST(&(iParam0->f_120[5])))
				{
					iParam0->f_120[5] = GRAPHICS::START_PARTICLE_FX_LOOPED_ON_PED_BONE("scr_mg_bathing_foam_torso", Global_35, 0f, 0f, 0f, 0f, 0f, 0f, 14412, 0.4f, false, false, false);
				}
				break;
			case 2:
				if (iParam0->f_36 >= 1)
				{
					if (!GRAPHICS::DOES_PARTICLE_FX_LOOPED_EXIST(&(iParam0->f_120[4])))
					{
						iParam0->f_120[4] = GRAPHICS::START_PARTICLE_FX_LOOPED_ON_PED_BONE("scr_mg_bathing_foam_forearm", Global_35, 0f, 0f, 0f, 0f, 0f, 0f, 53675, 0.5f, false, false, false);
					}
					if (!GRAPHICS::DOES_PARTICLE_FX_LOOPED_EXIST(&(iParam0->f_120[2])))
					{
						iParam0->f_120[2] = GRAPHICS::START_PARTICLE_FX_LOOPED_ON_PED_BONE("scr_mg_bathing_foam_upperarm", Global_35, 0f, 0f, 0f, 0f, 0f, 0f, 37873, 0.6f, false, false, false);
					}
				}
				else
				{
					if (!GRAPHICS::DOES_PARTICLE_FX_LOOPED_EXIST(&(iParam0->f_120[1])))
					{
						iParam0->f_120[1] = GRAPHICS::START_PARTICLE_FX_LOOPED_ON_PED_BONE("scr_mg_bathing_foam_upperarm", Global_35, 0f, 0f, 0f, 0f, 0f, 0f, 46065, 0.6f, false, false, false);
					}
					if (!GRAPHICS::DOES_PARTICLE_FX_LOOPED_EXIST(&(iParam0->f_120[3])))
					{
						iParam0->f_120[3] = GRAPHICS::START_PARTICLE_FX_LOOPED_ON_PED_BONE("scr_mg_bathing_foam_forearm", Global_35, 0f, 0f, 0f, 0f, 0f, 0f, 54187, 0.5f, false, false, false);
					}
				}
				break;
			case 3:
				if (iParam0->f_37 >= 1)
				{
					if (!GRAPHICS::DOES_PARTICLE_FX_LOOPED_EXIST(&(iParam0->f_120[7])))
					{
						iParam0->f_120[7] = GRAPHICS::START_PARTICLE_FX_LOOPED_ON_PED_BONE("scr_mg_bathing_foam_upperarm", Global_35, 0f, 0f, 0f, 0f, 0f, 0f, 6884, 1.5f, false, false, false);
					}
				}
				else if (!GRAPHICS::DOES_PARTICLE_FX_LOOPED_EXIST(&(iParam0->f_120[8])))
				{
					iParam0->f_120[8] = GRAPHICS::START_PARTICLE_FX_LOOPED_ON_PED_BONE("scr_mg_bathing_foam_upperarm", Global_35, 0f, 0f, 0f, 0f, 0f, 0f, 65478, 1.5f, false, false, false);
				}
				break;
		}
	}
}

PED::_0xE3144B932DFDFF65(iParam0, 0f, -1, 1, 1);
	PED::CLEAR_PED_ENV_DIRT(iParam0);
	PED::CLEAR_PED_DAMAGE_DECAL_BY_ZONE(iParam0, 10, "ALL");
	PED::CLEAR_PED_BLOOD_DAMAGE(Global_35);

void func_235()
{
	char* sVar0;

	if (PED::IS_PED_RAGDOLL(Global_35))
	{
		return;
	}
	if (CAM::_0xA24C1D341C6E0D53(1, 1, 1))
	{
		return;
	}
	if (!func_9(1))
	{
		return;
	}
	sVar0 = "outfit_change_unarmed";
	switch (Global_1946804->f_859)
	{
		case 1:
			sVar0 = "outfit_change_longarms";
			break;
		case 0:
			sVar0 = "outfit_change_offhand";
			break;
		case 2:
			sVar0 = "outfit_change_unarmed";
			break;
	}
	TASK::TASK_PLAY_ANIM(Global_35, func_344(), sVar0, 8f, -8f, -1, 67108880, 0f, false, 0, false, "Satchel_and_ik_hand_helpers_filter", false);
	func_91(1);
	STREAMING::REMOVE_ANIM_DICT(func_344());
}

char* func_344()
{
	return "MECH_INVENTORY@CLOTHING@OUTFIT_CHANGE";
}

PED::_0xE3144B932DFDFF65(Global_35, 0f, -1, 1, 1);
																PED::CLEAR_PED_DAMAGE_DECAL_BY_ZONE(Global_35, 10, "ALL");
																PED::CLEAR_PED_BLOOD_DAMAGE(Global_35);
																func_16(iParam0);
																AUDIO::TRIGGER_MUSIC_EVENT("MG_BATHING_STOP");
																INVENTORY::_0xE36D4A38D28D9CFB(0);
																INVENTORY::_0x5D6182F3BCE1333B(5, -142743235);
																if (ENTITY::DOES_ENTITY_EXIST(iParam0->f_135))
																{
																	ANIMSCENE::REMOVE_ANIM_SCENE_ENTITY(iParam0->f_68, "FEMALE", iParam0->f_135);
																	ENTITY::FREEZE_ENTITY_POSITION(iParam0->f_135, true);
																	PED::DELETE_PED(&(iParam0->f_135));
																}
																if (ENTITY::DOES_ENTITY_EXIST(BathingPed))
																{
																	ENTITY::FREEZE_ENTITY_POSITION(BathingPed, true);
																	PED::DELETE_PED(&(BathingPed));
																}
																iParam0->f_16 = 1;
																AUDIO::RELEASE_NAMED_SCRIPT_AUDIO_BANK("BATHING");
																AUDIO::_0x531A78D6BF27014B("BATHING_Sounds");
					
]]
