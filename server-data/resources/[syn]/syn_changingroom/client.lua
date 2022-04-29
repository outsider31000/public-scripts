-- Made by Blue 
local poutifts = 0
local playerskin = 0
local inmenu = false 
keys = {
    -- Letter E
    ["G"] = 0x760A9C6F,
}

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

local keyopen = false

Citizen.CreateThread( function()
    WarMenu.CreateMenu('outfitsmenu', 'Changing Room')
	while true do

        if WarMenu.IsMenuOpened('outfitsmenu') then
            if poutifts == 0 then
                WarMenu.Button('No saved outfits')
            else
                for i = 1, #poutifts do
                    if WarMenu.Button(poutifts[i].title) then
                        local jsonCloths = poutifts[i].comps
                        TriggerEvent("vorpcharacter:loadPlayerSkin", playerskin, jsonCloths)
                        TriggerServerEvent("syn:setoutfit", jsonCloths)
                        WarMenu.CloseMenu()
                    end
                end
            end

        end
        WarMenu.Display()
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	for _, info in pairs(Config.loc) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, 1001245999, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Changing Room")
    end  
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) 
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(10)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        for k,v in pairs(Config.props) do 
            local campfire = DoesObjectOfTypeExistAtCoords(coords.x, coords.y, coords.z, 1.5, GetHashKey(v), 0) -- prop required to interact
            if campfire ~= false and inmenu == false   then 
                DrawTxt("Press [~e~G~q~] For Wardrobe Menu", 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
                if whenKeyJustPressed(keys["G"]) then
                    inmenu = true 
                    TriggerServerEvent("syn:getoutfits")
                    TriggerServerEvent("syn:getskin")
                    Citizen.Wait(700)
                    WarMenu.OpenMenu('outfitsmenu')
                end
            end
        end
        for k,v in pairs(Config.loc) do
            local betweencoords = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, false)
            if IsPedOnFoot(player) then
			if betweencoords < 1 and inmenu == false  then
                    DrawTxt("Press [~e~G~q~] For Wardrobe Menu", 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
                    if whenKeyJustPressed(keys["G"]) then
                        inmenu = true 
                        TriggerServerEvent("syn:getoutfits")
                        TriggerServerEvent("syn:getskin")
                        Citizen.Wait(700)
                        WarMenu.OpenMenu('outfitsmenu')
                    end
                end
            else end
        end
     
    end
end) 

RegisterNetEvent("wardrobex:closemenu")
AddEventHandler("wardrobex:closemenu", function()
    inmenu = false
end)

RegisterNetEvent("syn:listoutfits")
AddEventHandler("syn:listoutfits", function(playeroutfits)
    poutifts = playeroutfits
end)
RegisterNetEvent("syn:getskins")
AddEventHandler("syn:getskins", function(skin)
    playerskin = skin
end)

RegisterNetEvent("syn_changingroom:canplace")
AddEventHandler("syn_changingroom:canplace", function()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 1)
    if IsTownBanned(town_hash) then
        TriggerEvent("vorp:TipBottom", "too close to town", 4000)
    else
        TriggerServerEvent("syn:puttent")
    end
end)

IsTownBanned = function (town)
	for k,v in pairs(Config.BannedTowns) do
		if town == GetHashKey(v) then
			return true
		end
	end
	return false
end


local status = false

local tent = 0
local campfire = 0 
RegisterNetEvent('syn:tent')
AddEventHandler('syn:tent', function()
    if tent ~= 0 then
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "You're placing a tent...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp005_s_posse_tent_bountyhunter07x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tent = prop
end)

RegisterNetEvent('syn:campfire')
AddEventHandler('syn:campfire', function()

    if campfire ~= 0 then
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "You're placing a campfire...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_campfire02x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    campfire = prop

end)
RegisterCommand('dtent', function(source, args, rawCommand)
    if tent == 0 then
     --   print("No hay tienda.")
    else
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
		TriggerServerEvent('syn:additem', "tent")
    end
end, false)




RegisterCommand('dcampfire', function(source, args, rawCommand)
    if campfire == 0 then
     --   print("There is no campfire.")
    else
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
		TriggerServerEvent('syn:additem', "campfire")
    end
end, false)



--[[ RegisterCommand('sa', function(source, args, rawCommand)
    ClearPedTasksImmediately(PlayerPedId())
end, false)
 ]]
