fx_version 'adamant'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Darren Docherty'
description 'A simple panel for RedM server moderation'
version '1.0.0'

client_scripts {
	'config.lua',
	'warmenu.lua',
	'hogtielock.lua',
	'client.lua'
}

server_scripts {
    'server.lua'
}
