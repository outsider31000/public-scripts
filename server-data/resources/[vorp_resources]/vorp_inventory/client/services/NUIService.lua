NUIService = {}
isProcessingPay = false
InInventory = false

NUIService.ReloadInventory = function(inventory)
	SendNUIMessage(json.decode(inventory))
	Wait(500)
	NUIService.LoadInv()
end

-- OpenContainerInventory

NUIService.OpenClanInventory = function(clanName, clanId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "clan", title = "" .. clanName .. "", clanid = clanId, capacity = capacity })
	InInventory = true
end

NUIService.NUIMoveToClan = function(obj)
	TriggerServerEvent("syn_clan:MoveToClan", json.encode(obj))
end

NUIService.NUITakeFromClan = function(obj)
	TriggerServerEvent("syn_clan:TakeFromClan", json.encode(obj))
end

NUIService.OpenContainerInventory = function(ContainerName, Containerid, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "Container", title = "" .. ContainerName .. "", Containerid = Containerid,
		capacity = capacity })
	InInventory = true
end

NUIService.NUIMoveToContainer = function(obj)
	TriggerServerEvent("syn_Container:MoveToContainer", json.encode(obj))
end

NUIService.NUITakeFromContainer = function(obj)
	TriggerServerEvent("syn_Container:TakeFromContainer", json.encode(obj))
end

NUIService.CloseInventory = function()
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "hide" })
	InInventory = false
end

NUIService.OpenHorseInventory = function(horseTitle, horseId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "horse", title = horseTitle, horseid = horseId, capacity = capacity })
	InInventory = true
	TriggerEvent("vorp_stables:setClosedInv", true)
end

NUIService.NUIMoveToHorse = function(obj)
	TriggerServerEvent("vorp_stables:MoveToHorse", json.encode(obj))
end

NUIService.NUITakeFromHorse = function(obj)
	TriggerServerEvent("vorp_stables:TakeFromHorse", json.encode(obj))
end

NUIService.OpenstealInventory = function(stealName, stealId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "steal", title = stealName, stealId = stealId, capacity = capacity })
	InInventory = true
	TriggerEvent("vorp_stables:setClosedInv", true)
end

NUIService.NUIMoveTosteal = function(obj)
	TriggerServerEvent("syn_search:MoveTosteal", json.encode(obj))
end

NUIService.NUITakeFromsteal = function(obj)
	TriggerServerEvent("syn_search:TakeFromsteal", json.encode(obj))
end

NUIService.OpenCartInventory = function(cartName, wagonId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "cart", title = cartName, wagonid = wagonId, capacity = capacity })
	InInventory = true

	TriggerEvent("vorp_stables:setClosedInv", true)
end

NUIService.NUIMoveToCart = function(obj)
	TriggerServerEvent("vorp_stables:MoveToCart", json.encode(obj))
end

NUIService.NUITakeFromCart = function(obj)
	TriggerServerEvent("vorp_stables:TakeFromCart", json.encode(obj))
end


NUIService.OpenHouseInventory = function(houseName, houseId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "house", title = houseName, houseId = houseId, capacity = capacity })
	InInventory = true
end

NUIService.NUIMoveToHouse = function(obj)
	TriggerServerEvent("vorp_housing:MoveToHouse", json.encode(obj))
end

NUIService.NUITakeFromHouse = function(obj)
	TriggerServerEvent("vorp_housing:TakeFromHouse", json.encode(obj))
end

NUIService.OpenBankInventory = function(bankName, bankId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "bank", title = bankName, bankId = bankId, capacity = capacity })
	InInventory = true
end

NUIService.NUIMoveToBank = function (obj)
	TriggerServerEvent("vorp_bank:MoveToBank", json.encode(obj))
end

NUIService.NUITakeFromBank = function (obj)
	TriggerServerEvent("vorp_bank:TakeFromBank", json.encode(obj))
end

NUIService.OpenHideoutInventory = function(hideoutName, hideoutId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "hideout", title = hideoutName, hideoutId = hideoutId, capacity = capacity })
	InInventory = true
end

NUIService.NUIMoveToHideout = function(obj)
	TriggerServerEvent("syn_underground:MoveToHideout", json.encode(obj))
end

NUIService.NUITakeFromHideout = function(obj)
	TriggerServerEvent("syn_underground:TakeFromHideout", json.encode(obj))
end

NUIService.setProcessingPayFalse = function()
	isProcessingPay = false
