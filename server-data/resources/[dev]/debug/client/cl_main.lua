Citizen.CreateThread(function()
    -- UI loop
    while true do
        Citizen.Wait(1)
        DrawCoords()

        -- Draw Player Location / Spawn Location
        local player = PlayerPedId()
        local pCoords = GetEntityCoords(player)
        local pDir = GetEntityHeading(player)

        -- Draw Player Location
        TxtAtWorldCoord(pCoords.x, pCoords.y, pCoords.z - 0.85, player .."\n?", 0.2, 2)
        local carriedEntity = Citizen.InvokeNative(0xD806CD2A4F2C2996, player)
        local carriedEntityModel = GetEntityModel(carriedEntity)
        local carriedEntityHash = Citizen.InvokeNative(0x31FEF6A20F00B963, carriedEntity)
        if carriedEntity then
            TxtAtWorldCoord(pCoords.x, pCoords.y, pCoords.z - 0.6, "Carrying: id: " .. carriedEntity .. ' model : ' .. carriedEntityModel .. " | " .. (GetHashName(carriedEntityModel) or ""), 0.175, 1)
            if carriedEntityHash then
                TxtAtWorldCoord(pCoords.x, pCoords.y, pCoords.z - 0.7, "Carrying: " .. carriedEntityHash .. " | " .. (GetHashName(carriedEntityHash) or ""), 0.175, 1)
            end
        end

        -- Draw Spawn Location
        local spawnCoords = GetOffsetFromEntityInWorldCoords(player, 0, 5.0, -0.5)
        TxtAtWorldCoord(spawnCoords.x, spawnCoords.y, spawnCoords.z, "?", 0.2, 2)
    end
end)

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

function GetHashName(hash)
    if HASH_MODELS[hash] then
        return HASH_MODELS[hash]
    end
    if HASH_PEDS[hash] then
        return HASH_PEDS[hash]
    end
    if HASH_PROVISIONS[hash] then
        return HASH_PROVISIONS[hash]
    end
    if HASH_VEHICLES[hash] then
        return HASH_VEHICLES[hash]
    end
    return false
end

function GetHashKeyIfValid(model_name)
    local model_hash = GetHashKey(model_name)
    local model_valid = IsModelValid(model_hash)
    if model_valid then
        return model_hash
    else
        return false
    end
end

function PrintValidModel(model_name)
    local model_hash = GetHashKeyIfValid(model_name)
    if model_hash then
        local knownModel = GetHashName(model_hash)
        if knownModel then
            if knownModel == model_name then
                print(model_name .. " is valid " .. model_hash)
            else
                print(model_name .. " is valid " .. model_hash .. ' but clashes with ' .. knownModel)
            end
        else
            print('NEW: ' .. model_name .. " is valid " .. model_hash)
        end
        ModelSearch(model_name .. '_GROUP_')
        return true
    end
end

function TestModelSuffix(model_base_name, suffix)
    local model_name
    model_name = model_base_name .. suffix
    local validA = PrintValidModel(model_name)
    model_name = model_name .. 'X'
    local validB = PrintValidModel(model_name)
    model_name = model_base_name .. suffix .. '_L'
    local validC = PrintValidModel(model_name)
    model_name = model_base_name .. suffix .. '_R'
    local validD = PrintValidModel(model_name)
    model_name = model_base_name .. suffix .. '_LG'
    local validE = PrintValidModel(model_name)
    model_name = model_base_name .. suffix .. '_MD'
    local validF = PrintValidModel(model_name)
    model_name = model_base_name .. suffix .. '_SM'
    local validG = PrintValidModel(model_name)
    model_name = model_base_name .. 'LRG' .. suffix
    local validH = PrintValidModel(model_name)
    model_name = model_name .. 'X'
    local validI = PrintValidModel(model_name)
    model_name = model_base_name .. 'MED' .. suffix
    local validJ = PrintValidModel(model_name)
    model_name = model_name .. 'X'
    local validK = PrintValidModel(model_name)
    model_name = model_base_name .. 'SML' .. suffix
    local validL = PrintValidModel(model_name)
    model_name = model_name .. 'X'
    local validM = PrintValidModel(model_name)
    if validA or validB or validC or validD or validE or validF or validG or validH or validI or validJ or validK or validL or validM then
    return true
    else
        return false
    end
