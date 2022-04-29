fx_version "adamant"

games {"rdr3"}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page 'html/scoreboard.html'

client_scripts {
    'config.lua',
    'scoreboard.lua'
}

server_scripts {
    'config.lua',
    'scoreboardsv.lua'
}

files {
    'html/scoreboard.html',
    'html/style.css',
    'html/reset.css',
    'html/listener.js',
    'html/images/bgPanel.png',
    'html/crock.ttf',
}