
fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games {"rdr3"}
author 'VORP @AndrewR3K'

client_scripts {
    'client/warmenu.lua',
    'client/client.lua',
    'config.lua'
}

shared_scripts {
    'config.lua',
	'locale.lua',
	'locales/es.lua',
	'locales/en.lua',
}

server_scripts {
    'config.lua',
    'server/server.lua',
}


files {
    'ui/*',
    'ui/assets/*',
    'ui/assets/fonts/*'
}
    
ui_page 'ui/index.html'

version '1.0'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_zonenotify'
