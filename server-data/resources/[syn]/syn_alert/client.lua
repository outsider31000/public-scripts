local cooldown = false 
local timer = Config.alertcooldown
local blips = {}
local isalerted = false 
local doctor = false 
local isalerted2 = false 
local serverid
local isalerted3 = false 
function GetPlayers()
	local players = {}
	for i = 0, 256 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, GetPlayerServerId(i))
		end
	end
	return players
end

Citizen.CreateThread(function()
    for k,v in pairs(Config.alerts) do 
        RegisterCommand(v.command, function(source, args, rawCommand)
            if not cooldown then 
                v.blip.coords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("syn_alert:sendalert",GetPlayers(),v.jobs,v.msg,v.blip,v.isdoctor)
                cooldown = true
            end
        end, false)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
	    if timer >= 0 and cooldown then
	    	Citizen.Wait(1000)
	    	if timer > 0 then
	    		timer = timer - 1
	    	end
            if 0 >= timer and cooldown then 
                cooldown = false 
                timer = Config.alertcooldown
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
    while true do
        Citizen.Wait(1)
        if isalerted then 
            drawtext("~e~do /"..Config.cancelblipcommand.." to remove notifications", 0.15, 0.16, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
            if doctor then 
                drawtext("someone needs your help, check your map for a blip do ~e~(/"..Config.medicresponse..")~q~ to respond", 0.15, 0.13, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
            else
                drawtext("~e~someone needs your help, check your map for a blip", 0.15, 0.13, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
            end
        end
        if isalerted2 then 
            drawtext("~e~do /"..Config.cancelblipcommand.." to remove notifications", 0.15, 0.16, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
            drawtext("~e~Doctor is on the way", 0.15, 0.13, 0.5, 0.5, true, 255, 255, 255, 255, true, 10000)
        end
        if isalerted3 then 
            drawtext("~e~do /"..Config.cancelblipcommand.." to remove notifications", 0.15, 0.16, 0.3, 0.3, true, 255, 255, 255, 255, true, 10000)
            drawtext("~e~ No Doctors Available", 0.15, 0.13, 0.5, 0.5, true, 255, 255, 255, 255, true, 10000)
        end
    end
end)
RegisterNetEvent("syn_alert:createblip")
AddEventHandler("syn_alert:createblip", function(blip,dx,id)
    isalerted = true 
    doctor = dx
    serverid = id
    local blipx =  N_0x554d9d53f696d002(1664425300, blip.coords.x, blip.coords.y, blip.coords.z)
    SetBlipScale(blipx, 0.2)
    SetBlipSprite(blipx, blip.blipsprite, 1) 
    Citizen.InvokeNative(0x9CB1A1623062F402, blipx, blip.Name)
    Citizen.InvokeNative(0x662D364ABF16DE2F,blipx,0x6F85C3CE)
    table.insert(blips, {
      blipz = blipx
    })
end)

RegisterNetEvent("syn_alert:recresp")
AddEventHandler("syn_alert:recresp", function()
   if isalerted then 
        isalerted = false 
   end
   isalerted2 = true 
end)

RegisterNetEvent("syn_alert:cantalert")
AddEventHandler("syn_alert:cantalert", function()
   if isalerted then 
        isalerted = false 
   end
   if isalerted2 then 
        isalerted2 = false 
   end
   isalerted3 = true 
end)

RegisterCommand(Config.medicresponse, function(source, args, rawCommand)
    if doctor then 
        doctor = false 
        TriggerServerEvent("syn_alert:inform",serverid)
    end
end, false)

RegisterCommand(Config.cancelblipcommand, function(source, args, rawCommand)
    isalerted = false 
    isalerted2 = false 
    isalerted3 = false 
    for k,v in pairs(blips) do 
        RemoveBlip(v.blipz)
    end
    blips = {}
end, false)