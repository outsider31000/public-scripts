StartShow = function(show, projection, movie)
	if Config.Shows[show] then
		local preventAnimscene, movieData = false, nil

		if (show:upper() == "MOVIE") then
			if IsMovieValid(projection, movie) then
				movieData = SetupMovie(projection, movie)
				projection, movie = Config.Projections[projection], Config.Movies[movie]
			else 
				print("Invalid movie or projection.") 
				return
			end
		end

		local rope, attachment = nil, nil
		local animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, Config.Shows[show].animscene[1], Config.Shows[show].animscene[2], Config.Shows[show].animscene[3], Config.Shows[show].animscene[4], Config.Shows[show].animscene[5]) --// _CREATE_ANIM_SCENE / ->f_48

		if animscene then
			if Config.Shows[show].position then

				SetAnimSceneOrigin(animscene, Config.Shows[show].position, Config.Shows[show].rotation, 2);
			end

			for index,entity in ipairs(Config.Shows[show].entities) do 
				local handle = 0

				if IsModelInCdimage(entity.model) or type(entity.model) == "string" then
					if IsModelInCdimage(entity.model) then
						while not HasModelLoaded(entity.model) do RequestModel(entity.model) Citizen.Wait(10) end
					end

					if IsModelAPed(entity.model) then
						handle = CreatePed(entity.model, vector3(0.0, 0.0, -500.0), 0.0, false, false, true, true);			
						AddEntityToAudioMixGroup(handle, "Default_Show_Performers_Group", -1.0);
						Citizen.InvokeNative(0x283978A15512B2FE, handle, true)

						if entity.flags then
							for _,flag in ipairs(entity.flags) do
								SetPedConfigFlag(handle, flag, true)
							end
						end

						if entity.ragdoll ~= nil then
							SetPedCanRagdoll(handle, false)			
						end

						if entity.ragdollFlag then
							SetRagdollBlockingFlags(handle, entity.ragdollFlag)
						end
					elseif type(entity.model) == "string" then	
						if IsWeaponValid(GetHashKey(entity.model)) then
							handle = Citizen.InvokeNative(0x9888652B8BA77F73, GetHashKey(entity.model), 0, vector3(0.0, 0.0, 0.0), true, 1.0);
						end
					else
						handle = CreateObject(entity.model, vector3(0.0, 0.0, -500.0), false, false, false, true, true);
					end

					SetAnimSceneEntity(animscene, entity.fields[1], handle, entity.fields[2])
					SetModelAsNoLongerNeeded(entity.model)
				end
			end

			LoadAnimScene(animscene)  
			while not _IsAnimSceneLoaded(animscene) do Citizen.Wait(10) end

			local curtain, curtainZone = GetShowCurtain(show)
			if curtain then
				ResetCurtain(curtainZone)

				if not _IsAnimSceneLoaded(curtain.animscene) then
					LoadAnimScene(curtain.animscene)  
					while not _IsAnimSceneLoaded(curtain.animscene) do Citizen.Wait(10) end
				end

				StartAnimScene(animscene)
				SetAnimScenePaused(animscene, true)

				StartAnimScene(curtain.animscene)
				while not _IsAnimSceneStarted(curtain.animscene) do Citizen.Wait(10) end

				PlayCurtainSound(Config.Shows[show].music)
				SetAnimScenePlaybackList(curtain.animscene, "PBL_OPEN_SLOW")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, curtain.animscene, "PBL_OPEN_SLOW", true)	

				if (show == "ESCAPENOOSE") and not rope then 
					rope, attachment = CreateNooseRope(animscene)
				end

				while not _IsAnimSceneStarted(curtain.animscene) do Citizen.Wait(10) end
				while not (_GetAnimsceneProgress(curtain.animscene) > 0.5) do Citizen.Wait(10) end
			
				SetAnimScenePlaybackList(curtain.animscene, "PBL_IDLE_OPEN")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, curtain.animscene, "PBL_IDLE_OPEN", true)
				SetAnimScenePaused(animscene, false)
			end

			if (show == "ESCAPENOOSE") and not rope then 
				rope, attachment = CreateNooseRope(animscene)
			end

			while not _IsAnimSceneStarted(animscene) do StartAnimScene(animscene) Citizen.Wait(100) end
			if not (show:upper() == "MOVIE") then
				while not _IsAnimSceneFinished(animscene) do Citizen.Wait(10) end
			end
		
			--// Sequences
			if Config.Shows[show].sequence then
				for index,transition in ipairs(Config.Shows[show].sequence) do
					if type(transition) == "table" then
						if Config.RandomTransitions then
							transition = transition[math.random(1, #transition)]
						else transition = transition[1] end
					end

					SetAnimScenePlaybackList(animscene, transition)
					Citizen.InvokeNative(0x15598CFB25F3DC7E, animscene, transition, true)

					while not _IsAnimSceneStarted(animscene) do Citizen.Wait(1) end

					if (show == "ESCAPENOOSE" and transition == "PL_E_Shoot_Rope") then
						if rope then
							DetachRopeFromEntity(rope, Citizen.InvokeNative(0xFB5674687A1B2814, animscene, "Noose", false))
						end
					end

					if (index == #Config.Shows[show].sequence) and Config.Shows[show].endAtProgress then
						break
					end

					while not _IsAnimSceneFinished(animscene) do print(_GetAnimsceneProgress(animscene)) Citizen.Wait(1) end
				end
			end

			if Config.Shows[show].endAtProgress then
				while not (_GetAnimsceneProgress(animscene) >= Config.Shows[show].endAtProgress) do Citizen.Wait(10) end
			end

			if curtain then
				SetAnimScenePlaybackList(curtain.animscene, "PBL_CLOSE_SLOW")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, curtain.animscene, "PBL_CLOSE_SLOW", true)

				while not _IsAnimSceneStarted(curtain.animscene) do Citizen.Wait(10) end
				while not (_GetAnimsceneProgress(curtain.animscene) > 0.5) do Citizen.Wait(10) end

				SetAnimScenePlaybackList(curtain.animscene, "PBL_IDLE_CLOSED")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, curtain.animscene, "PBL_IDLE_CLOSED", true)
			end
		end

		--// Movie player
		if (show:upper() == "MOVIE") then
			if animscene then 
				SetAnimScenePlaybackList(animscene, "pl_action")
				Citizen.InvokeNative(0x15598CFB25F3DC7E, animscene, "pl_action", true)
			
				while not _IsAnimSceneStarted(animscene) do Citizen.Wait(10) end
			end
		
			SetTvAudioFrontend(false)
			SetTvVolume(projection.volume)

			AttachTvAudioToEntity(movieData.screen)
			N_0xf49574e2332a8f06(movieData.screen, 5.0)
			N_0x04d1d4e411ce52d0(movieData.screen, movieData.renderTarget)

			SetTvChannel(-1)
			SetTvChannelPlaylist(0, movie.clip, true)
			SetTvChannel(0)

			_LoadStream(movie.audio)
			local stream = N_0x0556c784fa056628("Audience", movie.audio)
			PlayStreamFromPosition(projection.audiencePos, stream)

			Citizen.Wait(100)
			SetEntityVisible(movieData.screen, true)

			while IsStreamPlaying(stream) do
				if (projection.radius and (Vdist(GetEntityCoords(PlayerPedId()), projection.audiencePos) <= projection.radius)) or not projection.radius then
					SetTextRenderId(movieData.renderTarget)
					DrawTvChannel(projection.renderX, projection.renderY, projection.renderScaleX, projection.renderScaleY, 0.0, 255, 255, 255, 128)
				end

				Citizen.Wait(5)
			end
		end

		--// Cleanup show
		if (show:upper() == "MOVIE") then
			SetTvChannel(-1)
			SetTextRenderId(0)
			DeleteEntity(movieData.screen)

			if IsStreamPlaying(stream) then
				StopStream(stream)
			end

			if IsNamedRendertargetRegistered(projection.renderTarget) then
				ReleaseNamedRendertarget(projection.renderTarget)
			end
		end

		--// Cleanup animscene
		if animscene then
			if not (show:upper() == "MOVIE") then
				while not _IsAnimSceneFinished(animscene) do Citizen.Wait(10) end
			end

			if rope or attachment then 
				DeleteRope(rope)
				DeleteEntity(attachment) 
			end

			for index,entity in ipairs(Config.Shows[show].entities) do 
				if IsModelAPed(entity.model) then
					DeleteEntity(Citizen.InvokeNative(0xE5822422197BBBA3, animscene, entity.fields[1], false))
				elseif IsModelAVehicle(entity.model) then
					DeleteEntity(Citizen.InvokeNative(0x430EE0A19BC5A287, animscene, entity.fields[1], false))
				else
					DeleteEntity(Citizen.InvokeNative(0xFB5674687A1B2814, animscene, entity.fields[1], false))
				end
			end
			Citizen.InvokeNative(0x84EEDB2C6E650000, animscene)
		end
	end
end

SetupMovie = function(projection, movie)
	projection, movie = Config.Projections[projection], Config.Movies[movie]

	Config.Shows["MOVIE"].animscene[1] = movie.animscene or "script@shows@magic_lantern@ig2_projectionist@thebear"
	Config.Shows["MOVIE"].position = projection.originPos
	Config.Shows["MOVIE"].rotation = projection.originRot

	while not HasModelLoaded(projection.targetModel) do RequestModel(projection.targetModel) Citizen.Wait(10) end
	local screen = CreateObjectNoOffset(projection.targetModel, projection.screenPos, false, false, false, true)
	SetEntityRotation(screen, projection.screenRot, 2, true)
	SetEntityVisible(screen, false)
	SetEntityDynamic(screen, false)
	SetEntityProofs(screen, 31, false)
	FreezeEntityPosition(screen, true)
	SetModelAsNoLongerNeeded(projection.targetModel)

	if not IsNamedRendertargetRegistered(projection.renderTarget) then
		RegisterNamedRendertarget(projection.renderTarget, false)
		LinkNamedRendertarget(projection.targetModel)

		if not IsNamedRendertargetLinked(projection.targetModel) then	
			ReleaseNamedRendertarget(projection.renderTarget)
			print('Failed to link Render Target.')
			return
		end
	end

	return { screen = screen, renderTarget = GetNamedRendertargetRenderId(projection.renderTarget) }
end

IsMovieValid = function(projection, movie)
	return (Config.Projections[projection] and Config.Movies[movie])
end

GetShowCurtain = function(zone)
	if Config.Shows[zone] and Config.Shows[zone].curtain then
		return Config.Curtains[Config.Shows[zone].curtain], Config.Shows[zone].curtain
	end

	return
end

PlayCurtainSound = function(soundName)
	if not soundName then
		if math.random(1,2) == 2 then
			soundName = "Curtain_Opens_Music"
		else
			soundName = "Curtain_Open_Music"
		end
	end

	if Config.Soundsets[soundName] then
		while not LoadStream(soundName, Config.Soundsets[soundName]) do Citizen.Wait(10) end

		local stream = N_0x0556c784fa056628(soundName, Config.Soundsets[soundName])
		if (stream ~= -1) then
			N_0x839c9f124be74d94(stream, 0, 2548.749, -1305.267, 50.01453)
			N_0x839c9f124be74d94(stream, 1, 2543.801, -1305.251, 50.01453)

			PlayStreamFromPosition(2548.749, -1305.267, 50.01453, stream)
		end
	end
end

CreateCurtains = function()
	while not HasModelLoaded(`p_new_theater_curtain`) do RequestModel(`p_new_theater_curtain`) Citizen.Wait(10) end

	for zone,coords in pairs(Config.Curtains) do
		Config.Curtains[zone] = { object = CreateObject(`p_new_theater_curtain`, coords, false, false, false, false) }
		Config.Curtains[zone].animscene = Citizen.InvokeNative(0x1FCA98E33C1437B3, "script@shows@curtains@curtains", 0, "PBL_IDLE_CLOSED", false, true)
		SetAnimSceneEntity(Config.Curtains[zone].animscene, "CURTAIN", Config.Curtains[zone].object, 0)
	end

	SetModelAsNoLongerNeeded(`p_new_theater_curtain`)
end

ResetCurtain = function(zone)
	if Config.Curtains[zone] then
		ResetAnimScene(Config.Curtains[zone].animscene, 0)

		SetAnimSceneEntity(Config.Curtains[zone].animscene, "CURTAIN", Config.Curtains[zone].object, 0)

		SetAnimScenePlaybackList(Config.Curtains[zone].animscene, "PBL_IDLE_CLOSED")
		Citizen.InvokeNative(0x15598CFB25F3DC7E, Config.Curtains[zone].animscene, "PBL_IDLE_CLOSED", true)
	end
end

CreateNooseRope = function(animscene)
	local noose = Citizen.InvokeNative(0xFB5674687A1B2814, animscene, "Noose", false)

	if DoesEntityExist(noose) then
		while not HasModelLoaded(`P_SHOTGLASS01X`) do RequestModel(`P_SHOTGLASS01X`) Citizen.Wait(10) end
		local ropeAttachment = CreateObject(`P_SHOTGLASS01X`, GetOffsetFromEntityInWorldCoords(noose, 0.0, -0.6, 0.6023343), false, false, false, false, false)

		local rope = Citizen.InvokeNative(0xE9C59F6809373A99, 2546.724, -1309.638, 50.76665, 0.0, 0.0, 0.0, 0.3, 1, 0, -1, -1082130432)
		N_0x462ff2a432733a44(rope, ropeAttachment, noose, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0) --// ATTACH_ENTITIES_TO_ROPE ?
		N_0x522fa3f490e2f7ac(rope, 1, 1)

		SetModelAsNoLongerNeeded(`P_SHOTGLASS01X`)

		return rope, ropeAttachment
	end

	return nil
end

_LoadStream = function(soundSet)
	local timeout = 0
	while not LoadStream("Audience", soundSet) do
		if timeout > 4 then break end
		timeout = timeout+1

		Citizen.Wait(25) 
	end
end
_IsAnimSceneLoaded = function(animscene)
	return Citizen.InvokeNative(0x477122B8D05E7968, animscene, 1, 0)
end
_IsAnimSceneStarted = function(animscene)
	return Citizen.InvokeNative(0xCBFC7725DE6CE2E0, animscene, true)
end
_IsAnimSceneFinished = function(animscene)
	return (Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat()) == 1.0)
