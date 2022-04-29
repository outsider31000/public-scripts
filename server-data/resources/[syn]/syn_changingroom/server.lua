
local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

IsTownBanned = function (town)
	for k,v in pairs(Config.BannedTowns) do
		if town == GetHashKey(v) then
			return true
		end
	end
	return false
end

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()

    Citizen.Wait(1000)


    VorpInv.RegisterUsableItem("campfire", function(data)
        VorpInv.subItem(data.source, "campfire", 1)
        TriggerClientEvent("vorp:TipRight", data.source, "You're placing a campfire", 5000)
        TriggerClientEvent("syn:campfire", data.source)
    end)

    VorpInv.RegisterUsableItem("tent", function(data)
        TriggerClientEvent("syn_changingroom:canplace",data.source)
    end)

end)

RegisterNetEvent("syn:puttent")
AddEventHandler("syn:puttent", function()
    local _source = source
    VorpInv.subItem(_source, "tent", 1)
    TriggerClientEvent("vorp:TipRight", _source, "You're placing a tent", 5000)
    TriggerClientEvent("syn:tent", _source)
end)

RegisterNetEvent("syn:additem")
AddEventHandler("syn:additem", function(item)
    local _source = source
    VorpInv.addItem(source, item, 1)
end)



RegisterServerEvent("syn:getoutfits")
AddEventHandler("syn:getoutfits", function()
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier



    exports.ghmattimysql:execute('SELECT * FROM outfits WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        local playeroutfits = {}
        if result[1] ~= nil then 
            for i=1, #result, 1 do
            table.insert(playeroutfits, {
                title        = result[i].title,
                comps  = result[i].comps,
            })
            TriggerClientEvent("syn:listoutfits", _source, playeroutfits)
            end
        else
            playeroutfits = 0
            TriggerClientEvent("syn:listoutfits", _source, playeroutfits)

        end
    
    end)
end)

RegisterServerEvent("syn:setoutfit")
AddEventHandler("syn:setoutfit", function(jsonCloths)
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    local compPlayer = jsonCloths

    local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid , ['compPlayer'] = compPlayer}

    exports.ghmattimysql:execute("UPDATE characters Set compPlayer=@compPlayer WHERE identifier=@identifier AND charidentifier = @charidentifier", Parameters)

end)


RegisterServerEvent("syn:getskin")
AddEventHandler("syn:getskin", function()
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier



    exports.ghmattimysql:execute('SELECT skinPlayer FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        local playeroutfits = {}
        if result[1] ~= nil then 
            
            skin        = result[1].skinPlayer

            TriggerClientEvent("syn:getskins", _source, skin)
            
        else
            skin = 0
            TriggerClientEvent("syn:getskins", _source, skin)

        end
    
    end)
end)