end

function ModelSearch(name)
    Citizen.CreateThread(function()
        local letters = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'Y', 'Z' }
        local model_name = ''
        TestModelSuffix(name, '')
        local countSinceLastValid = 0
        local validA, validB, validC, validD, validE, validF
        for i = 1, 999 do
            countSinceLastValid = countSinceLastValid + 1
            -- Don't keep counting higher if there is no lower number values.
            if countSinceLastValid > 9 then
                break
            end
            if i < 10 then
                validA = TestModelSuffix(name, i)
            end
            if i < 100 then
                validB = TestModelSuffix(name, string.format("%02d", i))
            end
            validC = TestModelSuffix(name, string.format("%03d", i))
            -- Letters
            local validLetter = false
            local countSinceLastValidLetter = 0
            for l, letter in pairs(letters) do
                countSinceLastValidLetter = countSinceLastValidLetter + 1
                -- Don't keep counting higher if there is no lower number values.
                if countSinceLastValidLetter > 2 then
                    break
                end
                if i < 10 then
                    validD = TestModelSuffix(name, i .. letter)
                end
                if i < 100 then
                    validE = TestModelSuffix(name, string.format("%02d", i) .. letter)
                end
                validF = TestModelSuffix(name, string.format("%03d", i) .. letter)
                if validD or validE or validF then
                    countSinceLastValidLetter = 0
                end
            end
            if validA or validB or validC or validD or validE or validF then
                countSinceLastValid = 0
            end
        end
    end)
end

RegisterCommand("model_search", function(source, args, rawCommand)
    if args[1] == nil then
        print("Please provide a model prefix for testing")
    else
        ModelSearch(args[1])
        ModelSearch('P_' .. args[1])
        ModelSearch('P_' .. args[1] .. '_')
        ModelSearch('P_STATIC_' .. args[1])
        ModelSearch('P_STATIC_' .. args[1] .. '_')
        ModelSearch('P_RE_' .. args[1])
        ModelSearch('P_RE_' .. args[1] .. '_')
        ModelSearch('P_GEN_' .. args[1]) -- Double Check accuracy
        ModelSearch('P_GEN_' .. args[1] .. '_') -- Double Check accuracy
        ModelSearch('P_' .. args[1] .. '_CS')
        ModelSearch('P_CS_' .. args[1])
        ModelSearch('P_CS_' .. args[1] .. '_')
        ModelSearch('P_DIS_' .. args[1])
        ModelSearch('P_DIS_' .. args[1] .. '_')
        ModelSearch('S_' .. args[1])
        ModelSearch('S_' .. args[1] .. '_')
        ModelSearch('S_INV_' .. args[1])
        ModelSearch('S_INV_' .. args[1] .. '_')
    end
end)

RegisterCommand("identify", function(source, args, rawCommand)
    local hash = tonumber(args[1])
    if HASH_MODELS[hash] then
        print('HASH_MODELS: ', HASH_MODELS[hash])
    elseif HASH_PEDS[hash] then
        print('HASH_PEDS: ', HASH_PEDS[hash])
    elseif HASH_PROVISIONS[hash] then
        print('HASH_PROVISIONS: ', HASH_PROVISIONS[hash])
    elseif HASH_VEHICLES[hash] then
        print('HASH_VEHICLES: ', HASH_VEHICLES[hash])
    elseif HASH_CARRIABLE[hash] then
        print('HASH_CARRIABLE: ', HASH_CARRIABLE[hash])
    else
        print("I don't know that hash.")
    end
end)

RegisterCommand("swap", function(source, args, rawCommand)
    if args[1] == nil or args[2] == nil then
        print("Please provide to models for swapping")
    else
        Citizen.CreateThread(function()
            args[1] = ConvertArg(args[1])
            args[2] = ConvertArg(args[2])
            local player = PlayerPedId()
            local coords = GetEntityCoords(player)
            local model_valid = LoadModel(args[2])
            if model_valid then
                Citizen.InvokeNative(0x10B2218320B6F5AC, coords.x, coords.y, coords.z, 10.0, args[1], args[2])
                print("Swapped " .. args[1] .. " for " .. args[2])
                Citizen.Wait(2500)
                Citizen.InvokeNative(0x824E1C26A14CB817 , coords.x, coords.y, coords.z, 10.0, args[1], args[2])
                print("Removed swap of " .. args[1] .. " for " .. args[2])
                SetModelAsNoLongerNeeded(args[2])
            else
                print("Model not valid")
            end
        end)
    end
end)

