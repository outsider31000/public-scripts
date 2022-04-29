RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message, channel)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message, channel)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end

    print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- player join messages
--[[ AddEventHandler('chat:init', function()
    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' joined.')
end)

AddEventHandler('playerDropped', function(reason)
    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' left (' .. reason .. ')')
end)
 ]]
-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

-- API URLs
local DISCORD_API = 'https://discord.com/api'
local DISCORD_CDN = 'https://cdn.discordapp.com/avatars/'
local STEAM_API = 'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key='

RegisterNetEvent('poodlechat:reply')
RegisterNetEvent('poodlechat:staffMessage')
RegisterNetEvent('poodlechat:globalMessage')
RegisterNetEvent('poodlechat:actionMessage')
RegisterNetEvent('poodlechat:whisperMessage')
RegisterNetEvent('poodlechat:getPermissions')
RegisterNetEvent('poodlechat:report')

-- Queue to rate limit Discord requests
local DiscordQueue = {}

function EnqueueDiscordRequest(cb)
	table.insert(DiscordQueue, 1, cb)
end

function ProcessDiscordQueue()
	local cb = table.remove(DiscordQueue)

	if cb then
		cb()
	end
end

local LogColors = {
	['name'] = '\x1B[35m',
	['default'] = '\x1B[0m',
	['error'] = '\x1B[31m',
	['success'] = '\x1B[32m',
	['warning'] = '\x1B[33m'
}

function Log(label, message)
	local color = LogColors[label]

	if not color then
		color = LogColors.default
	end

	print(string.format('%s[PoodleChat] %s[%s]%s %s', LogColors.name, color, label, LogColors.default, message))
end

function GetIDFromSource(Type, ID)
	local IDs = GetPlayerIdentifiers(ID)
	for k, CurrentID in pairs(IDs) do
		local ID = stringsplit(CurrentID, ':')
		if (ID[1]:lower() == string.lower(Type)) then
			return ID[2]:lower()
		end
	end
	return nil
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function SendToDiscord(name, message, color)
	local connect = {
		{
			["color"] = color,
			["description"] = message
		}
	}

	EnqueueDiscordRequest(function()
		PerformHttpRequest(
			DISCORD_API..'/webhooks/'..ServerConfig.DiscordWebhookId..'/'.. ServerConfig.DiscordWebhookToken,
			function(status, text, headers) end,
			'POST',
			json.encode({
				username = ServerConfig.DiscordName,
				embeds = connect,
				avatar_url = ServerConfig.DiscordAvatar
			}),
			{['Content-Type'] = 'application/json' })
	end)
	--PerformHttpRequest(
	--	DISCORD_API .. '/channels/' .. ServerConfig.DiscordChannel .. '/messages',
	--	function(status, text, headers)
	--	end,
	--	'POST',
	--	json.encode({
	--		username = ServerConfig.DiscordName,
	--		embeds = connect,
	--		avatar_url = ServerConfig.DiscordAvatar
	--	}),
	--	{
	--		['Authorization'] = 'Bot ' .. ServerConfig.DiscordBotToken,
	--		['Content-Type'] = 'application/json'
	--	})
end

function GetNameWithRoleAndColor(source)
	local name = GetPlayerName(source)
	local role = nil

	for i = 1, #ServerConfig.Roles do
		if IsPlayerAceAllowed(tostring(source), ServerConfig.Roles[i].ace) then
			role = ServerConfig.Roles[i]
			break
		end
	end

	if role then
		return role.name .. ' | ' .. name, role.color
	else
		return name, nil
	end
end

function LocalMessage(source, message)
	if message == '' then
		return
	end

	message = Emojit(message)

	local name, color = GetNameWithRoleAndColor(source)

	if not color then
		color = Config.DefaultLocalColor
	end

	TriggerClientEvent('poodlechat:localMessage', -1, source, name, color, message)
end