end

NUIService.NUIUnequipWeapon = function(obj)
	local data = obj

	if UserWeapons[tonumber(data.id)] then
		UserWeapons[tonumber(data.id)]:UnequipWeapon()
	end

	NUIService.LoadInv()
end

NUIService.NUIGetNearPlayers = function(obj)
	local playerPed = PlayerPedId()
	local nearestPlayers = Utils.getNearestPlayers()
	local isAnyPlayerFound = false
	local closePlayersArr = {}
	local nuiReturn = {}

	for _, player in pairs(nearestPlayers) do
		isAnyPlayerFound = true
		table.insert(closePlayersArr, {
			label = GetPlayerServerId(player), -- show server id instead of steam name
			player = GetPlayerServerId(player)
		})
	end

	if next(closePlayersArr) == nil then
		print("No Near Players")
		return
	end

	local item = {}

	for k, v in pairs(obj) do
		item[k] = v
	end

	if item.id == nil then
		item.id = 0
	end

	if item.count == nil then
		item.count = 1
	end

	if item.hash == nil then
		item.hash = 1
	end

	nuiReturn.action = "nearPlayers"
	nuiReturn.foundAny = isAnyPlayerFound
	nuiReturn.players = closePlayersArr
	nuiReturn.item = item.item
	nuiReturn.hash = item.hash
	nuiReturn.count = item.count
	nuiReturn.id = item.id
	nuiReturn.type = item.type
	nuiReturn.what = item.what

	SendNUIMessage(nuiReturn)
end

NUIService.NUIGiveItem = function(obj)
	local nearestPlayers = Utils.getNearestPlayers()

	local data = Utils.expandoProcessing(obj)
	local data2 = Utils.expandoProcessing(data.data)

	for _, player in pairs(nearestPlayers) do
		if player ~= PlayerId() then
			if GetPlayerServerId(player) == tonumber(data.player) then
				local itemName = data2.item
				local target = tonumber(data.player)

				if data2.type == "item_money" then
					if isProcessingPay then return end
					isProcessingPay = true
					TriggerServerEvent("vorpinventory:giveMoneyToPlayer", target, tonumber(data2.count))
					TriggerServerEvent("vorpinventory:moneylog", target, tonumber(data2.count))
				elseif Config.UseGoldItem and data2.type == "item_gold" then
					if isProcessingPay then return end
					isProcessingPay = true
					TriggerServerEvent("vorpinventory:giveGoldToPlayer", target, tonumber(data2.count))
				elseif data2.type == "item_ammo" then 
					if isProcessingPay then return end
					isProcessingPay = true
					local amount = tonumber(data2.count)
					local ammotype = data2.item 
					local maxcount = Config.maxammo[ammotype]
					if amount > 0 and maxcount >= amount then 
						TriggerServerEvent("vorpinventory:servergiveammo", ammotype, amount, target,maxcount)
					end
				elseif tonumber(data2.id) == 0 then
					local amount = tonumber(data2.count)

					if amount > 0 and UserInventory[itemName]:getCount() >= amount then
						TriggerServerEvent("vorpinventory:serverGiveItem", itemName, amount, target, 1)
					else
						-- TODO error message: Invalid amount of item
					end
				else
					TriggerServerEvent("vorpinventory:serverGiveWeapon", tonumber(data2.id), target)
					TriggerServerEvent("vorpinventory:weaponlog", target, data2)
				end

				NUIService.LoadInv()
			end
		end
	end
end

NUIService.NUIDropItem = function(obj)
	local aux = Utils.expandoProcessing(obj)
	local itemName = aux.item
	local type = aux.type
	local qty = tonumber(aux.number)

	if type == "item_money" then
		TriggerServerEvent("vorpinventory:serverDropMoney", qty)
	end

	if Config.UseGoldItem then
		if type == "item_gold" then
			TriggerServerEvent("vorpinventory:serverDropGold", qty)
		end
	end

	if type == "item_standard" then
		if aux.number and aux.number ~= '' then
			if qty > 0 and UserInventory[itemName]:getCount() >= qty then
				TriggerServerEvent("vorpinventory:serverDropItem", itemName, qty)
				UserInventory[itemName]:quitCount(qty)
				if UserInventory[itemName]:getCount() == 0 then
					UserInventory[itemName] = nil
				end
			end
		end
	end

	if type == "item_weapon" then
		TriggerServerEvent("vorpinventory:serverDropWeapon", aux.id)

		if UserWeapons[aux.id] then
			local weapon = UserWeapons[aux.id]

			if weapon:getUsed() then
				weapon:setUsed(false)
				RemoveWeaponFromPed(PlayerPedId(), GetHashKey(weapon:getName()), true, 0)
			end

			UserWeapons[aux.id] = nil
		end
	end

	NUIService.LoadInv()
