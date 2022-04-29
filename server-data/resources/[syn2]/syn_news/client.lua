local isOpen = false
local doOpen = false
local doClose = true
local active = false
local JournalOuvert = false
local job 
local news = {}
TriggerEvent("menuapi:getData",function(call)
    MenuData = call
end)
AddEventHandler('menuapi:closemenu', function()

end)
function keysx(table)
    local keys = 0
    for k,v in pairs(table) do
       keys = keys + 1
    end
    return keys
end
RegisterCommand("editnews", function(source, args)
    TriggerServerEvent('syn_news:getjob')
    Wait(500)
    if contains(Config.jobs,job) then 
        createpaper()
    end
end)
function createpaper()
    MenuData.CloseAll()
    local elements = {
	}
    if next(news) == nil then 
        table.insert( elements, {label = "Front Page", value = 'front' , desc = "News Paper Front Page"})
    else
        table.insert( elements, {label = "Add Page", value = 'add' , desc = "Add a New Page"})
        table.insert( elements, {label = "Confirm", value = 'confirm' , desc = "Post News"})
        for k,v in ipairs(news) do 
            table.insert( elements, {label = "Edit Page: "..k, value = 'edit', pagenum = k , desc = "Edit Page"})
        end
    end
   MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
	{
		title    = "Edit News Paper",
		subtext    = "Options",
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
        if data.current == "backup" then 
            _G[data.trigger]()
        end
        if(data.current.value == "confirm") then
            MenuData.CloseAll() 
            TriggerServerEvent("syn_news:savenews",news)
        end
		if(data.current.value == "front") then
            MenuData.CloseAll() 
            TriggerEvent("syn_inputs:sendinputs", "Confirm", "Link", function(cb)
                local descx =     tostring(cb)
                if descx ~= nil and descx ~= "" then
                    if string.find(descx, "http") then
                        news[1] = descx
                    end
                end
                createpaper()
            end)
		end
        if(data.current.value == "add") then
            MenuData.CloseAll() 
            TriggerEvent("syn_inputs:sendinputs", "Confirm", "Link", function(cb)
                local descx =     tostring(cb)
                if descx ~= nil and descx ~= "" then
                    if string.find(descx, "http") then
                        news[keysx(news) + 1] = descx
                    end
                end
                createpaper()
            end)
		end
        if(data.current.value == "edit") then
            MenuData.CloseAll() 
            TriggerEvent("syn_inputs:sendinputs", "Confirm", "Link, Leave Empty to Remove", function(cb)
                local descx =     tostring(cb)
                if descx ~= nil and descx ~= "" then
                    if string.find(descx, "http") then
                        news[data.current.pagenum] = descx
                    end
                else 
                    table.remove( news, data.current.pagenum )
                end
                createpaper()
            end)
		end
	end,
	function(data, menu)
		menu.close()
	end)
end



RegisterNetEvent('syn_news:recjob')
AddEventHandler('syn_news:recjob', function(x,y)
	job = x 
    news = y
end)
function contains(table, element)
    if table ~= 0 then 
        for k, v in pairs(table) do
            if v == element then
                return true
            end
        end
    end
return false
end
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        FreezeEntityPosition(PlayerPedId(), false)
		CloseUI()
    end
end)

RegisterNetEvent('syn_news:open')
AddEventHandler('syn_news:open', function()
    TriggerServerEvent('syn_news:getjob')
    Wait(500)
	OpenUI()
end)

function OpenUI()
    local playerPed = PlayerPedId()
    isOpen = true
    SetNuiFocus(isOpen,isOpen)
    SendNUIMessage({
    type = "OpenBookGui",
    value = true,
    newsx = news,
    })
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	JournalOuvert = true
	SortirJournal()
	Wait(2000)
	local player = PlayerPedId()
    local coords = GetEntityCoords(player) 
    local props = CreateObject(GetHashKey("p_cs_newspaper_02x_noanim"), coords.x, coords.y, coords.z, 1, 0, 1)
    prop = props
    SetEntityAsMissionEntity(prop,true,true)
    RequestAnimDict("mech_carry_box")
    while not HasAnimDictLoaded("mech_carry_box") do
    Citizen.Wait(100)
    end
    Citizen.InvokeNative(0xEA47FE3719165B94, player,"mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0, 0, 0, 0)
    Citizen.InvokeNative(0x6B9BBD38AB0796DF, prop,player,GetEntityBoneIndexByName(player,"SKEL_L_Finger12"), 0.20, 0.00, -0.05, 180.0, 190.0, 0.0, true, true, false, true, 1, true)	
end

function CloseUI()
    local playerPed = PlayerPedId()
    isOpen = false
    SetNuiFocus(isOpen,isOpen)
    active = false
    FreezeEntityPosition(PlayerPedId(), false)
    SendNUIMessage({
    type = "OpenBookGui",
    value = false,
    })
	JournalOuvert = false
    RangerJournal()
    ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
    DetachEntity(prop,false,true)
    ClearPedTasks(player)
    DeleteObject(prop)	
end

Citizen.CreateThread(function(...)
    while true do
        Citizen.Wait(0)
        if doOpen then
            doOpen = false
            OpenUI()
        elseif doClose then
            doClose = false
            CloseUI()
        end
    end
end)

function SortirJournal()
    local ped = PlayerPedId()
	AnimationJ(ped, "mech_inspection@mini_map@satchel", "enter")
end

function RangerJournal()
    local ped = PlayerPedId()
	AnimationJ(ped, "mech_inspection@two_fold_map@satchel", "exit_satchel")
end

function AnimationJ(ped, dict, name)
    if not DoesAnimDictExist(dict) then
      return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, 2000, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

RegisterNUICallback('close', CloseUI)