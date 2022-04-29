VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("vorp_lumberjack:axecheck")
AddEventHandler("vorp_lumberjack:axecheck", function(tree)
	local _source = source
	local choppingtree = tree
	local axe = VorpInv.getItemCount(_source, Config.Axe)

	if axe > 0 then
		TriggerClientEvent("vorp_lumberjack:axechecked", _source, choppingtree)
	else
		TriggerClientEvent("vorp_lumberjack:noaxe", _source)
		TriggerClientEvent("vorp:TipRight", _source, "You don't have an axe", 2000)
	end
end)

function keysx(table)
    local keys = 0
    for k,v in pairs(table) do
       keys = keys + 1
    end
    return keys
end

RegisterServerEvent('vorp_lumberjack:addItem')
AddEventHandler('vorp_lumberjack:addItem', function()
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
				TriggerClientEvent("vorp:TipRight", _source, "You got "..reward[chance2].label, 3000)
			else
				TriggerClientEvent("vorp:TipRight", _source, "You can't carry any more "..reward[chance2].label, 3000)
			end
		end)
	end) 
end)