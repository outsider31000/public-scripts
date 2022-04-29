local jobpeds = {}
local blips = {}

Citizen.CreateThread(function()
    Citizen.Wait(1000)
	for k,v in pairs(Config.npcdoctor) do 
        if v.showblip then 
		    local blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
    	    SetBlipSprite(blip, v.blipsprite, 1)
    	    SetBlipScale(blip, 0.2)
    	    Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.Name)
            table.insert(blips, blip)
        end
        -----
        local hashModel = GetHashKey(v.npcmodel) 
        if IsModelValid(hashModel) then 
            RequestModel(hashModel)
            while not HasModelLoaded(hashModel) do                
                Wait(100)
            end
        end
        local npc = CreatePed(hashModel, v.Pos.x, v.Pos.y, v.Pos.z - 1.0,v.Pos.h, false, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
        SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)
        Wait(1000)
        FreezeEntityPosition(npc, true) -- NPC can't escape
        SetBlockingOfNonTemporaryEvents(npc, true) -- NPC can't be scared
        table.insert(jobpeds, npc)
	end
end)

RegisterCommand("rev",function()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    local isDead = IsEntityDead(player)
    for k, v in pairs(Config.npcdoctor) do
        if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5 then 
            if isDead then 
                TriggerServerEvent("syn_grandma:revive",v.price,v.gold)
            else
                TriggerEvent("vorp:TipBottom", Config.Language.notdead, 4000)
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = true 
        for k, v in pairs(Config.npcdoctor) do
            if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5 and not inmenu then
                sleep = false
                DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z, Config.Language.type)
            end
        end
        if sleep then 
            Citizen.Wait(500)
        end
    end
end)

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())  
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
	  SetTextScale(0.30, 0.30)
	  SetTextFontForCurrentCommand(1)
	  SetTextColor(255, 255, 255, 215)
	  SetTextCentre(1)
	  DisplayText(str,_x,_y)
	  local factor = (string.len(text)) / 225
	  DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
	end
end
function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end



AddEventHandler("onResourceStop",function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for k,v in pairs(blips) do 
            RemoveBlip(v)
        end
        for k,v in pairs(jobpeds) do 
            DeletePed(v)   
        end
    end
end)