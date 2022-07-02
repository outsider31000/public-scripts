PickupsService = {}
local promptGroup = GetRandomIntInRange(0, 0xffffff)
local WorldPickups = {}
local dropAll = false
local lastCoords = {}

PickupsService.CreateObject = function(model, position)
	local objectHash = GetHashKey(model)

	if not Citizen.InvokeNative(0x1283B8B89DD5D1B6, objectHash) then -- HasModelLoaded
		Citizen.InvokeNative(0xFA28FE3A6246FC30, objectHash) -- RequestModel
	end

	while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, objectHash) do -- HasModelLoaded
		Wait(1)
	end

	local entityHandle = Citizen.InvokeNative(0x509D5878EB39E842, objectHash, position.x, position.y, position.z, true, true, true) -- CreateObject

	Citizen.InvokeNative(0x58A850EAEE20FAA3, entityHandle) -- PlaceObjectOnGroundProperly
	Citizen.InvokeNative(0xDC19C288082E586E, entityHandle, true, false) -- SetEntityAsMissionEntity
	Citizen.InvokeNative(0x7D9EFB7AD6B19754, entityHandle, true) -- FreezeEntityPosition
	Citizen.InvokeNative(0x7DFB49BCDB73089A, entityHandle, true) -- SetPickupLight
	Citizen.InvokeNative(0xF66F820909453B8C, entityHandle, false, true) -- SetEntityCollision

	SetModelAsNoLongerNeeded(objectHash)

	return entityHandle
end

PickupsService.createPickup = function(name, amount, weaponId)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, true, true)
	local forward = GetEntityForwardVector(playerPed)
	local position = vector3(coords.x + forward.x * 1.6, coords.y + forward.y * 1.6, coords.z + forward.z * 1.6)
	local pickupModel = "P_COTTONBOX01X"


	if dropAll then
		local randomOffsetX = math.random(-35, 35)
		local randomOffsetY = math.random(-35, 35)

		position = vector3(lastCoords.x + (randomOffsetX / 10.0), lastCoords.y + (randomOffsetY / 10.0), lastCoords.z)
	end

	local entityHandle = PickupsService.CreateObject(pickupModel, position)

	TriggerServerEvent("vorpinventory:sharePickupServer", name, entityHandle, amount, position, weaponId)
	PlaySoundFrontend("show_info", "Study_Sounds", true, 0)

end

PickupsService.createMoneyPickup = function(amount)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, true, true)
	local forward = GetEntityForwardVector(playerPed)
	local position = vector3(coords.x + forward.x * 1.6, coords.y + forward.y * 1.6, coords.z + forward.z * 1.6)
	local pickupModel = "p_moneybag02x"

	if dropAll then
		local randomOffsetX = math.random(-35, 35)
		local randomOffsetY = math.random(-35, 35)

		position = vector3(lastCoords.x + (randomOffsetX / 10.0), lastCoords.y + (randomOffsetY / 10.0), lastCoords.z)
	end

	local entityHandle = PickupsService.CreateObject(pickupModel, position)

	TriggerServerEvent("vorpinventory:shareMoneyPickupServer", entityHandle, amount, position)
	PlaySoundFrontend("show_info", "Study_Sounds", true, 0)
end

PickupsService.createGoldPickup = function(amount)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, true, true)
	local forward = GetEntityForwardVector(playerPed)
	local position = vector3(coords.x + forward.x * 1.6, coords.y + forward.y * 1.6, coords.z + forward.z * 1.6)
	local pickupModel = "p_moneybag02x"

	if dropAll then
		local randomOffsetX = math.random(-35, 35)
		local randomOffsetY = math.random(-35, 35)

		position = vector3(lastCoords.x + (randomOffsetX / 10.0), lastCoords.y + (randomOffsetY / 10.0), lastCoords.z)
	end

	local entityHandle = PickupsService.CreateObject(pickupModel, position)

	TriggerServerEvent("vorpinventory:shareGoldPickupServer", entityHandle, amount, position)
	PlaySoundFrontend("show_info", "Study_Sounds", true, 0)
