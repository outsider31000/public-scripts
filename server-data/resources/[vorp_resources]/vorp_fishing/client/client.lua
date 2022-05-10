local fishing_minigame_struct = {}
local fishing_lure_cooldown = 0
local ready = false
local fishing = false
local fishStatus = 0
local fishForce = 0.6
local nextAttTime = 0
local horizontalMove = 0
local lastState = 0

local fishing_data = {
    fish                   = { weight = 0, rodweight },
    prompt_prepare_fishing = { group, change_bait, throw_hook },
    prompt_waiting_hook    = { group, hook_fish, reel_lure, cancel },
    prompt_hook            = { group, reel, cancel },
    prompt_finish          = { group, keep, throw_fish }
}

local fishs = {
    [`A_C_FISHBLUEGIL_01_MS`]        = Config.fishData.A_C_FISHBLUEGIL_01_MS[1],
    [`A_C_FISHBLUEGIL_01_SM`]        = Config.fishData.A_C_FISHBLUEGIL_01_SM[1],
    [`A_C_FISHBULLHEADCAT_01_MS`]    = Config.fishData.A_C_FISHBULLHEADCAT_01_MS[1],
    [`A_C_FISHBULLHEADCAT_01_SM`]    = Config.fishData.A_C_FISHBULLHEADCAT_01_SM[1],
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = Config.fishData.A_C_FISHCHAINPICKEREL_01_MS[1],
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = Config.fishData.A_C_FISHCHAINPICKEREL_01_SM[1],
    [`A_C_FISHCHANNELCATFISH_01_LG`] = Config.fishData.A_C_FISHCHANNELCATFISH_01_LG[1],
    [`A_C_FISHCHANNELCATFISH_01_XL`] = Config.fishData.A_C_FISHCHANNELCATFISH_01_XL[1],
    [`A_C_FISHLAKESTURGEON_01_LG`]   = Config.fishData.A_C_FISHLAKESTURGEON_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = Config.fishData.A_C_FISHLARGEMOUTHBASS_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = Config.fishData.A_C_FISHLARGEMOUTHBASS_01_MS[1],
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = Config.fishData.A_C_FISHLONGNOSEGAR_01_LG[1],
    [`A_C_FISHMUSKIE_01_LG`]         = Config.fishData.A_C_FISHMUSKIE_01_LG[1],
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = Config.fishData.A_C_FISHNORTHERNPIKE_01_LG[1],
    [`A_C_FISHPERCH_01_MS`]          = Config.fishData.A_C_FISHPERCH_01_MS[1],
    [`A_C_FISHPERCH_01_SM`]          = Config.fishData.A_C_FISHPERCH_01_SM[1],
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = Config.fishData.A_C_FISHRAINBOWTROUT_01_LG[1],
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = Config.fishData.A_C_FISHRAINBOWTROUT_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_MS`] = Config.fishData.A_C_FISHREDFINPICKEREL_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_SM`] = Config.fishData.A_C_FISHREDFINPICKEREL_01_SM[1],
    [`A_C_FISHROCKBASS_01_MS`]       = Config.fishData.A_C_FISHROCKBASS_01_MS[1],
    [`A_C_FISHROCKBASS_01_SM`]       = Config.fishData.A_C_FISHROCKBASS_01_SM[1],
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_LG[1],
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_ML[1],
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = Config.fishData.A_C_FISHSALMONSOCKEYE_01_MS[1],
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = Config.fishData.A_C_FISHSMALLMOUTHBASS_01_LG[1],
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = Config.fishData.A_C_FISHSMALLMOUTHBASS_01_MS[1],
}

