VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("vorp_mining:pickaxecheck")
AddEventHandler("vorp_mining:pickaxecheck", function(rock)
	local _source = source
	local miningrock = rock
	local pickaxe = VorpInv.getItemCount(_source, Config.Pickaxe)

	if pickaxe > 0 then
		TriggerClientEvent("vorp_mining:pickaxechecked", _source, miningrock)
	else
		TriggerClientEvent("vorp_mining:nopickaxe", _source)
		TriggerClientEvent("vorp:TipRight", _source, "You don't have a pickaxe", 2000)
	end
end)

function keysx(table)
    local keys = 0
    for k,v in pairs(table) do
       keys = keys + 1
    end
    return keys
end

RegisterServerEvent('vorp_mining:addItem')
AddEventHandler('vorp_mining:addItem', function()
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local chance =  math.random(1,10)
	local reward = {}
	for k,v in pairs(Config.Items) do 
		if v.chance >= chance then
			table.insert(reward,v)
		end
	end
	local chance2 = math.random(1,keysx(reward))
	TriggerEvent("vorpCore:canCarryItems", tonumber(_source), reward[chance2].amount, function(canCarry)
		TriggerEvent("vorpCore:canCarryItem", tonumber(_source), reward[chance2].name,reward[chance2].amount, function(canCarry2)
			if canCarry and canCarry2 then
				VorpInv.addItem(_source, reward[chance2].name, reward[chance2].amount)
				TriggerClientEvent("vorp:TipRight", _source, "You found "..reward[chance2].label, 3000)
			else
				TriggerClientEvent("vorp:TipRight", _source, "You can't carry any more "..reward[chance2].label, 3000)
			end
		end)
	end) 
end)