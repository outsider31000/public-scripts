fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
author 'VORP @outsider31000'
lua54 'yes'


client_scripts { 'client/client.lua' }

server_scripts { 'server/server.lua' }

shared_scripts {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}

dependencies {
    'menuapi',
    'vorp_inputs' -- download from the vorp github
}



--dont
--touch

version '1.6'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_stores-lua'
