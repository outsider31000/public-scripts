fx_version 'adamant'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
    'server/main.lua'
}

client_scripts {
    'client/warmenu.lua',
    'client/main.lua',
    'client/functions.lua'
}

shared_scripts {
    'config.lua',
    'locale.lua',
    'locales/es.lua',
    'locales/en.lua'
}