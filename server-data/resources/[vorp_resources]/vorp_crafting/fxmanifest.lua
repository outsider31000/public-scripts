fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"
lua54 'yes'

author "VORP @Blue edit by Bytesizd"

client_scripts {
    'client/client.lua',
    'client/functions.lua',
    'client/services/*.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua',
    'shared/locale.lua',
    'languages/*.lua'
}

files {
    'ui/*',
    'ui/assets/*',
    'ui/vendor/*',
    'ui/assets/fonts/*'
}

ui_page 'ui/index.html'

dependency 'vorp_core'

--dont touch
version '1.2.4'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_crafting'