end


local function getGuidFromItemId(inventoryId, itemData, category, slotId)
	local outItem = DataView.ArrayBuffer(8 * 13)

	if not itemData then
		itemData = 0
	end

	local success = Citizen.InvokeNative("0x886DFD3E185C8A89", inventoryId, itemData, category, slotId, outItem:Buffer()) --InventoryGetGuidFromItemid
	if success then
		return outItem:Buffer() --Seems to not return anythign diff. May need to pull from native above
	else
		return nil
	end
end

local function addWardrobeInventoryItem(itemName, slotHash)
	local itemHash = GetHashKey(itemName)
	local addReason = GetHashKey("ADD_REASON_DEFAULT")
	local inventoryId = 1

	-- _ITEMDATABASE_IS_KEY_VALID
	local isValid = Citizen.InvokeNative("0x6D5D51B188333FD1", itemHash, 0) --ItemdatabaseIsKeyValid
	if not isValid then
		return false
	end

	local characterItem = getGuidFromItemId(inventoryId, nil, GetHashKey("CHARACTER"), 0xA1212100)
	if not characterItem then
		return false
	end

	local wardrobeItem = getGuidFromItemId(inventoryId, characterItem, GetHashKey("WARDROBE"), 0x3DABBFA7)
	if not wardrobeItem then
		return false
	end

	local itemData = DataView.ArrayBuffer(8 * 13)

	-- _INVENTORY_ADD_ITEM_WITH_GUID
	local isAdded = Citizen.InvokeNative("0xCB5D11F9508A928D", inventoryId, itemData:Buffer(), wardrobeItem, itemHash,
		slotHash, 1, addReason)
	if not isAdded then
		return false
	end

	-- _INVENTORY_EQUIP_ITEM_WITH_GUID
	local equipped = Citizen.InvokeNative("0x734311E2852760D0", inventoryId, itemData:Buffer(), true)
	return equipped;
end

NUIService.NUIUseItem = function(data)
	if data["type"] == "item_standard" then

		TriggerServerEvent("vorp_inventory:useItem", data["item"])

	elseif data["type"] == "item_weapon" then

		local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, 0, false)
		local weaponId = tonumber(data["id"])
		local isWeaponARevolver = Citizen.InvokeNative(0xC212F1D05A8232BB, GetHashKey(UserWeapons[weaponId]:getName()))
		local isWeaponAPistol = Citizen.InvokeNative(0xDDC64F5E31EEDAB6, GetHashKey(UserWeapons[weaponId]:getName()))
		local isArmed = Citizen.InvokeNative(0xCB690F680A3EA971, PlayerPedId(), 4)
		local notdual = false 

		if (isWeaponARevolver or isWeaponAPistol) and isArmed then

			local isWeaponUsedARevolver = Citizen.InvokeNative(0xC212F1D05A8232BB, weaponHash)
			local isWeaponUsedAPistol = Citizen.InvokeNative(0xDDC64F5E31EEDAB6, weaponHash)

			if isWeaponUsedAPistol or isWeaponUsedARevolver then
				addWardrobeInventoryItem("CLOTHING_ITEM_M_OFFHAND_000_TINT_004", 0xF20B6B4A)
				addWardrobeInventoryItem("UPGRADE_OFFHAND_HOLSTER", 0x39E57B01)
				UserWeapons[weaponId]:setUsed2(true)
				UserWeapons[weaponId]:equipwep()
				UserWeapons[weaponId]:loadComponents()
				UserWeapons[weaponId]:setUsed(true)
				TriggerServerEvent("syn_weapons:weaponused", data)
			else
				notdual = true 
			end
		elseif not UserWeapons[weaponId]:getUsed() and not Citizen.InvokeNative(0x8DECB02F88F428BC, PlayerPedId(), GetHashKey(UserWeapons[weaponId]:getName()), 0, true) then
			notdual = true 
        end
		if notdual then 
			UserWeapons[weaponId]:equipwep()
            UserWeapons[weaponId]:loadComponents()
            UserWeapons[weaponId]:setUsed(true)
            TriggerServerEvent("syn_weapons:weaponused", data)
		end
		NUIService.LoadInv()
	end
