exports('vorp_inventoryApi',function()
    local self = {}
    self.subWeapon = function(source,weaponid)
        TriggerEvent("vorpCore:subWeapon",source,tonumber(weaponid))
    end

    self.createWeapon = function(source,weaponName,ammoaux,compaux)
        TriggerEvent("vorpCore:registerWeapon",source,tostring(string.upper(weaponName)),ammoaux,compaux)
    end

    self.giveWeapon = function(source,weaponid,target)
        TriggerEvent("vorpCore:giveWeapon",source,weaponid,target)
    end

    self.addItem = function(source,itemName,cuantity)
        TriggerEvent("vorpCore:addItem",source,tostring(itemName),tonumber(cuantity))
    end

    self.subItem = function(source,itemName,cuantity)
        TriggerEvent("vorpCore:subItem",source,tostring(itemName),tonumber(cuantity))
    end

    self.getItem = function(source, itemName)
        local item
        
        TriggerEvent("vorpCore:getItem", source, tostring(itemName), function(responseItem)
            item = responseItem
        end)

        return item
    end

    self.getItemCount = function(source,item)
        local count = 0
        TriggerEvent("vorpCore:getItemCount",source,function(itemcount)
            count = itemcount
        end,tostring(item))
        return count
    end

    self.getDBItem = function(source, itemName)
        local item
        local done = false

        exports.ghmattimysql:execute( "SELECT * FROM items WHERE item=@id;", {['@id'] = itemName}, 
            function(result)
                -- Add check for if the item exists.
                if result[1] then
                    item = result[1]
                else
                    print('Item does not exist in Items table. Item: '..itemName)
                end
                done = true
            end)

        -- Wait for the call to finish (aka makes this task more syncronous)
        while done == false do
            Wait(500)
        end

        return item
    end

    self.addBullets = function(source,weaponId,type,cuantity)
        TriggerEvent("vorpCore:addBullets",source,weaponId,type,cuantity)
    end

    self.subBullets = function(source,weaponId,type,cuantity)
        TriggerEvent("vorpCore:subBullets",source,weaponId,type,cuantity)
    end

    self.getWeaponBullets = function(source,weaponId)
        local bull
        TriggerEvent("vorpCore:getWeaponBullets",source,function(bullets)
            bull = bullets
        end,weaponId)
        return bull
    end
    
    self.getWeaponComponents = function(source,weaponId)
        local comp
        TriggerEvent("vorpCore:getWeaponComponents",source,function(components)
            comp = components
        end,weaponId) 
        return comp
    end

    self.getUserWeapons = function(source)
        local weapList
        TriggerEvent("vorpCore:getUserWeapons",source,function(weapons)
            weapList = weapons
        end)
        return weapList
    end

    self.canCarryItems = function(source, amount)
        local can
        TriggerEvent("vorpCore:canCarryItems",source,amount,function(data)
            can = data
        end)
        return can
    end

    self.canCarryItem = function(source, item, amount) 
        local can = false
        local done = false
        
        -- Limit is a restricted field in sql. Query for it directly gives an error.
        exports.ghmattimysql:execute( "SELECT * FROM items WHERE item=@id;", {['@id'] = item}, 
        function(result)

            -- Add check for if the item exists.
            local itemcount = self.getItemCount(source, item)
            local reqCount = itemcount + amount
            
            if result[1] then
                local limit = tonumber(result[1].limit)
                if reqCount <= limit then
                    can = true
                else
                    can = false
                end
            else
                -- Object does not exist in inventory, it can not be added
                print('Item does not exist in Items table. Item: '..item)
                can = false
            end
            
            done = true
        end)

        -- Wait for the call to finish (aka makes this task more syncronous)
        while done == false do
            Wait(500)
        end

        return can
    end

    self.getUserWeapon = function(source,weaponId)
        local weap
        TriggerEvent("vorpCore:getUserWeapon",source,function(weapon)
            weap = weapon
        end,weaponId)
        return weap
    end
        
    self.RegisterUsableItem = function(itemName,cb)
        TriggerEvent("vorpCore:registerUsableItem",itemName,cb)
    end

    self.getUserInventory = function(source)
        local inv
        TriggerEvent("vorpCore:getUserInventory", source, function(invent)
            inv = invent
        end)
        return inv
    end

    self.canCarryWeapons = function(source, amount, cb)
        TriggerEvent("vorpCore:canCarryWeapons", source, amount, cb)
    end

    self.CloseInv = function(source) 
        TriggerClientEvent("vorp_inventory:CloseInv",source)
    end
    self.OpenInv = function(source)
        TriggerClientEvent("vorp_inventory:OpenInv",source)
    end
    
    return self
end)