RegisterNetEvent("vorp_fishing:UseBait")
AddEventHandler("vorp_fishing:UseBait", function(UsableBait)
Citizen.CreateThread(function()
        Citizen.InvokeNative(0x1096603B519C905F, "MMFSH")
        prepareMyPrompt()    
        fishing = true
        local sleep = 1500
        currentLure = UsableBait
        UsableBait = nil
        ready = false
        while fishing do
            Citizen.Wait(0)
            GET_TASK_FISHING_DATA()
            if FISHING_GET_MINIGAME_STATE() == 1 and ready == false then
                ready = true  
                if Config.Debug then
                    print("Current bait: "..currentLure)
                end
                TaskSwapFishingBait(PlayerPedId(), currentLure, 0)    
                Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), currentLure, 0, 1)
            end

            if hasMinigameOn then
                sleep = 4
                local playerPed = PlayerPedId()

                if FISHING_GET_MINIGAME_STATE() == 2 then
                    FISHING_GET_MAX_THROWING_DISTANCE(math.random(25.0, 30.0))
                end

                if FISHING_GET_MINIGAME_STATE() == 6 then
                                
                    if IsControlJustPressed(0, 0x8FFC75D6) then
                        FISHING_SET_F_(6, 128)
                    end
                    
                    local bobberPosition = FISHING_GET_BOBBER_HANDLE()

                    local hookHandle = FISHING_GET_HOOK_HANDLE()
                    local hookPosition = GetEntityCoords(hookHandle)
                    local lured = false
                    
                    if IsControlPressed(0, GetHashKey("INPUT_DUCK")) then
                        local actualReelSpeed = Config.ReelSpeed
                        local playerCoords = GetEntityCoords(PlayerPedId(), true, true)
                        distance = playerCoords - hookPosition
                        
                        distance = hookPosition + distance * actualReelSpeed
                        SetEntityCoords(hookHandle, distance.x, distance.y, distance.z, false, false, false, false)                    
                    end

                    if FISHING_GET_LINE_DISTANCE() < 4.0 then
                        FISHING_SET_F_(14, 1.0)
                    else
                        FISHING_SET_F_(14, 0.4)
                    end

                    local fishHandle                    
                    for _, f in pairs(GetNearbyFishs(hookPosition, 50.0)) do
                        local fishPosition = GetEntityCoords(f)
                        if Config.Debug then
                            Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, fishPosition, fishPosition + vec3(0, 0, 2.0), 255, 255, 0, 255)
                        end
                        if fishing_lure_cooldown <= GetGameTimer() then
                            local dist = #(hookPosition - fishPosition)
                            if dist <= 1.6 then
                                fishHandle = f
                            else
                                if isFishInterested(GetEntityModel(f)) then
                                    TaskGoToEntity(f, bobberPosition, 100, 1, 1.0, 2.0, 0)
                                end
                            end

                            if lured == false then
                                lured = true
                            end
                        end
                    end                                        

                    if lured then
                        fishing_lure_cooldown = GetGameTimer() + (1 * 1000)
                    end

                    if fishHandle then
                        local probabilidadePuxar = math.random()
                        if probabilidadePuxar > 0.9 or probabilidadePuxar < 0.2 then -- soltar linha
                            if FISHING_GET_F_(5) == 1 then
                                Citizen.InvokeNative(0xF0FBF193F1F5C0EA, fishHandle)

                                SetPedConfigFlag(fishHandle, 17, true)

                                Citizen.InvokeNative(0x1F298C7BD30D1240, playerPed)

                                ClearPedTasksImmediately(fishHandle, false, true)
                                TaskSetBlockingOfNonTemporaryEvents(fishHandle, true)

                                Citizen.InvokeNative(0x1A52076D26E09004, playerPed, fishHandle)

                                FISHING_SET_FISH_HANDLE(fishHandle)
                                fishForce = 0.6

                                FISHING_SET_TRANSITION_FLAG(4)
                            end
                        end
                    end
                end

                if FISHING_GET_MINIGAME_STATE() == 7 then
                    fishing_data.fish.weight = FISHING_GET_F_(8)

                    if IsControlJustPressed(0, 0x8FFC75D6) then
                        FISHING_SET_F_(6, 11)
                    end
                    local fishHandle = FISHING_GET_FISH_HANDLE()

                    if GetControlNormal(0, 0x390948DC) > 0 then -- Direita
                        horizontalMove = horizontalMove - (0.05 * GetControlNormal(0, 0x390948DC))
                    end
                    if GetControlNormal(0, 0x390948DC) < 0 then -- Esquerda
                        horizontalMove = horizontalMove + (0.05 * -GetControlNormal(0, 0x390948DC))
                    end
                    if horizontalMove < 0 then
                        horizontalMove = 0
                    end
                    if horizontalMove > 1 then
                        horizontalMove = 1
                    end
                    FISHING_SET_F_(22, horizontalMove)


                    if FISHING_GET_LINE_DISTANCE() < 4.0 then
                        FISHING_SET_F_(6, 12)
                        FISHING_SET_F_(14, 1.0)
                    else
                        FISHING_SET_F_(14, 1.0)
                    end

                    if GetGameTimer() >= nextAttTime then
                        local probabilidadePuxar = math.random()
                        if probabilidadePuxar > 0.8 or probabilidadePuxar < 0.2 then -- soltar linha
                            fishForce = 0.8
                            tempoPuxando = math.random(2, 5) * 1000
                            fishStatus = 1 -- agitado
                            nextAttTime = GetGameTimer() + tempoPuxando

                            local fishHandle = FISHING_GET_FISH_HANDLE()
                            local x,y,z = table.unpack(GetEntityCoords(fishHandle))

                            local r = exports["vorp_fishing"]:VERTICAL_PROBE(x, y,  z, 1)
                            local valid, height = r[1], r[2]
                                                        
                        -- import from ptfx on vorp_fishing c# version
                        local particlecoords = GetEntityCoords(fishHandle)
                        RequestNamedPtfxAsset(GetHashKey('scr_mg_fishing'))
                            while not HasNamedPtfxAssetLoaded(GetHashKey('scr_mg_fishing')) do
                                Wait(5)
                            end                        
                        UseParticleFxAsset("scr_mg_fishing")
                        local Fisheffect = StartParticleFxNonLoopedAtCoord("scr_mg_fish_struggle", particlecoords, 0.0, 0.0, math.random(0, 360) + 0.0001, 1.5, 0, 0, 0)
                        SetParticleFxLoopedAlpha(Fisheffect, 1.0)

                      --  animDict = "mini_games@fishing@shore@hooked_med@struggle"

                      --  if not HasAnimDictLoaded(animDict) then
                      --      RequestAnimDict(animDict)
                      --      while not HasAnimDictLoaded(animDict) do
                      --          Citizen.Wait(0)
                      --      end
                      --  end

                        else
                            fishForce = 0
                            tempoPuxando = math.random(2, 5) * 1000
                            fishStatus = 0 --calmo
                            nextAttTime = GetGameTimer() + tempoPuxando
                        end
                    end

                    if fishStatus == 1 then
                        if IsControlPressed(0, GetHashKey("INPUT_GAME_MENU_OPTION")) then
                            FISHING_SET_ROD_WEIGHT(4)
                            fishForce = fishForce + 0.005
                        else
                            fishForce = fishForce - 0.005
                        end

                        if IsControlJustReleased(0, GetHashKey("INPUT_GAME_MENU_OPTION")) then
                            FISHING_SET_ROD_WEIGHT(2)
                        end

                        if fishForce >= 1.4 then
                            FISHING_SET_F_(6, 11)
                        else
                            if fishForce < 0.8 then
                                fishForce = 0.8
                            end
                        end
                        TaskSmartFleeCoord(fishHandle, GetEntityCoords(playerPed), 40.0, 50, 8, 1077936128)
                                                
                         -- import from ptfx on vorp_fishing c# version
                        local particlecoords = GetEntityCoords(fishHandle)
                        RequestNamedPtfxAsset(GetHashKey('scr_mg_fishing'))
                            while not HasNamedPtfxAssetLoaded(GetHashKey('scr_mg_fishing')) do
                                Wait(5)
                            end                        
                        UseParticleFxAsset("scr_mg_fishing")
                        local Fisheffect = StartParticleFxNonLoopedAtCoord("scr_mg_fish_struggle", particlecoords, 0.0, 0.0, math.random(0, 360) + 0.0001, 1.5, 0, 0, 0)
                        SetParticleFxLoopedAlpha(Fisheffect, 1.0)

                    else
                        if IsControlJustPressed(0, GetHashKey("INPUT_GAME_MENU_OPTION")) or (IsControlPressed(0, GetHashKey("INPUT_GAME_MENU_OPTION")) and GetGameTimer() % 25 == 0) then
                            FISHING_SET_ROD_WEIGHT(4)
                            TaskGoToEntity(fishHandle, playerPed, Config.Difficulty, 1.0, 1.5, 0.0, 0)
                            -- #######################################################
                            -- SetBlockingOfNonTemporaryEvents(fishHandle, true)
                            -- TaskGoToEntity(fishHandle, playerPed, 500, 5, 2.0, 2.0, 0)
                            -- ApplyForceToEntity(fishHandle, 0, GetEntityCoords(playerPed))
                            -- SetEntityVelocity(fishHandle, GetEntityCoords(playerPed))
                            -- TaskGoToEntity(fishHandle, playerPed, 1000, 20, 1.0, 0.0, 1) !!
                            -- Citizen.InvokeNative(0x53187E563F938E76,1)
                        end

                        if IsControlJustReleased(0, GetHashKey("INPUT_GAME_MENU_OPTION")) then
                            FISHING_SET_ROD_WEIGHT(2)
                        end
                    end

                    if FISHING_GET_F_(6) ~= 11 and FISHING_GET_F_(6) ~= 12 then
                        FISHING_SET_F_(13, fishForce)
                        FISHING_SET_F_(21, fishForce)
                    end

                    if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                        FISHING_SET_ROD_POSITION_UD(0.6)
                    end

                    if IsControlJustReleased(0, GetHashKey("INPUT_ATTACK")) then
                        FISHING_SET_ROD_POSITION_UD(0.0)
                    end            
                end

                if FISHING_GET_MINIGAME_STATE() == 12 then
                    if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                        if fishing then
                            FISHING_SET_TRANSITION_FLAG(32)
                            fishing = false
                            local entity = FISHING_GET_FISH_HANDLE()
                            local fishModel = GetEntityModel(entity)
                            TriggerServerEvent("vorp_fishing:FishToInventory", fishModel)
                            if Config.DiscordIntegration == true then
                                TriggerServerEvent("vorp_fishing:discord_keep", fishModel, fishing_data.fish.weight)
                            end
                            SetEntityAsMissionEntity(entity, true, true)
                            Citizen.Wait(3000)
                            DeleteEntity(entity)
                            Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "", 0, 1)
                        end
                    end

                    if IsControlJustPressed(0, GetHashKey("INPUT_AIM")) then
                        if fishing then
                            fishing = false
                            local entity = FISHING_GET_FISH_HANDLE()
                            Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "", 0, 1)
                            FISHING_SET_TRANSITION_FLAG(64)
                            SetEntityAsMissionEntity(entity, true, true)
                            Citizen.Wait(3000)
                            DeleteEntity(entity)
                        end
                    end

                    if FISHING_GET_F_(5) == 96 and FISHING_GET_F_(6) == 0 then
                        fishing = false
                        Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "", 0, 1)                        
                        local entity = FISHING_GET_FISH_HANDLE()
                        SetEntityAsMissionEntity(entity, true, true)
                        Citizen.Wait(3000)
                        DeleteEntity(entity)
                    end
                end

                if IsControlJustPressed(0, GetHashKey("INPUT_TOGGLE_HOLSTER")) then
                    fishing = false
                    FISHING_SET_TRANSITION_FLAG(8)                
                    Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "", 0, 1)
                end
            end
            lastState = FISHING_GET_MINIGAME_STATE()
            Citizen.Wait(sleep)
        end
    end)
