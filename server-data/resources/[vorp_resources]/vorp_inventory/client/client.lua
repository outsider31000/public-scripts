local loaded = false 
local getammoinfo = false 
local playerammoinfo = {}


RegisterNetEvent('syn:getnuistuff')
AddEventHandler('syn:getnuistuff', function(x,y,mon,gol)
	local nuistuff = x 
    local player = PlayerPedId()
 	SendNUIMessage({
		action = "changecheck",
		check = nuistuff,
		info = y,
	})
    SendNUIMessage({
        action      = "updateStatusHud",
        show        = not IsRadarHidden(),
        money       = mon,
        gold        = gol,
        id          = GetPlayerServerId(NetworkGetEntityOwner(player)),
    })
end)

if Config.DevMode then
    AddEventHandler('onClientResourceStart', function (resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
          return
        end
        print('loading resource')
        SetNuiFocus(false, false)
        SendNUIMessage({action= "hide"})
        print("Loading Inventory")
        TriggerServerEvent("vorpinventory:getItemsTable")
        Wait(300)
        TriggerServerEvent("vorpinventory:getInventory")
        Wait(5000)
        TriggerServerEvent("vorpCore:LoadAllAmmo")
        print("inventory loaded")
        Wait(2500)
        TriggerEvent("vorpinventory:loaded")
      end)
end


----- Ammo saving
function contains(table, element)
    if table ~= 0 then 
        for k, v in pairs(table) do
            if k == element then
                return true
            end
        end
    end
return false
end
Citizen.CreateThread(function()
	while true do
        Wait(1)
        if not loaded then 
            DisableControlAction(0, 0xC1989F95, true)
        else
            Wait(500)
        end
    end
end)

RegisterNetEvent("vorpinventory:loaded")
AddEventHandler("vorpinventory:loaded", function()
    SendNUIMessage({
        action      = "reclabels",
        labels = Config.Ammolabels
    })
    getammoinfo = true 
    TriggerServerEvent("vorpinventory:getammoinfo")
    while getammoinfo do 
        Wait(100)
    end
    local playerammo = playerammoinfo["ammo"]
    SendNUIMessage({
        action      = "updateammo",
        ammo = playerammo
    })
    loaded = true 
end)

RegisterNetEvent("vorpinventory:updateuiammocount")
AddEventHandler("vorpinventory:updateuiammocount", function(ammo)
	SendNUIMessage({
        action      = "updateammo",
        ammo = ammo
    })
    NUIService.LoadInv()
end)

RegisterNetEvent("vorpinventory:setammotoped")
AddEventHandler("vorpinventory:setammotoped", function(ammo)
    Citizen.InvokeNative(0xF25DF915FA38C5F3,PlayerPedId(),1,1)
	Citizen.InvokeNative(0x1B83C0DEEBCBB214,PlayerPedId())
    for k,v in pairs(ammo) do 
        SetPedAmmoByType(PlayerPedId(), GetHashKey(k), v)
    end
end)

RegisterNetEvent("vorpinventory:updateuiammocount")
AddEventHandler("vorpinventory:updateuiammocount", function(ammo)
	SendNUIMessage({
        action      = "updateammo",
        ammo = ammo
    })
    NUIService.LoadInv()
end)
RegisterNetEvent("vorpinventory:recammo")
AddEventHandler("vorpinventory:recammo", function(ammo)
	playerammoinfo = ammo
	getammoinfo = false 
end)
-- Threads
Citizen.CreateThread(function()
	while true do
		Wait(500)
        if loaded then 
		    local isArmed = Citizen.InvokeNative(0xCB690F680A3EA971, PlayerPedId(), 4)
            local wephash = Citizen.InvokeNative(0x8425C5F057012DAB,PlayerPedId())
		    local ismelee = Citizen.InvokeNative(0x959383DCD42040DA, wephash)
		    if (isArmed or GetWeapontypeGroup(wephash) == 1548507267 ) and not ismelee then
		    	getammoinfo = true 
		    	TriggerServerEvent("vorpinventory:getammoinfo")
		    	while getammoinfo do 
		    		Wait(100)
		    	end
		    	local wepgroup = GetWeapontypeGroup(wephash)
		    	local ammotypes = Config.Ammotypes[tostring(wepgroup)]
		    	local playerammo = playerammoinfo["ammo"]
                if ammotypes ~= nil and playerammo ~= nil then 
		    	    for k,v in pairs(ammotypes) do 
		    	    	if contains(playerammo,v) then 
		    	    		local qt = Citizen.InvokeNative(0x39D22031557946C1, PlayerPedId(), GetHashKey(v))
                            if not qt or ((GetWeapontypeGroup(wephash) == 1548507267 or GetWeapontypeGroup(wephash) == -1241684019) and qt == 1) then -- an issue occurs where when the player fires their last throwable this loop stops since the player auto switches to melee and it never registers that they used the last of their ammo, creating a problem where the player will always have 1 throwable left even after they have used it. to combat this the player is considered out of ammo if they only have 1 ammo left
                                qt = 0 
                            end
		    	    		if playerammo[v] ~= qt then
		    	    			playerammoinfo["ammo"][v] = qt
		    	    			TriggerServerEvent("vorpinventory:updateammo",playerammoinfo)
                                SendNUIMessage({
                                    action      = "updateammo",
                                    ammo = playerammo
                                })
		    	    		end
		    	    	end
		    	    end
                end
		    end
        end
	end
end)