function SendUserMessageToDiscord(source, name, message, avatar)
	local data = {}
	data.username = name .. ' [' .. source .. ']'
	data.content = message
	if avatar then
		data.avatar_url = avatar
	end
	data.tts = false

	EnqueueDiscordRequest(function()
		PerformHttpRequest(
			DISCORD_API..'/webhooks/'..ServerConfig.DiscordWebhookId..'/'..ServerConfig.DiscordWebhookToken,
			function(status, text, headers) end,
			'POST',
			json.encode(data),
			{['Content-Type'] = 'application/json'})
	end)
	--PerformHttpRequest(
	--	DISCORD_API .. '/channels/' .. ServerConfig.DiscordChannel .. '/messages',
	--	function(status, text, headers) end,
	--	'POST',
	--	json.encode(data),
	--	{
	--		['Authorization'] = 'Bot ' .. ServerConfig.DiscordBotToken,
	--		['Content-Type'] = 'application/json'
	--	})
end

function SendMessageWithDiscordAvatar(source, name, message)
	if not IsSet(ServerConfig.DiscordBotToken) then
		return false
	end

	local id = GetIDFromSource('discord', source)

	if id then
		EnqueueDiscordRequest(function()
			PerformHttpRequest(DISCORD_API .. '/users/' .. id, function(status, text, headers)
				local hash = json.decode(text)['avatar']
				local avatar = DISCORD_CDN .. id .. '/' .. hash .. '.png'
				SendUserMessageToDiscord(source, name, message, avatar)
			end, 'GET', '', {['Authorization'] = 'Bot ' .. ServerConfig.DiscordBotToken})
		end)

		return true
	end

	return false
end

function SendMessageWithSteamAvatar(source, name, message)
	if not IsSet(ServerConfig.SteamKey) then
		return false
	end

	local id = GetIDFromSource('steam', source)

	if id then
		PerformHttpRequest(STEAM_API .. ServerConfig.SteamKey .. '&steamids=' .. tonumber(id, 16), function(status, text, headers)
			local avatar = string.match(text, '"avatarfull":"(.-)","')
			SendUserMessageToDiscord(source, name, message, avatar)
		end)

		return true
	end

	return false
end

function GlobalMessage(source, message)
	if message == '' then
		return
	end

	message = Emojit(message)

	local name, color = GetNameWithRoleAndColor(source)

	if not color then
		color = Config.DefaultGlobalColor
	end

	TriggerClientEvent('chat:addMessage', -1, {color = color, args = {'[Global] ' .. name, message}})

	-- Send global messages to Discord
	if IsDiscordSendEnabled() then
		-- Escape @everyone and @here to prevent mentions on Discord
		if string.match(message, "@everyone") then
			message = message:gsub("@everyone", "`@everyone`")
		end
		if string.match(message, "@here") then
			message = message:gsub("@here", "`@here`")
		end

		-- Try getting avatar from Discord, Steam, or fallback to no avatar
		if not SendMessageWithDiscordAvatar(source, name, message) then
			if not SendMessageWithSteamAvatar(source, name, message) then
				SendUserMessageToDiscord(source, name, message, nil)
			end
		end
	end
end

AddEventHandler('poodlechat:globalMessage', function(message)
	GlobalMessage(source, message)
end)

function LocalCommand(source, args, raw)
	local message = table.concat(args, ' ')
	LocalMessage(source, message)
end

--[[ RegisterCommand('say', function(source, args, raw)
	-- If source is a player, send a local message
	if source and source > 0 then
		LocalCommand(source, args, raw)
	-- If source is console, send to all players
	else
		TriggerClientEvent('chat:addMessage', -1, {color = {255, 255, 255}, args = {'console', message}})
	end
end, true) ]]

-- Send messages to current channel by default
AddEventHandler('chatMessage', function(source, name, message, channel)
	if string.sub(message, 1, string.len("/")) ~= "/" then
		if channel == 'Global' then
			GlobalMessage(source, message)
		elseif channel == 'Local' then
			LocalMessage(source, message)
		elseif channel == 'Staff' then
			StaffMessage(source, message)
		end
	end
	CancelEvent()
end)

AddEventHandler('poodlechat:actionMessage', function(message)
	local name = GetPlayerName(source)

	if message == '' then
		return
	end

	message = Emojit(message)

	TriggerClientEvent("poodlechat:action", -1, source, name, message)
end, false)

function GetPlayerId(id)
	-- First, search by ID
	for _, playerId in ipairs(GetPlayers()) do
		if playerId == id then
			return playerId
		end
	end

	-- Then, try by name
	id = string.lower(id)

	for _, playerId in ipairs(GetPlayers()) do
		if string.lower(GetPlayerName(playerId)) == id then
			return playerId
		end
	end

	return nil