end)

Citizen.CreateThread(function()
    prepareMyPrompt()
    while true do
        Citizen.Wait(0)
        if FISHING_GET_MINIGAME_STATE() == 1 then
            PromptSetActiveGroupThisFrame(fishing_data.prompt_prepare_fishing.group, CreateVarString(10, "LITERAL_STRING", Config.Lang.ReadyToFish))
        end    
        
        if FISHING_GET_MINIGAME_STATE() == 6 then
            PromptSetActiveGroupThisFrame(fishing_data.prompt_waiting_hook.group, CreateVarString(10, "LITERAL_STRING", Config.Lang.Fishing))
        end

        if FISHING_GET_MINIGAME_STATE() == 7 then
            fishing_data.fish.weight = FISHING_GET_F_(8)
            PromptSetActiveGroupThisFrame(fishing_data.prompt_hook.group, CreateVarString(10, "LITERAL_STRING", Config.Lang.MiniGame))
        end
        if FISHING_GET_MINIGAME_STATE() == 12 then
            if fishs[GetEntityModel(FISHING_GET_FISH_HANDLE())] ~= nil then
                PromptSetActiveGroupThisFrame(fishing_data.prompt_finish.group, CreateVarString(10, "LITERAL_STRING",Config.Lang.FishName..": "..fishs[GetEntityModel(FISHING_GET_FISH_HANDLE())] .." // "..Config.Lang.FishWeight..": "..string.format("%.2f%%", (fishing_data.fish.weight * 54.25)):gsub("%%", "").."Kg"))

            end
        end
    end
end)