end

NUIService.NUISound = function(obj)
	PlaySoundFrontend("BACK", "RDRO_Character_Creator_Sounds", true, 0)
end

NUIService.NUIFocusOff = function(obj)
	NUIService.CloseInv()
	TriggerEvent("vorp_stables:setClosedInv", false)
	TriggerEvent("syn:closeinv")
end

NUIService.OnKey = function()
	if IsControlJustReleased(1, Config.openKey) and IsInputDisabled(0) then
		if InInventory then
			NUIService.CloseInv()
			Wait(1000)
		else
			NUIService.OpenInv()
			Wait(1000)
		end
	end
end

NUIService.LoadInv = function()
	local payload = {}
	local items = {}

	TriggerServerEvent("vorpinventory:check_slots")


	for _, currentItem in pairs(UserInventory) do
		local item = {}
		item.count = currentItem:getCount()
		item.limit = currentItem:getLimit()
		item.label = currentItem:getLabel()
		item.name = currentItem:getName()
		item.type = currentItem:getType()
		item.usable = currentItem:getUsable()
		item.canRemove = currentItem:getCanRemove()
		item.desc = currentItem:getDesc()

		table.insert(items, item)
	end

	for _, currentWeapon in pairs(UserWeapons) do
		local weapon = {}
		weapon.count = currentWeapon:getTotalAmmoCount() -- TODO Replace by number of ammo (all types or one specific tipe ?)
		weapon.limit = -1
		weapon.label = currentWeapon:getLabel() -- Citizen.InvokeNative(0x89CF5FF3D363311E, GetHashKey(currentWeapon:getName()))
		weapon.name = currentWeapon:getName()
		weapon.hash = GetHashKey(currentWeapon:getName())
		weapon.type = "item_weapon"
		weapon.usable = true
		weapon.canRemove = true
		weapon.id = currentWeapon:getId()
		weapon.used = currentWeapon:getUsed()
		weapon.desc = currentWeapon:getDesc()

		table.insert(items, weapon)
	end

	payload.action = "setItems"
	payload.itemList = items

	SendNUIMessage(payload)
end

NUIService.OpenInv = function()
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "display", type = "main" })
	InInventory = true

	NUIService.LoadInv()
end

NUIService.CloseInv = function()
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "hide" })
	InInventory = false
end

NUIService.transactionStarted = function(displaytext)
	SetNuiFocus(true, false)
	SendNUIMessage({ action = "transaction", type = "started", text = _U("TransactionLoading") })
end

NUIService.transactionComplete = function()
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "transaction", type = "completed" })
end

NUIService.initiateData = function()
	-- Add Locales
	SendNUIMessage({ action = "initiate", language = {
		empty = _U("emptyammo"),
		prompttitle = _U("prompttitle"),
		promptaccept = _U("promptaccept"),
		inventoryclose = _U("inventoryclose"),
		inventorysearch = _U("inventorysearch"),
		toplayerpromptitle = _U("toplayerpromptitle"),
		toplaterpromptaccept = _U("toplaterpromptaccept"),
		gunbeltlabel = _U("gunbeltlabel"),
		gunbeltdescription = _U("gunbeltdescription"),
		inventorymoneylabel = _U("inventorymoneylabel"),
		inventorymoneydescription = _U("inventorymoneydescription"),
		givemoney = _U("givemoney"),
		dropmoney = _U("dropmoney"),
		inventorygoldlabel =  _U("inventorygoldlabel"),
		inventorygolddescription =  _U("inventorygolddescription"),
		givegold = _U("givegold"),
		dropgold = _U("dropgold"),
		unequip = _U("unequip"),
		use = _U("use"),
		give = _U("give"),
		drop = _U("drop")
	}})
end

-- Main loop
Citizen.CreateThread(function()
	Wait(5000)
	NUIService.initiateData()

	while true do
		if IsControlJustReleased(0, Config.OpenKey) and IsInputDisabled(0) then
			if InInventory then
				NUIService.CloseInv()
			else
				NUIService.OpenInv()
			end
		end

		if Config.DisableDeathInventory then
			if InInventory and IsPedDeadOrDying(PlayerPedId()) then
				NUIService.CloseInv()
			end
		end
		Wait(1)
	end
end)
