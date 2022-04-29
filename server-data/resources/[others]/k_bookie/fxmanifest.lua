fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
ui_page 'html/ui.html'

client_scripts {
    'config.lua',
    'client/client_func.lua',
    'client/client.lua',
    'client/client_props.lua',
}

server_scripts {
    'config.lua',
    'server/server.lua',
}
files {
    'html/ui.html',
    'html/crock.ttf',
}
