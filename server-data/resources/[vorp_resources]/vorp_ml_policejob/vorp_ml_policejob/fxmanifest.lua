fx_version "adamant"

games {"rdr3"}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/warmenu.lua',
	'functions.lua'
}

shared_scripts {
	'locale.lua',
	'locales/es.lua',
	'locales/en.lua',
}

dependency 'vorp_core'