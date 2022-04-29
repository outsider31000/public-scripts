TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


RegisterServerEvent('vorp_loot')
AddEventHandler('vorp_loot', function(price,xp)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local _price = tonumber(price)
    local playername = Character.firstname.. ' ' ..Character.lastname
	local steamhex = GetPlayerIdentifier(_source)
    local text = "looted AI for ".._price
	local message = "Player ID: "..GetPlayerName(_source).."\nCharacter: "..playername.."\nSteam: "..steamhex.."\nIP: ".." Msg: "..text
	--Discord( "npc loot", message, 16711680)
    Character.addCurrency(0, _price)

end)


RegisterServerEvent("Log")
AddEventHandler("Log", function( category, action, colordec)
	Discord( category, action, colordec)
end)

function Discord( title, description, color)
	local webhook = ""
	local logs = {
		{
			["color"] = color,
			["title"] = title,
			["description"] = description,
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = logs}), { ['Content-Type'] = 'application/json' })
end