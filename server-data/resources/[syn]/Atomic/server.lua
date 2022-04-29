local systemlogs = ""
local systemlogs2 = ""
local deathlogs = ""
local discord = ""

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent("CheckGroup")
AddEventHandler("CheckGroup", function()
	local _source = source
	local User = VorpCore.getUser(_source)
	local group = User.getGroup
	if group == "moderator" or group == "admin" then
		TriggerClientEvent("OpenMenu", source)
	end
end)

RegisterServerEvent("checksteam")
AddEventHandler("checksteam", function()
	local _source = source
  local Character = VorpCore.getUser(_source).getUsedCharacter
  local steamname = GetPlayerName(_source)
  local identifier = Character.identifier
  local charidentifier = Character.charIdentifier
  exports.ghmattimysql:execute('SELECT steamname FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = identifier, ['charidentifier'] = charidentifier}, function(result)
      if result[1] == nil then 
        exports.ghmattimysql:execute("UPDATE characters Set steamname=@steamname WHERE identifier=@identifier AND charidentifier = @charidentifier", {['steamname'] = steamname,['identifier'] = identifier, ['charidentifier'] = charidentifier})
      else
        local steamname2 = result[1].steamname
        if steamname2 ~= steamname then 
          exports.ghmattimysql:execute("UPDATE characters Set steamname=@steamname WHERE identifier=@identifier AND charidentifier = @charidentifier", {['steamname'] = steamname,['identifier'] = identifier, ['charidentifier'] = charidentifier})  
        end
      end
  end)

end)
RegisterServerEvent("kickafk")
AddEventHandler("kickafk", function()
	DropPlayer(source, "You were AFK for too long.")
end)


RegisterCommand("nc", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local Character = User.getUsedCharacter
	local playername = Character.firstname.. ' ' ..Character.lastname
  local group = User.getGroup -- Return user group (not character group)
    if group == "admin" then
      TriggerClientEvent('syn:noclip',source)
    else return false
    end
   end
end)

RegisterServerEvent("GiveWeapon")
AddEventHandler("GiveWeapon", function(player, weapon, ammo, components)
	local _source = source
	local User = VorpCore.getUser(_source)
	local userCharacter = User.getUsedCharacter
	local playername = userCharacter.firstname.. ' ' ..userCharacter.lastname
	local group = User.getGroup
	local targetPlayer = VorpCore.getUser(player)
	local tarChar = targetPlayer.getUsedCharacter
	local tarName = tarChar.firstname.. ' ' ..tarChar.lastname
	
	if group == "moderator" or group == "admin" then
		TriggerEvent("vorpCore:canCarryWeapons", tonumber(player), 1, function(canCarry)
			if canCarry then
				local message = "`"..playername.."` gave `"..tarName.. "` a `"..weapon.."`"
				TriggerEvent("Log", systemlogs, "Staff Give Weapon", message, 0)
				VorpInv.createWeapon(tonumber(player), weapon, ammo, components)
				TriggerClientEvent("vorp:TipRight", _source, "You gave " ..tarName..' a '..weapon, 3000)
				TriggerClientEvent("vorp:TipRight", player, playername.." gave you a "..weapon, 3000)
			else
				local message = "`"..playername.."` can't carry anymore weapons"
				TriggerEvent("Log", systemlogs, "Staff Give Weapon", message, 0)
				TriggerClientEvent("vorp:TipRight", _source, tarName.." Can't carry any more weapons", 3000)
				TriggerClientEvent("vorp:TipRight", player, "You can't carry any more weapons", 3000)
			end
		end)
	else
		TriggerClientEvent("vorp:TipRight", _source, "This is an admin/moderator command only", 2000)
	end
end)

