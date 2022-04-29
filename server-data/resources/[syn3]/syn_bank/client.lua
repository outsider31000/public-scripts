
local prompts = GetRandomIntInRange(0, 0xffffff)
local openmenu
local inmenu = false
local bank
local bankinfo
local blips = {}
TriggerEvent("menuapi:getData",function(call)
    MenuData = call
end)

AddEventHandler('menuapi:closemenu', function()
    if inmenu then 
        inmenu = false 
        bankinfo = nil 
        ClearPedTasks(PlayerPedId())
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    for k,v in pairs(Config.banks) do 
		local blip = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
    	SetBlipSprite(blip, v.blipsprite, 1)
    	SetBlipScale(blip, 1.5)
    	Citizen.InvokeNative(0x9CB1A1623062F402, blip, k)
        table.insert(blips, blip)
    end
end)

AddEventHandler("onResourceStop",function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for k,v in pairs(blips) do 
            RemoveBlip(v)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = Config.language.openmenu
	openmenu = PromptRegisterBegin()
	PromptSetControlAction(openmenu, Config.keys["G"])
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(openmenu, str)
	PromptSetEnabled(openmenu, 1)
	PromptSetVisible(openmenu, 1)
	PromptSetStandardMode(openmenu,1)
	PromptSetGroup(openmenu, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,openmenu,true)
	PromptRegisterEnd(openmenu)
end)

RegisterNetEvent("syn_bank:recinfo")
AddEventHandler("syn_bank:recinfo", function(x)
	bankinfo = x 
end)

RegisterNetEvent("syn_bank:ready")
AddEventHandler("syn_bank:ready", function()
	inmenu = false
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local sleep = true 
        local playercoords = GetEntityCoords(PlayerPedId())
        if not inmenu then 
            for k,v in pairs(Config.banks) do 
                local dist = GetDistanceBetweenCoords(playercoords,v.x,v.y,v.z, true)
                if 1.5 > dist then 
                    sleep = false 
                    local label  = CreateVarString(10, 'LITERAL_STRING', Config.language.bank)
                    PromptSetActiveGroupThisFrame(prompts, label)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE,openmenu) then
                        inmenu = true 
                        bank = v.city
                        TriggerServerEvent("syn_bank:getinfo",bank)
                        while bankinfo == nil do 
                           Citizen.Wait(500)
                        end
                        TaskStandStill(PlayerPedId(), -1)
                        openbank(k)
                    end
                end
            end
        end
        if sleep then 
            Citizen.Wait(500)
        end
    end
end)

function openbank(title)
	MenuData.CloseAll()
	local elements = {
		{label = Config.language.cashbalance..bankinfo.money, value = 'nothing' , desc = Config.language.cashbalance2},
	}
    if Config.gold then 
        table.insert(elements, {label = Config.language.goldbalance..bankinfo.gold, value = 'nothing' , desc = Config.language.cashbalance2}) 
    end
    table.insert(elements, {label = Config.language.depocash, value = 'dcash' , desc = Config.language.depocash2}) 
    table.insert(elements, {label = Config.language.takecash, value = 'wcash' , desc = Config.language.takecash2}) 
    if Config.gold then 
        table.insert(elements, {label = Config.language.depogold, value = 'dgold' , desc = Config.language.depogold2}) 
        table.insert(elements, {label = Config.language.takegold, value = 'wgold' , desc = Config.language.takegold2}) 
    end
   MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
	{
		title    = title,
		subtext    = Config.language.welcome,
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
		if(data.current.value == 'dcash') then
            TriggerEvent("syn_inputs:sendinputs", Config.language.confirm, Config.language.amount, function(cb)
                local amount =     tonumber(cb)
                if amount ~= nil and amount > 0 then
                   TriggerServerEvent("syn_bank:depositcash",amount,bank)
                else
                    TriggerEvent("vorp:TipBottom", Config.language.invalid, 6000) 
                    inmenu = false 
                end
            end)
            MenuData.CloseAll()
            bankinfo = nil 
            ClearPedTasks(PlayerPedId())
		end
        if(data.current.value == 'dgold') then
            TriggerEvent("syn_inputs:sendinputs", Config.language.confirm, Config.language.amount, function(cb)
                local amount =     tonumber(cb)
                if amount ~= nil and amount > 0 then
                   TriggerServerEvent("syn_bank:depositgold",amount,bank)
                else
                    TriggerEvent("vorp:TipBottom", Config.language.invalid, 6000) 
                    inmenu = false 
                end
            end)
            MenuData.CloseAll()
            bankinfo = nil 
            ClearPedTasks(PlayerPedId())
		end
        if(data.current.value == 'wcash') then
            TriggerEvent("syn_inputs:sendinputs", Config.language.confirm, Config.language.amount, function(cb)
                local amount =     tonumber(cb)
                if amount ~= nil and amount > 0 then
                   TriggerServerEvent("syn_bank:withcash",amount,bank)
                else
                    TriggerEvent("vorp:TipBottom", Config.language.invalid, 6000) 
                    inmenu = false 
                end
            end)
            MenuData.CloseAll()
            bankinfo = nil 
            ClearPedTasks(PlayerPedId())
		end
        if(data.current.value == 'wgold') then
            TriggerEvent("syn_inputs:sendinputs", Config.language.confirm, Config.language.amount, function(cb)
                local amount =     tonumber(cb)
                if amount ~= nil and amount > 0 then
                   TriggerServerEvent("syn_bank:withgold",amount,bank)
                else
                    TriggerEvent("vorp:TipBottom", Config.language.invalid, 6000) 
                    inmenu = false 
                end
            end)
            MenuData.CloseAll()
            bankinfo = nil 
            ClearPedTasks(PlayerPedId())
		end
	end,
	function(data, menu)
		menu.close()
	end)
end