function ConvertArg(arg)
    local hashStart = "HASH_"
    local strStart = "STR_"
    if arg:sub(1, #hashStart) == hashStart then
        local hashName = GetTextSubstring(arg, 5, GetLengthOfLiteralString(arg))
        return GetHashKey(hashName)
    elseif arg:sub(1, #strStart) == strStart then
        local str = GetTextSubstring(arg, 4, GetLengthOfLiteralString(arg))
        return CreateVarString(10, 'LITERAL_STRING', str)
    elseif arg == "PLAYER_ID" or arg == "P_ID" then
        return PlayerId()
    elseif arg == "PLAYER_PED" or arg == "P_PED" then
        return PlayerPedId()
    elseif arg == "PLAYER_COORD" or arg == "P_COORD" then
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        return { coords.x, coords.y, coords.z }
    elseif arg == "PLAYER_COORD_GROUND" or arg == "P_COORD_G" then
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        return { coords.x, coords.y, coords.z - 1.0 }
    elseif arg == "PLAYER_DIR" or arg == "P_DIR" then
        local player = PlayerPedId()
        return GetEntityHeading(player)
    elseif arg:lower() == "true" then
        return true
    elseif arg:lower() == "false" then
        return false
    elseif not (nil == tonumber(arg)) then
        return tonumber(arg)
    else
        return arg
    end
end

RegisterCommand('native', function(source, args, rawCommand)
    if args[1] == nil then
        print('Please specify a function to call')
    else
        local args2 = {}

        for k, v in pairs(args) do
            v = MG.dev_utility.ConvertArg(v)
            if type(v) == 'table' then
                for key, value in pairs(v) do
                    table.insert(args2, value)
                end
            else
                table.insert(args2, v)
            end
        end

        print('Args:', table.unpack(args2))

        Citizen.CreateThread(function()
            local r = {}
            r[1], r[2], r[3], r[4], r[5] = Citizen.InvokeNative(table.unpack(args2))
            for k, v in pairs(r) do
                -- if v then
                    if tonumber(v) == nil then
                        print('r' .. tostring(k), v)
                    else
                        local s = string.pack('i4', tonumber(v))
                        local f = string.unpack('f', s)
                        print('r' .. tostring(k), tonumber(v), f)
                    end
                -- end
            end
            print('============')
        end)
    end
end)


---
--- Entity Natives
--- 0x61914209C36EFDDB Entity Status? 3 on ground 4 picking up 5 carried 6 dropping
--- 0x96C638784DB4C815 Has a number when target is alive is false after target dies
--- 0xD21C7418C590BB40 -1 when alive 2 when dying / dead
--- 0xAAACB74442C1BED3 number increments every call
--- 0xC8CCDB712FBCBA92 Occluded? Visible on screen?
--- 0x31FEF6A20F00B963 Provision Hash
---

RegisterCommand("golden", function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100) -- SetAttributeCoreValue
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100) -- SetAttributeCoreValue
        Citizen.InvokeNative(0xC6258F41D86676E0, player, 2, 100) -- SetAttributeCoreValue
        EnableAttributeOverpower(player, 0, 5000.0)
        EnableAttributeOverpower(player, 1, 5000.0)
        EnableAttributeOverpower(player, 2, 5000.0)
        -- 0x103C2F885ABEB00B Is Attribute Overpowered
        -- 0xF6A7C08DF2E28B28 Set Attribute Overpowered Amount
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 0, 5000.0)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 1, 5000.0)
        Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 2, 5000.0)
        local mount = GetMount(player)
        if mount then
            Citizen.InvokeNative(0xC6258F41D86676E0, mount, 0, 100) -- SetAttributeCoreValue
            Citizen.InvokeNative(0xC6258F41D86676E0, mount, 1, 100) -- SetAttributeCoreValue
            EnableAttributeOverpower(mount, 0, 5000.0)
            EnableAttributeOverpower(mount, 1, 5000.0)
            Citizen.InvokeNative(0xF6A7C08DF2E28B28, mount, 0, 5000.0)
            Citizen.InvokeNative(0xF6A7C08DF2E28B28, mount, 1, 5000.0)
        end
    end)
