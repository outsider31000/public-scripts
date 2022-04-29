-- Config setting utilities
function IsSet(value)
	return value and value ~= ''
end

function IsDiscordSendEnabled()
	return IsSet(ServerConfig.DiscordWebhookId) and IsSet(ServerConfig.DiscordWebhookToken)
end

function IsDiscordReceiveEnabled()
	return IsSet(ServerConfig.DiscordBotToken) and IsSet(ServerConfig.DiscordChannel)
end

function IsDiscordReportEnabled()
	return IsSet(ServerConfig.DiscordReportWebhook)
end

function IsDiscordEnabled()
	return IsDiscordSendEnabled() or IsDiscordReceiveEnabled() or IsDiscordReportEnabled()
end