--[[ RegisterServerEvent("GiveItem")
AddEventHandler("GiveItem", function(player, itemgiven, qty)
    local _source = source
    local User = VorpCore.getUser(_source) -- Return User with functions and all characters
	local group = User.getGroup
    local Character = User.getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname
    local inventory = VorpInv.getUserInventory(tonumber(player))
	local tarUser = VorpCore.getUser(tonumber(player))
	local tarChar = tarUser.getUsedCharacter
	local tarName = tarChar.firstname..' '..tarChar.lastname

	if group == "moderator" or group == "admin" then
		TriggerEvent("vorpCore:canCarryItems", tonumber(player), tonumber(qty), function(canCarry)
			if canCarry then
				if contains2(inventory, itemgiven) then
					for i,item in pairs(inventory) do
						if item.name == itemgiven then
							local carrying = qty + item.count
							if item.limit >= carrying then
								VorpInv.addItem(tonumber(player), itemgiven, qty)
								local message = playername..' gave '..tarName..' '..qty.. ' x '..item.label
								TriggerEvent("Log", systemlogs, "Staff Give Item", message, 0)
								TriggerClientEvent("vorp:TipRight", _source, "You gave "..tarName..' '..qty..' x '..item.label, 2000)
								TriggerClientEvent("vorp:TipRight", tonumber(player), "You received "..qty..' x '..item.label..' from an Admin', 2000)
							else
								local message = "`"..playername.."` tried to give "..tarName.." "..qty.." x "..item.label.." but they can't carry anymore "..carrying.."/"..item.limit
								TriggerEvent("Log", systemlogs, "Staff Give Item", message, 0)
								TriggerClientEvent("vorp:TipRight", _source, "That person can't carry anymore "..item.label.." Count: "..item.count..'/'..item.limit, 2000)
								TriggerClientEvent("vorp:TipRight", tonumber(player), "You can't carry more than "..item.limit..' x '..item.label.."Count: "..item.count..'/'..item.limit, 2000)
							end
						end
					end
				else
					local item = itemgiven
					exports.ghmattimysql:execute('SELECT * FROM items WHERE item = @item', {['item'] = item}, function(result)
						if result[1] ~= nil then
							local itemlimit = result[1].limit
							local itemlabel = result[1].label
							if itemlimit >= tonumber(qty) then
								VorpInv.addItem(player, item, qty)
								local message = playername..' gave '..tarName..' '..qty..' x '..itemlabel
								TriggerEvent("Log", systemlogs, "Give Item", message, 0)
								TriggerClientEvent("vorp:TipRight", _source, "You gave "..tarName..' '..qty..' x '..itemlabel, 2000)
								TriggerClientEvent("vorp:TipRight", player, "You received "..qty..' x '..itemlabel..' from an Admin', 2000)
							else
								local message = "`"..playername.."` tried to give "..tarName.." "..qty.." x "..itemlabel.." but they can't carry more than "..tonumber(qty).."/"..itemlimit
								TriggerEvent("Log", systemlogs, "Give Item", message, 0)
								TriggerClientEvent("vorp:TipRight", _source, "That person can't more than "..itemlimit..' '..itemlabel, 2000)
								TriggerClientEvent("vorp:TipRight", player, "You can't carry any more than "..itemlimit..' '..itemlabel, 2000)
							end
						end
					end)
				end
			else
				TriggerClientEvent("vorp:TipRight", _source, tarName.." can't carry any more items", 2000)
				TriggerClientEvent("vorp:TipRight", player, "You can't carry any more items", 2000)
			end
		end)
	else
		TriggerClientEvent("vorp:TipRight", _source, "This is an admin/moderator only command", 2000)
	end
end) ]]

function contains2(table, element)
	for k, v in pairs(table) do
		for x, y in pairs(v) do
			  if y == element then
				return true
			end
		end
	end
	return false
end

function Discord(webhook, title, description, color)
  local _source = source
	local logs = {
		{
			["color"] = color,
			["title"] = title,
			["description"] = description,
		}
	}

	  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = logs}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent("AnnouncePlayer")
AddEventHandler("AnnouncePlayer", function()
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local playername = GetPlayerName(source)
	local ip = GetPlayerEndpoint(_source)
	local steamhex = GetPlayerIdentifier(_source)
  local message = "Player ID: "..GetPlayerName(_source).."\nCharacter: "..playername.."\nSteam: "..steamhex.."\nIP: "
	TriggerEvent("Log", systemlogs2, "Character Joined", message, 0)
end)