end)

RegisterCommand("weather", function(source, args, rawCommand)
    Citizen.InvokeNative(0x59174F1AFE095B5A, tonumber(args[1]), true, false, true, true, false)
end)

RegisterCommand('draw_sprite', function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local drawCount = 0
        local player = PlayerPedId()
        local pCoord = GetEntityCoords(player)
        while drawCount < 1000 do
            Citizen.Wait(1)
            SpriteAtWorldCoord(pCoord.x, pCoord.y, pCoord.z, args[1], args[2], 0.1)
            drawCount = drawCount + 1
        end
    end)
end)

RegisterCommand("loadout", function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_MELEE_KNIFE'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_MELEE_KNIFE_JAWBONE'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_MELEE_MACHETE'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_MELEE_HATCHET'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_MELEE_HATCHET_HUNTER'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_THROWN_DYNAMITE'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_THROWN_MOLOTOV'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_THROWN_THROWING_KNIVES'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_THROWN_TOMAHAWK'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_THROWN_TOMAHAWK_ANCIENT'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_SHOTGUN_SAWEDOFF'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_BOW'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_LASSO'), 0, true, 0)
        Citizen.Wait(750)
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey('WEAPON_SNIPERRIFLE_CARCANO'), 0, true, 0)
    end)
end)

RegisterCommand('bow_test', function(source, args, rawCommand)
    RemoveAllPedWeapons(PlayerPedId(), true, true)
    GiveWeaponToPed_2(PlayerPedId(), GetHashKey('WEAPON_BOW'), 0, false, true, 0, false, 0.5, 1.0, 752097756, false, 0.0, false)
    Citizen.InvokeNative(0x106A811C6D3035F3, PlayerPedId(), GetHashKey('AMMO_ARROW'), 5, 752097756)
    Citizen.InvokeNative(0x106A811C6D3035F3, PlayerPedId(), GetHashKey('AMMO_ARROW'), 6, 752097756)
    Citizen.InvokeNative(0x106A811C6D3035F3, PlayerPedId(), GetHashKey('AMMO_ARROW_IMPROVED'), 5, 752097756)
    Citizen.InvokeNative(0x106A811C6D3035F3, PlayerPedId(), GetHashKey('AMMO_ARROW_SMALL_GAME'), 5, 752097756)
    Citizen.InvokeNative(0x106A811C6D3035F3, PlayerPedId(), GetHashKey('AMMO_ARROW_FIRE'), 5, 752097756)
    Citizen.InvokeNative(0x106A811C6D3035F3, PlayerPedId(), GetHashKey('AMMO_ARROW_POISON'), 5, 752097756)
    Citizen.InvokeNative(0x106A811C6D3035F3, PlayerPedId(), GetHashKey('AMMO_ARROW_TRACKING'), 5, 752097756)
    Citizen.InvokeNative(0x106A811C6D3035F3, PlayerPedId(), GetHashKey('AMMO_ARROW_DYNAMITE'), 5, 752097756)
    Citizen.InvokeNative(0xADF692B254977C0C, PlayerPedId(), GetHashKey('WEAPON_BOW'), true, 0, false, false)
    Citizen.InvokeNative(0xCC9C4393523833E2, PlayerPedId(), GetHashKey('WEAPON_BOW'), GetHashKey('AMMO_ARROW_DYNAMITE'))
end)

RegisterCommand("weapon", function(source, args, rawCommand) -- GIVES A WEAPON
    if args[1] == nil then
        print("Please set the specific name for weapon")
    else
        local player = PlayerPedId()
        Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey(args[1]), 500, true, 0)
        -- 0xB190BCA3F4042F95     P_ID    HASH_WEAPON_BOW      10   -   GIVE DEFAULT AMMO FOR WEAPON
        -- 0x106A811C6D3035F3     P_ID    HASH_AMMO_ARROW      10   -   GIVE SPECIFIC AMMO
        -- SetCurrentPedWeapon    P_ID    HASH_WEAPON_UNARMED  true
    end