function GET_TASK_FISHING_DATA()
    local r = exports["vorp_fishing"]:GET_TASK_FISHING_DATA_EXTRA()
    hasMinigameOn = r[1]
    local outAsInt = r[2]
    local outAsFloat = r[3]

    fishing_minigame_struct = {}

    fishing_minigame_struct = {
        f_0 = outAsInt["0"],
        f_1 = outAsFloat["2"],
        f_2 = outAsFloat["4"],
        f_3 = outAsFloat["6"],
        f_4 = outAsFloat["8"],
        f_5 = outAsInt["10"],
        f_6 = outAsInt["12"],
        f_7 = outAsInt["14"],
        f_8 = outAsFloat["16"],
        f_9 = outAsFloat["18"],
        f_10 = outAsInt["20"],
        f_11 = outAsInt["22"],
        f_12 = outAsInt["24"],
        f_13 = outAsFloat["26"],
        f_14 = outAsFloat["28"],
        f_15 = outAsFloat["30"],
        f_16 = outAsInt["32"],
        f_17 = outAsFloat["34"],
        f_18 = outAsInt["36"],
        f_19 = outAsInt["38"],
        f_20 = outAsFloat["40"],
        f_21 = outAsFloat["42"],
        f_22 = outAsFloat["44"],
        f_23 = outAsFloat["46"], 
        f_24 = outAsFloat["48"],
        f_25 = outAsFloat["50"],
        f_26 = outAsFloat["52"],
        f_27 = outAsFloat["54"] 
    }