AddEventHandler('playerDropped', function(reason)
	local ip = GetPlayerEndpoint(source)
	local steamhex = GetPlayerIdentifier(source)
	local name = GetPlayerName(source)
  local message =  "Player ID: "..name.."\nSteam: "..steamhex.."\nIP: "..ip..", REASON: "..reason
	TriggerEvent("Log", systemlogs2, "User Disconnected", message, 0)
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied', function(id,player,killer,DeathReason, Weapon)
	local _source = source
	local User = VorpCore.getUser(player).getUsedCharacter
	local playername = GetPlayerName(_source)
  local killername = GetPlayerName(killer)
	if Weapon == nil then _Weapon = "" else _Weapon = "`"..Weapon.."`" end
	if id == 1 then  -- Suicide/died
		Discord(deathlogs, "Death Log", playername..' `'..DeathReason..'` '.._Weapon, 0)
	elseif id == 2 then -- Killed by other player
		Discord(deathlogs, "Death Log", killername..' `'..DeathReason..'` '..playername..' '.._Weapon, 0)
	else -- When gets killed by something else
		Discord(deathlogs, "Death Log", playername..' `died`', 0)
	end
end)

RegisterServerEvent("Log")
AddEventHandler("Log", function(webhook, category, action, colordec)
	Discord(webhook, category, action, colordec)
end)



RegisterServerEvent("Announce")
AddEventHandler("Announce", function(message)
	TriggerClientEvent("vorp:TipBottom", -1, "Announcement: "..message, 8000)
end)

RegisterServerEvent("Bring")
AddEventHandler("Bring", function(target, x, y, z)
	TriggerClientEvent("Bring", target, x, y, z)
end)

RegisterServerEvent("Message")
AddEventHandler("Message", function(target, message)
	TriggerClientEvent("vorp:TipBottom", target, message, 5000)
end)

RegisterServerEvent("KickPlayer")
AddEventHandler("KickPlayer", function(target)
	DropPlayer(target, "You have been kicked by a moderator. Please visit "..discord.." for help.")
	TriggerClientEvent("vorp:TipRight", source, "Player has been kicked.", 3000)
end)

RegisterServerEvent("DelObj")
AddEventHandler("DelObj", function(type)
	local _source = source
	local User = VorpCore.getUser(_source)
	local group = User.getGroup
	local deltype = tonumber(type)

	if group == "admin" then
		if deltype == "on" then
			TriggerClientEvent("ObjectDeleteOn", _source)
		end
		if deltype == "off" then
			TriggerClientEvent("ObjectDeleteOff", _source)
		end
	else
		TriggerClientEvent("vorp:TipRight", _source, "This is an admin only command", 2000)
	end
end)


RegisterServerEvent('syn_commands:send')
AddEventHandler('syn_commands:send', function(title, description, color)
  Discord(systemlogs,title, description, color)
end)




RegisterServerEvent('syn_commands:getplayers')
AddEventHandler('syn_commands:getplayers', function()
  local _source = source
  local players = GetPlayers()
  local data = {}
  for index, player in ipairs(players) do
      local playerPed = GetPlayerPed(player)
      if DoesEntityExist(playerPed) then
          local coords = GetEntityCoords(playerPed)
          data[tostring(player)] = {
              serverId = player, 
              networkId = NetworkGetNetworkIdFromEntity(playerPed),
              x = coords.x,
              y = coords.y,
              z = coords.z,
              name = GetPlayerName(player),
              ped = playerPed,
          }
      end
  end
  TriggerClientEvent("getplayers",_source,data)
end)