end, false)

RegisterCommand('spawn', function(source, args, rawCommand)
    local player = PlayerPedId()
    local pCoords = GetEntityCoords(player)
    local pDir = GetEntityHeading(player)
    -- 0x405180B14DA5A935 SetPedType(entity, ??) -- Always makes PedType 4

    local spawnCoords = GetOffsetFromEntityInWorldCoords(player, 0, 5.0, 0)

    local modelName = args[1]
    local modelHash = tonumber(modelName)
    if nil == modelHash then
        modelHash = GetHashKey(modelName)
    end
    print(modelName .. " : " .. modelHash)
    print(modelName .. " : " .. GetHashKey(modelName))
    print(IsModelInCdimage(modelHash), IsModelAVehicle(modelHash), IsModelAPed(modelHash), IsModelValid(modelHash))
    if (IsModelAPed(modelHash)) then
        Citizen.CreateThread(function()
            LoadModel(modelHash)
            local entity = CreatePed(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, pDir, true, false, false, false)
            SetEntityVisible(entity, true)
            SetEntityAlpha(entity, 255, false)
            Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
            SetModelAsNoLongerNeeded(modelHash)
            SetEntityAsNoLongerNeeded(entity)
            GetEntityCoords(entity)
            if Config.TrackEntities == 1 then
                entitiesToDraw[entity] = true
            end
        end)
    end
end)

RegisterCommand("hash", function(source, args, rawCommand) -- GIVES A WEAPON
    print(GetHashKey(args[1]))
end, false)

RegisterCommand('vehicle', function(source, args, rawCommand)
    local player = PlayerPedId()
    local pCoords = GetEntityCoords(player)
    local pDir = GetEntityHeading(player)
    -- 0x405180B14DA5A935 SetPedType(entity, ??) -- Always makes PedType 4

    local spawnCoords = GetOffsetFromEntityInWorldCoords(player, 0, 2.0, 0)

    local modelName = args[1]
    local modelHash
    if not IsModelAVehicle(tonumber(args[1])) then
        modelHash = GetHashKey(modelName)
    else
        modelHash = tonumber(args[1])
    end
    print(modelName .. " : " .. modelHash)
    print(modelHash, IsModelInCdimage(modelHash), IsModelAVehicle(modelHash), IsModelAPed(modelHash), IsModelValid(modelHash))
    if IsModelAVehicle(modelHash) then
        Citizen.CreateThread(function()
            LoadModel(modelHash)
            local entity = CreateVehicle(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, pDir - 90.0, false, false, false, false)
            SetEntityVisible(entity, true)
            SetEntityAlpha(entity, 255, false)
            SetModelAsNoLongerNeeded(modelHash)
            --GetEntityCoords(entity)
            if Config.TrackVehicles == 1 then
                vehiclesToDraw[entity] = true
            end
        end)
    end
end)

RegisterCommand("delete_entity", function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local entity_id = tonumber(args[1])
        if entity_id then
            SetEntityAsMissionEntity(entity_id, true, true)
            DeletePed(entity_id)
            DeleteEntity(entity_id)
        end
    end)
end)

function SetEntityModel(entity, model)
    entity = tonumber(entity)
    if tonumber(model) == nil then
        model = GetHashKey(model)
    else
        model = tonumber(model)
    end
    if IsModelValid(model) then
        local entityCoords = GetEntityCoords(entity)
        local entityModel = GetEntityModel(entity)
        LoadModel(model)
        CreateModelSwap(entityCoords.x, entityCoords.y, entityCoords.z, 0.0, entityModel, model)
    else
        print('Invalid Model')
    end
end

RegisterCommand("set_entity_model", function(source, args, rawCommand)
    if not args[1] or not args[2] then
        print("Specify an entity and model")
    else
        Citizen.CreateThread(function()
            SetEntityModel(table.unpack(args))
        end)
    end
end)

