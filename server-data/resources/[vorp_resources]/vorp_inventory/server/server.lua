

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


-- get discord id
function getIdentity(source, identity)
	local num = 0
	local num2 = GetNumPlayerIdentifiers(source)
  
	if GetNumPlayerIdentifiers(source) > 0 then
	  local ident = nil
	  while num < num2 and not ident do
		local a = GetPlayerIdentifier(source, num)
		if string.find(a, identity) then ident = a end
		num = num+1
	  end
	  --return ident;
	  return string.sub(ident, 9)
	end
end

RegisterServerEvent("vorpinventory:check_slots")
AddEventHandler("vorpinventory:check_slots", function()
    local _source = tonumber(source)
    local eq = 0
    if _source ~= 0 and _source >= 1 and _source ~= nil then
        eq = VorpInv.getUserInventory(_source)
    else
        --print("source player ".._source)
    end
    local test = eq
    local slot_check = 0
    if test ~= nil then
        for i = 1, #test do
            slot_check = slot_check + test[i].count
        end
    else
    slot_check = 0
    end
    local stufftosend = tonumber(slot_check)
    local part2 = Config.MaxItemsInInventory.Items
    local User = VorpCore.getUser(_source).getUsedCharacter
    local money = User.money
    local gold = User.gold
    TriggerClientEvent("syn:getnuistuff", _source, stufftosend,part2,money,gold)
end)



RegisterServerEvent("vorpinventory:getLabelFromId")
AddEventHandler("vorpinventory:getLabelFromId",function(id, item2, cb)
    local _source = id
    local inventory = VorpInv.getUserInventory(_source)
    local label = "not found"
     for i,item in ipairs(inventory) do
        if item.name == item2 then 
            label = item.label
        break end
    end
    cb(label) 
end)



RegisterServerEvent("vorpinventory:itemlog")
AddEventHandler("vorpinventory:itemlog", function(_source,targetHandle,itemName, amount)
    local name = GetPlayerName(_source)
    local name2 = GetPlayerName(targetHandle)
    local description = name..Config.Language.gave..amount.." "..itemName..Config.Language.to..name2
    Discord(Config.Language.gaveitem,_source,description)
end)

RegisterServerEvent("vorpinventory:weaponlog")
AddEventHandler("vorpinventory:weaponlog", function(targetHandle, data)
    local _source = source
    local name = GetPlayerName(_source)
    local name2 = GetPlayerName(targetHandle)
    local description = name..Config.Language.gave..data.item..Config.Language.to..name2..Config.Language.withid..data.id
    Discord(Config.Language.gaveitem,_source,description) 
end)

RegisterServerEvent("vorpinventory:moneylog")
AddEventHandler("vorpinventory:moneylog", function(_source,targetHandle, amount)
    local name = GetPlayerName(_source)
    local name2 = GetPlayerName(targetHandle)
    local description = name..Config.Language.gave.." $"..amount.." "..Config.Language.to..name2
    Discord(Config.Language.gaveitem,_source,description)
end)

function Discord(title,_source,description)
    local logs = {}
    local name = GetPlayerName(_source)
    local avatar = Config.webhookavatar
    local color = 3447003
    local discordid
    if Config.discordid then 
      discordid = getIdentity(_source, "discord")
    else
      discordid = nil 
    end
    if discordid ~= nil then 
      logs = {
        {
          ["color"] = color,
          ["title"] = name,
          ["description"] = description.."\n".."**Discord:** <@"..discordid..">",
        }
      }
    else
      logs = {
        {
          ["color"] = color,
          ["title"] = name,
          ["description"] = description,
        }
      }
    end
    PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({["username"] = title ,["avatar_url"] = avatar ,embeds = logs}), { ['Content-Type'] = 'application/json' })
end



if Config.Debug then
  RegisterCommand("getInv", function(source, args, rawCommand)
      -- If the source is > 0, then that means it must be a player.
      if (source > 0) then
          local characterId = Core.getUser(source).getUsedCharacter
      
          TriggerClientEvent("vorp:SelectedCharacter", source, characterId)
      
      -- If it's not a player, then it must be RCON, a resource, or the server console directly.
      else
          print("This command was executed by the server console, RCON client, or a resource.")
      end
  end, false --[[this command is not restricted, everyone can use this.]])
end
