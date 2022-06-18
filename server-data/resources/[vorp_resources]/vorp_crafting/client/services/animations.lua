Animations = {}
-- Props
local mainprop
local subprop
local Anims = Config.Animations

Animations.playAnimation = function (ped, anim)
    local animation = Anims[anim]
	if not DoesAnimDictExist(animation.dict) then
		return
	end
    
    if animation.prop then
        local coords = GetEntityCoords(ped)
        mainprop = CreateObject(animation.prop.model, coords.x, coords.y, coords.z, true, true, false, false, true)
        local boneIndex = GetEntityBoneIndexByName(ped, animation.prop.bone)
        AttachEntityToEntity(mainprop, ped, boneIndex, animation.prop.coords.x, animation.prop.coords.y, animation.prop.coords.z, animation.prop.coords.xr, animation.prop.coords.yr, animation.prop.coords.zr, true, true, false, true, 1, true)
        
        if animation.prop.subprop then
            local pcoords = GetEntityCoords(subprop)
            subprop = CreateObject(animation.prop.subprop.model, pcoords.x, pcoords.y, pcoords.z, true, true, false, false, true)
            AttachEntityToEntity(subprop, ped, boneIndex, animation.prop.subprop.coords.x, animation.prop.subprop.coords.y, animation.prop.subprop.coords.z, animation.prop.subprop.coords.xr, animation.prop.subprop.coords.yr, animation.prop.subprop.coords.zr, true, true, false, true, 1, true)
        end
    end


    if animation.type == 'scenario' then
        TaskStartScenarioInPlace(ped, GetHashKey(animation.hash), 12000, true, false, false, false)
    elseif animation.type == 'standard' then
        RequestAnimDict(animation.dict)

        while not HasAnimDictLoaded(animation.dict) do
            Wait(0)
        end
        TaskPlayAnim(ped, animation.dict, animation.name, 1.0, 1.0, -1, animation.flag, 1.0, false, false, false, '', false)
    end
end

Animations.endAnimation = function(anim) 
    local animation = Anims[anim]
    RemoveAnimDict(animation.dict)
    StopAnimTask(PlayerPedId(), animation.dict, animation.name, 1.0)

    if mainprop then
        DeleteObject(mainprop)    
    end

    if subprop then
        DeleteObject(subprop)
    end
end

Animations.endAnimations = function()
    ClearPedTasksImmediately(PlayerPedId())
end

Animations.forceRestScenario = function(val)
    Citizen.InvokeNative(0xE5A3DD2FF84E1A4B, val) 
end

-- RegisterCommand("playanimation", function(source, args, rawCommand)
--     local playerPed = PlayerPedId()

--     Animations.playAnimation(playerPed, args[1])
--     Citizen.Wait(8000)

--     Animations.endAnimation(args[1])
-- end, false)