end

function isFishInterested(fishModel)
    local baitedFish = Config.BaitsPerFish[currentLure]
    if baitedFish ~= nil then
        for _, fish in pairs(baitedFish) do
            if fishs[fishModel] == fish then
                return true
            end
        end
    end
    return false
end

function SET_TASK_FISHING_DATA()
    if fishing_minigame_struct.f_0 ~= nil then
        exports["vorp_fishing"]:SET_TASK_FISHING_DATA_EXTRA(fishing_minigame_struct)
    end
end

function FISHING_HAS_MINIGAME_ON()
    return hasMinigameOn
end

function FISHING_GET_F_(f)
    return fishing_minigame_struct["f_" .. f]
end

function FISHING_GET_MINIGAME_STATE()
    return FISHING_GET_F_(0)
end

function FISHING_GET_MAX_THROWING_DISTANCE()
    return FISHING_GET_F_(1)
end

function FISHING_GET_LINE_DISTANCE()
    return FISHING_GET_F_(2)
end

function FISHING_GET_TRANSITION_FLAG()
    return FISHING_GET_F_(6)
end

function FISHING_GET_FISH_HANDLE()
    return FISHING_GET_F_(7)
end

function FISHING_GET_CALCULATED_FISH_WEIGHT()
    return FISHING_GET_F_(8)
