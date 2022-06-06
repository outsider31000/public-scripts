local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local function giveReward(context, data, skipfinal)
	local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
	
	local money, gold, rolPoints, xp = 0,0,0,0
	local givenItem, givenAmount, givenDisplay = {},{},{}
	local animal, found
	if context == "skinned" then
		animal = Config.SkinnableAnimals[data.model]
		if animal then
			found = true
			givenItem = animal.givenItem or {}
			givenAmount = animal.givenAmount or {}
			givenDisplay = animal.givenDisplay or {}
			money = animal.money or 0
			gold = animal.gold or 0
			rolPoints = animal.rolPoints or 0
			xp = animal.xp or 0
		end
	elseif context == "pelt" then
		animal = Config.Animals[data.model]
		if animal then
			found = true
			money = animal.money or 0
			gold = animal.gold or 0
			rolPoints = animal.rolPoints or 0
			xp = animal.xp or 0
			
			local multiplier = 1.0
			if animal.poorQualityMultiplier and (data.quality == animal.poorQualityMultiplier) then
				multiplier = animal.poorQualityMultiplier
			elseif animal.goodQualityMultiplier and (data.quality == animal.goodQualityMultiplier) then
				multiplier = animal.goodQualityMultiplier
			elseif animal.perfectQualityMultiplier and (data.quality == animal.perfectQualityMultiplier) then
				multiplier = animal.perfectQualityMultiplier
			end
			
			money = money * multiplier
			gold = gold * multiplier
			rolPoints = rolPoints * multiplier
			xp = xp * multiplier
		end
	elseif context == "carcass" then
		animal = Config.Animals[data.model]
		if animal then
			found = true
			givenItem = animal.givenItem or {}
			givenAmount = animal.givenAmount or {}
			givenDisplay = animal.givenDisplay or {}
			money = animal.money or 0
			gold = animal.gold or 0
			rolPoints = animal.rolPoints or 0
			xp = animal.xp or 0
		end
	end
	
	if found then
		local monies = {}
			
		if money ~= 0 then
			table.insert(monies, Config.Language.dollar .. money)
			Character.addCurrency(0, money)
		end

		if gold ~= 0 then
			table.insert(monies, gold .. " gold")
			Character.addCurrency(1, gold)
		end

		if rolPoints ~= 0 then
			table.insert(monies, rolPoints .. " rolPoints")
			Character.addCurrency(2, rolPoints)
		end

		if xp ~= 0 then
			Character.addXp(xp)
		end
		
		if #monies > 0 then
			TriggerClientEvent("vorp:TipRight", _source, Config.Language.AnimalSold .. table.concat(monies, ", "), 4000)
		end
		
		if not skipfinal then
			TriggerClientEvent("vorp_hunting:finalizeReward", _source, data.entity, data.horse)
		end
		
		local itemsAvailable = true 
		local done = false
		
		if #givenItem ~= #givenAmount then
			print('Error: Please ensure givenItem and givenAmount have the same length in the items config.')
		elseif (givenItem ~= nil) and (#givenItem > 0) then
			local formattedGivenItems = {}
			local total = 0

			-- Format items and set random quantities if set.
			-- Check if items can be added
			-- total up the quantity so it can be checked as a whole
			for k, v in pairs(givenItem) do
				local nmb = 0

				if givenAmount[k] > 0 then
					nmb = givenAmount[k]
				else
					nmb = math.random(Config.ItemQuantity.Min, Config.ItemQuantity.Max)
				end

				formattedGivenItems[k] = {
					nmb = nmb,
					item = v
				}

				total = total + nmb

				-- Check if there is enough to add, if not send message
				TriggerEvent("vorpCore:canCarryItem", tonumber(_source), v, nmb, function(canCarryItem)                
					if canCarryItem ~= true then
						itemsAvailable = false              
					end
					done = true
				end)

				while done == false do
					Wait(500)
				end
			end

			if itemsAvailable == false then
				TriggerClientEvent("vorp:TipRight", _source,  Config.Language.FullInventory, 4000)
				return
			end

			-- Check if there is enough room in inventory in general.
			local invAvailable = VorpInv.canCarryItems(_source, total)
			if invAvailable ~= true then
				TriggerClientEvent("vorp:TipRight", _source, Config.Language.FullInventory, 4000)
				return
			end

			-- Give items
			local validDisplays = #givenItem == #givenDisplay
			local givenMsg = ""
			if #formattedGivenItems > 0 then
				if context == skinned then
					givenMsg = Config.Language.SkinnableAnimalstowed
				else
					givenMsg = "You received "
				end
				if not validDisplays then givenMsg = givenMsg .. "items..." end
			end
			for k, v in pairs(formattedGivenItems) do
				if validDisplays then
					if k > 1 then
						givenMsg = givenMsg .. Config.Language.join .. givenDisplay[k] .. ((v.nmb > 1) and "s" or "")
					else
						givenMsg = givenMsg .. givenDisplay[k] .. ((v.nmb > 1) and "s" or "")
					end
				end
				VorpInv.addItem(_source, v.item, v.nmb) 
			end

			if givenMsg ~= "" then
				TriggerClientEvent("vorp:TipRight", _source, givenMsg, 4000)
			end
		end
	end
end

RegisterServerEvent("vorp_hunting:giveReward")
AddEventHandler("vorp_hunting:giveReward", giveReward)


RegisterServerEvent("vorp_hunting:getJob")
AddEventHandler("vorp_hunting:getJob", function(source)
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local job = Character.job -- character table

    TriggerClientEvent("vorp_hunting:findJob", _source, job)

end)