end

AddEventHandler('poodlechat:whisperMessage', function(id, message)
	local name, color = GetNameWithRoleAndColor(source)

	if message == '' then
		return
	end

	message = Emojit(message)

	id = GetPlayerId(id)

	if id then
		-- Echo the message to the sender's chat
		TriggerClientEvent('poodlechat:whisperEcho', source, id, GetPlayerName(id), message)
		-- Send the message to the recipient
		TriggerClientEvent('poodlechat:whisper', id, source, name, message)
		-- Set the /reply target for sender and recipient
		TriggerClientEvent('poodlechat:setReplyTo', id, source)
		TriggerClientEvent('poodlechat:setReplyTo', source, id)
	else
		TriggerClientEvent('poodlechat:whisperError', source, id)
	end
end)

AddEventHandler('poodlechat:reply', function(target, message)
	Whisper(source, target, message)
end)

function StaffMessage(source, message)
	if not IsPlayerAceAllowed(source, ServerConfig.StaffChannelAce) then
		TriggerClientEvent('chat:addMessage', source, {
			color = {255, 0, 0},
			args = {'Error', 'You do not have access to the Staff channel.'}
		})
		return
	end

	local name, color = GetNameWithRoleAndColor(source)

	if not color then
		color = Config.DefaultStaffColor
	end

	for _, playerId in ipairs(GetPlayers()) do
		if IsPlayerAceAllowed(playerId, ServerConfig.StaffChannelAce) then
			TriggerClientEvent('chat:addMessage', playerId, {
				color = color,
				args = {'[Staff] ' .. name, message}
			});
		end
	end
end

AddEventHandler('poodlechat:staffMessage', function(message)
	StaffMessage(source, message)
end)

function SetPermissions(source)
	TriggerClientEvent('poodlechat:setPermissions', source, {
		canAccessStaffChannel = IsPlayerAceAllowed(source, ServerConfig.StaffChannelAce)
	})
end

AddEventHandler('poodlechat:getPermissions', function()
	SetPermissions(source)
end)

RegisterCommand('poodlechat_refresh_perms', function(source, args, raw)
	for _, playerId in ipairs(GetPlayers()) do
		SetPermissions(playerId)
	end
end, true)

function IsResponseOk(status)
	return status >= 200 and status <= 299
end

function SendReportToDiscord(source, id, reason)
	local reporterName = GetPlayerName(source)
	local reporteeName = GetPlayerName(id)
	local reporterLicense = GetIDFromSource('license', source)
	local reporteeLicense = GetIDFromSource('license', id)
	local reporterIp = GetPlayerEndpoint(source)
	local reporteeIp = GetPlayerEndpoint(id)

	local message = table.concat({
		'**Reporter:** ' .. reporterName,
		'**License:** ' .. reporterLicense,
		'**IP:** ' .. reporterIp,
		'',
		'**Player Reported:** ' .. reporteeName,
		'**License:** ' .. reporteeLicense,
		'**IP:** ' .. reporteeIp,
		'',
		'**Reason:** ' .. reason
	}, '\n')

	local data = {
		embeds = {
			{
				['color'] = ServerConfig.DiscordReportColor,
				['description'] = message
			}
		}
	}

	EnqueueDiscordRequest(function()
		PerformHttpRequest(
			ServerConfig.DiscordReportWebhook,
			function(status, text, headers)
				-- If there is an error, fallback to printing the report in the server console
				if IsResponseOk(status) then
					TriggerClientEvent('chat:addMessage', source, {
						color = ServerConfig.DiscordReportFeedbackColor,
						args = {ServerConfig.DiscordReportFeedbackSuccessMessage}
					})
				else
					Log('error', string.format('Failed to send report: %d %s %s\n%s', status, text, json.encode(headers), message))

					TriggerClientEvent('chat:addMessage', source, {
						color = ServerConfig.DiscordReportFeedbackColor,
						args = {ServerConfig.DiscordReportFeedbackFailureMessage}
					})
				end
			end,
			'POST',
			json.encode(data),
			{['Content-Type'] = 'application/json'})
		--[[
		PerformHttpRequest(
			DISCORD_API .. '/channels/' .. ServerConfig.DiscordReportChannel .. '/messages',
			function(status, text, headers)
				-- If there is an error, fallback to printing the report in the server console
				if IsResponseOk(status) then
					Log('error', string.format('Failed to send report: %d %s %s\n%s', status, text, json.encode(headers), message))
				end

				TriggerClientEvent('chat:addMessage', source, {
					color = ServerConfig.DiscordReportFeedbackColor,
					args = {ServerConfig.DiscordReportFeedbackMessage}
				})
			end,
			'POST',
			json.encode(data),
			{
				['Authorization'] = 'Bot ' .. ServerConfig.DiscordBotToken,
				['Content-Type'] = 'application/json'
			})
		]]
	end)
