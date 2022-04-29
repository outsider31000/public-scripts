fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/style.css',
	'ui/script.js',
	'ui/CHINESER.TTF'
}

shared_scripts {
	'common.lua',
	'config.lua'
}

client_scripts {
	'client.lua'
}

server_scripts {
	'server.lua'
}