end

PickupsService.sharePickupClient = function(name, entityHandle, amount, position, value, weaponId)
	if value == 1 then
		if WorldPickups[entityHandle] == nil then
			local label = Utils.GetHashreadableLabel(name, weaponId)

			local pickup = Pickup:New({
				name = (amount > 1) and label .. " x " .. tostring(amount) or label,
				entityId = entityHandle,
				amount = amount,
				weaponId = weaponId,
				coords = position,
				prompt = Prompt:New(0xF84FA74F, _U("TakeFromFloor"), PromptType.StandardHold, promptGroup)
			})


			pickup.prompt:SetVisible(false)
			WorldPickups[entityHandle] = pickup
			if Config.Debug then
				print('Item pickup added: ' .. tostring(pickup.name))
			end
		end
	else
		if WorldPickups[entityHandle] ~= nil then
			WorldPickups[entityHandle].prompt:Delete()
			Utils.TableRemoveByKey(WorldPickups, entityHandle)
		end
	end
end

PickupsService.shareMoneyPickupClient = function(entityHandle, amount, position, value)
	if value == 1 then
		if WorldPickups[entityHandle] == nil then
			local pickup = Pickup:New({
				name = "Money (" .. tostring(amount) .. ")",
				entityId = entityHandle,
				amount = amount,
				isMoney = true,
				coords = position,
				prompt = Prompt:New(0xF84FA74F, _U("TakeFromFloor"), PromptType.StandardHold, promptGroup)
			})


			pickup.prompt:SetVisible(false)
			WorldPickups[entityHandle] = pickup
			if Config.Debug then
				print('Money pickup added: ' .. tostring(pickup.name))
			end
		end
	else
		if WorldPickups[entityHandle] ~= nil then
			WorldPickups[entityHandle].prompt:Delete()
			Utils.TableRemoveByKey(WorldPickups, entityHandle)
		end
	end
end

PickupsService.shareGoldPickupClient = function(entityHandle, amount, position, value)
	if value == 1 then
		if WorldPickups[entityHandle] == nil then
			local pickup = Pickup:New({
				name = "Gold (" .. tostring(amount) .. ")",
				entityId = entityHandle,
				amount = amount,
				isGold = true,
				coords = position,
				prompt = Prompt:New(0xF84FA74F, _U("TakeFromFloor"), PromptType.StandardHold, promptGroup)
			})


			pickup.prompt:SetVisible(false)
			WorldPickups[entityHandle] = pickup
			if Config.Debug then
				print('Gold pickup added: ' .. tostring(pickup.name))
			end
		end
	else
		if WorldPickups[entityHandle] ~= nil then
			WorldPickups[entityHandle].prompt:Delete()
			Utils.TableRemoveByKey(WorldPickups, entityHandle)
		end
	end
end

PickupsService.removePickupClient = function(entityHandle)
	Citizen.InvokeNative(0xDC19C288082E586E, entityHandle, false, true) -- SetEntityAsMissionEntity
	NetworkRequestControlOfEntity(entityHandle)
	local timeout = 0

	while not NetworkHasControlOfEntity(entityHandle) and timeout < 5000 do
		timeout = timeout + 100
		if timeout == 5000 then
			if Config.Debug then
				print("Failed to get Control of the Entity")
			end
		end
		Wait(100)
	end

	Citizen.InvokeNative(0x7D9EFB7AD6B19754, entityHandle, false) -- FreezeEntityPosition
	Citizen.InvokeNative(0x7DFB49BCDB73089A, entityHandle, false) -- SetPickupLight
	DeleteObject(entityHandle)
end

