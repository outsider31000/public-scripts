games { 'rdr3' }

fx_version 'bodacious'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts { 'g_config.lua' }

server_scripts {
	'server/*.lua'
}

client_scripts {
	'client/*.lua',
	'structs.js'
}