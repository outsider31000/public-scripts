local VORPcore = {}


TriggerEvent("getCore",function(core)
    VORPcore = core
end)

local Animations = exports.vorp_animations.initiate()
local started = false
local Playerjob

RegisterNetEvent('RSG:sendjob')
AddEventHandler('RSG:sendjob', function(job,count)
    Playerjob = job
    playercount = count
end)
    

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local sleep = true 
        for k, v in pairs(Config.grave) do
            local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
            if holding then 
                local isdead = IsEntityDead(holding)
                if isdead then
                    if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 2 and not started  then
                        sleep = false
                        DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z, Config.Language.burry)
                        
                        if whenKeyJustPressed(Config.keys["G"]) then
                            Wait(500)
                            if playercount > 0 then
                            started = true 
                            if CheckTable(Config.jobs, Playerjob) then
                            burry()
                            Wait(500)
                        else
                            VORPcore.NotifyRightTip("you dont have the job fo this ",4000)
                            Citizen.Wait(500)
			    started = false
                                end
                            end
                        end
                    end
                end
            end
        end
        if sleep then 
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()

	for k, v in pairs(Config.grave) do
        local blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
		SetBlipSprite(blip, Config.BlipSpriteHash, 1)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.blipName)
        end

end)

function burry()
    local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
    DeleteEntity(holding) 
if Config.vorpanimations then
    Animations.playAnimation('gravedigging', 10000)
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
    Citizen.InvokeNative(0xFCCC886EDE3C63EC,PlayerPedId(),false,true)
    started = false
    TriggerServerEvent("syn_undertaker:reward")

else
    --TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_SHOVEL_COAL_PICKUP"), 5000, true, false, false, false) --ORIGINAL
    --TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_GRAVE_MOURNING_KNEEL"), 5000, true, false, false, false) --KNEEL
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("SC_WORLD_HUMAN_KNEELING"), 5000, true, false, false, false) --Kneeling
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
    Citizen.InvokeNative(0xFCCC886EDE3C63EC,PlayerPedId(),false,true)
    started = false
    TriggerServerEvent("syn_undertaker:reward")
end

end

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
        TriggerServerEvent('RSG:checkjob')

        return true
    else
        return false
    end
end
function CheckTable(table, element) --Job checking table
	for k, v in pairs(table) do
		if v == element then
			return true
		end
	end
	return false
end
