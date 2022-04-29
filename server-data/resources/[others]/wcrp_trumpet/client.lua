local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }


--menu

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, -306.57, 811.12, 119.18) < 1.0) then
            DrawTxt("Press [~e~Del~q~] to play [~e~Trumpet~q~]", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x4AF4D473) then -- e
                TriggerEvent("valsaloon:trumpet")
                print('playing Trumpet')

            end
        end
    end
end)

--RegisterCommand("trumpet", function(source, args, rawCommand) -- slash COMMAND
AddEventHandler('valsaloon:trumpet', function()
    local _source = source
            if trumpet ~= 0 then
                SetEntityAsMissionEntity(trumpet)
                DeleteObject(nativetrumpetprop)
                trumpet = 0
                end
                local playerPed = PlayerPedId()
                Citizen.Wait(0)
                ClearPedTasksImmediately(PlayerPedId())
                TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_TRUMPET'), -1, true, false, false, false)
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
                local prop = CreateObject(GetHashKey("p_shavingbox01x"), x, y, z, true, false, true)
                SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
                PlaceObjectOnGroundProperly(prop)
                trumpet = prop
    
    --end, false)
end)

Citizen.CreateThread(function()
    while true do
	local playerPed = PlayerPedId()
        Citizen.Wait(0)
		
        if whenKeyJustPressed(keys['BACKSPACE']) then
            if trumpet ~= 0 then
            SetEntityAsMissionEntity(trumpet)
            DeleteObject(trumpet)
			ClearPedTasksImmediately(PlayerPedId())
            trumpet = 0
            end
     end
	end
end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
   SetTextScale(w, h)
   SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
   SetTextCentre(centre)
   if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
   Citizen.InvokeNative(0xADA9255D, 10);
   DisplayText(str, x, y)
end