end

AddEventHandler('poodlechat:report', function(player, reason)
	if not IsDiscordReportEnabled() then
		TriggerClientEvent('chat:addMessage', source, {
			color = {255, 0, 0},
			args = {'Error', 'The report function is not enabled.'}
		})
		return
	end

	local id = GetPlayerId(player)

	if id then
		SendReportToDiscord(source, id, reason)
	else
		TriggerClientEvent('chat:addMessage', source, {
			color = {255, 0, 0},
			args = {'Error', 'No player with ID or name ' .. player .. ' exists'}
		})
	end
end)

AddEventHandler('playerConnecting', function() 
	SendToDiscord("Server Login", "**" .. GetPlayerName(source) .. "** is connecting to the server.", 65280)
end)

AddEventHandler('playerDropped', function(reason) 
	local color = 16711680
	if string.match(reason, "Kicked") or string.match(reason, "Banned") then
		color = 16007897
	end
	SendToDiscord("Server Logout", "**" .. GetPlayerName(source) .. "** has left the server. \n Reason: " .. reason, color)
end)

-- Display Discord messages in in-game chat
local LastMessageId = nil

function DiscordMessage(message)
	if message.id == ServerConfig.DiscordWebhookId then
		return
	end

	if message.content == '' then
		return
	end

	TriggerClientEvent('chat:addMessage', -1, {
		color = ServerConfig.DiscordColor,
		args = {'[Discord] ' .. message.name, message.content}
	})
end

function GetDiscordMessages()
	PerformHttpRequest(
		DISCORD_API ..'/channels/'..ServerConfig.DiscordChannel..'/messages?after='..LastMessageId,
		function(status, text, headers)
			if IsResponseOk(status) then
				local data = json.decode(text)

				if #data > 0 then
					-- Extract messages from response
					local messages = {}
					for _, message in ipairs(data) do
						messages[message.id] = {
							id = message.author.id,
							name = message.author.username,
							content = message.content
						}
					end

					-- Sort by ID
					local ids = {}
					for id, message in pairs(messages) do
						table.insert(ids, id)
					end
					table.sort(ids)

					-- Send to in-game chat
					for _, id in ipairs(ids) do
						DiscordMessage(messages[id])
					end

					LastMessageId = ids[#ids]
				end
			else
				Log('warning', string.format('Failed to receive messages: %d %s %s', status, text, json.encode(headers)))
			end

			EnqueueDiscordRequest(GetDiscordMessages)
		end,
		'GET',
		'',
		{['Authorization'] = 'Bot ' .. ServerConfig.DiscordBotToken})
end

-- Get the last message ID to start from
function InitDiscordReceive()
	PerformHttpRequest(
		DISCORD_API .. '/channels/' .. ServerConfig.DiscordChannel .. '/messages?limit=1',
		function(status, text, headers)
			if IsResponseOk(status) then
				local data = json.decode(text)

				LastMessageId = data[#data].id

				Log('success', 'Ready to receive Discord messages!')
			else
				Log('error', string.format('Failed to initialize: %d %s %s', status, text, json.encode(headers)))
			end

			if LastMessageId then
				EnqueueDiscordRequest(GetDiscordMessages)
			else
				EnqueueDiscordRequest(InitDiscordReceive)
			end
		end,
		'GET',
		'',
		{
			['Authorization'] = 'Bot ' .. ServerConfig.DiscordBotToken
		})
end

if IsDiscordEnabled() then
	CreateThread(function()
		if IsDiscordReceiveEnabled() then
			EnqueueDiscordRequest(InitDiscordReceive)
		end

		while true do
			ProcessDiscordQueue()
			Wait(ServerConfig.DiscordRateLimit)
		end
	end)
end
