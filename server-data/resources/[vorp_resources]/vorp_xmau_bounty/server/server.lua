local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
Inventory = exports.vorp_inventory:vorp_inventoryApi()
local cooldown = 0

RegisterServerEvent('vorp_bountyhunting:AddSomeMoney')
AddEventHandler('vorp_bountyhunting:AddSomeMoney', function()
    local _source = source
    local price = Config.Price
    -- local xp = Config.Xp
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Character.addCurrency(0, price)
    TriggerClientEvent("vorp:TipRight", _source, "You Got Paid "..price, 5000)
    -- Character.addXp(xp)
end)

RegisterServerEvent('bounty:startcooldown')
AddEventHandler('bounty:startcooldown', function()
    cooldown = 1 
    cooldowntimer = Config.cooldowntimer * 60000 -- convert minutes to mili seconds
    Wait(cooldowntimer)
    cooldown = 0
end)

RegisterServerEvent('vorp_bountyhunting:valreward')
AddEventHandler('vorp_bountyhunting:valreward', function()
    local _source = source
    local price2 = Config.Priceval
    -- local xp = Config.Xp
    local Character = VorpCore.getUser(_source).getUsedCharacter
    Character.addCurrency(0, price2)
    TriggerClientEvent("vorp:TipRight", _source, "You Got Paid "..price2, 5000)
    -- Character.addXp(xp)
end)

RegisterServerEvent('bounty:checkcard')
AddEventHandler('bounty:checkcard', function()
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
	local item = true
    --[[ if job == "bountyhunter" then
		item = true
	end ]]
	TriggerClientEvent('bounty:findcard', _source,item,cooldown)
end)