fx_version 'adamant'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


dependencies {
    "PolyZone"
}

ui_page 'html/index.html'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.lua',
	'client/main.lua',
}

server_scripts {
	'server/server.lua'
}

files {
	'html/index.html',
	'html/css/style.css',
	'html/js/script.js'
}