function headingDir(entity)
    local hd = GetEntityHeading(entity)
    if hd < 22.5 then
        return "N"
    elseif hd < 67.5 then
        return "NW"
    elseif hd < 112.5 then
        return "W"
    elseif hd < 157.5 then
        return "SW"
    elseif hd < 202.5 then
        return "S"
    elseif hd < 247.5 then
        return "SE"
    elseif hd < 292.5 then
        return "E"
    elseif hd < 337.5 then
        return "NE"
    end
    return "N"
end

function DrawCoords()
    if Config.DrawCoords == 1 then
        local _source = source
        local ent = GetPlayerPed(_source)
        local pp = GetEntityCoords(ent)
        local hd = GetEntityHeading(ent)
        DrawTxt(
            "x = " .. tonumber(string.format("%.4f", pp.x)) .. "\ny = " .. tonumber(string.format("%.4f", pp.y)) .. "\nz = " .. tonumber(string.format("%.4f", pp.z)) -- Coordinates
            .. "\nH: " .. headingDir(ent) .. " " .. tonumber(string.format("%.2f", hd)) -- Heading
            .. "\nT: " .. GetClockHours() .. ':' .. GetClockMinutes() -- Time
            , 0.005, 0.75, 0.225, true, 255, 255, 255, 255, false, 1)
    end
end

function TxtAtWorldCoord(x, y, z, txt, size, font, alpha)
    alpha = alpha or 255
    local s, sx, sy = GetScreenCoordFromWorldCoord(x, y ,z)
    if (sx > 0 and sx < 1) or (sy > 0 and sy < 1) then
        local s, sx, sy = GetHudScreenPositionFromWorldPosition(x, y, z)
        DrawTxt(txt, sx, sy, size, true, 255, 255, 255, alpha, true, font) -- Font 2 has some symbol conversions ex. @ becomes the rockstar logo
    end
end

function DrawTxt(str, x, y, size, enableShadow, r, g, b, a, centre, font)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(1, size)
    SetTextColor(math.floor(r), math.floor(g), math.floor(b), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    SetTextFontForCurrentCommand(font)
    DisplayText(str, x, y)
end

RegisterCommand("anim_scene", function(source, args, rawCommand)
    if args[1] then
        args[1] = ConvertArg(args[1])
    end
    if args[2] then
        args[2] = ConvertArg(args[2])
    end
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        local animScene = Citizen.InvokeNative(0x1FCA98E33C1437B3, 'script@beat@wilderness@chainGang@blackWhiteVariation1', 0, 'PBL_NORMAL', 0, 1)  -- _CREATE_ANIM_SCENE
        print('create animScene: ', animScene)
        local pCoord = GetEntityCoords(player)
        -- pCoord = GetOffsetFromEntityInWorldCoords(player, -0.0185, 0.5436, -1.0016)
        local pRot = GetEntityRotation(player)
        Citizen.InvokeNative(0x020894BF17A02EF2, animScene, pCoord.x, pCoord.y, pCoord.z, pRot.x, pRot.y, pRot.z, 2) -- SET_ANIM_SCENE_ORIGIN
        -- Citizen.InvokeNative(0x020894BF17A02EF2, animScene, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2) -- SET_ANIM_SCENE_ORIGIN
        Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "PRIS_3", player, 0) -- SET_ANIM_SCENE_ENTITY
        -- Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "arthur", 90214, 0) -- SET_ANIM_SCENE_ENTITY
        Citizen.InvokeNative(0xAF068580194D9DC7, animScene) -- LOAD_ANIM_SCENE
        Citizen.Wait(1000)
        Citizen.InvokeNative(0xF4D94AF761768700, animScene) -- START_ANIM_SCENE
        Citizen.Wait(10000)
        Citizen.InvokeNative(0x84EEDB2C6E650000, animScene) -- _DELETE_ANIM_SCENE
        print('delete animScene: ', animScene)
    end)
end)

