resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

-- Client Scripts
client_script 'client/main.lua'

-- Server Scripts
server_script 'server/main.lua'

-- NUI Default Page
ui_page('client/html/index.html')

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files {
    'client/html/index.html',

    'client/html/sounds/PinFail.ogg',
    'client/html/sounds/PinSucc.ogg',
    'client/html/sounds/roulette.ogg'
}