end

function FISHING_GET_F_9()
    return FISHING_GET_F_(9)
end

function FISHING_GET_SCRIPT_TIMER()
    return FISHING_GET_F_(10)
end

function FISHING_GET_BOBBER_HANDLE()
    return FISHING_GET_F_(11)
end

function FISHING_GET_HOOK_HANDLE()
    return FISHING_GET_F_(12)
end

function FISHING_SET_F_(f, v)
    fishing_minigame_struct["f_" .. f] = v
    SET_TASK_FISHING_DATA()
end

function FISHING_SET_LINE_DISTANCE(v)
    FISHING_SET_F_(2, v)
end

function FISHING_SET_TRANSITION_FLAG(v)
    FISHING_SET_F_(6, v)
end

function FISHING_SET_FISH_HANDLE(v)
    FISHING_SET_F_(7, v)
    local weight_index = FishModelToSomeSortOfWeightIndex(GetEntityModel(v))

    FISHING_SET_CALCULATED_FISH_WEIGHT(GetRandomFishWeightForWeightIndex(weight_index) / 54.25)

    fishing_data.fish.rodweight = 2
    FISHING_SET_ROD_WEIGHT(fishing_data.fish.rodweight)
end

function FISHING_SET_CALCULATED_FISH_WEIGHT(v)
    fishing_data.fish.weight = v * 54.25

    FISHING_SET_F_(8, v)
end

function FISHING_SET_ROD_WEIGHT(v)
    FISHING_SET_F_(18, v)
end

function FISHING_SET_ROD_POSITION_LR(v)
    FISHING_SET_F_(22, v)
end

function FISHING_SET_ROD_POSITION_UD(v)
    FISHING_SET_F_(23, v)
end

function GetNearbyFishs(coords, radius)
    local r = {}

    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, coords, radius, itemSet, 1, Citizen.ResultAsInteger())

    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            if GetEntityPopulationType(entity) == 6 and not IsPedDeadOrDying(entity, 0) then
                table.insert(r, entity)
            end
        end
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end

    return r
end

function FishModelToSomeSortOfWeightIndex(fishModel)
    if fishModel == GetHashKey("A_C_FISHBLUEGIL_01_SM") or fishModel == GetHashKey("A_C_FISHBLUEGIL_01_MS") then
        return 0
    elseif fishModel == GetHashKey("A_C_FISHBULLHEADCAT_01_MS") or fishModel == GetHashKey("A_C_FISHBULLHEADCAT_01_SM") then
        return 1
    elseif fishModel == GetHashKey("A_C_FISHCHAINPICKEREL_01_MS") or fishModel == GetHashKey("A_C_FISHCHAINPICKEREL_01_SM") then
        return 2
    elseif fishModel == GetHashKey("A_C_FISHCHANNELCATFISH_01_XL") or fishModel == GetHashKey("A_C_FISHCHANNELCATFISH_01_LG") then
        return 3
    elseif fishModel == GetHashKey("A_C_FISHLAKESTURGEON_01_LG") then
        return 4
    elseif fishModel == GetHashKey("A_C_FISHLARGEMOUTHBASS_01_MS") or fishModel == GetHashKey("A_C_FISHLARGEMOUTHBASS_01_LG") then
        return 5
    elseif fishModel == GetHashKey("A_C_FISHLONGNOSEGAR_01_LG") then
        return 6
    elseif fishModel == GetHashKey("A_C_FISHMUSKIE_01_LG") then
        return 7
    elseif fishModel == GetHashKey("A_C_FISHNORTHERNPIKE_01_LG") then
        return 8
    elseif fishModel == GetHashKey("A_C_FISHPERCH_01_MS") or fishModel == GetHashKey("A_C_FISHPERCH_01_SM") then
        return 9
    elseif fishModel == GetHashKey("A_C_FISHREDFINPICKEREL_01_MS") or fishModel == GetHashKey("A_C_FISHREDFINPICKEREL_01_SM") then
        return 10
    elseif fishModel == GetHashKey("A_C_FISHROCKBASS_01_MS") or fishModel == GetHashKey("A_C_FISHROCKBASS_01_SM") then
        return 11
    elseif fishModel == GetHashKey("A_C_FISHSMALLMOUTHBASS_01_LG") or fishModel == GetHashKey("A_C_FISHSMALLMOUTHBASS_01_MS") then
        return 12
    elseif fishModel == GetHashKey("A_C_FISHSALMONSOCKEYE_01_MS") or fishModel == GetHashKey("A_C_FISHSALMONSOCKEYE_01_LG") then
        return 13
    elseif fishModel == GetHashKey("A_C_FISHRAINBOWTROUT_01_LG") or fishModel == GetHashKey("A_C_FISHRAINBOWTROUT_01_MS") then
        return 14
    end