RegisterCommand("handover_money", function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        local animScene = CreateAnimScene('script@beat@town@townRobbery@handover_money', 64, 0, 0, 1)
        print('create animScene: ', animScene)
        local pCoord = GetEntityCoords(player, 1, 0)
        pCoord = GetOffsetFromEntityInWorldCoords(player, -0.0497, 1.2016, 0.0)
        local pRot = GetEntityRotation(player, 2)
        SetAnimSceneOrigin(animScene, pCoord.x, pCoord.y, pCoord.z, pRot.x, pRot.y, pRot.z - 175.66, 2)
        SetAnimSceneEntity(animScene, "pedPlayer", player, 0)
        local objectModel = GetHashKey('P_FOLDEDBILLS01X')
        local objMoney = CreateObject(objectModel, pCoord.x, pCoord.y, pCoord.z, 2)
        SetAnimSceneEntity(animScene, "objMoney", objMoney, 0)
        SetEntityVisible(objMoney, false)
        local boneIndex = GetPedBoneIndex(player, 7966)
        AttachEntityToEntity(objMoney, player, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1, 0, 0)
        -- SetAnimSceneEntity(animScene, "pedStranger", 24625, 0)
        LoadAnimScene(animScene)
        Citizen.Wait(1000)
        StartAnimScene(animScene)
        Citizen.Wait(500)
        SetEntityVisible(objMoney, true)
        Citizen.Wait(2500)
        SetEntityAsMissionEntity(objMoney, true, true)
        DeleteObject(objMoney)
        Citizen.Wait(3000)
        Citizen.InvokeNative(0x84EEDB2C6E650000 , animScene) -- _DELETE_ANIM_SCENE
        print('delete animScene: ', animScene)
    end)
end)

-- 0xAAA34F8A7CB32098 Clear Cuffs?
-- 0xE1EF3C1216AFF2CD Clear Cuffs?
RegisterCommand("rope", function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        Citizen.InvokeNative(0x7981037A96E7D174, player)
        Citizen.InvokeNative(0xAE6004120C18DF97, player, 0, 0)
        SetPedConfigFlag(player, 137, 1)
        SetPedConfigFlag(player, 44, 1)
        SetPedConfigFlag(player, 26, 1)
        SetEntityLoadCollisionFlag(player, true)
        SetPedConfigFlag(player, 263, 0)
        SetPedConfigFlag(player, 138, 1)
        SetPedConfigFlag(player, 487, 1)
        SetPedConfigFlag(player, 448, 1)
        SetPedCanRagdoll(player, true)
        Citizen.InvokeNative(0x18FF3110CF47115D, player, 7, false)
        ClearPedTasks(player, 1, 0)
        local object = CreateObject(1071795929, -315.1255, 733.6245, 122.897, 1, 1, 0, 0, 1)
        -- SetEntityCoords(object, -315.1255, 733.6245, 122.897)
        FreezeEntityPosition(object, true)
        SetEntityLoadCollisionFlag(object, true)
        -- SetEntityVisible(object, false)
        local coord = GetEntityCoords(object, 1, 0)
        local object2 = CreateObject(357863945, -315.075, 730.922, 119.6113, 1, 1, 0, 0, 1)
        -- SetEntityCoords(object2, -315.075, 730.922, 119.6113)
        FreezeEntityPosition(object2, true)
        SetEntityLoadCollisionFlag(object2, true)
        Citizen.InvokeNative(0xB6CBD40F8EA69E8A, object2)
        AttachEntityToEntityPhysically(object2, player, 0, GetPedBoneIndex(player, 14284), 0.02, -0.11, 0.0, 0.0, 0.0, 0.0, 183.0, 88.5, 97.0, -1.0, 0, 1, 0, 0, 0, 1, 1065353216, 1065353216)
        local fLocal_1029 = 3.3
        local fLocal_1030 = 2.35
        local rope = Citizen.InvokeNative(0xE9C59F6809373A99, coord.x, coord.y, coord.z, 0.0, 0.0, 0.0, fLocal_1030, 6, 1, 31, -1082130432)
        Citizen.InvokeNative(0xF092B6030D6FD49C, rope, 'ROPE_SETTINGS_DEFAULT')
        Citizen.InvokeNative(0x522FA3F490E2F7AC, rope, 1)
        Citizen.InvokeNative(0x8D59079C37C21D78, rope, 2.0)
        Citizen.InvokeNative(0x462FF2A432733A44, rope, object, object2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 'ropeAttach')
        Citizen.InvokeNative(0x3C6490D940FF5D0B, rope, 0, "ropeAttach", fLocal_1029, 0)
        Citizen.InvokeNative(0x76BAD9D538BCA1AA, rope, 0.0)
        Citizen.InvokeNative(0xB40EA9E0D2E2F7F3, rope, 1.0)
        Citizen.InvokeNative(0x86F0B6730C32AC14, player, 1)
        Citizen.InvokeNative(0xEF371232BC6053E1, player)
        Citizen.InvokeNative(0x8101BA1C0B462412, player, rope)
        Citizen.Wait(2500)
        SetPedToRagdoll(player, 1500, 1500, 1, 0, 1, 0)
        SetPedConfigFlag(player, 448, 1)
        SetEntityAsMissionEntity(215816, true, true)
        DeleteEntity(215816)
    end)
