InventoryApiService = {}

---@param count number
---@param limit number
---@param label string
---@param name string
---@param type string
---@param canUse boolean
---@param canRemove boolean
InventoryApiService.addItem = function (count, limit, label, name, type, canUse, canRemove)
    if UserInventory[name] ~= nil then
        UserInventory[name]:addCount(count)
    else
        UserInventory[name] = Item:New({
            count = count,
            limit = limit,
            name = name,
            label = label,
            type = type,
            canUse = canUse,
            canRemove = canRemove
        })
    end
    NUIService.LoadInv()
end

---@param weaponId number
InventoryApiService.subWeapon = function (weaponId)
    if UserWeapons[weaponId] ~= nil then
        if UserWeapons[weaponId]:getUsed() then
            RemoveWeaponFromPed(PlayerPedId(), GetHashKey(UserWeapons[weaponId]:getName()),true, 0)
        end
        Utils.TableRemoveByKey(UserWeapons, weaponId)
    end
    NUIService.LoadInv()
end

---@param name string
---@param qty number
InventoryApiService.subItem = function (name, qty)
    if UserInventory[name] ~= nil then
        UserInventory[name]:setCount(qty)
        if UserInventory[name]:getCount() == 0 then
            --table.remove(UserInventory, name)
            Utils.TableRemoveByKey(UserInventory, name)
        end
    end
    NUIService.LoadInv()
end

---@param weaponId number
---@param bulletType string
---@param qty number
InventoryApiService.addWeaponBullets = function (weaponId, bulletType, qty)
    if UserWeapons[weaponId] ~= nil then
        UserWeapons[weaponId]:addAmmo(bulletType, qty)
        if UserWeapons[weaponId]:getUsed() then
            SetPedAmmoByType(PlayerPedId(), GetHashKey(bulletType), UserWeapons[weaponId]:getAmmo(bulletType))
        end
    end
    NUIService.LoadInv()
end

---@param weaponId number
---@param bulletType string
---@param qty number
InventoryApiService.subWeaponBullets = function (weaponId, bulletType, qty)
    if UserWeapons[weaponId] ~= nil then
        UserWeapons[weaponId]:subAmmo(bulletType, qty)
        if UserWeapons[weaponId]:getUsed() then
            SetPedAmmoByType(PlayerPedId(), GetHashKey(bulletType), UserWeapons[weaponId]:getAmmo(bulletType))
        end
    end
    NUIService.LoadInv()
end

---@param weaponId number
---@param component string
InventoryApiService.addComponent = function (weaponId, component)
    if UserWeapons[weaponId] ~= nil then
        for _,v in pairs(UserWeapons[weaponId]:getAllComponents()) do
            if v == component then
                return
            end
        end

        UserWeapons[weaponId]:setComponent(component)
        if UserWeapons[weaponId]:getUsed() then
            Citizen.InvokeNative(0x4899CB088EDF59B8, PlayerPedId(), GetHashKey(UserWeapons[weaponId]:getName()), true, 0)
            UserWeapons[weaponId]:loadAmmo()
            UserWeapons[weaponId]:loadComponents()
        end
    end
end

---@param weaponId number
---@param component string
InventoryApiService.subComponent = function (weaponId, component)
    if UserWeapons[weaponId] ~= nil then
        for _,v in pairs(UserWeapons[weaponId]:getAllComponents()) do
            if v == component then
                return
            end
        end

        UserWeapons[weaponId]:quitComponent(component)
        if UserWeapons[weaponId]:getUsed() then
            Citizen.InvokeNative(0x4899CB088EDF59B8, PlayerPedId(), GetHashKey(UserWeapons[weaponId]:getName()), true, 0)
            UserWeapons[weaponId]:loadAmmo()
            UserWeapons[weaponId]:loadComponents()
        end
    end
end