end

function GetMinMaxWeightForWeightIndex(index)
    local min = 0.0
    local max = 0.0

    if index == 0 or index == 1 or index == 3 or index == 9 or index == 10 or index == 11 or index == 2 then
        min = 0.5
        max = 3.0
    elseif index == 3 or index == 4 or index == 6 or index == 7 or index == 8 then
        min = 14.0
        max = 20.0
    elseif index == 5 or index == 12 or index == 13 or index == 14 then
        min = 4.0
        max = 6.0
    end

    min = min * 0.25
    max = max * 0.25

    return min, max
end

function GetRandomFishWeightForWeightIndex(index)
    local min, max = GetMinMaxWeightForWeightIndex(index)
    local weight = math.random() * (max - min) + min

    return weight
end

function prepareMyPrompt()
    fishing_data.prompt_prepare_fishing.group = GetRandomIntInRange(0, 0xffffff)
    local prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, GetHashKey("INPUT_AIM")) -- MOUSE LEFT CLICK
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.PrepRod))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_prepare_fishing.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_prepare_fishing.change_bait = prompt

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0x07CE1E61) -- LEFT CONTROL
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.ThrowHook))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_prepare_fishing.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_prepare_fishing.throw_hook = prompt


    fishing_data.prompt_waiting_hook.group = GetRandomIntInRange(0, 0xffffff)
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, GetHashKey("INPUT_ATTACK")) -- MOUSE LEFT CLICK
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.HookFish))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_waiting_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_waiting_hook.hook_fish = prompt

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0x8FFC75D6) -- LEFT SHIFT
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.Cancel))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_waiting_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_waiting_hook.cancel = prompt
    
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0xDB096B85) -- LEFT CONTROL
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.ReelLure))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_waiting_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_waiting_hook.reel_lure = prompt

    -- Puxando Peixe
    fishing_data.prompt_hook.group = GetRandomIntInRange(0, 0xffffff)
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0xFBD7B3E6) -- SPACE
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.ReelIn))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_hook.reel = prompt

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0x8FFC75D6) -- LEFT SHIFT
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.Cancel))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_hook.cancel = prompt

    -- Peixe Pego
    fishing_data.prompt_finish.group = GetRandomIntInRange(0, 0xffffff)
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, GetHashKey("INPUT_ATTACK")) -- MOUSE LEFT CLICK
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.KeepFish))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_finish.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_finish.keep_fish = prompt

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt,  GetHashKey("INPUT_AIM")) -- MOUSE RIGHT CLICK
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", Config.Lang.ThrowFish))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_finish.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_finish.throw_fish = prompt
    
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        PromptDelete(fishing_data.prompt_prepare_fishing.throw_hook)
        PromptDelete(fishing_data.prompt_waiting_hook.hook_fish)
        PromptDelete(fishing_data.prompt_waiting_hook.cancel)
        PromptDelete(fishing_data.prompt_hook.reel)
        PromptDelete(fishing_data.prompt_hook.cancel)
        PromptDelete(fishing_data.prompt_finish.keep_fish)
        PromptDelete(fishing_data.prompt_finish.throw_fish)
    end
end)
