ServerConfig = {}

-- ID of a Discord webhook to post with. Leave as '' to disable sending messages to Discord.
ServerConfig.DiscordWebhookId = ''

-- Token for the above Discord webhook. Leave as '' to disable sending messages to Discord.
ServerConfig.DiscordWebhookToken = ''

-- The default name to use on Discord.
ServerConfig.DiscordName = ''

-- The default avatar to use on Discord.
ServerConfig.DiscordAvatar = ''

-- A Discord bot token, used for getting messages and player avatars. Leave as '' to disable.
ServerConfig.DiscordBotToken = ''

-- Discord channel ID to echo messages in-game from. Leave as '' to disable showing Discord messages in-game.
ServerConfig.DiscordChannel = ''

-- Colour for messages from Discord
ServerConfig.DiscordColor = {115, 138, 219}

-- Discord webhook to post player reports to.
ServerConfig.DiscordReportWebhook = ''

-- Colour used for the report message embed on Discord.
ServerConfig.DiscordReportColor = 0xfe7f9c

-- Message sent to players upon successfully submitting a report.
ServerConfig.DiscordReportFeedbackSuccessMessage = 'Your report has been submitted.'

-- Message sent to players if a report fails.
ServerConfig.DiscordReportFeedbackFailureMessage = 'Sorry, something went wrong with your report.'

-- Colour for the above feedback message.
ServerConfig.DiscordReportFeedbackColor = {255, 165, 0}

-- Time in milliseconds between any two Discord requests.
ServerConfig.DiscordRateLimit = 2000

-- A Steam API key, used for getting avatars from Steam. Leave as '' to disable.
ServerConfig.SteamKey = ''

-- The ace that grants access to the Staff channel
ServerConfig.StaffChannelAce = 'chat.staffChannel'

-- Roles that can appear in front of player names, based on an ace.
-- Optionally, each role can be given a custom colour.
--
-- Example:
--   {name = 'Admin', color = {255, 0, 0}, ace = 'chat.admin'}
--
-- To show this role for all members of group.admin:
--   add_ace group.admin chat.admin allow
ServerConfig.Roles = {
	--{name = 'Admin', ace = 'chat.admin'},
	--{name = 'Moderator', color = {0, 255, 0}, ace = 'chat.moderator'}
}