end
_IsAnimSceneFinished_2 = function(animscene)
	return Citizen.InvokeNative(0xD8254CB2C586412B, animscene, 0)
end
_GetAnimsceneProgress = function(animscene)
	return Citizen.InvokeNative(0x3FBC3F51BF12DFBF, animscene, Citizen.ResultAsFloat())
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

CreateBlips = function()
	for town,data in pairs(Config.Projections) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 0xB04092F8, data.originPos)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, CreateVarString(10, "LITERAL_STRING", "Theatre"))
        SetBlipSprite(blip, `blip_ambient_theatre`)

        table.insert(Config.CreatedEntries, { type = "BLIP", handle = blip })
	end
	
	local blip = Citizen.InvokeNative(0x554D9D53F696D002, 0xB04092F8, Config.Shows["CANCAN_A"].position)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, CreateVarString(10, "LITERAL_STRING", "Theatre"))
    SetBlipSprite(blip, `blip_ambient_theatre`)

    table.insert(Config.CreatedEntries, { type = "BLIP", handle = blip })
end

RegisterNetEvent("syn_cinema:startShow")
AddEventHandler("syn_cinema:startShow", function(show)
	if type(show) == "table" then
		StartShow("MOVIE", show.town, show.name)
	else
		StartShow(show)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _,entry in ipairs(Config.CreatedEntries) do
			if (entry.type == "ENTITY") then
				 if DoesEntityExist(entry.handle) then DeleteEntity(entry.handle) end
			elseif (entry.type == "BLIP") then
				RemoveBlip(entry.handle)
			elseif (entry.type == "PROMPT") then
				Citizen.InvokeNative(0x00EDE88D4D13CF59, entry.handle)
			elseif (entry.type == "CAM") then
				if DoesCamExist(entry.handle) then RenderScriptCams(false, false, 0, false, false, false) DestroyCam(entry.handle) end            
			end
		end

		for _,curtain in pairs(Config.Curtains) do
			if type(curtain) == "table" then
				DeleteEntity(curtain.object)
				Citizen.InvokeNative(0x84EEDB2C6E650000, curtain.animscene)
			end
		end
	end
end)

Citizen.SetTimeout(0, CreateBlips)
Citizen.SetTimeout(0, CreateCurtains)