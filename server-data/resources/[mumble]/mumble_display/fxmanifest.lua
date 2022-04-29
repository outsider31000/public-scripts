fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"


ui_page 'html/ui.html'
files {
	'html/style.css',
	'html/style.js',
	'html/*.png',
	'html/ui.html'
}


client_script 'cl.lua'