RegisterCommand("hp", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local Character = User.getUsedCharacter
	local playername = Character.firstname.. ' ' ..Character.lastname
  local group = User.getGroup -- Return user group (not character group)
  local id =  args[1]
    if group == "admin" then
      TriggerClientEvent('syn:heal', id)
      TriggerClientEvent('fred_meta:consume',id, 100,100,0,100,100.0,100,100,100,100.0,100.0)
        TriggerEvent("syn_commands:send","Player Used Heal", "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)
    else return false
    end
   end
  end)
  RegisterCommand("god", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local Character = User.getUsedCharacter
  local group = User.getGroup -- Return user group (not character group)
  local playername = Character.firstname.. ' ' ..Character.lastname
  local id =  args[1]
    if group == "admin" then

      TriggerClientEvent('syn:godmodexrt', id)
      Discord("Player Used Godmode", "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)
     

    else return false
    end
   end
  end)

  RegisterCommand("res", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local Character = User.getUsedCharacter
	local playername = Character.firstname.. ' ' ..Character.lastname
  local group = User.getGroup -- Return user group (not character group)
  local id =  args[1]
    if group == "admin" then
      TriggerClientEvent('vorp:resurrectPlayer', id)
        Discord("Player Used revive", "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)

    else return false
    end
   end
  end)

  RegisterCommand("givecash", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local Character = User.getUsedCharacter
	local playername = Character.firstname.. ' ' ..Character.lastname

  local group = User.getGroup -- Return user group (not character group)
  local id =  args[1]
  local cash =  args[2]
  local Character = VorpCore.getUser(id).getUsedCharacter

    if group == "admin" then
      Character.addCurrency(0, cash)
        Discord("Player Used give cash "..cash, "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)

    else return false
    end
   end
  end)

  RegisterCommand("givewep", function(source, args)
    if args ~= nil then
      local User = VorpCore.getUser(source) 
      local Character = User.getUsedCharacter
      local playername = Character.firstname.. ' ' ..Character.lastname    
      local _source = source
      local group = User.getGroup -- Return user group (not character group)
      local id =   args[1]
      local weaponHash =   tostring(args[2])
      local ammo = {["nothing"] = 0}
      local components =  {["nothing"] = 0}
      if group == "admin" then
        TriggerEvent("vorpCore:canCarryWeapons", tonumber(id), 1, function(canCarry)

          if canCarry then 
           -- TriggerEvent("vorpCore:registerWeapon", tonumber(id), weaponHash, ammo, components)
            VorpInv.createWeapon(tonumber(id), weaponHash, ammo, components)
            Discord("Player Used give weapon "..args[2], "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)

          end
        end)  
        
      else return false
      end
    end
  end)

  RegisterCommand("givegold", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local Character = User.getUsedCharacter
  local playername = Character.firstname.. ' ' ..Character.lastname    

  local group = User.getGroup -- Return user group (not character group)
  local id =  args[1]
  local cash =  args[2]
  local Character = VorpCore.getUser(id).getUsedCharacter

    if group == "admin" then
      Character.addCurrency(1, cash)
      Discord("Player Used give gold "..cash, "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)

    else return false
    end
   end
  end)

  RegisterCommand("giveitem", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local Character = User.getUsedCharacter
  local playername = Character.firstname.. ' ' ..Character.lastname    
  local group = User.getGroup -- Return user group (not character group)
  local id =  args[1]
  local item =  args[2]
  local count =  args[3]
  local Character = VorpCore.getUser(id).getUsedCharacter

    if group == "admin" then
      VorpInv.addItem(id, item, count)
        Discord("Player Used give item "..item, "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)

    else return false
    end
   end
  end)

  RegisterCommand("takecash", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local group = User.getGroup -- Return user group (not character group)
  local id =  args[1]
  local cash =  args[2]
  local Character = VorpCore.getUser(id).getUsedCharacter

    if group == "admin" then
      Character.removeCurrency(0, cash)
    else return false
    end
   end
  end)

  RegisterCommand("takegold", function(source, args)
    
    if args ~= nil then
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local group = User.getGroup -- Return user group (not character group)
  local id =  args[1]
  local cash =  args[2]
  local Character = VorpCore.getUser(id).getUsedCharacter

    if group == "admin" then
      Character.removeCurrency(1, cash)
    else return false
    end
   end
  end)

  RegisterCommand("tpm", function(source, args)
  local User = VorpCore.getUser(source) -- Return User with functions and all characters
  local Character = User.getUsedCharacter
  local playername = Character.firstname.. ' ' ..Character.lastname    
  local _source = source
  local group = User.getGroup -- Return user group (not character group)
   if group == "admin" then
      TriggerClientEvent('syn:tpm2', _source,_source)
        Discord("Player Used tpm", "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)

    else return false
   end
  end)

  RegisterCommand("tp", function(source, args)
    local User = VorpCore.getUser(source) -- Return User with functions and all characters
    local Character = User.getUsedCharacter
    local playername = Character.firstname.. ' ' ..Character.lastname    
    local group = User.getGroup -- Return user group (not character group)
     if group == "admin" then
      local x =  tonumber(args[1])
      local y =   tonumber(args[2])
      local z =   tonumber(args[3])
        TriggerClientEvent('syn:tp', source,x,y,z)
        Discord("Player Used tpm", "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)
  
      else return false
     end
    end)

  RegisterNetEvent("fixanimals:attack")
  AddEventHandler("fixanimals:attack", function(target, entity)
    TriggerClientEvent("fixanimals:attack", target, source, entity)
  end)
