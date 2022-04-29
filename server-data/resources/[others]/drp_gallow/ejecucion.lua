-- RECURSO MODIFICADO PARA EL SERVIDOR RP DESPERADOSRP.COM --
-- Implementado por Mapachito --

local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }
--[[local WaterTypes = {
    [1] =  {["name"] = "Sea of Coronado",       ["waterhash"] = -247856387, ["watertype"] = "lake"},
    [2] =  {["name"] = "San Luis River",        ["waterhash"] = -1504425495, ["watertype"] = "river"},
    [3] =  {["name"] = "Lake Don Julio",        ["waterhash"] = -1369817450, ["watertype"] = "lake"},
    [4] =  {["name"] = "Flat Iron Lake",        ["waterhash"] = -1356490953, ["watertype"] = "lake"},
    [5] =  {["name"] = "Upper Montana River",   ["waterhash"] = -1781130443, ["watertype"] = "river"},
    [6] =  {["name"] = "Owanjila",              ["waterhash"] = -1300497193, ["watertype"] = "river"},
    [7] =  {["name"] = "HawkEye Creek",         ["waterhash"] = -1276586360, ["watertype"] = "river"},
    [8] =  {["name"] = "Little Creek River",    ["waterhash"] = -1410384421, ["watertype"] = "river"},
    [9] =  {["name"] = "Dakota River",          ["waterhash"] = 370072007, ["watertype"] = "river"},
    [10] =  {["name"] = "Beartooth Beck",       ["waterhash"] = 650214731, ["watertype"] = "river"},
    [11] =  {["name"] = "Lake Isabella",        ["waterhash"] = 592454541, ["watertype"] = "lake"},
    [12] =  {["name"] = "Cattail Pond",         ["waterhash"] = -804804953, ["watertype"] = "lake"},
    [13] =  {["name"] = "Deadboot Creek",       ["waterhash"] = 1245451421, ["watertype"] = "river"},
    [14] =  {["name"] = "Spider Gorge",         ["waterhash"] = -218679770, ["watertype"] = "river"},
    [15] =  {["name"] = "O'Creagh's Run",       ["waterhash"] = -1817904483, ["watertype"] = "lake"},
    [16] =  {["name"] = "Moonstone Pond",       ["waterhash"] = -811730579, ["watertype"] = "lake"},
    [17] =  {["name"] = "Roanoke Valley",       ["waterhash"] = -1229593481, ["watertype"] = "river"},
    [18] =  {["name"] = "Elysian Pool",         ["waterhash"] = -105598602, ["watertype"] = "lake"},
    [19] =  {["name"] = "Heartland Overflow",   ["waterhash"] = 1755369577, ["watertype"] = "swamp"},
    [20] =  {["name"] = "Lagras",               ["waterhash"] = -557290573, ["watertype"] = "swamp"},
    [21] =  {["name"] = "Lannahechee River",    ["waterhash"] = -2040708515, ["watertype"] = "river"},
    [22] =  {["name"] = "Dakota River",         ["waterhash"] = 370072007, ["watertype"] = "river"},
    [23] =  {["name"] = "Random1",              ["waterhash"] = 231313522, ["watertype"] = "river"},
    [24] =  {["name"] = "Random2",              ["waterhash"] = 2005774838, ["watertype"] = "river"},
    [25] =  {["name"] = "Random3",              ["waterhash"] = -1287619521, ["watertype"] = "river"},
    [26] =  {["name"] = "Random4",              ["waterhash"] = -1308233316, ["watertype"] = "river"},
    [27] =  {["name"] = "Random5",              ["waterhash"] = -196675805, ["watertype"] = "river"},
}
--]]
--menu

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
        --[[local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)
            for k,v in pairs(WaterTypes) do 
            if Water == WaterTypes[k]["waterhash"]  then--]]
         -----FIN DE LO NUEVO-------

    if (Vdist(coords.x, coords.y, coords.z, -764.81, -1259.58, 47.59) < 1.0)  or
        (Vdist(coords.x, coords.y, coords.z, -313.98, 728.84, 120.80) < 1.0)  or
        (Vdist(coords.x, coords.y, coords.z, -1806.72, -333.71, 167.85) < 1.0)  or
        (Vdist(coords.x, coords.y, coords.z, -4203.86, -3443.74, 40.27) < 1.0) then
            DrawTxt("[~e~E~q~] Suffer ~e~sentence~q~", 0.90, 0.10, 0.3, 0.3, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0xDFF812F9) then -- e
                TriggerEvent("drp:soga")
                print('ahorcandose')

            end
     end
    end
end)

--RegisterCommand("soga", function(source, args, rawCommand) -- slash COMMAND
AddEventHandler('drp:soga', function()

local _source = source
    if Config.horca then
        local pl = Citizen.InvokeNative(0x217E9DC48139933D)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
            Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
            else end
    end, false)

    ----original debajo--
    --[[local _source = source
            if soga ~= 0 then
                SetEntityAsMissionEntity(soga)
                DeleteObject(nativesogaprop)
                soga = 0
                end
                local playerPed = PlayerPedId()
                Citizen.Wait(0)
                ClearPedTasksImmediately(PlayerPedId())
                TaskStartScenasogaInPlace(playerPed, GetHashKey('WORLD_HUMAN_FLEE'), -1, true, false, false, false)
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
                --local prop = CreateObject(GetHashKey("p_shavingbox01x"), x, y, z, true, false, true)
                SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
                PlaceObjectOnGroundProperly(prop)
                soga = prop--]]
    
    --end, false)
--end)

Citizen.CreateThread(function()
    while true do
	local playerPed = PlayerPedId()
        Citizen.Wait(0)
		
        if whenKeyJustPressed(keys['BACKSPACE']) then --TABULADOR PARA DETENER ACCIÓN
            if soga ~= 0 then
            SetEntityAsMissionEntity(soga)
            DeleteObject(soga)
			ClearPedTasksImmediately(PlayerPedId())
            soga = 0
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
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) -- Cambiar tipo de fuente: 1,2,3,...
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end