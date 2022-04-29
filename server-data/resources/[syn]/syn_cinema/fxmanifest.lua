games { 'rdr3' }

fx_version 'bodacious'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts { 'config.lua' }

client_scripts {
	'client/config.lua',
    'client/main.lua'
}

server_scripts {
	'client/config.lua',
	'server/main.lua',
}

exports { 'StartShow' }