end)

RegisterCommand("hang", function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        local animScene = CreateAnimScene('script@beat@town@publicHanging@deputyplayerlever', 0, 'PBL_LEVER_GUARD_V1', 0, 1)
        print('create animScene: ', animScene)
        local pCoord = GetEntityCoords(player, 1, 0)
        -- pCoord = GetOffsetFromEntityInWorldCoords(player, -0.0497, 1.2016, 0.0)
        local pRot = GetEntityRotation(player, 2)
        SetAnimSceneOrigin(animScene, pCoord.x, pCoord.y, pCoord.z, pRot.x, pRot.y, pRot.z, 2)
        SetAnimSceneEntity(animScene, "plr", player, 0)
        -- SetAnimSceneEntity(animScene, "pedStranger", 24625, 0)
        LoadAnimScene(animScene)
        Citizen.Wait(1000)
        StartAnimScene(animScene)
        Citizen.Wait(5000)
        Citizen.InvokeNative(0x84EEDB2C6E650000 , animScene) -- _DELETE_ANIM_SCENE
        print('delete animScene: ', animScene)
    end)
end)

RegisterCommand("pickaxe", function(source, args, rawCommand)
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        local animScene = Citizen.InvokeNative(0x1FCA98E33C1437B3, 'script@story@GNG3@IG@IG_4_Prison_Work@Prison_Work', 0, 'pbl_WorkingLoop', 0, 1)  -- _CREATE_ANIM_SCENE
        print('create animScene: ', animScene)
        local pCoord = GetEntityCoords(player, 1, 0)
        pCoord = GetOffsetFromEntityInWorldCoords(player, 0.0631, 1.7005, -1.1211)
        local pRot = GetEntityRotation(player, 2)
        Citizen.InvokeNative(0x020894BF17A02EF2, animScene, pCoord.x, pCoord.y, pCoord.z, pRot.x, pRot.y, pRot.z - 285.0, 2)
        Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "MrsAdler", player, 0) -- SET_ANIM_SCENE_ENTITY
        local pickaxe = Citizen.InvokeNative(0x509D5878EB39E842, GetHashKey('P_PICKAXE01X'), pCoord.x, pCoord.y, pCoord.z, 2)
        Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "P_PICKAXE01X", pickaxe, 0) -- SET_ANIM_SCENE_ENTITY
        Citizen.InvokeNative(0x1794B4FCC84D812F, pickaxe, false)
        local boneIndex = Citizen.InvokeNative(0x3F428D08BE5AAE31, player, 7966)
        Citizen.InvokeNative(0x6B9BBD38AB0796DF, pickaxe, player, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1, 0, 0)
        Citizen.InvokeNative(0xAF068580194D9DC7, animScene)
        Citizen.Wait(500)
        Citizen.InvokeNative(0xF4D94AF761768700, animScene)
        Citizen.InvokeNative(0x1794B4FCC84D812F, pickaxe, true)
        Citizen.Wait(10000)
        SetEntityAsMissionEntity(pickaxe, true, true)
        DeleteObject(pickaxe)
        Citizen.InvokeNative(0x84EEDB2C6E650000, animScene)
        print('delete animScene: ', animScene)
    end)
end)


-- RequestAnimDict("script_proc@robberies@homestead@lonnies_shack@deception")
-- while not HasAnimDictLoaded("script_proc@robberies@homestead@lonnies_shack@deception") do
--     Citizen.Wait(50)
-- end
-- TaskPlayAnim(player, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop", 2.0, -2.0, -1, 0, 0, 0, 0, 0, 0, 0)