PickupsService.playerAnim = function(obj)
	local animDict = "amb_work@world_human_box_pickup@1@male_a@stand_exit_withprop"
	Citizen.InvokeNative(0xA862A2AD321F94B4, animDict)

	while not Citizen.InvokeNative(0x27FF6FE8009B40CA, animDict) do
		Wait(10)
	end

	Citizen.InvokeNative(0xEA47FE3719165B94, PlayerPedId(), animDict, "exit_front", 1.0, 8.0, -1, 1, 0, false, false, false)
	Wait(1200)
	PlaySoundFrontend("CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true, 1)
	Wait(1000)
	Citizen.InvokeNative(0xE1EF3C1216AFF2CD, PlayerPedId())
end

PickupsService.DeadActions = function()
	local playerPed = PlayerPedId()

	lastCoords = GetEntityCoords(playerPed, true, true)
	dropAll = true
	PickupsService.dropAllPlease()
end

PickupsService.dropAllPlease = function()
	Wait(200)

	if Config.DropOnRespawn.Money then
		TriggerServerEvent("vorpinventory:serverDropAllMoney")
		Wait(200)
	end

	if Config.UseGoldItem and Config.DropOnRespawn.Gold then
		TriggerServerEvent("vorpinventory:serverDropAllGold")
		Wait(200)
	end

	if Config.DropOnRespawn.Items then
		local items = UserInventory

		for _, item in pairs(items) do
			local itemName = item:getName()
			local itemCount = item:getCount()

			TriggerServerEvent("vorpinventory:serverDropItem", itemName, itemCount)
			UserInventory[itemName]:quitCount(itemCount)

			if UserInventory[itemName]:getCount() == 0 then
				UserInventory[itemName] = nil
			end

			Wait(200)
		end
	end

	if Config.DropOnRespawn.Weapons then
		local weapons = UserWeapons

		for index, weapon in pairs(weapons) do
			TriggerServerEvent("vorpinventory:serverDropWeapon", index)

			if next(UserWeapons[index]) ~= nil then
				local currentWeapon = UserWeapons[index]

				if currentWeapon:getUsed() then
					currentWeapon:setUsed(false)
					RemoveWeaponFromPed(PlayerPedId(), GetHashKey(currentWeapon:getName()), true, 0)
				end

				UserWeapons[index] = nil
				Wait(200)
			end
		end
	end





	Wait(200)
	dropAll = false
end

PickupsService.OnWorldPickup = function()
	if next(WorldPickups) == nil then
		Wait(1000)
		return
	end

	local playerPed = PlayerPedId()
	local pickupsInRange = {}

	for key, value in pairs(WorldPickups) do
		if value:IsInRange() then
			table.insert(pickupsInRange, value)
		end
	end

	table.sort(pickupsInRange, function(left, right)
		return left:Distance() < right:Distance()
	end)


	for _, pickup in pairs(pickupsInRange) do
		if pickup:Distance() <= 1.2 then
			Citizen.InvokeNative(0x69F4BE8C8CC4796C, playerPed, pickup.entityId, 3000, 2048, 3) -- TaskLookAtEntity
			local isDead = IsEntityDead(playerPed)


			pickup.prompt:SetVisible(not isDead)

			local promptSubLabel = CreateVarString(10, "LITERAL_STRING", pickup.name)
			Citizen.InvokeNative(0xC65A45D4453C2627, promptGroup, promptSubLabel, 1) -- UiPromptSetActiveGroupThisFrame

			if pickup.prompt:HasHoldModeCompleted() then
				if pickup.isMoney then
					TriggerServerEvent("vorpinventory:onPickupMoney", pickup.entityId)
				elseif Config.UseGoldItem and pickup.isGold then 
					TriggerServerEvent("vorpinventory:onPickupGold", pickup.entityId )
				else
					TriggerServerEvent("vorpinventory:onPickup", pickup.entityId)
				end

				Wait(1000)
			end
		else
			if pickup.prompt:GetEnabled() then
				pickup.prompt:SetVisible(false)
			end
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		PickupsService.OnWorldPickup()
	end
end)
