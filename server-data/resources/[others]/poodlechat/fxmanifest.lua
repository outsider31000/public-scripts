fx_version 'adamant'
games {'gta5', 'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'PoodleChat'

files {
	'html/index.html',
	'html/index.css',
	'html/config.default.js',
	'html/config.js',
	'html/App.js',
	'html/Message.js',
	'html/Suggestions.js',
	'html/vendor/vue.2.3.3.min.js',
	'html/vendor/flexboxgrid.6.3.1.min.css',
	'html/vendor/animate.3.5.2.min.css',
	'html/vendor/latofonts.css',
	'html/vendor/fonts/LatoRegular.woff2',
	'html/vendor/fonts/LatoRegular2.woff2',
	'html/vendor/fonts/LatoLight2.woff2',
	'html/vendor/fonts/LatoLight.woff2',
	'html/vendor/fonts/LatoBold.woff2',
	'html/vendor/fonts/LatoBold2.woff2',
}

ui_page 'html/index.html'

shared_scripts {
	'shared/config.lua',
	'shared/emoji.lua'
}

client_scripts {
	'client/client.lua'
}

server_scripts {
	'server/config.lua',
	'server/common.lua',
	'server/server.lua'
}
